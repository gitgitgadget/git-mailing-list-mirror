Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960CE1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdLHUZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:25:34 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34533 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdLHUZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:25:33 -0500
Received: by mail-pf0-f174.google.com with SMTP id a90so8045280pfk.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9lWPT4pnfrdvj9c/viWerxMu5F4Rdyt6QnZaLfesX0c=;
        b=SZs99I9635aDXwpLtK7g5/OksE9QcZtT70F6GpB4cJlD8qsc/2zSjxNi/iTCDUQolr
         /SC26Fb6+l/sZGgMm6IJf4asQp3hk8jdNytOnt8gzlDl94QIWmG+K9n0CB8P5B3cG8NU
         w2X5zxJ15qudvlxkgzQrZZ4EIl+JEi9LNbAdno0tRkj0YqC1AYQEgZ44siD/yAlbmboj
         bwYFW8j4G0J3/8k96XW08cePEGC0N91zXEH2sx93DsaAouE2KIigrptBzDKu/QYRRtgK
         C9ZHfrtB3O2Qz5F8uivluBlKSUfwufC0MWchmw+ENN/0qr/OSp41yKUilrLtz6yekjmI
         G7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lWPT4pnfrdvj9c/viWerxMu5F4Rdyt6QnZaLfesX0c=;
        b=UK+KUWY2sL2CVQ5HenvpoVGWy8Ge/HrRmWOW5jDQ+dMoZOdbMziPTIq0kUUjYHpfpW
         hM2lm6OnaDje1CnZX53uySaB+QDBb2T8w8c19LLAY/amWmVwhDAUkCJPAEIAi4CuEAYi
         FzdDUIAhSnQvO3KXlyOxgl1C9azWZiJdNQEOmfmm0I8cxolNiF11T0cDzkLHLVfGZTi7
         n6JgS2vac60+wREyUfEpzhbFY7oyqZRVsSX24bEt1UJYzURzW4W1DIN+e0uhmM+vl3ZT
         dIi198RC7Q9MKj9IyQA6CILfNOMHH+/Iv/TczbSStTuUtl9EKDppLJqo2MDeYilMo2PD
         Q2DA==
X-Gm-Message-State: AJaThX4bZjKR3tJbbqCKyCpsvz7NDJ8zykJEKjBFkM9i1FeDB2MtYFC8
        PHHoX15svDJNPIhkq8CddBuZcWIycNM=
X-Google-Smtp-Source: AGs4zMaRxQN0TXi2HBuqJqsFiezkpdVTrGWQCG3EzTilbH1FJoIJkH3IWQYR6eSK9SI5VqxlbjpUiA==
X-Received: by 10.84.135.101 with SMTP id 92mr32630797pli.172.1512764732724;
        Fri, 08 Dec 2017 12:25:32 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id h13sm13591483pfi.40.2017.12.08.12.25.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 12:25:31 -0800 (PST)
Date:   Fri, 8 Dec 2017 12:25:30 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 11/15] serve: introduce git-serve
Message-ID: <20171208202530.GE140529@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-12-bmwill@google.com>
 <xmqq8teeaywm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8teeaywm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +static struct protocol_capability *get_capability(const char *key)
> > +{
> > +	int i;
> > +
> > +	if (!key)
> > +		return NULL;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
> > +		struct protocol_capability *c = &capabilities[i];
> > +		const char *out;
> > +		if (skip_prefix(key, c->name, &out) && (!*out || *out == '='))
> > +			return c;
> 
> Looks familiar and resembles what was recently discussed on list ;-)
> 
> > +int cmd_serve(int argc, const char **argv, const char *prefix)
> > +{
> > +
> > +	struct option options[] = {
> > +		OPT_END()
> > +	};
> > +
> > +	/* ignore all unknown cmdline switches for now */
> > +	argc = parse_options(argc, argv, prefix, options, grep_usage,
> > +			     PARSE_OPT_KEEP_DASHDASH |
> > +			     PARSE_OPT_KEEP_UNKNOWN);
> > +	serve();
> > +
> > +	return 0;
> > +}

I assume that at some point we may want to have a new endpoint that just
does v2 without needing the side channel to tell it to do so.  Maybe for
brand new server commands, like a remote grep or a remote object-stat or
something that don't have a v1 equivalent that can be fallen back to.
That's why I included a builtin/serve.c 

> > ...
> > +/* Main serve loop for protocol version 2 */
> > +void serve(void)
> > +{
> > +	/* serve by default supports v2 */
> > +	packet_write_fmt(1, "version 2\n");
> > +
> > +	advertise_capabilities();
> > +
> > +	for (;;)
> > +		if (process_request())
> > +			break;
> > +}
> 
> I am guessing that this would be run just like upload-pack,
> i.e. invoked via ssh or via git-daemon, and that is why it can just
> assume that fd#0/fd#1 are already connected to the other end.  It
> may be helpful to document somewhere how we envision to invoke this
> program.
> 

This function I was planning to just be executed by upload-pack and
receive-pack when a client requests protocol v2.  But yes the idea would
be that fd#0/fd#1 would be already setup like they are for upload-pack
and receive-pack.

-- 
Brandon Williams
