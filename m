Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55BC1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbcLHSEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:04:05 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33367 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbcLHSEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:04:05 -0500
Received: by mail-qt0-f182.google.com with SMTP id p16so417764953qta.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FUmusYJB6cilThOd0mQNtDBIBVnfB9rNy+p31oG27aY=;
        b=gnsszjEYEz2K8DxiBxVjtFFkzs8dZpLOyOiXDfV1NOde1RmSbEb/nGmcjWKLV5T6cE
         OcF+QdtdUkv+QQCmFaDEBFzW0xCJz0aD3BUDmUbpRN+PN1cETiXKSRyFlmQCJDR+zzm2
         W+vWiHDFmD13gUeRtjC7hriPF3mmclxqdQ5n1n6uSA/0xNNULejOS70P496RFRxS0swI
         6BkHNDQarE+CcD5FSsKsrsDkx942QAr9M0Vs3sTfY3FUlOGQDBCFqwu/k8ejwfGqALs3
         m7y3SqNDauY75kYZAIxjVSGEI+jOYio4ObGfsVRGqQyU/FCUkjp2+Q3WY8MEi7ZLuTkp
         sdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FUmusYJB6cilThOd0mQNtDBIBVnfB9rNy+p31oG27aY=;
        b=ElW6ZVjz6dE5kwtE8YDcEawBeAiXoRYVQ0E4RN4DQnbuAVw/CzgsIUzwbCZe/vTpWG
         zYzufQCDuhh1UW3wQKOyPPBfsBUVZNhFn5JNEgFwy5S6PDfhcaywwGFR+PICDRlW9iVr
         NHMPIwleozJe+ta9yYm1ef/e884RKSy7k+wmxXQxTtlTCfZvXJlCs8kNABcVyVs4rshK
         TO9Rh7sLKq0RsPOAAIMlCRSlopT3wsti2ssZEv6gBo3grlKCizk7UNFg1j9B/JaLr1Iu
         87IHXrxjTuPxu3rf/STsPCQnlYJh5KzEoy+rEEnSG2cc+2r4VS24X97EHEo1bAs+7Gh0
         zo7Q==
X-Gm-Message-State: AKaTC00stQcit0AiCQxBWfjXUkJbrEg6yykg2IPxIaYyJUcK8dWTDNe2ih2a4JkrLxaViZFLUTIVRyO8jRMuSVyq
X-Received: by 10.200.53.9 with SMTP id y9mr64009601qtb.176.1481220243978;
 Thu, 08 Dec 2016 10:04:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 8 Dec 2016 10:04:03 -0800 (PST)
In-Reply-To: <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
References: <20161208003940.28794-1-vi0oss@gmail.com> <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
 <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Dec 2016 10:04:03 -0800
Message-ID: <CAGZ79kbbi1J3BgQF-Ws0Ud-4h9efuQJTdsiA7Skh1fZXH5xqgg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     Jeff King <peff@peff.net>
Cc:     vi0oss <vi0oss@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 9:46 AM, Jeff King <peff@peff.net> wrote:
>
> will both trigger on the &&-chain linter, because it uses a magic exit
> code to detect the breakage. I think the problem is just that the
> &&-chain linter cannot peek inside subshells, and that's where the bug
> was in this case.

Uh, yeah in the subshell, but the patch v2 did have it not in
subshells, I'll take another look.

>
> I wish we could improve that, but I spend a lot of brain cycles on it at
> one point and couldn't come up with a workable solution.

Is it possible to overwrite what happens when you open a subshell with ( ) ?
i.e. I imagine in the global test-setup we'd setup that ( ) not just
opens /bin/sh
but a shell with benefits such that we can execute just one && chain.
