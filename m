Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA281F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeFIJqV (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:46:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34305 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeFIJqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:46:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so5007684wmc.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOVi+x+e1uyk4wp+bbndgRjqLWftniyCN5eT8XIlYGI=;
        b=u9QWa7SgV9bSKGHEdyj9WwdAq7y+jGskDFWfCfkATJ/qHPxY9fEkLdy9OT30Z2IAjJ
         /rMzHMbllnSGM3Zgn95iTOG3bT2yOKGGgANQQsRcRv9aCLg7WEVjBkXVf2th9RyiG0q0
         KYGJno+4y1s/Q5n0NvKNFQHyW+lN1gvPYgTEeWiTTcsldGHZMVVHVi8Th1O5isi27cQ/
         loYz/l72Sr1RHfGuEr/0cJlv+WhP4QqAd21y6P72SY7EzuVbnPO0au0MSyR0a6BX5Cpq
         yZw0x+q9mPNN6etWvRvPZ9+YaWIbpUA1DmQG8hv89sPQj13DzzctJzWmnC1OMRaMyWFw
         tXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOVi+x+e1uyk4wp+bbndgRjqLWftniyCN5eT8XIlYGI=;
        b=DWE/GG2s+w68zpe+tiWoiBJOph4LBZbb2TrJqs05NEHI3Gh03XWPhSxbe/aImo25KD
         jMgSKc0EwOqgXmlVZSR1FQ5PeGQTtZazZxAq/5CLY4aSbDEQqjO+DKJhskvXMuSBgwjY
         s8xhfbKo/thAFOX8dqZ5trGUhMJNJWHPE0ihoCKP4lJIJ3rPm8nh8h+v8h9LPWjaNVwP
         dtXIt4fQ8m1uiSodvG/JWoszJu0Bh5xz4Q0uCTRjmPWkTsaK4antkz26Z+Hivgk13vho
         DoLkqVYZRx2JhR2ipsR4wIRiwa/MEvO4YN1CTG/Juu+OFadq9YawY/Ebo+Vdgx763uDR
         1IZA==
X-Gm-Message-State: APt69E03/FIlSAAQou1WK/c/MsjFGuqwflRS/8z+PvA0o2yzJ3ijpBuq
        8HZPmqdrYoUoQUCGTvcmheg=
X-Google-Smtp-Source: ADUXVKKNU5FHLYboZQpMP0eHngu2MUJi0dGFLQnocSpjwpWGgo+cdq5xdoZP8Tj2uRKQS5eaoADLhg==
X-Received: by 2002:a1c:934e:: with SMTP id v75-v6mr4045433wmd.52.1528537579372;
        Sat, 09 Jun 2018 02:46:19 -0700 (PDT)
Received: from localhost.localdomain (x4db10187.dyn.telefonica.de. [77.177.1.135])
        by smtp.gmail.com with ESMTPSA id h7-v6sm2599475wmc.44.2018.06.09.02.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Jun 2018 02:46:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] t7415: don't bother creating commit for symlink test
Date:   Sat,  9 Jun 2018 11:46:13 +0200
Message-Id: <20180609094613.17675-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180609093118.GA8942@sigill.intra.peff.net>
References: <20180609093028.GA8864@sigill.intra.peff.net> <20180609093118.GA8942@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As a result, there's no need to create a commit in our
> tests. Let's drop it in the name of simplicity.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7415-submodule-names.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index a770d92a55..e2aae587ae 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -141,7 +141,6 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '

I add few more lines of context here:

                tree=$(
                        {
                                printf "100644 blob $content\t$tricky\n" &&

>  				printf "120000 blob $target\t.gitmodules\n"
>  			} | git mktree
>  		) &&
> -		commit=$(git commit-tree $tree) &&

This was the only case where that $tree variable was used, so perhaps
that can go away as well, in the name of even more simplicity?

>  
>  		# Check not only that we fail, but that it is due to the
>  		# symlink detector; this grep string comes from the config
> -- 
> 2.18.0.rc1.446.g4486251e51
> 
> 
