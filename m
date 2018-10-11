Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B036F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJLGE0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:04:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50705 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJLGE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:04:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so10440322wmg.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WJRoI4A2zXixulUCHBGgCVyp0MFjvunkOvdQFz14wgo=;
        b=kF1652lom83Zr7lcsq0p6zsILXse961kiuHEjx8VvzOjLtmgc2xD/q6ybeUj9eAMG0
         BgXO5GHmfb2XMqW/X3uKMUKWiMktvywBCNH5rBg8wHhfsfctoJpSdk9IeDZnRxegIEhA
         P81ZbPc1NsQoP1WYDgU4VaZTJtYx1+VvZWOmbLLlgU5AvTe2cmqLvuMEE76qMmzht4+W
         CwtvLt1bmutlXSpov2TN1nwhslPs+txwRil6cM9XubBy/nCwLFB0pzcryvWI0QQmCdg4
         x7t8LefeCu/U7c+uebv3E869osU/rqOLw/yraU68zN9T7wsxi/dT1E/oYM9We3YrNMHB
         QYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WJRoI4A2zXixulUCHBGgCVyp0MFjvunkOvdQFz14wgo=;
        b=YG0M2SULrQwjwNr5sY6dQtb55Y6nGZ5B61E0ypOVeyWLaIjdP6pbbUEdvbWJ36iwYE
         3ChHSWf+I3tkIh8oN9+oekF0x2BqF/3UCislMkl/PESi8GFN5f/jB06OAW5k+xXGBPvU
         eisUP7uJCD22NU6encnjG0HMLGyZnTBwjLK7006ftGFotUyZGmn2avH1aY0pXbOOiyGv
         HhJLw4PB0T3c2Gk+jEAg2nzRpXXPU/vh0avFRNyVOVxrUSYtMgPjenLQcqxg0eBlXVpx
         ydOP7fRvwDMVucWapZfixK0B9+fM/fXp47q2wnEMPITEsX59MghIiQhDKKA5cjwH086+
         rLxA==
X-Gm-Message-State: ABuFfoi0E/wFT09FT8R7mZD2zcd/n16cT+ijoRLLmPfe4NHojHV4YJ9y
        p+aZm+pPqh2CbjNZ61VaQAuf/udl
X-Google-Smtp-Source: ACcGV61/yvhWSU7RanuS4PMl3pvaHhlt/wmaJelerQnSBiRjecjP97ceHc/SfadHav63x8sbBi1jCw==
X-Received: by 2002:a1c:5d54:: with SMTP id r81-v6mr2979972wmb.88.1539297304468;
        Thu, 11 Oct 2018 15:35:04 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id x66-v6sm10338194wme.35.2018.10.11.15.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:35:03 -0700 (PDT)
Date:   Thu, 11 Oct 2018 23:34:57 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011223457.GB7131@rigel>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net>
 <20181011154319.GA6386@rigel>
 <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
 <20181011175136.GA8825@sigill.intra.peff.net>
 <20181011203518.GA2385@rigel>
 <20181011205323.GB11618@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011205323.GB11618@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 04:53:23PM -0400, Jeff King wrote:
> Right, I like that part. It's just that putting "HEAD" there already has
> a meaning: it would find refs/heads/HEAD.
> 
> Now I'll grant that's a bad name for a branch (and the source of other
> confusions, and I think perhaps even something a few commands actively
> discourage these days).
>

Makes sense. My whole premise was based on the fact that refs/heads/HEAD
wouldn't be supported. Now it's obvious to me that isn't necessarily
true. And now I understand the real issue. Thanks for bearing with me.

I also agree with your proposed '--list-head' suggestion.

So, ideally, instead of my broken suggestion of:
    $ git branch --verbose --list HEAD feature1 hotfix-*;

The equivalent would be:
    $ git branch --verbose --list-head --list feature1 hotfix-*;

and it would coalesce nicely as long as --list-head conforms with the
default formatting for --list.

--
Cheers
Rafael Ascensão
