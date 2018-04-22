Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC1F1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeDVXYv (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:24:51 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:44537 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeDVXYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:24:50 -0400
Received: by mail-pf0-f182.google.com with SMTP id p15so7670350pff.11
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cAXlcqY7whhINLxFJ7KI6NydPnIZQkiB5kTpPHvzBG0=;
        b=IYpQY3nA5iZ7HfXTIdL32gn9Vu0dHJ+V8hpHB44tbOFWCcwc4sf1piPRBb9vedjeVy
         7+cadNpApAXBvqfg79PUolmfaJudE0+bQA/CN8pvpcLJyUxPUtcmcdRjLK6dfY4uWaH2
         WCUaxMVj8wtFXnErLWQ4tBwP1m7xfcPaqH86jld+WxCxEp+XI7sAfeJlYMZDdNOhGfyK
         FKxcfH+8IfZjr4lu3c1Ve1X+PSu8xEAZCJToDy7pNl7atV6HTTNn6ia1iLjaN8R2Y6Nf
         +NGOJbwQ2YcF8+IMqInJ14kdQfEpVxQ+Pi6wc+E1YLHXVnL86joCGTDlHIRrFQI1W9YT
         nUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cAXlcqY7whhINLxFJ7KI6NydPnIZQkiB5kTpPHvzBG0=;
        b=NRCIaJOhdQmVlxMoZ+vsHX8WBo9A8ltty6kandkcRYqs5e+oUB0U/j3ZwVPMvD/u9d
         ElKo5zVCowbbqW60pM4F+KaJMTdUAfSGLM51eAMVioqgfbdoA3cOoQbBL5HdgR87iepn
         npyLN5ZP/yRbEQDLQSJuPAwwGsMzz9f/uoSLBYbMPEZ49ofpfJlPCpzsouUAoclV7Vtf
         pd7GHdRcl51nk1oh3+GeuMQB4dG/7Vc+akGkEjW7uTgy2M+DLZmvivgzXhIR8HnQykQd
         /YTeoJXyhKibd3rJP7VukPvGEZilztmeEdyuA/xK5ZiYxoDPMEURAXPizGeXJxeBlscX
         OWmg==
X-Gm-Message-State: ALQs6tDZQrCIvf0hQjY+LHXT3nN78ozJaIJk4r1x55abBf2WD+dNSGqa
        mXdtNdfzTl+MEZyfAr55JVuWUw==
X-Google-Smtp-Source: AIpwx4853mrFVgtUdCwzQL4TDxdIEOQ7BnmUB1ThLaM98MZWJtNgncMJRNAbdBH0QjuuQcwt01CDJw==
X-Received: by 2002:a17:902:d909:: with SMTP id c9-v6mr18279075plz.229.1524439489732;
        Sun, 22 Apr 2018 16:24:49 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id z8sm16940030pgc.90.2018.04.22.16.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:24:48 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Sun, 22 Apr 2018 16:24:47 -0700
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 3/6] grep.[ch]: teach columnnum, color_columnno to
 grep_opt
Message-ID: <20180422232447.GA48072@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
 <87a7tuex47.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7tuex47.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 11:42:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Apr 22 2018, Taylor Blau wrote:
>
> > In preparation of adding --column-number to 'git-grep(1)', we extend
> > grep_opt to take in the requisite new members.
>
> Just a nit: Makes sense to refer to these camel-cased in docs & commit
> messages.

Could you clarify which? I am not sure if you mean --column-number,
'git-grep(1)', or grep_opt.


Thanks,
Taylor
