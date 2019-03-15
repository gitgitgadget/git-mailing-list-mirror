Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D0420248
	for <e@80x24.org>; Fri, 15 Mar 2019 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCOUt2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 16:49:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38050 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfCOUt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 16:49:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so7134096pfn.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8IlxmxTWO4XKB8izsh5cs7fE/CRvTBiDbPv+UrxxIbo=;
        b=IO7eeYsPbxC++94tP7Vmxpg/FINy7AGnEV9f8KOmiurFvocaLdybs/end6EwoqgK8c
         0hqOEJRoDKN0MrpRlF8sY8IHIaB4cb0kYTgqkTJfWUaU8VpOXUSVrc3vWFfBif/P0zQa
         mRlJP2sOnMLjLrpaBc53s532APx+q56oacKEjUE65DUFw8GhtoyyZNeicdwvXSygvnkx
         PFvm1umIz84HonNQa+GoayFgM3ke/5b8ctz1dJyOnh34nQJb+DcHH96uXRSV8D7uM/gp
         whCwzpgC6Nqix+jYQeV+kqskYUHgilZsWqX3f3DFpewiIefo8vImt7Ph+L+bCGmqqyNq
         cOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8IlxmxTWO4XKB8izsh5cs7fE/CRvTBiDbPv+UrxxIbo=;
        b=tK4HHd52GfSTNCbxBok3ix9cJbIyAMk4GelAaF10h43WsdJBhAGzXzibcu/VSBXP9E
         lRUOWlJ7GBu8zyoIfR0qHOzpIjSzOT9iPjX4ZXZ1Gi/4vp+oOa5GDn09dHYqCDmP4X+i
         2clqZ6VoYDSxO60nsotMu1t7QDneb0RGX5B2d6HwEv7Mm7EQVSgV4VhZFXMtNe6FTV/b
         cD/2xUtV2tEu8qH9yUXKEGOH6qfgUqtURlmpqG3t/yzllL2wrX+HkRMVpVxAr/PQ3eHX
         Z5B5nO2od9irIj3g6auafoKsdKX5Swxp+0ZfeClnVnbD8paCA8BSTk2yBY1In3X/8kjd
         X6Qg==
X-Gm-Message-State: APjAAAXXfwwhDKO6n8NUcseB++tN1emC9mVSmBDYmc3WGQHMrLgqzd++
        KLeEY35H/JQEwJ/zMO0RTEJWWQ==
X-Google-Smtp-Source: APXvYqx68d3lWzaNXCRgZ0t2g2E2RR8qiMwc0EKQLoLHrbz0ugRDteLceB8qCBsjGU3OUoF7jn92YQ==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr5991410pfh.60.1552682967476;
        Fri, 15 Mar 2019 13:49:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id i126sm5174765pfc.101.2019.03.15.13.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:49:26 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:49:19 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
Message-ID: <20190315204919.GF47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
 <87h8c6baif.fsf@evledraar.gmail.com>
 <20190315204327.GE47591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190315204327.GE47591@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.15 13:43, Josh Steadmon wrote:
> On 2019.03.14 00:49, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Thu, Mar 14 2019, Josh Steadmon wrote:
> > 
> > > When the value of a trace2 environment variable contains instances of
> > > the string "%ISO8601%", expand them into the current UTC timestamp in
> > > ISO 8601 format.
> > 
> > Any reason not to just support feeding the path to strbuf_addftime(), to
> > e.g. support a daily/hourly log?
> 
> No reason not to. Seems reasonable to me.

Although as Junio says elsewhere in this thread, it's possible that we
may want to support fields other than timestamps.
