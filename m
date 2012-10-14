From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t0003-attributes.sh: Don't overwrite t/.gitattributes
Date: Sun, 14 Oct 2012 09:37:09 +0700
Message-ID: <CACsJy8B0n8O74pXMqbzEjSuoJSuWd=MW+zZJakTZ5z6WhVMWng@mail.gmail.com>
References: <5079A881.7010802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 14 04:37:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE5O-0006q1-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab2JNChk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 22:37:40 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:62534 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2JNChj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:37:39 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2896617iag.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KT7cKnyKaoJlWhpNuHbgssud/1neSLDgccFWa8njjUw=;
        b=uYjANli9d+WZNnUc2Bo/t41HJ/wuEYTMhaSEBROMeuKqRxnwR4mxYeljJQC8CMTL2m
         4NJt00urZcWt3oyjR6ugd8k+W3fae9/9YM/0V7QGx1OO9GhDV0nl/dpOOdVt2vR3Uy8W
         dMCO4dkCzO4wCHASwunyH/uq+PCj+77BGnjiA1GiQq1QXXxd2UbPcAJxLgDEBDkxBmFz
         CymouP7NQ2A0wxFNoHy/F5k5r7SuG0qNlvEiLwIl047rDWvOjXQ+G9ER+ITDMm1p6oEk
         wPpBZNFqqpBJNNarB/064Hi9y1qc+t4GdhFibQ81wG4AM8BMZJpykE+eg1litVtE8rc3
         RFag==
Received: by 10.50.153.130 with SMTP id vg2mr5660546igb.26.1350182259407; Sat,
 13 Oct 2012 19:37:39 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 13 Oct 2012 19:37:09 -0700 (PDT)
In-Reply-To: <5079A881.7010802@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207604>

On Sun, Oct 14, 2012 at 12:44 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> This test in the current pu branch (commit bb0e6bf "Merge branch
> 'aw/rebase-am-failure-detection' into pu", 11-10-2012) overwrites
> the contents of t/.gitattributes. Note that the merge of the two
> branches 'nd/wildmatch' and 'nd/attr-match-optim-more' both add
> new tests at the end, and *both* sets initially 'cd ..' ...

I'm resending nd/wildmatch to move the tests before bare repo tests so
"cd .." is no longer necessary. nd/attr-match-optim-more has the same
fix.

>  t/t0003-attributes.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 7ed288f..fe80af7 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -247,7 +247,6 @@ test_expect_success 'patterns starting with exclamation' '
>  '
>
>  test_expect_success '"**" test' '
> -       cd .. &&
>         echo "**/f foo=bar" >.gitattributes &&
>         cat <<\EOF >expect &&
>  f: foo: bar
> --
> 1.7.12
>



-- 
Duy
