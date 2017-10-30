Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A96202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932749AbdJ3RuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:50:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:54900 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdJ3Rt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:49:56 -0400
Received: by mail-io0-f194.google.com with SMTP id e89so29039582ioi.11
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLOQVIWc8BmQbJF/SSSsj9wm5+C7KG2HIQqqOkKepfI=;
        b=lGc+aXzpe2+J0Un2fksra+QdIvX79Zt5DIt9bELevrSpb8miQexGTWeZexzW17iAtp
         o9QF2x+wpbvaiphWEjLz3YwNW9wzCx+1biwWjY1tS6BxTLQGFDOBGZPK4q+fPPzbTpCE
         MdMl2qrbUM4qoRDFDRmUjwDSllrMWhtlWUxQVvDhpJy+v1XdwBweixoX1MLDV97v4B2Y
         wkUNEQKdzANo1oEqRHvDeYJNA4BpbWekyoURCWw7b4v7EBBh+U5UmjO6afGnPh6XFoqM
         xrErAlQJL5Fg26oCUt1/SZaTmVFxwyng7p2TWVMRi1saEV7igauB3MfTnjiGlhLN95dJ
         jYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLOQVIWc8BmQbJF/SSSsj9wm5+C7KG2HIQqqOkKepfI=;
        b=RlhgvvVlYPsyHlccB8bbU/nqNJB3ym1pbZSWv3bSuVAJlOuVV3nno7QRoAXJoVDY4M
         A/F23YZWcS+Avb2Qg/tSuueqwd2IIOvYdOtONGQjbAWPxOtkQzpe8CAMVAV2HXo3zS7u
         FBaUegIGSiLaHp2uhPJttkohfhRWLGvOUG0KUIWRn3X7fpyrW+AvgUYuMsU6KxXScTSN
         bZmMQfh0PVgCyC2IwmrjI8yXU+DxQfjYVKhGA/7WmpnGeWsGuJHHlED+mUf6vc78XXAW
         kjJ2l9TvhJfHSqiyV0zV6VJnZXuKaqVDgpMlgznBRgJy4JQ5v33ISYeQA+sTxEg2qX3H
         0pAw==
X-Gm-Message-State: AMCzsaWDXpaE6CAOn4W461uxv22J8P+ia/oQepnE5CBU1nVhqfHepVbh
        gCSUvdV78c7r/dQ7f26/1V89DPb4xS0=
X-Google-Smtp-Source: ABhQp+RZ2ThymxyMoqkl7w5788WgII00OWCkeT2zX2G22vWrl8GmlZMT2iIrmI/WlzfRUApAn9b2fg==
X-Received: by 10.107.9.146 with SMTP id 18mr11998698ioj.126.1509385795144;
        Mon, 30 Oct 2017 10:49:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9c29:988d:323f:ada0])
        by smtp.gmail.com with ESMTPSA id s16sm2090560itb.15.2017.10.30.10.49.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 10:49:54 -0700 (PDT)
Date:   Mon, 30 Oct 2017 10:49:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff: convert flags to be stored in bitfields
Message-ID: <20171030174952.GA125460@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171027222853.180981-4-bmwill@google.com>
 <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1zeafaq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > We have have reached the limit of the number of flags that can be stored
> 
> s/have have/have/; but bit #9 is unused.  
> 
> "We cannot add many more flags even if we wanted to" would be more
> flexible and does not take this change hostage to whatever topic
> that tries to claim that bit, I would think.

I'll tweak the wording a bit.

> 
> > in a single unsigned int.  In order to allow for more flags to be added
> > to the diff machinery in the future this patch converts the flags to be
> > stored in bitfields in 'struct diff_flags'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/commit.c |  7 +++--
> >  builtin/log.c    |  2 +-
> >  diff-lib.c       |  6 ++--
> >  diff.c           |  3 +-
> >  diff.h           | 96 +++++++++++++++++++++++++++++++++-----------------------
> >  sequencer.c      |  5 +--
> >  6 files changed, 70 insertions(+), 49 deletions(-)
> >
> 
> > diff --git a/diff.h b/diff.h
> > index aca150ba2..d58f06106 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -60,42 +60,59 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
> >  
> >  #define DIFF_FORMAT_CALLBACK	0x1000
> >  
> > -#define DIFF_OPT_RECURSIVE           (1 <<  0)
> > -#define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
> > -#define DIFF_OPT_BINARY              (1 <<  2)
> > -...
> > -#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
> > -#define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> > -#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
> > -
> > -#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
> > -#define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
> > -#define DIFF_OPT_SET(opts, flag)    (((opts)->flags |= DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
> > -#define DIFF_OPT_CLR(opts, flag)    (((opts)->flags &= ~DIFF_OPT_##flag),((opts)->touched_flags |= DIFF_OPT_##flag))
> > +#define DIFF_FLAGS_INIT { 0 }
> > +extern const struct diff_flags diff_flags_cleared;
> 
> This thing is curious.  Seeing the scary diff_flags_or(), I would
> have expected we'd have diff_flags_clear(&flags).

This seemed to make things easier in practice because I was passing some
structs by value, let me work with it a bit to see what it looks like
when they are passed by reference instead.

