Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1A51F404
	for <e@80x24.org>; Thu, 22 Feb 2018 21:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBVVzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 16:55:55 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:38321 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeBVVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 16:55:54 -0500
Received: by mail-pg0-f46.google.com with SMTP id l24so2539287pgc.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za1+eMQ4i/b+4Pj/U2NGk0zNyzTuYUwC/28AVJVBq+w=;
        b=YDLU/JpDgJ0ETESp9h/xzFDIdm1Zxul8zkZK2raDhK00Xqn3pGiRbIqVkHiI+Lv77A
         Ly7rdNJanSiSwGHpIQrBHMvoyER57gehtg6/rD8YVlJzuDAa1p+H6reU6yCLxyHTV0ur
         EylXxv1n672HAFPliperr1c6uSOD+pjVfHgmbhxmnpg06wlzSCqeyCyeOeQK5PCa8WAn
         OF6wqEwQyAnfEpZSddLxllj+G5EGBWVLYGiClmI9WEbHcfrtHwFAfMMGYqz1TpoHJCkd
         zSysRV8+4dcDnJE+u2ivpIQ5GXrKG3uRJGQGMYGv+7G9aJu7X5dqYIBxr7YFqkezEfdv
         si0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za1+eMQ4i/b+4Pj/U2NGk0zNyzTuYUwC/28AVJVBq+w=;
        b=f0X5E7AVzqYQDy1sUbvIA1B3fOneCygWltZ6V++edeTu+FLF/eq5XeIA6gDDhNVvD4
         WQ6rbGh4/i7xi1VMHdQYmrNim/JuUi7iE73jNP1c7gPgtxJqB3VoSEVpbq0L+6Kn3XKK
         RKJxZ0S8GwWLeS4t/Zjr4/b4yxDR8AVEDx0V0OGKERfdLoAofziO4kNUkm0mWAMHjpPm
         g/fk9pM7dhOwkoE31iTgazXLUc/3ptnUmgJkj+xp9Bo/W98t3o7GxqJIca8l0svCqcRE
         KRSy1RfgekF/MNV7H/va54mGMXJrm81x84GcQgE6gwSrOsKe/SJXtFckUjIWfyZkz35p
         abeg==
X-Gm-Message-State: APf1xPCADLgPbD4LYkD9GU7pZxgK+yH33RmncTQEpZhiW3bX/YFZSWAJ
        3MxvOaxhOKoWD8Ntcv4Jsn3rtQ==
X-Google-Smtp-Source: AH8x226g7o8PPiZWDfPXrIOGvsgKZskRbX3LF9l1Jzrp7PYGsb/K9LnLptxmu0MQod1slLir89vMtA==
X-Received: by 10.101.97.139 with SMTP id c11mr6896828pgv.431.1519336554125;
        Thu, 22 Feb 2018 13:55:54 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id h69sm1695975pfe.97.2018.02.22.13.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 13:55:52 -0800 (PST)
Date:   Thu, 22 Feb 2018 13:55:51 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 28/35] transport-helper: introduce stateless-connect
Message-Id: <20180222135551.b9131397d4dc2b6bed376d0d@google.com>
In-Reply-To: <20180222185353.GH185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-29-bmwill@google.com>
        <20180221160116.1619fcc4ffa7e9c13a5ab9ba@google.com>
        <20180222185353.GH185096@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Feb 2018 10:53:53 -0800
Brandon Williams <bmwill@google.com> wrote:

> > > @@ -612,6 +615,11 @@ static int process_connect_service(struct transport *transport,
> > >  	if (data->connect) {
> > >  		strbuf_addf(&cmdbuf, "connect %s\n", name);
> > >  		ret = run_connect(transport, &cmdbuf);
> > > +	} else if (data->stateless_connect) {
> > > +		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
> > > +		ret = run_connect(transport, &cmdbuf);
> > > +		if (ret)
> > > +			transport->stateless_rpc = 1;
> > 
> > Why is process_connect_service() falling back to stateless_connect if
> > connect doesn't work? I don't think this fallback would work, as a
> > client that needs "connect" might need its full capabilities.
> 
> Right now there isn't really a notion of "needing" connect since if
> connect fails then you need to fallback to doing the dumb thing.  Also
> note that there isn't all fallback from connect to stateless-connect
> here.  If the remote helper advertises connect, only connect will be
> tried even if stateless-connect is advertised.  So this only really
> works in the case where stateless-connect is advertised and connect
> isn't, as is with our http remote-helper.

After some in-office discussion, I think I understand how this works.
Assuming a HTTP server that supports protocol v2 (at least for
ls-refs/fetch):

 1. Fetch, which supports protocol v2, will (indirectly) call
    process_connect_service. If it learns that it supports v2, it must
    know that what's returned may not be a fully bidirectional channel,
    but may only be a stateless-connect channel (and it does know).
 2. Archive/upload-archive, which does not support protocol v2, will
    (indirectly) call process_connect_service. stateless_connect checks
    info/refs and observes that the server supports protocol v2, so it
    returns a stateless-connect channel. The user, being unaware of
    protocol versions, tries to use it, and it doesn't work. (This is a
    slight regression in that previously, it would fail more quickly -
    archive/upload-archive has always not supported HTTP because HTTP
    doesn't support connect.)

I still think that it's too confusing for process_connect_service() to
attempt to fallback to stateless-connect, at least because the user must
remember that process_connect_service() returns such a channel if
protocol v2 is used (and existing code must be updated to know this).
It's probably better to have a new API that can return either a connect
channel or a stateless-connect channel, and the user will always use it
as if it was a stateless-connect channel. The old API then can be
separately deprecated and removed, if desired.
