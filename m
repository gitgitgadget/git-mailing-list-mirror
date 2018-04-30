Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DA1215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeD3PdH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:33:07 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35271 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbeD3PdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:33:06 -0400
Received: by mail-ua0-f193.google.com with SMTP id a2so5203915uak.2
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qrHmGiMjD2acIfNnIyq7/EdSC76QUqZArfEGgk+bFqM=;
        b=NM5hQnFNZTSb+/mUfJBU0HsYUX19+ZLeEd2JYvAtVYsUNKkvS2Yc/bzx2EYwARlJOx
         b3lAf7CLWSWc7MyZ3CXxt/R1Rn4vogFgNH2CAQW5yv89E+kI+FMcHlfC9hafPNSe0vVM
         OjtRFw/FvCjJVl+OvNpWc6GTp2EEdYrrV0/H+2ykA1YW8HRMfGOawuKLEsmb5XN5KEsZ
         bcdrysW6BqZfDmH+5MDmOYPd1XAaYJNfihvRtUbivSYtyhlfGpGMzMtKldgU9IWoU/B5
         0FfbyOUmrfRV/wRmVM/nalwQdSctEO/eatTFcR3TYY075HoYtYVaZz7p1IKcia5tkgjG
         vXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qrHmGiMjD2acIfNnIyq7/EdSC76QUqZArfEGgk+bFqM=;
        b=onVa5tn0gGhHF8JYXnBgKlWQY8GPWJPS5EiGfiHK2vaq51ZI0yJs6lqVcIAFOPqJnr
         KnH1jGNe2B1HaAhWjNobSboiG+wpXswjvSoB5njsJufuhHJV7+jAIzaZF6ilxRH+D8Zc
         aCX3rBSEdSwOWD5UEUadcH94M7dplF6BwcYyqPjwwtfsRUpvWfCKgonqVN9lBPXCquaw
         n2MEa4Ymnx9Xb+hmGAkM/NndVCv5ObHdaNoNbrufoPAtrphfQYmQEKXojTHxcPOcF4sW
         U+/XgMv1WiWGStVlZsnPCBybaLDYEt2FWsZE5qZ2LQ46WkZqgEg1e/uEe7JpiRjxvypY
         Zfsw==
X-Gm-Message-State: ALQs6tBzQZKo7TssPvy3ykE9PxbMvLHZia3lRGg0yeEQ+jfunidjpWzW
        ifuTfJheC2gdbaBIN+oB4FMuTVyA/rQ5P90tI7c=
X-Google-Smtp-Source: AB8JxZocVP5DZEpkALD5CSI/ZAE0zSuyzZmy11SWDvzKd+9DwLuGu12Y8v8y5nYEEO6GuW9Nf8O140kVOvtPq1ywYok=
X-Received: by 10.176.83.38 with SMTP id x35mr9505913uax.29.1525102385639;
 Mon, 30 Apr 2018 08:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 08:33:05 -0700 (PDT)
In-Reply-To: <20180430063519.27122-1-tboegi@web.de>
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
 <20180430063519.27122-1-tboegi@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 08:33:05 -0700
Message-ID: <CABPp-BHa7y8ggoCoLY0z4_=3njH=UV8GscXaz_YWvfNbfmPxhA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for APFS
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Apr 29, 2018 at 11:35 PM,  <tboegi@web.de> wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> On HFS (which is the default Mac filesystem prior to High Sierra),
> unicode names are "decomposed" before recording.
> On APFS, which appears to be the new default filesystem in Mac OS High
> Sierra, filenames are recorded as specified by the user.
>
> APFS continues to allow the user to access it via any name
> that normalizes to the same thing.
>
> This difference causes t0050-filesystem.sh to fail two tests.
>
> Improve the test for a NFD/NFC in test-lib.sh:
> Test if the same file can be reached in pre- and decomposed unicode.
>
> Reported-By: Elijah Newren <newren@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/test-lib.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ea2bbaaa7a..e206250d1b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '

I'm not sure what "NFD" and "NFC" stand for, but I suspect the test
prerequisite name may be specific to how HFS handled things.  If so,
should it be renamed from UTF8_NFD_TO_NFC to something else, such as
UTF8_NORMALIZATION?

>         auml=3D$(printf "\303\244")
>         aumlcdiar=3D$(printf "\141\314\210")
>         >"$auml" &&
> -       case "$(echo *)" in
> -       "$aumlcdiar")
> -               true ;;
> -       *)
> -               false ;;
> -       esac
> +       test -r "$aumlcdiar"
>  '
>
>  test_lazy_prereq AUTOIDENT '
> --
> 2.16.0.rc0.8.g5497051b43
