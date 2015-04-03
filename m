From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 1/4] git-p4: fix small bug in locked test scripts
Date: Fri, 3 Apr 2015 15:02:16 -0400
Message-ID: <CAPig+cSd6vZagHnWktUmv+nQe99yi28nkGLhF8Ks08A=p1UzYw@mail.gmail.com>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
	<1428087218-8186-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6rH-0006G7-92
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 21:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbDCTCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 15:02:19 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34280 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbDCTCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 15:02:18 -0400
Received: by lboc7 with SMTP id c7so83660550lbo.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=e0kAaBfDoDfYlLtO6GGigqbCCgWlQx4EfmHeqgTNuYU=;
        b=z+4AdQ19d4Ek/4K5rSB1K59VUYxTgzE93PayUX5FdO3Q2+pG/esu8fOqOJ7uYCsekr
         9sJPWEfw7uAi3W+PEGwO2gTXkoJ8qDxJLMxkxvoQ7RW52gGFqEM6zc1P2PkMie8aLE2x
         HRAzzH97wv3yJNw7rD9og9qbTpRbRCvskpEB1JR3v+xETe0VqFDcXqwm5WvLgIyB9QwY
         BlP81fqIdk6FHijTCax07/lKIwDdLl9iSOsyXY5QhZqZwW8E6mdVdIkGC+Joxob6Xc1a
         fOUu1nSdJwzMdc9vwIN05O9Ts63o3UbVX0EF+x6BlSkmb7Rp8CIoWtf3G6wUUl3hO0vz
         f1mg==
X-Received: by 10.152.219.2 with SMTP id pk2mr3230496lac.107.1428087736758;
 Fri, 03 Apr 2015 12:02:16 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 3 Apr 2015 12:02:16 -0700 (PDT)
In-Reply-To: <1428087218-8186-2-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: PuGv0wWEsL9zBxTgxFDv8dZNsbU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266721>

On Fri, Apr 3, 2015 at 2:53 PM, Luke Diamand <luke@diamand.org> wrote:
> Test script t9816-git-p4-locked.sh test #4 tests for
> adding a file that is locked by Perforce automatially.

s/automatially/automatically/

> This is currently not supported by git-p4 and so is
> expected to fail.
>
> However, a small typo meant it always failed, even with
> a fixed git-p4. Fix the typo to resolve this.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  t/t9816-git-p4-locked.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
> index e71e543..ce0eb22 100755
> --- a/t/t9816-git-p4-locked.sh
> +++ b/t/t9816-git-p4-locked.sh
> @@ -41,7 +41,7 @@ test_expect_failure 'add with lock not taken' '
>         (
>                 cd "$git" &&
>                 echo line1 >>add-lock-not-taken &&
> -               git add file2 &&
> +               git add add-lock-not-taken &&
>                 git commit -m "add add-lock-not-taken" &&
>                 git config git-p4.skipSubmitEdit true &&
>                 git p4 submit --verbose
> --
> 2.3.0.rc1.30.g76afe74