> 
> > +struct diff_flags {
> > +	unsigned RECURSIVE:1;
> > +	unsigned TREE_IN_RECURSIVE:1;
> > +	unsigned BINARY:1;
> > +...
> > +	unsigned FUNCCONTEXT:1;
> > +	unsigned PICKAXE_IGNORE_CASE:1;
> > +	unsigned DEFAULT_FOLLOW_RENAMES:1;
> > +};
> > +
> > +static inline struct diff_flags diff_flags_or(struct diff_flags a,
> > +					      struct diff_flags b)
> > +{
> > +	char *tmp_a = (char *)&a;
> > +	char *tmp_b = (char *)&b;
> > +	int i;
> > +
> > +	for (i = 0; i < sizeof(struct diff_flags); i++)
> > +		tmp_a[i] |= tmp_b[i];
> > +
> > +	return a;
> > +}
> 
> This is doubly scary, but let's see why we need it by looking at the
> callers.
> 
> > +#define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
> > +#define DIFF_OPT_TOUCHED(opts, flag)	((opts)->touched_flags.flag)
> > +#define DIFF_OPT_SET(opts, flag)	(((opts)->flags.flag = 1),((opts)->touched_flags.flag = 1))
> > +#define DIFF_OPT_CLR(opts, flag)	(((opts)->flags.flag = 0),((opts)->touched_flags.flag = 1))
> 
> These are trivial and straight-forward.
> 
> > +
> >  #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
> >  #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
> >  #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
> > @@ -122,8 +139,8 @@ struct diff_options {
> >  	const char *a_prefix, *b_prefix;
> >  	const char *line_prefix;
> >  	size_t line_prefix_length;
> > -	unsigned flags;
> > -	unsigned touched_flags;
> > +	struct diff_flags flags;
> > +	struct diff_flags touched_flags;
> >  
> >  	/* diff-filter bits */
> >  	unsigned int filter;
> > @@ -388,7 +405,8 @@ extern int diff_result_code(struct diff_options *, int);
> >  
> >  extern void diff_no_index(struct rev_info *, int, const char **);
> >  
> > -extern int index_differs_from(const char *def, int diff_flags, int ita_invisible_in_index);
> > +extern int index_differs_from(const char *def, struct diff_flags flags,
> > +			      int ita_invisible_in_index);
> 
> OK.  I tend to think twice before passing any struct by value (even
> something that starts its life as a small/single-word struct), but
> let's see how much simpler this allows callers to become.
> 
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index d75b3805e..de08c2594 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -912,11 +912,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> >  			 * submodules which were manually staged, which would
> >  			 * be really confusing.
> >  			 */
> > -			int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> > +			struct diff_flags flags = DIFF_FLAGS_INIT;
> > +			flags.OVERRIDE_SUBMODULE_CONFIG = 1;
> >  			if (ignore_submodule_arg &&
> >  			    !strcmp(ignore_submodule_arg, "all"))
> > -				diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
> 
> This couldn't have been done in patches 1+2/3 because DIFF_OPT_SET()
> does not take a bare 'flags' but diffopt itself, which was a bit
> unfortunate, but the end result after this step becomes a lot more
> sensible.
> 
> > -			commitable = index_differs_from(parent, diff_flags, 1);
> > +				flags.IGNORE_SUBMODULES = 1;
> > +			commitable = index_differs_from(parent, flags, 1);
> 
> OK.
> 
> > diff --git a/builtin/log.c b/builtin/log.c
> > index d81a09051..780975ed4 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -134,7 +134,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
> >  
> >  	if (default_date_mode)
> >  		parse_date_format(default_date_mode, &rev->date_mode);
> > -	rev->diffopt.touched_flags = 0;
> > +	rev->diffopt.touched_flags = diff_flags_cleared;
> 
> So this structure assignment is a more kosher way to clear
> everything than memset(&touched_flags, '\0', sizeof(...));
> I'd still prefer
> 
> 	diff_flags_clear(&rev->diffopt.touched_flags);
> 
> tough, as it is easy to forget diff_flags_cleared is a singleton
> constant specifically created to be assigned for clearing another
> flags struct.
> 
> > @@ -546,7 +546,7 @@ int index_differs_from(const char *def, int diff_flags,
> >  	setup_revisions(0, NULL, &rev, &opt);
> >  	DIFF_OPT_SET(&rev.diffopt, QUICK);
> >  	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
> > -	rev.diffopt.flags |= diff_flags;
> > +	rev.diffopt.flags = diff_flags_or(rev.diffopt.flags, flags);
> 
> In a more general case, we cannot know what flags setup_revisions()
> gave to rev.diffopt, and because of that we cannot do
> 
> 	rev.diffopt.flags = diff_flags;
> 	DIFF_OPT_SET(&rev.diffopt, QUICK);
> 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
> 
> without using the flags_or() thing.  In this codepath, that
> currently is not a problem (because we give ac/av = 0/NULL), but it
> probably is a good idea to avoid depending on that.
> 
> I still haven't brought myself to like the structure being passed by
> value and the singleton diff_flags_cleared thing, but I suspect that
> we may get used to them once we start using these.  I dunno.
> 
> Thanks.

-- 
Brandon Williams
