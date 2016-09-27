Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C1A20986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756548AbcI0Utq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:49:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36405 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756439AbcI0Uti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:49:38 -0400
Received: by mail-pa0-f49.google.com with SMTP id qn7so9019213pac.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3AOX/0FoAW/S87LgtjBBff8lUMwH9r7n4JKqFiLplI=;
        b=XFwz7snTGi6sXA3qSARYqWmJ/SfCadZ74nlSkJilbd0PBu1fgXIuuDsZKJxdqmZM35
         fDhR+uu87wtHKSJ+MhysvCXKjco6gXOotIcM1UAlw7Z7L/24JdG1GNaLIWFKOxl7Who1
         UNv44uOwmhrQYiAQS74i8Lg3rWs+iD/R1j41k7XeTSfoCKAOo4zD/COQrYq0h1EcXFpd
         Qu0xvTxizyHQteMpDri2IlL4FadnfAjCl+ZvzmG5cubWlMQbOlO4RLWDlcD0/LVQ3mO3
         CBFc2YSDHlwazxMO4xmAroRymlJByft4LbQoB6qulit97zMLhYhxR/tG1sAKkX7zEYtp
         GkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3AOX/0FoAW/S87LgtjBBff8lUMwH9r7n4JKqFiLplI=;
        b=gxZgLitK91kdZhownMUrxwNkdQVmQBzgg6iif0M2h8S2XpkR14d2i0P5M5Fqjuo4OG
         l5FyouZsJY3CyNVaOYlc3K7noyaCqmP79awV7PIqXp8IFqR++j2FTPdCnRJMwxRKPNye
         QhwDrI6itUVfQiHlzF5WLL1EuZDAJ07jxICAMPBSsemQroV90WHm1wYS+jtjqkH1kn/V
         kWk3xpTn9NQ91ZuBI5eHwD5PlcqtF9zU0azhOjtOWuFJSVtjodg5lzLbEbDSIqXO7ZQa
         zln6UUQTxG/efTc7YyZ8F18Lle/t8O05jcn1g4RwHwuEGWoHi2KBSiNM2+mbxd9Q/32h
         LH7A==
X-Gm-Message-State: AE9vXwOjEz1M2x5Hvx8gkAtRWFcgyaTadTQ7gBMRVsdBjEVlwm0X1zQ8aogpjk8ii7HB/otI
X-Received: by 10.66.253.7 with SMTP id zw7mr51625405pac.25.1475009378162;
        Tue, 27 Sep 2016 13:49:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id l81sm6979103pfi.14.2016.09.27.13.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:49:37 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:49:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160927204935.GF32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-4-git-send-email-bmwill@google.com>
 <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> > @@ -170,6 +171,27 @@ static void show_killed_files(struct dir_struct *dir)
> >  	}
> >  }
> >  
> > +/*
> > + * Compile an argv_array with all of the options supported by --recurse_submodules
> > + */
> > +static void compile_submodule_options(int show_tag)
> > +{
> > +	if (show_cached)
> > +		argv_array_push(&recurse_submodules_opts, "--cached");
> > +	if (show_stage)
> > +		argv_array_push(&recurse_submodules_opts, "--stage");
> > +	if (show_valid_bit)
> > +		argv_array_push(&recurse_submodules_opts, "-v");
> > +	if (show_tag)
> > +		argv_array_push(&recurse_submodules_opts, "-t");
> > +	if (line_terminator == '\0')
> > +		argv_array_push(&recurse_submodules_opts, "-z");
> > +	if (debug_mode)
> > +		argv_array_push(&recurse_submodules_opts, "--debug");
> > +	if (show_eol)
> > +		argv_array_push(&recurse_submodules_opts, "--eol");
> > +}
> 
> OK.  These are only the safe ones to pass through?  "compile" or
> "assemble" is much less important thing to say than how these are
> chosen.  "pass_supported_options()" or something?  I dunno.

Alternatively we can change this to compile all potential options (not
just the ones that are supported now) and then just error the caller
out, as you've suggested, if an unsupported option used.  'pass' may not
be the most descriptive word for this function as it isn't actually
doing the passing but rather generating an argv of options that will be
passed in the event a submodule is found and we need to kick off a child
process for it.

-- 
Brandon Williams
