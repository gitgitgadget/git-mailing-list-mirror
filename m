From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash: handle specifying stashes with spaces
Date: Sat, 30 Nov 2013 19:41:56 -0500
Message-ID: <CAPig+cTRhb9vwMSsw9n6JF-00rFnToZtSuGnWAwNMaUcvvg5KQ@mail.gmail.com>
References: <1385752979-28162-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 01:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmv79-0002o5-F9
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 01:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab3LAAl7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 19:41:59 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:41047 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab3LAAl6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Nov 2013 19:41:58 -0500
Received: by mail-lb0-f182.google.com with SMTP id u14so7874790lbd.13
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 16:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+DCO/d8S/to+IqdaMDcBh1vNvMMp62ZgEIpbmTvTO2w=;
        b=EKXbl4aFDVlHIYCjQ/RT3YpAh0mB20ULv29DBuuAbgmupOaUvTJ4PbiRALant6EaLu
         8XCdIq9vMVnaoIBAqaFDG/SMxGhdT1PkfNTQSSxjsy2zc9XKZAyKIm+qLxA8I/6R0gg8
         n5A9hMb3Gi8cqWo4OEXk3Vdk+gixaE7hC20AKojzM9/OmEjk2Fx0VebCGHj/ooWynkyh
         m9OlHt+SFUkIVyEw5kaApgeQ96VpzxbLiG60LONK+RIbpgq66kWHQ67PWcUeBYc1xcia
         EnwABI82SUC4NN1zdZ3GM+5C8ei6mFbBAwmIESMJcx8f3HsoCu3AFQ9urNefCpkqhP/v
         YYJw==
X-Received: by 10.152.234.231 with SMTP id uh7mr4798736lac.10.1385858517042;
 Sat, 30 Nov 2013 16:41:57 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Sat, 30 Nov 2013 16:41:56 -0800 (PST)
In-Reply-To: <1385752979-28162-1-git-send-email-oystwa@gmail.com>
X-Google-Sender-Auth: o79t2LT-efMDhATbgCpWJlw9dSE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238575>

On Fri, Nov 29, 2013 at 2:22 PM, =D8ystein Walle <oystwa@gmail.com> wro=
te:
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index debda7a..0568ec5 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -673,4 +673,15 @@ test_expect_success 'store updates stash ref and=
 reflog' '
>         grep quux bazzy
>  '
>
> +test_expect_success 'handle stash specification with spaces' '
> +       git stash clear

Do you want && at the end of this line?

> +       echo pig > file &&
> +       git stash &&
> +       test_tick &&
> +       echo cow > file &&
> +       git stash &&
> +       git stash apply "stash@{Thu Apr 7 15:17:13 2005 -0700}" &&
> +       grep pig file
> +'
> +
>  test_done
> --
> 1.8.5.1.g359345f
