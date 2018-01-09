Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EE11F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeAIUY7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:24:59 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:39019 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbeAIUY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:24:58 -0500
Received: by mail-pg0-f54.google.com with SMTP id z20so6494845pgv.6
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 12:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FC1x1SyWC8ph9QguO1KA1R3jjBDnyjtDiDqHHsK6aIc=;
        b=mf/pZlzMXhT6kbyo20kPYN2mq9XRAnOZoZOTUSp5zKzdh3YsVsNgVuUycHj7QNTMGR
         DUE3HKuHUifqt1TK346jIrN5RhR1W6qnIhTQCiNV1Dywv3Kg8x+5wFo6RsRQDnqffMtS
         g1qjbCsHOTagiRmbhl0QttIa0WI6JatJHNewO8JXoGXSoQHIwzYqdYZBC3VgCNNg5vaW
         ngachKd5FHy6e6vl7wMs1/l5DBk6ExFOoGl0R4/RSvmzVf9nk90J4A7iIALMP53FNKMu
         8TRYoqzqDzzSP0+OhGJTVgM9ub8SBD4O0VM82QkicmTIP5WC0I8QbdWReQeaXOMyKsOM
         p/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FC1x1SyWC8ph9QguO1KA1R3jjBDnyjtDiDqHHsK6aIc=;
        b=HSoKyXd2hYl9cNbzRkxSUMVLqb7PELCoYwTdZHVmh6vULaMgo9oxyQjZtYlnxtOb6H
         j1AadirbFj/KhVzkU5Hof/kBUyQ46pStRWXPEWWIxfEu73sKNucZ/oAzSVLEMDVLl54n
         S/3Quf1fQG9XY6jJgWp8dxrz0qyzQD9n6qtjU7H7OOwRpQJyJjRO9AO2TT2OVWblOF5G
         syOWKwGRKnFAnGPJaF7QKo2Meo8myMrYnf5JG5F0eM6uW37CFv1drSA82j6hYe0js7SA
         XCBZQo/LdlZB0X0WkUpEHg8Zf/pOq/fsWfLFwD+24xRUC5zI1LrUz3PPnHGkEfKs2AdN
         RAng==
X-Gm-Message-State: AKGB3mIsenZkhnKbhZgrQ2ISkru4ub+SNqDFlsw8ViZKjGv+3w+cIc8S
        CQRUFlbW2gbcKUbf4wUOE0qT4g==
X-Google-Smtp-Source: ACJfBosiNYMU3TboYsYMGSJEUibOkKid2AoU5eOoxCx3bCQOiGRJcp1fMc1d0/n+Xi5UzrZxM6IXTA==
X-Received: by 10.84.128.36 with SMTP id 33mr16279897pla.75.1515529497370;
        Tue, 09 Jan 2018 12:24:57 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id s184sm29852151pfb.9.2018.01.09.12.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 12:24:56 -0800 (PST)
Date:   Tue, 9 Jan 2018 12:24:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 11/26] serve: introduce git-serve
Message-Id: <20180109122455.5845c4f12ccdd4cada1528f2@google.com>
In-Reply-To: <20180103001828.205012-12-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-12-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:13 -0800
Brandon Williams <bmwill@google.com> wrote:

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> new file mode 100644
> index 000000000..b87ba3816
> --- /dev/null
> +++ b/Documentation/technical/protocol-v2.txt

I'll review the documentation later, once there is some consensus that
the overall design is OK. (Or maybe there already is consensus?)

> diff --git a/builtin/serve.c b/builtin/serve.c
> new file mode 100644
> index 000000000..bb726786a
> --- /dev/null
> +++ b/builtin/serve.c
> @@ -0,0 +1,30 @@
> +#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "serve.h"
> +
> +static char const * const grep_usage[] = {

Should be serve_usage.

> diff --git a/serve.c b/serve.c
> new file mode 100644
> index 000000000..da8127775
> --- /dev/null
> +++ b/serve.c

[snip]

> +struct protocol_capability {
> +	const char *name; /* capability name */

Maybe document as:

  The name of the capability. The server uses this name when advertising
  this capability, and the client uses this name to invoke the command
  corresponding to this capability.

> +	/*
> +	 * Function queried to see if a capability should be advertised.
> +	 * Optionally a value can be specified by adding it to 'value'.
> +	 */
> +	int (*advertise)(struct repository *r, struct strbuf *value);

Document what happens when value is appended to. For example:

  ... If value is appended to, the server will advertise this capability
  as <name>=<value> instead of <name>.

> +	/*
> +	 * Function called when a client requests the capability as a command.
> +	 * The command request will be provided to the function via 'keys', the
> +	 * capabilities requested, and 'args', the command specific parameters.
> +	 *
> +	 * This field should be NULL for capabilities which are not commands.
> +	 */
> +	int (*command)(struct repository *r,
> +		       struct argv_array *keys,
> +		       struct argv_array *args);

Looking at the code below, I see that the command is not executed unless
advertise returns true - this means that a command cannot be both
supported and unadvertised. Would this be too restrictive? For example,
this would disallow a gradual across-multiple-servers rollout in which
we allow but not advertise a capability, and then after some time,
advertise the capability.

If we change this, then the value parameter of advertise can be
mandatory instead of optional.
