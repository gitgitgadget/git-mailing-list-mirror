Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E307B1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfIDRzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 13:55:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42457 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfIDRzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 13:55:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id c9so61100qth.9
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FbiHNvqZOfesypl77qjQQLfDClp4lib6FIQo25AfdgI=;
        b=TXF+QdMdvoi8uUByTz/Q3xYcJfD9i7//Ttlb7w4Sf8XIWHcBoyfWbb8Dtmk3muqhFJ
         MadrlPFfpHMbChVsW3mj3RyWVVZL3SoS6Nf+WF8U85Z3u3MdQT4yC1HQFovmQlmE01Lb
         rtpRDZ/E6IurUh/PbsCqOBYUkHGS8EY5LPTL39S7N84v/fZ0Z4rjKdLmXD3UfpWy9HVu
         h80LNX3pBKGWLTjPxP9deHwRGdiuCD/fYEdf0+rAyrF5HvvXU6sihuiglSGSusJ29Nll
         +enJGR8UQTpEqHUXCz6MuAZoXl8I6c7EbCrg3BeiNV+sEQS+LnSvW+9BLEAIwYhrbn5S
         Q0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FbiHNvqZOfesypl77qjQQLfDClp4lib6FIQo25AfdgI=;
        b=SEZsMRDZT8Vxlbj2IzdDxkSOIjC5lfhGrqxL2Kl+Ng4iDdP9o5+fTTPZkWgN0JBrOq
         q8wEz2QS4+tgGplkL02zjETfvZbaI+wHnxh4p//xjh0Atkw8WloKUFmtyMLMlxG4hvag
         sKHfYz7/4B37n55C+bVKxAJ+jNdSgZwxCZJawYISgIgD+48USWpvsJexzz3PLxANfbsT
         242kgk9TESnfnBd3G6JFy7UyjdUgMaKmeahXVrKUSSXpJV4JgxzAdIhi4PyQ+WlVfGog
         CBR1Rnio4ln8tX0azwBsZFf8xCJj6ZrHV5leXn1ZxPITQWKB+nw0A9sFOsjbLKg2OAiN
         T/Sw==
X-Gm-Message-State: APjAAAWubTdasb7woR8lMihreqweUxpOOE6N8rli1ZDMidCYsVf+UU7G
        gKyw4Qn8cQKVxNGfhxF+AOIQYdBYSLI=
X-Google-Smtp-Source: APXvYqzLL6krPwnssuvvVOFHZdiqxEx5LF8PiroiTkAe1/tqUQtSPvnkEw/4AKwAOwyHwGPUETjHpw==
X-Received: by 2002:ac8:2b47:: with SMTP id 7mr41584957qtv.116.1567619702306;
        Wed, 04 Sep 2019 10:55:02 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:24fd:2e2b:8aac:d853])
        by smtp.gmail.com with ESMTPSA id z22sm10328648qti.1.2019.09.04.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 10:55:01 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:55:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/1] contrib/git-jump: support alias expansion
Message-ID: <cover.1567619579.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been meaning to send this patch for a while, which teaches the
'git-jump' script how to respect user aliases for commands like 'diff',
'merge', and 'grep'.

I often find myself parsing the output of 'git diff' (which I spell 'g
di') in less, and then wanting to jump to some specific diff in a file,
i.e., by running 'git jump diff -- <filename>'.

But, I am so used to typing 'di' instead of 'diff', that I often write
the later invocation as 'g jump di -- <filename>', and 'git-jump'
complains that it doesn't know what 'di' means.

Let's rectify that by teaching it how to expand alises, which is
implemented in the patch below.

Thanks,
Taylor

Taylor Blau (1):
  contrib/git-jump/git-jump: support alias expansion

 contrib/git-jump/README   | 4 ++++
 contrib/git-jump/git-jump | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--
2.22.0
