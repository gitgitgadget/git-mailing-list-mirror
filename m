Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70715202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdCOVmb (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:42:31 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34623 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdCOVmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:42:31 -0400
Received: by mail-pg0-f52.google.com with SMTP id 141so14872327pgd.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LDcvpcH1QiOraTKgbyW+3EmBZTqj+KMuhbL0NCXB3D4=;
        b=ZnpW25441ek9sJIlmIM2gfLyIn6fhiN/AJ4LEEU1P3B2qsievwsmhtw0wOchZxotuG
         D2ecwmG9DtCfmTooLAF5n+VCH1cSFhJCX2su55BJLa6cjbMjh5yashQqDf8Nwn6PTP33
         uyFurvssbFQMLskGoINhupDqhdW9irBwASUq+GoAEX2Kb0PwgcSUPJ7HAEVV9LgsXhVa
         DObiFM9abe0Bd16nUnjCgHd+Pt+Y236r1lQ0TG6+4uOSyDvKGMACNsXQJHgbJhQdJMFF
         xejLCbnqDh3kTTk6BrgFqwNTQvD96MO2mhz5tbBQJHi9xSjaH/vf8m+7CdAiJ2gdmLFd
         eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LDcvpcH1QiOraTKgbyW+3EmBZTqj+KMuhbL0NCXB3D4=;
        b=PgxxS5L9JLmw1TlYrxlDGp5omL24I8OPox/PRQVZTq99YKF+VR2g84Tpbl6+Lh1sD+
         +AGBCHrH0BL0DK4siZut+sYBayMk73QwGWNTAoyO0kAv/FJiT5Oc3cjIgO5t0sETXEFM
         TvPVrjAckQ21PQmV8lYddsR1rK/2JQ8YMWMeHsbhvfnxG+2P5hvVBUBfyt22y+P4AcrW
         H/vLioEPZKKKuGY9Z0hcsfxQpxLfnBa6TEC209kb6NNlFN04tjhxVGK1AsGZKLj0RhCX
         I5vdpMfomT0vanCKC+HCEPJOPfmBIWUumiuE5FLqgIn8ztU2xFvHJXXjtUSU7naUVKz8
         6DGA==
X-Gm-Message-State: AFeK/H3jwU6GiB1PjqC1Tw4sPhfNgY5879yba24szUKIgrFC0zVsFC5liaD4QzuiKb81u768
X-Received: by 10.98.112.134 with SMTP id l128mr6256462pfc.81.1489614149513;
        Wed, 15 Mar 2017 14:42:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id n29sm3345874pfi.101.2017.03.15.14.42.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 14:42:28 -0700 (PDT)
Date:   Wed, 15 Mar 2017 14:42:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 06/10] submodule update: add `--init-active` switch
Message-ID: <20170315214227.GD159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-7-bmwill@google.com>
 <xmqqr31ziroz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr31ziroz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +static void module_list_active(struct module_list *list)
> > +{
> > +	int i;
> > +
> > +	if (read_cache() < 0)
> > +		die(_("index file corrupt"));
> > +
> > +	gitmodules_config();
> > +
> > +	for (i = 0; i < active_nr; i++) {
> > +		const struct cache_entry *ce = active_cache[i];
> > +
> > +		if (!S_ISGITLINK(ce->ce_mode) ||
> > +		    !is_submodule_initialized(ce->name))
> > +			continue;
> 
> This, because "is_submodule_initialized()" is not "is it
> initialized?" but "is it interesting?", will catch a submodule
> that used to be uninteresting but has become interesting (e.g. a new
> submodule added to somewhere in "lib/" when submodule.active lists
> "lib/" as one of the pathspecs to match interesting submodules) and
> automatically updates it.

Yes, is_submodule_initialized should be renamed to something more
descriptive (is_submodule_active, or something) in a follow on series
because it is doing a check to see which submodule's the user finds
interesting.

-- 
Brandon Williams
