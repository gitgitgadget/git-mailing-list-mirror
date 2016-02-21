From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] merge-recursive: test option to disable renames
Date: Sun, 21 Feb 2016 13:01:53 -0500
Message-ID: <CAPig+cSaF73ff-RppOZWiS3Hm1skmqGj+tE9g6Y85hM1GnWn7A@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-5-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 19:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYLU-00015B-38
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbcBUSC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:02:56 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35554 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcBUSBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 13:01:53 -0500
Received: by mail-vk0-f42.google.com with SMTP id e6so112122757vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=H1Xwz9r8db5AML1G2a5lCCWRWgDx5fiV8+vxDq5zSsI=;
        b=oQT+Lju4Aw6U0hJYJ9RXnnRxb7SUlHfFuOjaN9uPC3Mf2PoYRoapQKinBOEzMEwaHW
         WDXN0pahCgEfjjiuor9Mk2LTQ3ovqbbgC7grq3sj8F4O8FDbN4AOCvML27FAF0NTGjjg
         Uw6TLXudIgbkHdx++VXyEyxukhCTu3tmlladLBBiXPGJrh6DAdl6b3bTuEeuYxx+JxMt
         lMyL+/pAcRqATusqDKPXC421zqk6Bxro2hQxAnR6+u/V2EnhFkz1Ic/XNjk8jukR2h9A
         mMSl4dI2xE6IEuZN7qQLhFxBJ5k8WW+AIV6FheTVv+TJFDUZyyK2WPo/CVbz+iaM5HgT
         NHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H1Xwz9r8db5AML1G2a5lCCWRWgDx5fiV8+vxDq5zSsI=;
        b=KguX8yu7uyRz7ByOFDvzCUIv6HPX6PSUSxhe7vFK7E0qg23wP74DjOq8QR+tNJVOOT
         acHPb9Wvvw4LaSvOGZN/PUCl5Ze0k2SsPEiRcRKvwJIXmQQrZe4CfMQjEk0spPPxoSX3
         aG5tGcdoipD0lQF7+zTJt0HKmd3z4uBUW5Wgq7gJSgudbQ2Tc0stHTX3L0Ff/Zw+bWvZ
         IQr//rkC67l4Xw7D8H5wtFGd98qPDRWkmGtWooDUQRQaUBWNwfdBGPDRwGeOz6gFpu0p
         35LBlB5i8GiVUnUCWAWqcgVu0PNDVbKps0q3Z5txQU2ctkRbu6fn7mBOfni5eKcYC7wH
         Wr1g==
X-Gm-Message-State: AG10YOT1/vyZ2g00NdoXPbVcYM/K1/5Niykx4MENnzat6VVxRCqh6zz77ijQanBSOiYSQi3WGqqGI6tMzrRRhg==
X-Received: by 10.31.141.2 with SMTP id p2mr20186845vkd.37.1456077713214; Sun,
 21 Feb 2016 10:01:53 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 10:01:53 -0800 (PST)
In-Reply-To: <1456067358-19781-5-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: NVe20o5UutNZwmZoMQ5EzknIqfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286818>

On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> Also update name and description of tests for consistency:
> "merge-recursive options"          -> "merge-recursive space options"
> "merge-recursive rename threshold" -> "merge-recursive rename options=
"
>
> Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
> ---
> diff --git a/t/t3034-merge-recursive-rename-threshold.sh b/t/t3034-me=
rge-recursive-rename-options.sh
> similarity index 83%
> rename from t/t3034-merge-recursive-rename-threshold.sh
> rename to t/t3034-merge-recursive-rename-options.sh

t3034 was entirely new in the previous patch (3/5) and could have been
given the correct name at that time, so it's not clear why the
approach of giving it a too-specific name and then immediately
renaming it with a more general purpose name in the following patch is
desirable. It should be perfectly fine to start with the general
purpose name even if the patch initially contains only very specific
tests (knowing that you will be adding more tests later).

> --- a/t/t3034-merge-recursive-rename-threshold.sh
> +++ b/t/t3034-merge-recursive-rename-options.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -test_description=3D'merge-recursive rename threshold option
> +test_description=3D'merge-recursive rename options

Ditto. This could have been described with the more generic "options"
from the start.

>  Test rename detection by examining rename/delete conflicts.
>
> @@ -137,10 +137,28 @@ test_expect_success 'rename threshold is trunca=
ted' '
>         check_find_renames_100
>  '
>
> +test_expect_success 'disabled rename detection' '
> +       git read-tree --reset -u HEAD &&
> +       git merge-recursive --no-renames HEAD^ -- HEAD master &&
> +       check_no_renames
> +'
> +
>  test_expect_success 'last wins in --rename-threshold=3D<m> --rename-=
threshold=3D<n>' '
>         git read-tree --reset -u HEAD &&
>         test_must_fail git merge-recursive --rename-threshold=3D25 --=
rename-threshold=3D75 HEAD^ -- HEAD master &&
>         check_find_renames_75
>  '
>
> +test_expect_success 'last wins in --no-renames --rename-threshold=3D=
<n>' '
> +       git read-tree --reset -u HEAD &&
> +       test_must_fail git merge-recursive --no-renames --rename-thre=
shold=3D25 HEAD^ -- HEAD master &&
> +       check_find_renames_25
> +'
> +
> +test_expect_success 'last wins in --rename-threshold=3D<n> --no-rena=
mes' '
> +       git read-tree --reset -u HEAD &&
> +       git merge-recursive --rename-threshold=3D25 --no-renames HEAD=
^ -- HEAD master &&
> +       check_no_renames
> +'
