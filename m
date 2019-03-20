Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BBE20248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfCTLwn (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:52:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33870 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfCTLwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:52:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so2443541wrq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wn4x3D8JlBRwYUB6wzTIzr2k0zGPOxe1NYGz1fm1iZo=;
        b=cDV80+gwqDaaPjVKe/WFhedoy6mnGssFZ8SxldX6J0zJmcefvB+WuMYe2NkSMpOPY6
         FhjoMZmnLCI8nq1qz3dUpntyDb7OkeLVdQvhg8fzlc3v+gL7alo3oC7GH54ZXBvNTWH8
         rTVYCJvYtg6Xd4+2KY8qAwaVv5K+2Kdcmmv2iKMyvjgUTIUHIN8PSbQOxOMH7eRpQg9k
         49m+QEAkMfh2W0Pu0h/3ChZMZubhLABZ4OLqoyz40JijOVCXEV9juqSLhMTC4KfQq/+m
         RBvbp+u/uFiqai8rqYiuklGXSXLtcIxwmERJVuh6m3BjIzqJ7oDHArFzpsLHtnplcyp1
         RHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wn4x3D8JlBRwYUB6wzTIzr2k0zGPOxe1NYGz1fm1iZo=;
        b=gvfpYzWt4WrNgrGWqBGme3q/naHD51olOM+6jJJ39EQULBPiAIV02x1wnlX8yIdcvp
         HJaL2q4U3TF88k1iQFee1GRWfiBwCsYNmqfe+1kDlArijrVvOR5f61bBamShHVbq7ZYJ
         TLFnccLnoOWFDrNwnk9nhzqnSCWY1NZZxsyivHC28iS+lPHw5FMJcsdwArO9F8+HwSY1
         OKMBURNmWIEFOmNubIk3Glr/i+ohywf2wAnRorQvQ34aUB8agScruZ2p2EJ2zI46hZJa
         7TIaVXB5Ji5ajcI+uQRGtbDGMkR92neYhf7UO6FBRE2pZKSmoVAmQy8HJB7ePRQR0YVq
         +DGw==
X-Gm-Message-State: APjAAAU9t2JPUj2+D8wq19/GrFNpV7kPU6fJ5MvSpPsmq/wayKQVttHj
        dlz5vEQ+KEH571CGtwHMmEO/PKfj
X-Google-Smtp-Source: APXvYqyi1KCC7nguSv69sefWF7V3aewnYf9Ddfcyuo1BY2dLUhTep8mnyzSmw5+buxLVIKqztKJXNQ==
X-Received: by 2002:adf:e949:: with SMTP id m9mr22766145wrn.1.1553082761667;
        Wed, 20 Mar 2019 04:52:41 -0700 (PDT)
Received: from szeder.dev (x4dbe3845.dyn.telefonica.de. [77.190.56.69])
        by smtp.gmail.com with ESMTPSA id n13sm2195952wrw.67.2019.03.20.04.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:52:40 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:52:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Dave Huseby <dhuseby@linuxfoundation.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/1] t/lib-gpg.sh: fix GPG keyring import options
Message-ID: <20190320115234.GA22459@szeder.dev>
References: <20190319232013.t5pmbgfgojjbczqh@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319232013.t5pmbgfgojjbczqh@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 19, 2019 at 04:20:13PM -0700, Dave Huseby wrote:
> Fix the way GPG keyrings are imported during testing to prevent GPG from 
> prompting for approval to change the default config. This appears to have no
> adverse affects on GPG users with "normal" configurations but fixes the
> always-interactive prompting I see with my multi-keyring setup.
> 
> v2: fixed the whitespace.
> 
> Signed-off-by: Dave Huseby <dhuseby@linuxfoundation.org>
> ---
>  t/lib-gpg.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 8d28652b72..e72e0554f1 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -32,8 +32,8 @@ then
>  		GNUPGHOME="$(pwd)/gpghome" &&
>  		export GNUPGHOME &&
>  		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
> -		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
> -			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
> +		gpg --import-options merge-only --homedir "${GNUPGHOME}" 2>/dev/null \
> +			--import "$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&

Normally an Ubuntu 16.04 LTS based box can run all tests with the GPG
prereq just fine, but with this patch it can't.

After making 'lib-gpg.sh' a bit more informative by adding 'set -x'
and removing the 'gpg ... 2>/dev/null' redirections it appears that
with this '--import-options merge-only' GPG can't find the keys:

  $ ./t7612-merge-verify-signatures.sh -V -x
  + gpg --version
  + gpg_version=gpg (GnuPG) 1.4.20
  Copyright (C) 2015 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  
  Home: /home/szeder/src/git/t/trash directory.t7612-merge-verify-signatures/gnupg-home-not-used
  Supported algorithms:
  Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
  Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
          CAMELLIA128, CAMELLIA192, CAMELLIA256
  Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
  Compression: Uncompressed, ZIP, ZLIB, BZIP2
  + test 0 != 127
  + mkdir ./gpghome
  + chmod 0700 ./gpghome
  + pwd
  + GNUPGHOME=/home/szeder/src/git/t/trash directory.t7612-merge-verify-signatures/gpghome
  + export GNUPGHOME
  + gpgconf --kill gpg-agent
  + gpg --import-options merge-only --homedir /home/szeder/src/git/t/trash directory.t7612-merge-verify-signatures/gpghome --import /home/szeder/src/git/t/lib-gpg/keyring.gpg
  gpg: keyring `/home/szeder/src/git/t/trash directory.t7612-merge-verify-signatures/gpghome/secring.gpg' created
  gpg: keyring `/home/szeder/src/git/t/trash directory.t7612-merge-verify-signatures/gpghome/pubring.gpg' created
  gpg: key CDDE430D: secret key not found: secret key not available
  gpg: error reading `/home/szeder/src/git/t/lib-gpg/keyring.gpg': secret key not available
  gpg: import from `/home/szeder/src/git/t/lib-gpg/keyring.gpg' failed: secret key not available
  gpg: Total number processed: 0
  gpg:       secret keys read: 1
  + test_have_prereq GPG
  + save_IFS=     
  
  + IFS=,
  + set -- GPG
  + IFS=  
  
  + total_prereq=0
  + ok_prereq=0
  + missing_prereq=
  + negative_prereq=
  + total_prereq=1
  + satisfied_this_prereq=
  + prerequisite=GPG
  + test -z 
  + missing_prereq=GPG
  + test 1 = 0
  + set +x
  ok 1 # skip create signed commits (missing GPG)
  [....]

