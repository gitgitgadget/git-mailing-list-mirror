Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F3C1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeFSWvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:51:22 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44366 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFSWvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:51:19 -0400
Received: by mail-oi0-f52.google.com with SMTP id c128-v6so1269972oig.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tlzX1NNgX7RCyBVfDo4jB0mGjOot50yKHW3iDz/XCc=;
        b=Df0b0QmhPqZMu51WyvMvEmQTmuqt78MMhZZTYHGsMcUtmVeqBdrmHxm2s2Zw1QP9Pz
         KQ7l4D7EW/tzmrwhdxfKJZ3blPYVCNZ4ieMeLNX7poEdtfMwlVxHttrAFX7S0w98PBie
         xcznzuzEtPrs2gqnv8uu35QAV982tKLOdYsGUvRQpC5zlViwv27Kl6pBBPIRFmcAiWj9
         jqmQ4O84gWF5FC5Ntk1tvdRXDrEsSCXpFcY51nj3aSg8HNBPIaHPvyVOjndLBMrWwZ7H
         SAJzwQ38FPZH3JcK/r10a11kkCvTcPCjxulJnaUB46AKzx3HFotLo074imsQnkGqmmRy
         kf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tlzX1NNgX7RCyBVfDo4jB0mGjOot50yKHW3iDz/XCc=;
        b=A5CXoGerjO1ibZeHUkPkMfALP9GWTWXgbv74WVqixm1a8g82edgs3I1XmY/Rq1bCtT
         6NpFcrmrcz49+u+/myCpoORepxjlLF3oGMemWtOeFqPSekWtsPitm2/J+ghSN5jDKHhK
         xJ3l/FUhpPEko9S6fILhbjqW4FOeG9Vin9DhBbHQlRklqrQBHBtPX/7p+IXNP4qqrHUs
         dcXjNsQwr6x5eV8z3kL+zXiBTg3DxkXifzlCb+7LKFHY7iYPNMz9DvMKrQE4DOLnqovV
         lOciDRa2ublQ27AJtfoS2lOX8Kze8l/wa7t54P6KM71cyNmuZP3XkRoTZKJJHqJXi6xu
         /Fhw==
X-Gm-Message-State: APt69E0sEw05oau3xTbY+usmQmhGZDnGM7w+81nY4VMFgVUcbg7peIVp
        QY92JKWhuimleoIEZS4cedJD7N5Sz5U=
X-Google-Smtp-Source: ADUXVKKxgdDtMMdkuJGGTwLJgXqg2u6ge556imN5VfTykfiynpKAKWyU2dh2wBfnKWQ29ZARyIcH7A==
X-Received: by 2002:aca:be42:: with SMTP id o63-v6mr10673395oif.22.1529448678703;
        Tue, 19 Jun 2018 15:51:18 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id x13-v6sm374414oie.13.2018.06.19.15.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:51:17 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:51:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619225115.GA58486@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 06:43:01PM -0500, Taylor Blau wrote:
> Hi,
>
> Attached is a ``fresh start'' of my series to teach 'git grep --column'.
> Since the last time I sent this, much has changed, notably the semantics
> for deciding which column is the first when given (1) extended
> expressions and (2) --invert.

Hi (again),

I have posted an updated version of this series on my fork available at
[1], in case anyone is interested in the changes before I publish them
here tomorrow.

I am going to let this thread sit overnight to collect any more
feedback.


Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/compare/tb/grep-colno
