Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCE11F453
	for <e@80x24.org>; Thu, 20 Sep 2018 20:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeIUB5u (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:57:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35462 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:57:50 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so9489692iob.2
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KFULGqIoPo86u7mTXMA9dV2IYkExCtTswTGOF748gsg=;
        b=atX4fl4b+4IhEH4/YHA7dbbpCHI/yEK1zSjy7m3f9u7r3dcOskJlKu8F3Vva393AUu
         Hqve3uav6Gi80TLCCkca8MkRnPelozcxER657S/XufKPd6QEVNc/+wVaPM4D4Cq+e/Ks
         sIpajqiFiEBayVVOMzO3qvO4uX+hrt3bBfxbZVzje7pWAHrmPoCIdB26Al76R7xnlgii
         nThpf1209ayHqNRL8GWKk5KCJSTJgzLE6ODmoomD5iFk1Zyvt4lF/1RdRm9rb7pU5MQ8
         psMqWRUS4CM1FYczIFKbeMFMvG6/X2xbq97aeARdbcRzdnlTV7HONqtly/N0H/KNnxcl
         kXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KFULGqIoPo86u7mTXMA9dV2IYkExCtTswTGOF748gsg=;
        b=OhN9qsfQEORXXHIwW7S/YpCivK7mR8ApOEHxDpnjti7YZ1XD+QnEScLD196EFjZuu0
         wZZ2BBPUe8jgn7aD6XyrmXkiDTZH++wg7dX5IWBMQxXhnOW5YgKLCVHzZRdtSQG7BDM4
         cWXIIKKzSWnq9APPLEABXo+AOBC93xawKArq6rThXR+NHVL2Rw5duz/cZj/sp16kWUMK
         YoDetev7FCDOJvoYfJ2qvX3tGT9nGqtp2hIphG0Ggkdgv2KBUEmZFsHVtscWyq8sXMRv
         gHeNErnIXi4QU6YdTPx/B7l3Pvn7h8sBwSja6C9j6L8cM7jqkd88roPiwbb5TMGR8Rro
         lOzw==
X-Gm-Message-State: APzg51D9OA+QfxGe1DH68POtuRwu2cGgeBBZULgWaO2A3NlZ/2AlTdy/
        y4x6d58By/G7uCXVnoPXBS7uOA==
X-Google-Smtp-Source: ANB0VdaPBC9l3+3fJ7rgBS8/wZU4X67sOXTwE7VyVg4ukioM0mCFtqKWPigTQgxDnbutNse+VUn2gg==
X-Received: by 2002:a24:dcc3:: with SMTP id q186-v6mr3322421itg.126.1537474358308;
        Thu, 20 Sep 2018 13:12:38 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id v82-v6sm8857347iod.14.2018.09.20.13.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:12:36 -0700 (PDT)
Date:   Thu, 20 Sep 2018 16:12:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180920201235.GB83799@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
 <20180920194734.GD29603@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920194734.GD29603@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 03:47:34PM -0400, Jeff King wrote:
> On Thu, Sep 20, 2018 at 02:04:13PM -0400, Taylor Blau wrote:
>
> > The recently-introduced "core.alternateRefsCommand" allows callers to
> > specify with high flexibility the tips that they wish to advertise from
> > alternates. This flexibility comes at the cost of some inconvenience
> > when the caller only wishes to limit the advertisement to one or more
> > prefixes.
>
> To be clear: this isn't something we plan to use at GitHub at all. It
> just seemed like a nice "in between" the current inflexible state and
> the "incredibly flexible but not trivial to use" command from patch 2.
>
> Note that unlike core.alternateRefsCommand, there are no security issues
> here with reading this from the alternate, although:
>
>  - it's a little awkward to read the config from the alternate
>
>  - since these are clearly related config, it probably makes sense for
>    them to be consistent

Another note is that the thing we are planning on using
("core.alternateRefsCommand") could also be implemented as a hook,
e.g., .git/hooks/gather-alternate-refs.

That said, I think that this makes more sense when the alternate is
doing the configuring, not the ohter way around.

> > For example, to advertise only tags, a caller using
> > 'core.alternateRefsCommand' would have to do:
> >
> >   $ git config core.alternateRefsCommand ' \
> >       git -C "$1" for-each-ref refs/tags \
> >       --format="%(objectname) %(refname)" \
> >     '
>
> I think it's more likely that advertising only heads would make sense.
> The pathological repos I see are usually a sane number of branches and
> then an absurd number of tags.

I agree with you. I used "refs/tags" as the prefix here since I'd like
different output than when "core.alternateRefsPrefixes" isn't configured
at all. Since we have a tag for each commit (we use test_commit to do
so), and refs/heads/{a,b,c,master}, we'd get the same output whether we
configured the prefix to be refs/heads, or didn't configure it at all.

Since using 'git for-each-ref' sorts in order of refname, a prefix of
"refs/tags" sorts in order of tagname, so we'll get different output
because of it.

That said, I think that this test is a little fragile as-is, since it'll
break if we change the ordering of 'git for-each-ref'. Maybe we should
`| sort >actual.haves`?

> Not that it's super important, but I wonder if we should give a
> motivating example like this in the documentation. In which case we'd
> probably want to give the most plausible one.

Maybe. I don't feel strongly about it, though.

> > Since the value of "core.alternateRefsPrefixes" is appended to 'git
> > for-each-ref' and then executed, include a "--" before taking the
> > configured value to avoid misinterpreting arguments as flags to 'git
> > for-each-ref'.
>
> Good idea.
>
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index b908bc5825..d768c57310 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -622,6 +622,12 @@ core.alternateRefsCommand::
> >  	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
> >  	Output must be of the form: `%(objectname) SPC %(refname)`.
> >
> > +core.alternateRefsPrefixes::
> > +	When listing references from an alternate, list only references that begin
> > +	with the given prefix. To list multiple prefixes, separate them with a
> > +	whitespace character. If `core.alternateRefsCommand` is set, setting
> > +	`core.alternateRefsPrefixes` has no effect.
>
> I can't remember all of the rules for how for-each-ref matches prefixes,
> but I remember that it's subtly different than git-branch (and that's
> why ref-filter.c has two matching modes). Do we need to spell out the
> rules here (or at least say "it matches like for-each-ref")?

