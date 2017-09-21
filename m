Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6F2202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 21:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdIUV2x (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 17:28:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35207 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdIUV2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 17:28:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id j16so4079791pga.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+0XmePc2mlvjAC+Iw9MzAlbcNT5iYfvD1nfT+NKXbTM=;
        b=AKZCuo0S1FQpIwKwnOQZvxWbY7WneVHE8/CMcl23H+/ZYT3SDtZU5b4zXSf0MBjjtL
         BNBoWas8wKLRjF+Zq/kVW3xayI+Rko9dz4XTVdyE+GG/UHL9VH8E8sPHz3mvQONZi69V
         4bOFMbHlK6UfcAF6EN18QkxN8rsp76i89oBG8cDGwMVgjsgBqrAS9FEh1iS3HRPLukCF
         htoN9MqLbuvZm25DTePV4cyqXYEePdcGTEs62BLVds8UhuMmteuwsLRIImaL6dJ7heLC
         yPSkrNrcLqb7UdAecEuNT5JXlicTKFSMEvV6EkQ7Sroq34p/l1s9gi5c102kjPwvB1Kf
         p2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+0XmePc2mlvjAC+Iw9MzAlbcNT5iYfvD1nfT+NKXbTM=;
        b=IiItj1dMw9fKGhvjorsaC2S0TtD89wLVhWP2C+nkc8OL0H0Hb4mGXKZV8o8IZtN1J1
         Qr0fwR7Zcq9n6sDsL8dChi3k9yFOlNMb7q8B9hn36XAKn1yAGKGGcZ//2g34on81BzWw
         74Gy5sj3MwPaZeYs7yXNEy9n55EREByoRGJnRplFwwfv2l0RM03TZlitOB4RY9oJDl3a
         tKnQ8hqJrX7O1m8I7yndcXFNbtrImR8RMfd1usIA7Jwu4Y2zcB+mTIVbycmc99Y9kHpA
         D/G96eq7m+jjl/6H6jTXj4kAnU1Fg23jnmjJDIDZava5gpU62siFwSmgR+wMJPROACJN
         XiKQ==
X-Gm-Message-State: AHPjjUi4nMeAJLznYqKWAnIadDJY/nBqUZu95iXzKVutWIPrrwBr4JGa
        9wHvsr7J6eyD5uUmreXonHo=
X-Google-Smtp-Source: AOwi7QCH8on+D/3/QZfV7+QQPtevGIsmAHYCATKW+LLyZuUHuqsDRVLSuzgjb2eXggIJlez5KTra6A==
X-Received: by 10.98.193.2 with SMTP id i2mr6756940pfg.207.1506029331416;
        Thu, 21 Sep 2017 14:28:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:217a:913b:5a28:6f69])
        by smtp.gmail.com with ESMTPSA id l12sm4628789pgp.74.2017.09.21.14.28.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 14:28:50 -0700 (PDT)
Date:   Thu, 21 Sep 2017 14:28:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v1] travis-ci: fix "skip_branch_tip_with_tag()" string
 comparison
Message-ID: <20170921212848.GJ27425@aiede.mtv.corp.google.com>
References: <20170921204830.66831-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170921204830.66831-1-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com wrote:

> 09f5e97 ("travis-ci: skip a branch build if equal tag is present",
> 2017-09-17) introduced the "skip_branch_tip_with_tag" function with
> a broken string comparison. Fix it!
>
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Thanks for the fix.

09f5e97 appears to be for the ls/travis-scriptify branch, which is
already part of "next" (if it weren't, I'd suggest just squashing your
patch into that commit).

> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -14,7 +14,7 @@ skip_branch_tip_with_tag () {
>  	# of a tag.
> 
>  	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
> -		$TAG != $TRAVIS_BRANCH
> +		[ "$TAG" != "$TRAVIS_BRANCH" ]

Git style is to use 'test' instead of '[' for this.  See
https://public-inbox.org/git/2f3cdc85-f051-c0ae-b9db-fd13cac78aed@gmail.com/
for more on that subject.

Could you squash in the following?

Thanks,
Jonathan

diff --git i/ci/lib-travisci.sh w/ci/lib-travisci.sh
index c3b46f4a7d..b3ed0a0dda 100755
--- i/ci/lib-travisci.sh
+++ w/ci/lib-travisci.sh
@@ -14,7 +14,7 @@ skip_branch_tip_with_tag () {
 	# of a tag.
 
 	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
-		[ "$TAG" != "$TRAVIS_BRANCH" ]
+		test "$TAG" != "$TRAVIS_BRANCH"
 	then
 		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
 		exit 0
