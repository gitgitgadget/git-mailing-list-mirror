From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/21] t6030: generalize test to not rely on current implementation
Date: Sun, 10 Apr 2016 20:23:23 -0400
Message-ID: <CAPig+cQP8MgDZTbJZiFnp5XCAVKBmdH7VdgJrWsHX_cGtH2RDQ@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-6-git-send-email-s-beyer@gmx.net>
	<570A596F.9080200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>, Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 02:23:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apPdb-0004Wd-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 02:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbcDKAXZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2016 20:23:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34700 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcDKAXY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2016 20:23:24 -0400
Received: by mail-io0-f195.google.com with SMTP id z133so23394796iod.1
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Rz2LShJ5NjhoGul1VJkLJR50L+YsnzcbbvrRYHS7DuM=;
        b=i6HFwvhjrcoRvc6n/q6uRYq62Hk2lQ2EdfhZSiDDNLFlB+xCz/RcoDKBFWcl6/CvYa
         n1t6xEbx73YZy5AjWeTB8W/2Yk+7rf5Fq/sJzCCV+xWdsly5TUFpaUwk00Dbv1Mf75NF
         myfMw3WNVPX2aR6GOF70LlnUYJPzXL6PxjTv2NM5paXz2dI5o6qnSWk1ZmyVBdg3uAOK
         HP/LAFWcycYKcMsCEt6P4Gf7fucrdw13GH8/wv6Wp1phi0tNBWZmo0HJrZpcAExJHZII
         bimAiEWGbKBB5RhunNBU+YikXE71+jzTHWjqPhR5uupLwWZOY6st57YHcCTSblr3cYSU
         Wu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Rz2LShJ5NjhoGul1VJkLJR50L+YsnzcbbvrRYHS7DuM=;
        b=YykiI65qOAC3e5HBEMloVr4T91siKvKay4C6GtU+RjjiP2CCzXQOSO2Dv7vcJVIYst
         GtwYvdL17lztLftOIqJ04ymTLXzasM5uzj9RQWVAIviNTjQXOEivAcTEnwPSMA7oddya
         Vnswc6elMKdqLFapFhzu+MM9B42EBgiuw3C7kJac2lHsxnvOTjmhEtH4zMLcmDG12l/p
         9phK5uJQAGVboDSk6DHXN5qBa8qf5D8smJBw73i36JHKOrxy1zGZA3PRP4WQ+w3AD5Pl
         5Jr1+luULmxaiX4Vjq0ttUqxA4joTZqhJSk9K5XL/pOdqWuud22nvOKJVcf+A17yYtvK
         /Jgg==
X-Gm-Message-State: AD7BkJLj+g/6SNAn6i7RZdGZYoAk129uwIJk3AdxdMtVAQ2uWfqtfCRO84mjjlz6WSes0IN7na0sdqhp2ym+Yw==
X-Received: by 10.107.9.28 with SMTP id j28mr20736124ioi.104.1460334203965;
 Sun, 10 Apr 2016 17:23:23 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Sun, 10 Apr 2016 17:23:23 -0700 (PDT)
In-Reply-To: <570A596F.9080200@web.de>
X-Google-Sender-Auth: rm_b2rvx-vx7dg93M72_bgu37YE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291196>

On Sun, Apr 10, 2016 at 9:47 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 10.04.16 15:18, Stephan Beyer wrote:
>> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.=
sh
>> @@ -10,36 +10,34 @@ exec </dev/null
>> +     if [ -f "$_file" ]; then
> I know that the old code did the same, is there a chance
> to adopt to the git-style:
>         if test -f "$_file" ; then

Hmm, isn't the preferred style?

    if test -f "$_file"
    then

>> +test_expect_success '"git bisect run" simple case' '
>> +     echo "#"\!"/bin/sh" > test_script.sh &&
>> +     echo "grep Another hello > /dev/null" >> test_script.sh &&
>> +     echo "test \$? -ne 0" >> test_script.sh &&
>> +     chmod +x test_script.sh &&
>> +     git bisect start &&
>> +     git bisect good $HASH1 &&
>> +     git bisect bad $HASH4 &&
>> +     git bisect run ./test_script.sh > my_bisect_log.txt &&
>> +     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
>> +     git bisect reset
>> +'
> Portabily:
> Since yesterday/yesterweek the usage of hard-coded
> #!/bin/sh had shown to be problematic
> Junio posted an update like this:
> -       printf "#!/bin/sh\n" >diff &&
> -       printf "printf \"\$GIT_PREFIX\"" >>diff &&
> -       chmod +x diff &&
> +       write_script diff <<-\EOF &&
> +       printf "%s" "$GIT_PREFIX"
> +       EOF

It might be nice to have these style fixes and modernizations as a
preparatory cleanup patch.
