From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 10:40:18 -0700
Message-ID: <xmqqpp23we4d.fsf@gitster.mtv.corp.google.com>
References: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
	<1441035616-39128-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 31 19:40:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWT4K-0000kE-9X
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbbHaRk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 13:40:28 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36861 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbbHaRk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:40:27 -0400
Received: by pabpg12 with SMTP id pg12so13476103pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Y/rW3Wb6L4ob41Qy+Do+Dr++Rjf5VMIjQ4YCC0Nt3L8=;
        b=OVdggPbwjhPCw4O8GAw4fPbdjyLu+l+xuwnp5BG3WK4djlsJTm+6lKDE3QMA1kb0Ea
         xDxYa7Fh4Cbc2Y/HQ2HmNs+wBZxtyobtSU1Bkg5BmrYSrCciMWHgl1pFXjz0X8kyWuCf
         MoIUbtm744DZ8eDMfwG6W3fMvvd5Dh7C0PuAkyLEVK2yyCR4MvucXGZlaPvRjNGg7OEI
         QpKmXp7BifYGxZT6W1bRatVCZCz0FaNdyQJgJA9EsCgHbz3DtRcIhRECw8dCAyntYC4U
         EiIe+IsN/F6Ts/u3DAxmUvWaWeNzV/ROyKz8KdEAKGUR31ujtpFH+bLoU0G79ZMrgrA2
         HLbQ==
X-Received: by 10.68.98.5 with SMTP id ee5mr39630044pbb.95.1441042826858;
        Mon, 31 Aug 2015 10:40:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id eg2sm15455141pad.44.2015.08.31.10.40.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 10:40:26 -0700 (PDT)
In-Reply-To: <1441035616-39128-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 31 Aug 2015 17:40:16
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276896>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-p4.txt        |  4 ++++
>  git-p4.py                       |  6 ++++++
>  t/t9821-git-p4-path-encoding.sh | 38 +++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 48 insertions(+)
>  create mode 100755 t/t9821-git-p4-path-encoding.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..98b6c0f 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,10 @@ Git repository:
>  	Use a client spec to find the list of interesting files in p4.
>  	See the "CLIENT SPEC" section below.
> =20
> +----path-encoding <encoding>::
> +	The encoding to use when reading p4 client paths. With this option
> +	non ASCII paths are properly stored in Git. For example, the encodi=
ng 'cp1252' is often used on Windows systems.
> +

This line is overly long.  Let AsciiDoc wrap it upon output and keep
the source within a reasonable limit (see existing lines around the
new text to see what is considered reasonable).

Do I see too many dashes before the option name, by the way, or is
it my e-mail client tricking my eyes?

> diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-en=
coding.sh
> new file mode 100755
> index 0000000..f6bb79c
> --- /dev/null
> +++ b/t/t9821-git-p4-path-encoding.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description=3D'Clone repositories with non ASCII paths'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo containing cp1251 encoded paths' =
'
> +	cd "$cli" &&
> +
> +	FILENAME=3D"$(echo "a-=A4_o-=B6_u-=BC.txt" | iconv -f utf-8 -t cp12=
52)" &&

Hmm, we'd be better off not having a bare UTF-8 sequence in the
source like this, especially when you already have the same thing
backslash-escaped in the "expect" file below.  Perhaps

	NAME=3D"a-\303\244_o-\303\266_u-\303\274.txt" &&

	UTF8=3D$(printf "$NAME") &&
        CP1252=3D$(printf "$NAME" | iconv -t cp1252) &&
        echo "\"$UTF8\"" >expect &&

        >"$CP1252" &&
        p4 add "$CP1252" &&
        ...

or something along that line?

> +	>"$FILENAME" &&
> +	p4 add "$FILENAME" &&
> +	p4 submit -d "test"
> +'
> +
> +test_expect_success 'Clone repo containing cp1251 encoded paths' '
> +	git p4 clone --destination=3D"$git" --path-encoding=3Dcp1252 //depo=
t &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		cat >expect <<-\EOF &&
> +		"a-\303\244_o-\303\266_u-\303\274.txt"
> +		EOF
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
