Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DAF208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdHTK2E (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:28:04 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38755 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbdHTK2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:28:03 -0400
Received: by mail-wr0-f180.google.com with SMTP id p8so11554251wrf.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2thk+JJQcXEpZAcr6zBHudC6MJOGR7fa3OLyg88LN6k=;
        b=SseXUx1Iy8lA2MjXHc/TxPKFmBPHjh2iGyN9YC0IhEuVdzTO4/K5alBN3a9kzjT6Ak
         Zf0T+m6/pwX/xv2CsygoZDtwfc8oY+LSWHAWK6qUb5gNGsoI0YMR0K9YJUR99RWgTspH
         AHgU53IPBBo5L01CV9MMStleD3KsgCePz1+wcASSGAHXe0hYH0Zqjzf+jEYD8w3q5wbp
         st30IvvPKxAuUpx5PfZKTMJCM3m+RPZWMSU6hycH8crAL4PcmOpuNrfEKAdwHns7gLRn
         yYJvDAY3+PmF9+KVWctNho5LZlH+KYTf7p43Nf8H6dCR8njR2XNeMOjke7HxYblDM0Wv
         +HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2thk+JJQcXEpZAcr6zBHudC6MJOGR7fa3OLyg88LN6k=;
        b=BG64p5bHmYal7DySPYVMtdw7BYNiHKnEHGmmxsKyydYgebwi8gmJ9vZMfn5YrXGH71
         QwKBbDALx//iyHC071rIC5B5sl2dJoIWFmd3i97PUEI4GtM+eUWfghZ/gbG+0ZRDu+J5
         gljHbJQZ0ZC/5YvcnaHkHE8FBUqwF+1dCTg6tEjsi1aV6Gveu0DUKPL0MTYpjrAECZ8S
         l7N7Bj1yb8uy+Ys4pRRZnyE1RupW72IlOQl9m1PSBIx11Rz3LiRR25lT7QRE2enW+F2p
         gE8T0awG/4QHGF9H3+i0tuC3JcQwcqij1G5mk5FEHLN+rcRcu97v/ylHh4SWpOrd2f1q
         lOhw==
X-Gm-Message-State: AHYfb5h825iZgAX0yPsAEjCPJfSMhUTeULyD61IJh/nmlLrJQXnXl+au
        8XgLdowmOdApvr7/
X-Received: by 10.223.198.198 with SMTP id c6mr10283276wrh.148.1503224881455;
        Sun, 20 Aug 2017 03:28:01 -0700 (PDT)
Received: from ?IPv6:2001:a61:1095:9b01:f9a8:a32:94cd:946a? ([2001:a61:1095:9b01:f9a8:a32:94cd:946a])
        by smtp.googlemail.com with ESMTPSA id b133sm2399144wmh.21.2017.08.20.03.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 03:28:00 -0700 (PDT)
Subject: Re: git-svn: Handling of branches created from subfolders
To:     Jan Teske <jan.teske@gmail.com>, git@vger.kernel.org
References: <1ED00C5D-177C-4F95-8261-BFB7345B7C08@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <8c910a5b-ed96-41d4-d157-f138af51011f@gmail.com>
Date:   Sun, 20 Aug 2017 12:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1ED00C5D-177C-4F95-8261-BFB7345B7C08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.2017 um 14:45 schrieb Jan Teske:
> Is there any way to fix such branches from subfolders in a way that they integrate correctly with the converted git repository, without losing any (or at least too much) history? If this is not possible with git-svn directly, maybe I could prepare the SVN repo or post-process the converted git repository somehow?

You can use `git replace --graft` to connect the first commit of the
loose branches with their source. After all connections are in place you
can use `git filter-branch` to make the replacements permanent.

This will not change the content or directory structure of branch1 or
branch2 but the diff with their parent commits will show up as a huge
delete/rename operation. So merging/Cherry-picking between trunk and
branch1/branch2 will be ... challenging.
