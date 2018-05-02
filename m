Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122FB2023D
	for <e@80x24.org>; Wed,  2 May 2018 20:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEBUaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 16:30:11 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46597 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEBUaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 16:30:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id z4-v6so11443014pgu.13
        for <git@vger.kernel.org>; Wed, 02 May 2018 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EG+Ltf0XwN7byEI2DXNSCHa2vP2KbjacmEJTbRPTOM=;
        b=ISG46dtDY8fGUZHhWZR82287kUWUTeCgBAQGUdVtofbB2TxiH/c3YmAOmvyOpGvGQv
         BBKXXKRnEo9GOq2DTJQHBV6/jzAjinuOUeEZD2PDayqqqqaxsnAgIIks2XDU8dfyIGV2
         31A2MJvwAB/hnhKjy+PsE0sNe+7FVPTea9oFTxfEqHhSo/K+59YplRidPRU4NsuYGCSn
         Oh66xSLWgE9eqGlYGktaBSioM7+X9oT2swnQru79FMbUoJGRpSFD6RPysObhoOOBy2f4
         IxYFIGbSAvgwPMUZL3Xl60QAv4FDZSDsuck7ite7d1H33DetOl2af2bsWo2wA4KNfd1j
         RJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EG+Ltf0XwN7byEI2DXNSCHa2vP2KbjacmEJTbRPTOM=;
        b=ot36RhfgEbcKiXbCnjtdeXfPTUHPJeTxRbHQH9ehXPqzbmxuD5b89rbvV5BoTQhX5T
         GwsUmcEdd4VZt7yyKHb1C7gYoz1vzdT2taFaYQ9fLocaxoWBeYijul4IuunW5zuTxwcO
         EXoklvwVBaWU2I2/MAdMZt3qP3q4omAGqdjQqLt63jITGllYE9K9iQv+dVVv9HA4qbGZ
         k6wTeI1SBMKTOG6G4tEHpgx8RemW1gn8o+qBIhaOJE0U7QUOI+Ey/ns9t3X1QGxHyczU
         kgUclvSVpvxZ4gsypQEyuQD8CXxvQpk+cJ+JPZ2cai0ts0BdRXk/28UDVsL6VvyKsgzP
         hMYg==
X-Gm-Message-State: ALQs6tDaBMlaJ2IdA5N/nVgRbOq9RBJfKGCKGETHlgQoW7iRG5b5U6zQ
        jhCGLZnNRRce+prfoILaMzYVSA==
X-Google-Smtp-Source: AB8JxZqIatJJhp1nqDuy6acMmYfD6rToZGb1VPstq+fz8QtfFdMmQZGQ/LKRNjNRixClXbvTQq4m3A==
X-Received: by 2002:a65:4844:: with SMTP id i4-v6mr17079021pgs.191.1525293007991;
        Wed, 02 May 2018 13:30:07 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u188sm20140872pfb.84.2018.05.02.13.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 13:30:06 -0700 (PDT)
Date:   Wed, 2 May 2018 13:30:05 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] repository: introduce object parser field
Message-Id: <20180502133005.668e9eefda445f37ba808b96@google.com>
In-Reply-To: <20180501213403.14643-2-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180501213403.14643-2-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  1 May 2018 14:33:51 -0700
Stefan Beller <sbeller@google.com> wrote:

> Git's object access code can be thought of as containing two layers:
> the raw object store provides access to raw object content, while the
> higher level obj_hash code parses raw objects and keeps track of
> parenthood and other object relationships using 'struct object'.
> Keeping these layers separate should make it easier to find relevant
> functions and to change the implementation of one without having to
> touch the other.

I only understood this after reading the code below. I think this
paragraph can be removed; I don't see its relevance - of course we need
to store metadata about how to load objects somewhere, and caching
objects we have already loaded is a good idea: and the metadata and
cache are two separate things before and after this patch anyway.

> Add an object_parser field to 'struct repository' to prepare obj_hash
> to be handled per repository.  Callers still only use the_repository
> for now --- later patches will adapt them to handle arbitrary
> repositories.

I think this is better reworded as:

  Convert the existing global cache for parsed objects (obj_hash) into
  repository-specific parsed object caches. Existing code that uses
  obj_hash are modified to use the parsed object cache of
  the_repository; future patches will use the parsed object caches of
  other repositories.

> +struct object_parser *object_parser_new(void)
> +{
> +	struct object_parser *o = xmalloc(sizeof(*o));
> +	memset(o, 0, sizeof(*o));
> +	return o;
> +}

I'm not sure that I like this style of code (I prefer the strbuf style
with _INIT and release(), which I think is more flexible) but I don't
feel too strongly about it.

> +struct object_parser {
> +	struct object **obj_hash;
> +	int nr_objs, obj_hash_size;
> +};

object_parser is probably a bad name. I think Duy had some good
suggestions in [1].

[1] https://public-inbox.org/git/CACsJy8CgX6BME=EhiDBfMRzBOYDBNHE6Ouxv4fZC-GW7Rsi81Q@mail.gmail.com/

>  	/*
> -	 * Holds any information related to accessing the raw object content.
> +	 * Holds any information needed to retrieve the raw content
> +	 * of objects. The object_parser uses this to get object
> +	 * content which it then parses.
>  	 */
>  	struct raw_object_store *objects;

I think the additional sentence ("The object_parser uses this...") is
unnecessary and confusing, especially if its identity is going to be one
of storage (like "parsed_objects" implies).

> +	/*
> +	 * State for the object parser. This owns all parsed objects
> +	 * (struct object) so callers do not have to manage their
> +	 * lifetime.
> +	 */
> +	struct object_parser *parsed_objects;

Even after all the commits in this patch set, this does not store any
state for parsing. Maybe just document as:

  All objects in this repository that have been parsed. This structure
  owns all objects it references, so users of "struct object *"
  generally do not need to free them; instead, when a repository is no
  longer used, call object_parser_clear() on this structure.

(And maybe say that the freeing method on struct repository will
automatically call object_parser_clear().)
