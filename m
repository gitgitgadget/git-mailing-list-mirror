Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEDE1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbeAIWQq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:16:46 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:40139 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755157AbeAIWQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:16:45 -0500
Received: by mail-pg0-f49.google.com with SMTP id q12so8951181pgt.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 14:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SfzYD1FSdCQndFyJUdCEbfZ8rNoh/9cmJIiRZozptSA=;
        b=ut2umiEUS+nzeBOd+V7a0pa/nYV04WVNke5EyP1F12Vkb1y6kxv12u9I2vo8hYq6h8
         PrxCNsX1y4tp8tOJi9sGb7NWYb71GO7qwbiSI5VaJUmMEz5IVtXS79foeAA40lY8YAuy
         1v+v4We9IXBcAaVhZPmd3ThUaV1D3N5gfSn/cXAVc1eHFRH53v9iZ++sksmCBrx/MHN+
         z5J66VEjksMbTR1DNwBJ93uHM38DQR4G6VunmgGLmyBETgaLPVP5mBgv2oUw2YsnoToT
         +BkEmVl/y2niJBSPDc1JOFWpf92dexO5v5rWUEnY6W7L6x/JbsqfPbO5tvodor7TEKoO
         3BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfzYD1FSdCQndFyJUdCEbfZ8rNoh/9cmJIiRZozptSA=;
        b=BTZuVuEcX3E/VhRVYESNxXI5/e7enHTJCNsnkLS4OEFCQPRuAr24QPmsa/VGW+uku2
         4vhAZMWLEee/5W+2roql2Y+Mi4IU1MEm3Z3pgFHyYfPGEeb4HH8H7Em8n0eBdI4XPsEs
         B8/XLS7pS3kJTxm4CvzmYWEhRnXxDVJgBXDCQBfO3tru4BvPZqQDHsUwzHSbYKy2NXd3
         ZF8dOajBqRKyXK01l75Kw7SvvhIccoXgNZJxnDBg73Ai+KAHTRL223dXvhD3KNSFgIR1
         0uOZXBOXudCvXI5wFz6QeTqkzU17w6k8ZoVCJQOiNefVuw6fek8zzluQ7D1n+LjJqeV9
         cVJw==
X-Gm-Message-State: AKwxytdD+lQMRHxuhHY9U3qCWpak+9kmClR6RKG4ruBY04G1ORJjDtvv
        JoW310yGOeL1OBZf87EnOgBEow==
X-Google-Smtp-Source: ACJfBosJzx6hObhfswxfOwBY0epmiLWcQwfQk5WwqSKcqTmQbCfi5ti9bpg604AnZtq+EIMZVnh64Q==
X-Received: by 10.101.82.1 with SMTP id o1mr3101591pgp.259.1515536205091;
        Tue, 09 Jan 2018 14:16:45 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id s81sm34219541pfg.60.2018.01.09.14.16.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 14:16:44 -0800 (PST)
Date:   Tue, 9 Jan 2018 14:16:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-ID: <20180109221642.GF151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-12-bmwill@google.com>
 <20180109122455.5845c4f12ccdd4cada1528f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109122455.5845c4f12ccdd4cada1528f2@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:13 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > new file mode 100644
> > index 000000000..b87ba3816
> > --- /dev/null
> > +++ b/Documentation/technical/protocol-v2.txt
> 
> I'll review the documentation later, once there is some consensus that
> the overall design is OK. (Or maybe there already is consensus?)
> 
> > diff --git a/builtin/serve.c b/builtin/serve.c
> > new file mode 100644
> > index 000000000..bb726786a
> > --- /dev/null
> > +++ b/builtin/serve.c
> > @@ -0,0 +1,30 @@
> > +#include "cache.h"
> > +#include "builtin.h"
> > +#include "parse-options.h"
> > +#include "serve.h"
> > +
> > +static char const * const grep_usage[] = {
> 
> Should be serve_usage.
> 
> > diff --git a/serve.c b/serve.c
> > new file mode 100644
> > index 000000000..da8127775
> > --- /dev/null
> > +++ b/serve.c
> 
> [snip]
> 
> > +struct protocol_capability {
> > +	const char *name; /* capability name */
> 
> Maybe document as:
> 
>   The name of the capability. The server uses this name when advertising
>   this capability, and the client uses this name to invoke the command
>   corresponding to this capability.
> 
> > +	/*
> > +	 * Function queried to see if a capability should be advertised.
> > +	 * Optionally a value can be specified by adding it to 'value'.
> > +	 */
> > +	int (*advertise)(struct repository *r, struct strbuf *value);
> 
> Document what happens when value is appended to. For example:
> 
>   ... If value is appended to, the server will advertise this capability
>   as <name>=<value> instead of <name>.
> 

All good documentation changes.

> > +	/*
> > +	 * Function called when a client requests the capability as a command.
> > +	 * The command request will be provided to the function via 'keys', the
> > +	 * capabilities requested, and 'args', the command specific parameters.
> > +	 *
> > +	 * This field should be NULL for capabilities which are not commands.
> > +	 */
> > +	int (*command)(struct repository *r,
> > +		       struct argv_array *keys,
> > +		       struct argv_array *args);
> 
> Looking at the code below, I see that the command is not executed unless
> advertise returns true - this means that a command cannot be both
> supported and unadvertised. Would this be too restrictive? For example,
> this would disallow a gradual across-multiple-servers rollout in which
> we allow but not advertise a capability, and then after some time,
> advertise the capability.

One way to change this would be to just add another function to the
struct which is called to check if the command is allowed, instead of
relying on the same function to do that for both advertise and
allow...though I don't see a big win for allowing a command but not
advertising it.

> 
> If we change this, then the value parameter of advertise can be
> mandatory instead of optional.

I don't see how this fixes the issue you bring up.

-- 
Brandon Williams
