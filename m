Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487CA1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfIETkH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:40:07 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37673 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbfIETkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:40:07 -0400
Received: by mail-pf1-f182.google.com with SMTP id y9so2508804pfl.4
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0AD9/px5BPXoDUfcOGM95b3eMv7j7rMo3CBiUXbrKc=;
        b=bJbOX4w9Y2xhigwgF5qDA3fgp2a317vegaew3RQEtCaeDUS+KYwL2vfSWWejVTMXwA
         BqwUvIzRED+FeqwZRGmJwHgn+NNJrZjm1vzOhgus5unm1itOrPzHnw+r7mScEHgrnkMB
         nworeJuapjDKk1m5obqVNgt7nEAk+F/6eY4/4HpvGMN8Ahg6iozV2afFvWJUeyhniAds
         cvDc1pDOocx/Hu9YGxDSUfUygvBveyZSBd+CSmQrP8whMWaIgNEH5kBPj0FVoY6jGuKD
         uZIJ77WzIxQsx0QtGedpjpSEJfcbqop8ue+rrNvr89vxBgrosKIIUVPfeaNUv72B/Gzy
         iQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0AD9/px5BPXoDUfcOGM95b3eMv7j7rMo3CBiUXbrKc=;
        b=cNQnij+L2xNUO9fk5CQRdpuOZEnWdiKVdmi/Whxlo7jCuYdZAyhHYOA0rLNHsPs9q9
         CdHc8T4Wgt8pwcPdUpfmxCWpWD75LFb70CIkhXeH5QalPhP824ZhLNiLEgIUFKtNuryv
         epFrKLY0jkBjYeWt+8G+vtPIZ1QS16xKUimFVg7mc8WJea+03PGOCzoH+LadXnyyD3EE
         CMRoft4fG98rpX7J2uIU/+Q8Otxe7f71VaJYJMPxkJkBxbnsyRTERKa+/G/G0aNj/sJQ
         VQIrM65qFgaQEE4G7vTz85/GsHFXH379t80yd5TcEjIwI63LtybzNamHBqnxQVZ/jyud
         6mag==
X-Gm-Message-State: APjAAAVSLBkrAV/V0jqG7HKGyGTg+GEN8SX8U3NgiRCH3NK6XNpc3av0
        6A0EuTvoaoxDOiLWv15oka0Q/A8c8wY=
X-Google-Smtp-Source: APXvYqxW+6J7w1Pl+Lbsb/R4nBshMn4lCzvUEsFnSNHbft4AbA/ectNktsLWXjGBXLd+tNpLtPOrcw==
X-Received: by 2002:a62:f246:: with SMTP id y6mr5924520pfl.22.1567712405797;
        Thu, 05 Sep 2019 12:40:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r187sm7996103pfc.105.2019.09.05.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:40:05 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:39:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190905193959.GA17913@google.com>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904194114.GA31398@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 03:41:15PM -0400, Jeff King wrote:
> On Tue, Aug 27, 2019 at 01:17:57AM -0400, Jeff King wrote:
> 
> > Do we have interested mentors for the next round of Outreachy?
> > 
> > The deadline for Git to apply to the program is September 5th. The
> > deadline for mentors to have submitted project descriptions is September
> > 24th. Intern applications would start on October 1st.
> > 
> > If there are mentors who want to participate, I can handle the project
> > application and can start asking around for funding.
> 
> Funding is still up in the air, but in the meantime I've tentatively
> signed us up (we have until the 24th to have the funding committed).
> Next we need mentors to submit projects, as well as first-time
> contribution micro-projects.

I'm interested to mentor too, but I haven't done anything like this -
official mentoring, intern hosting, anything - so I will need to learn
:)

 - Emily
