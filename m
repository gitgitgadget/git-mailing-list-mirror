Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9D11F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391749AbfGWUBJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:01:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35217 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGWUBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:01:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so13633844pgr.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSaXwSZadC+uNZOtIrgaE08Az3YaH2npooJAm4egKhI=;
        b=aGZc8AEKAXqMyRK53sTfN0pN/id7Cn0ut4oOk+swrn4j9yiyrQ+bTbM6P1ZGcl22Cz
         CBAn3eCk9EPWOr/CJFCsNi58ob9mKVcZCfdBa9wOFlYVJH0mWXaHtwRhvddxdE0gu+Zb
         VNEG/aXQA2PO0q9ZCh8XxNn/ap2IhgYX5OjwM1+PxdgqWyGzfuu1Qc8ibqTcIlYHJFuC
         mBxMxJ8LIpCMBl4V+jo7mu+sNfqik8Ie5h+6EmQ49J7iNAM25D3NjTmIwj2eLQRT+tYL
         w7+0jKk0hTprTdqmJaPCdo/W9/jId/EmIKo4SumRbRGEjeTjyJ/44RgbPijYX2OPzsbV
         FNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSaXwSZadC+uNZOtIrgaE08Az3YaH2npooJAm4egKhI=;
        b=MbnEvl/2QB7ab91b0VL1rsMzT8XY06oZwDG2oZHt7F5Q8sLBdIYHi4O/91ppMgj1Bg
         FRT2BecX1nQHWTOTxOY+zZBnxg6HSxy95Xq+tyOcs4wOkrK+fk2herNpZILf6yvR+X9B
         wqsC3KsnNvpSl0ZDh2wTbjSCkxlRP5GPecoJBrbZza++l7XeanS/Vr3OGL7+/2Nr1MB3
         c0tygNKRxaiLlyRL8WOK/Ej/ib/VmMZGSx53NkK6TlffJXm/HzMwPcKKMPP/GHtAeXlM
         Rj+EQIvXvjRlV0NkhG4d1ftOvpijo2m7w5Gxv1qmoer5zMuoxgLhfE5xa206gRIXbzTt
         G7EA==
X-Gm-Message-State: APjAAAX2m0wOS4nYAqjZi1jO4Vf4dFyvt4DlAac8uD5hDcVGSPSAgqRX
        MgBCj5Mm/G5vcxEVkdVjCF0=
X-Google-Smtp-Source: APXvYqxd18YlgfOR4jhQY98HehamMcvvgvOfuIV9Fe3Gv9+xOqRoZna8uVWS9Xw22HWPBJR4kVeMlQ==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr85398521pjb.89.1563912067945;
        Tue, 23 Jul 2019 13:01:07 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.220])
        by smtp.gmail.com with ESMTPSA id 10sm48435421pfb.30.2019.07.23.13.01.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:01:07 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Phillip <phillip.wood123@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
Date:   Wed, 24 Jul 2019 01:28:20 +0530
Message-Id: <20190723195820.16856-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <6e61e65e-53c2-eb49-2197-03fe9796ef1f@gmail.com>
References: <6e61e65e-53c2-eb49-2197-03fe9796ef1f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Mon, 22 Jul 2019 11:00:40 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> [...]
> >
> > +	if (opts->ignore_whitespace) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		if (opts->strategy_opts)
> > +			strbuf_addstr(&buf, opts->strategy_opts);
> > +
> > +		strbuf_addstr(&buf, " --ignore-space-change");
> > +		free(opts->strategy_opts);
> > +		opts->strategy_opts = strbuf_detach(&buf, NULL);
> > +	}
> > +
> 
> I think this would fit better in get_replay_opts()

Agreed, I'll move this to get_replay_opts().

> [...]
> 
> > @@ -489,6 +501,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> >  		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
> >  			N_("GPG-sign commits"),
> >  			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > +		OPT_BOOL(0, "ignore-whitespace", &opts.ignore_whitespace,
> > +			 N_("ignore changes in whitespace")),
> 
> As with the other patch is this actually going to be used by
> rebase--preserve-merges.sh?

I added this just for the completness. Is there any discussion on
dropping rebase--interactive as command and may be lib'fying it while
deprecating rebase--preserve-merges?

> [...]
> 
> > @@ -43,6 +43,7 @@ struct replay_opts {
> >  	int verbose;
> >  	int quiet;
> >  	int reschedule_failed_exec;
> > +	int ignore_whitespace;
> 
> Is this new field used anywhere - we add -Xignore-space-change to
> replay_opts.xopts so why do we need this as well?

Ah! I just realised cmd_rebase__interactive use rebase_options and
not replay_options. I too think this field is not required.

Thanks
Rohit

