Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0766120951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdCNWRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:17:08 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35071 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdCNWRG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:17:06 -0400
Received: by mail-pg0-f48.google.com with SMTP id b129so96642694pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKlY/ZQaaSTkURIWgo7U8yIrX325sb62iVPxkJDOa1c=;
        b=RLclogjSIfrnuXdzXl3XqbWpukvH+mH9APwJ2+SUUbAMiUSj1Emv5sf84q/dullP1Z
         USByLHz9DTPKw3Z+MUIAvnJkqIRs2Fyog3VN3wFv/UyHMnpB0U9EVkPE7yF79BvApQQ6
         vpeJsRt3vemuYw+dNP/uDbbGS2y0Fe61lzCYAUDZ8VjHhDQmLjwFu3bDzbQ/g2dHozDM
         /THr1qm1+xrN97lM75T9D30kv3nZE2E7CPZthFRgw7dML6s642EnCkE+OgujN5qdoM7v
         cjyYT7exDJAv52Vg42LHHXlfFzMJoSbamgIB7kifJR03owYim78nX8LScc/XHnGKk+/e
         i0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKlY/ZQaaSTkURIWgo7U8yIrX325sb62iVPxkJDOa1c=;
        b=KZakYqVh7UhP0rxZwBnI65URUnRmVBj0eaYfNqsNR2yutEb4iHZu2L1zFV1uRgGY2k
         URkQUrS/6ReBgI/8a6uXox3zJCtwXmLW3fhefp9V0bs44o8Ns40AWQ3ZW/TN76woznG+
         QLhzZTRblTTmud3UDyfOfp8KgR8RFi5XnFjoB/qvhYGfkWjwJWaeYsrdXLc5zlJHqwiw
         /ca95UqnabY8tF10RLFE3yV2SYjAkn+Ksbw+mk+JuU2Uf5YIEWurTNymWG5vjr4nY+/u
         OvQQSOQE3llcQpbEckwSPf9O0V4EmTs+ejYzVcdKisjCSla8HN5D0hwhM26T4pElyz8i
         t66w==
X-Gm-Message-State: AMke39lzRUR5sgVyazjWCrpF1aUHAwmIgPq5utLJl4W42DQGUZ7xLGw61BWrvVONk7sFSPUf
X-Received: by 10.98.72.199 with SMTP id q68mr46818338pfi.152.1489529824655;
        Tue, 14 Mar 2017 15:17:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id 90sm40351190pfl.24.2017.03.14.15.17.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:17:03 -0700 (PDT)
Date:   Tue, 14 Mar 2017 15:17:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 00/10] decoupling a submodule's existence and its url
Message-ID: <20170314221702.GA168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <xmqqh92vh70l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh92vh70l.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > changes in v3:
> >
> > * Droped a patch which tried to use a more accurate URL for deinit.  It didn't
> >   really fit inside the scope of this series.  It may be something we want to
> >   revisit later though.
> >
> > * The --init-active flag now ensure that all submodules which are configured to
> >   be 'active' (either via 'submodule.active' or 'submodule.<name>.active') go
> >   through the initialization phase and have their relevent info copied over to
> >   the config.
> 
> Aside from comments I sent already to the individual patches, I
> think overall this coherently adds a nicer way to keep track of
> which submodules are of interest (and which are not) than what we
> traditionally had.  I'll queue it on 'pu', awaiting further
> polishing (if necessary).

I've just started looking at your comments and I expect I'll do at least
one more round of polish.

Thanks for taking a look!

-- 
Brandon Williams