Good idea. I'll do that.

> Also, a minor nit, but I think the argv_array_split() helper you're
> using soaks up arbitrary amounts of whitespace. So maybe "separate them
> with whitespace" instead of "a whitespace character". Or maybe we should
> be strict in what we suggest and liberal in what we parse. ;)

Yeah, I think that chaning "a whitespace character" -> "with
whitespace" is the easier thing to do ;-).

> > +test_expect_success 'with core.alternateRefsPrefixes' '
> > +	test_config -C fork core.alternateRefsPrefixes "refs/tags" &&
> > +	cat >expect <<-EOF &&
> > +	$(git rev-parse one) .have
> > +	$(git rev-parse three) .have
> > +	$(git rev-parse two) .have
> > +	EOF
> > +	printf "0000" | git receive-pack fork | extract_haves >actual &&
> > +	test_cmp expect actual
>
> Looks sane, though the same pipe comment applies as before.

Thanks. I applied that suggestion in both locations when reading your
last mail.

> >  test_done
> > diff --git a/transport.c b/transport.c
> > index e7d2cdf00b..9323e5c3cd 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1341,6 +1341,11 @@ static void fill_alternate_refs_command(struct child_process *cmd,
> >  		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> >  		argv_array_push(&cmd->args, "for-each-ref");
> >  		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> > +
> > +		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
> > +			argv_array_push(&cmd->args, "--");
> > +			argv_array_split(&cmd->args, value);
> > +		}
> >  	}
>
> The implementation ended up delightfully simple.

Thanks :-). It made me quite happy, too.

Thanks,
Taylor
