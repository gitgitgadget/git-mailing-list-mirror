Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6EF1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeI2Ebq (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:31:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45596 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2Ebp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:31:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so5350215pgd.12
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZ7sr8bsxjQsCyhigcUx7rm2qdW+LW2CZ6N29WmyFoo=;
        b=g/FIIy7vlLE3xzN1I4tcVpb6yzWJzv9/N5OxE9L7HpxKo0cG6gr/BbY7MCnUBDgjos
         XwiRDNunnVCJVuTJyNCshbLEg5vhuRAXXLRULYDIFZ8o+3BCwOjAxqvSEUk8dVYlbjMI
         Igxxhg7xFugRBuSrrnYDcnl94cDoE2zpPhmKdoxcM4wPfmbdRyE9zaole7Wjojh9wg5j
         IGmoWwrt6LTnn06DU6vNTOVwPpjvXpNqchqppWbyly3gnHSwYyqOHHJZBUzSB4kICgnU
         8ZjUtlRavju9sumlBpIFGelBllON+879ZdMYygqWtlgzEC+VPv/3nZ7qgud2jiyk1rg4
         Msgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZ7sr8bsxjQsCyhigcUx7rm2qdW+LW2CZ6N29WmyFoo=;
        b=c1mD4qztGBQFrrLwzgppjEF3Yjk2RJQ+qmOuU3R3kWngsNTI2VIgjQ2Iv2PQZ/TZxv
         wbVptIRiXUia0zyJGxJlNYAdVdDO3lYXbpvGT+Mk+7SH2JpcGuX3WfgzaFQT3kQ+PTxt
         4tIsYtRSm8X2od1HcmedeBQVSWZ+CA3eiNCE/jYk9SKfafxjO/grhOmfkRmePw4kBMbw
         KtPlyMYXo6scV36cEG6vhvZhvfKcbjXT0VzrBegsgAml+9M9A+xGNw9jwV+4ctmLTvOQ
         OkZCZASljd7TT7GDmqie/sp1z46jHa7HfqzK3dlvBXJA77bhpjMVpXsNlUAXYG5Vl2wo
         ILFg==
X-Gm-Message-State: ABuFfogwZI0/And8xaa9FtvvTfm4riq8O7I8HQzO2w0rFd6JN7E+5EAP
        Ci4bwkP/p/I4UeSH8m0vmGJZ7g==
X-Google-Smtp-Source: ACcGV60Xhu11tCjOzwbgxnRo96+ZuCV8tOl/8NcMHNqtUBaZKRqlLf+LX8ajf6dGv+VgofBwilkzWg==
X-Received: by 2002:a17:902:7887:: with SMTP id q7-v6mr501864pll.111.1538172359689;
        Fri, 28 Sep 2018 15:05:59 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:a5eb:f7e6:92aa:f2c8])
        by smtp.gmail.com with ESMTPSA id l16-v6sm13118912pfj.179.2018.09.28.15.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:05:58 -0700 (PDT)
Date:   Fri, 28 Sep 2018 15:05:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 4/4] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180928220557.GB45367@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <48eb774c9e36f468549a278fd8cf703d8a34af28.1538108385.git.me@ttaylorr.com>
 <20180928053057.GD25850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928053057.GD25850@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 01:30:57AM -0400, Jeff King wrote:
> On Thu, Sep 27, 2018 at 09:25:45PM -0700, Taylor Blau wrote:
>
> > The recently-introduced "core.alternateRefsCommand" allows callers to
> > specify with high flexibility the tips that they wish to advertise from
> > alternates. This flexibility comes at the cost of some inconvenience
> > when the caller only wishes to limit the advertisement to one or more
> > prefixes.
> >
> > For example, to advertise only tags, a caller using
> > 'core.alternateRefsCommand' would have to do:
> >
> >   $ git config core.alternateRefsCommand ' \
> >       git -C "$1" for-each-ref refs/tags --format="%(objectname)"'
>
> This has the same "$@" issue as the previous one, I think (which only
> makes your point about it being cumbersome more true!).

Hmm. I'll be curious to how you respond to my other message about the
same topic. I feel that whatever the outcome there is will affect both
locations in the same way.

> > In the case that the caller wishes to specify multiple prefixes, they
> > may separate them by whitespace. If "core.alternateRefsCommand" is set,
> > it will take precedence over "core.alternateRefsPrefixes".
>
> Just a meta-comment: I don't particularly mind this discussion in the
> commit message, but since these points ought to be in the documentation
> anyway, it may make sense to omit them here in the name of brevity.

Sure, that makes sense.

> > +core.alternateRefsPrefixes::
> > +	When listing references from an alternate, list only references that begin
> > +	with the given prefix. Prefixes match as if they were given as arguments to
> > +	linkgit:git-for-each-ref[1]. To list multiple prefixes, separate them with
> > +	whitespace. If `core.alternateRefsCommand` is set, setting
> > +	`core.alternateRefsPrefixes` has no effect.
>
> Looks good.
>
> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > index 503dde35a4..3449967cc7 100755
> > --- a/t/t5410-receive-pack.sh
> > +++ b/t/t5410-receive-pack.sh
> > @@ -46,4 +46,12 @@ test_expect_success 'with core.alternateRefsCommand' '
> >  	test_cmp expect actual.haves
> >  '
> >
> > +test_expect_success 'with core.alternateRefsPrefixes' '
> > +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> > +	git rev-parse one three two >expect &&
> > +	printf "0000" | git receive-pack fork >actual &&
> > +	extract_haves <actual >actual.haves &&
> > +	test_cmp expect actual.haves
> > +'
>
> If you follow my suggestion on the test setup from the last patch, it
> would make sense to just put "refs/heads/public/" here. Although neither
> that nor what you have here tests the whitespace separation. Possibly
> there should be a third hierarchy.

Sounds good; that's what I did.

> > diff --git a/transport.c b/transport.c
> > index e271b66603..83474add28 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
> >  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> >  		argv_array_push(&cmd->args, "for-each-ref");
> >  		argv_array_push(&cmd->args, "--format=%(objectname)");
> > +
> > +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> > +			argv_array_push(&cmd->args, "--");
> > +			argv_array_split(&cmd->args, value);
> > +		}
>
> And this part looks good.

Thanks for the review of this patch, too.

Thanks,
Taylor
