Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FB41F406
	for <e@80x24.org>; Wed, 16 May 2018 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeEPRSf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 13:18:35 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40648 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeEPRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 13:18:34 -0400
Received: by mail-yw0-f193.google.com with SMTP id p144-v6so464323ywg.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qZmziWWoHoaEGV7FBTtyGfniy7oMt1G2HAXbgL8Ilxc=;
        b=mzD4fxk5x1kTOclER4HELVIdTOXxDHCfe408YeoNf2xaqUJX3kk9geyfL+y4mJ4fV6
         TBlKX5zz2C888ZMPrUreOvNAup5HNfi/U55T/6Wt/BMWp2sSLdp0UAMYHlrbiMNxCEuy
         MnG3xmj+1bsl5zjXZVrkOGjePBv7zo6u3WEIcgwvCFRAczGSX71Xn1c1viuICwx9J0XP
         SYz2DTUwvVgCf3mOqDBFtVgD0xDmKds5NdM4CG+Srd9Z2DceX04+VGEAkvru7D2mgP2V
         q3WsJ6e43iTZDMmC7//bTqTBxZJfZi4mXDoxcERugdVWkx4ICSG6+Q47whPr0BXmyPVy
         DOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qZmziWWoHoaEGV7FBTtyGfniy7oMt1G2HAXbgL8Ilxc=;
        b=Lu/+cFCCUyWIKf4HYA+xGOfQiOU9er4pc7ZEweN6dNq4lo5b3zXHC8uqsoxVyfI894
         N9xRdBaT0Js+LSYy0eKElajQYTvO0uiblb9b5uj0UGcbsjqVlZejvnsE/gWE9WRXzBGi
         XyFexlGGeAPuq0WEE8QeXEet8N10SfQICr9WL2JVhtsu4CdCD+iTFbHKWcFqxb8lKWDk
         8vzXsJWsKtj/ZhoM6QVfu/yQ31RON/SufUjtGYB0rw32Hexy3zTJa6s3WAKaI42TWDnF
         MotaqrbBi/PO/RWmVljkRd3HeyJrp7jucPZ2QEYhI8Mvy3rMWV002FZgBNNKFi1BCOXi
         kMsw==
X-Gm-Message-State: ALKqPwcwD2F23jx/UOjK6u7ODwq6vpSKvVQlT8Dc6F7EP7LdErD6eDr6
        Hos1bDr/hpkVdedvheCX1shR6nAYv7fGjE/pj00f5w==
X-Google-Smtp-Source: AB8JxZpV4AFurkjrN2pTb1hCzFeho7F1R0Tbm4Ns1+8BdOlAyU9frco6CqqUhbdiEx5A7nPuVPrddl4UEBNA4GX7WBo=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr958569ywa.340.1526491113614;
 Wed, 16 May 2018 10:18:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 10:18:33
 -0700 (PDT)
In-Reply-To: <20180516015630.661349-14-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net> <20180516015630.661349-14-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 10:18:33 -0700
Message-ID: <CAGZ79kYrDDGtSSViUwqOaJCTUUcUaiJe1DQHGSqS+3SCYnEv8g@mail.gmail.com>
Subject: Re: [PATCH v3 13/28] t3702: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 6:56 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Strip out the index lines in the diff before comparing them, as these
> will differ between hash algorithms.  This leads to a smaller, simpler
> change than editing the index line.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t3702-add-edit.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
> index 3cb74ca296..1be5cd5756 100755
> --- a/t/t3702-add-edit.sh
> +++ b/t/t3702-add-edit.sh
> @@ -40,7 +40,6 @@ test_expect_success 'setup' '
>
>  cat > expected-patch << EOF
>  diff --git a/file b/file
> -index b9834b5..9020acb 100644
>  --- a/file
>  +++ b/file
>  @@ -1,11 +1,6 @@
> @@ -80,7 +79,6 @@ EOF
>
>  cat > expected << EOF
>  diff --git a/file b/file
> -index b9834b5..ef6e94c 100644
>  --- a/file
>  +++ b/file
>  @@ -1,10 +1,12 @@
> @@ -100,7 +98,7 @@ EOF
>
>  echo "#!$SHELL_PATH" >fake-editor.sh
>  cat >> fake-editor.sh <<\EOF
> -mv -f "$1" orig-patch &&
> +egrep -v '^index' "$1" >orig-patch &&

This reminds me of the way we test alot of the patch format already.
But there we use standard grep as opposed to egrep.

git grep egrep doesn't show a lot of hits, but all commits
that mention egrep found via 'git log --grep egrep' mention
that there is some sort of portability issue for using egrep
specifically.

Is the ^index a problem for standard grep, i.e. do we need to fix
other places?

$ git grep -- "-v index"
t4061-diff-indent.sh:318:       grep -v index out-diff-files-raw
>out-diff-files-compacted &&
t4061-diff-indent.sh:327:       grep -v index out-diff-files-raw2
>out-diff-files-compacted2 &&
t4061-diff-indent.sh:336:       grep -v index out-diff-files-raw
>out-diff-files &&
t4061-diff-indent.sh:345:       grep -v index out-diff-files-raw2
>out-diff-files &&
t4061-diff-indent.sh:354:       grep -v index out-diff-files-raw3
>out-diff-files-compacted &&
t4061-diff-indent.sh:363:       grep -v index out-diff-files-raw4
>out-diff-files &&

The commit message seems to be the same at most of the patches
in this series, which makes sense, but a mention regarding the choice of
grep would be appreciated!

Thanks,
Stefan
