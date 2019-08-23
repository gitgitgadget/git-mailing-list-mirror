Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C21E1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 18:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbfHWSPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 14:15:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42044 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388081AbfHWSPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 14:15:51 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so22072671iob.9
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zobSadn61GOVsd9IQZfZxDDML98UqEg8QACrk0BHGYQ=;
        b=YJ2Czq7CJ/tsrd/ne3Rdiyk6IeHfwd1WeNKsuKd7+eqivq1aEVxMiPVWG7EKN/UH6+
         ng+zx7PUvWYpZXbIsYJUOPwHcJKUWxjQvjTScDUVOlo2d2XQ022cvJkN+TiGTV3XFngk
         qxp0BjUxzhpNa4cPdZvkScM9fQI5urEdXvnlp9vEeg23Ff51ewFJggeeQ2QpxE7h37mt
         xihQilxDP+RDQOsEphiZbOp9kJ0059vwPr+MoQharS/ww3CpxAKZjdufNqM9w3FyVDv/
         woBWcU0RyMrKwZG9tUGqYfQcXHDuRpTIg0pahJ3+KyHrSlk6QJo8xkor28q7lScqSLba
         MKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zobSadn61GOVsd9IQZfZxDDML98UqEg8QACrk0BHGYQ=;
        b=s4tkh1bOz1PQc5LuW/LoOCysTULCYYK0adMKSExV6/TMgzXwTc17Bd59B8t5SL4eea
         CmZnda2aEewj1fvT2mdQCmSRUMvLL71NFz9LysuspT901t346G/TBPjl+3IiQ8mPT47l
         JgSppeoWPN45UaF8fW1qzlapkQOxjdMR/fBwqjcvu25RrQes6segtycwCbKOML2fcQKd
         vbanGNIEaEyXAO+me+AvWucKNW3DZzIfWbU9bOar2RmfSGpLzq1tgNAgUpQc2us1XIfb
         NQULOSlQ+sSdKQJoXv3N77HGL2tPsp0uQt4tnuLf/icGkYcCQYIssB/Bk5KBxxClikEG
         km8Q==
X-Gm-Message-State: APjAAAVUi/8ihC3fcvEKYWCfqzg/VOghJLhahk0Z+ZN/PZ8wVlhqjaYt
        qVphnKIU8V3CbVBnPH+3EWw=
X-Google-Smtp-Source: APXvYqxvfpJxwd2BZNfrN0b7jRKKaQyeL42DNUmYkTUUHuJZcUtsgPYhchXjkzYnYZT9xAU9J9laNg==
X-Received: by 2002:a6b:915:: with SMTP id t21mr5470331ioi.261.1566584149975;
        Fri, 23 Aug 2019 11:15:49 -0700 (PDT)
Received: from archbookpro.localdomain (CPE001a8c429ab1-CM1cabc0716f20.cpe.net.cable.rogers.com. [174.116.84.77])
        by smtp.gmail.com with ESMTPSA id y25sm5714586iol.59.2019.08.23.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 11:15:49 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:15:45 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
Message-ID: <20190823181545.GA14048@archbookpro.localdomain>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
 <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 12:32:19PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Teach format-patch to use the first line of the branch description as
> > the Subject: of the generated cover letter, rather than "*** SUBJECT
> 
> I would not say "the first line", as I do not think that is what
> happens by calling pretty.c::format_subject().  The function is
> designed to take the first paragraph, and the behaviour is in line
> with how the subject is formed from the log message in a commit
> object.  I'd say "the first paragraph" instead.
> 
> > HERE ***" if `--infer-cover-subject` is specified or the corresponding
> > `format.inferCoverSubject` option is enabled. This complements the
> > existing inclusion of the branch description in the cover letter body.
> >
> > The reason why this behaviour is not made default is because this change
> > is not backwards compatible and may break existing tooling that may rely
> > on the default template subject.
> 
> I'd suggest writing it more assertively, rather than appearing to be
> making lame excuses.  Perhaps like
> 
> 	The new behaviour is not made default; doing so would
> 	surprise existing users, which is not a good idea.
> 
> Or just drop the excuse of not changing the default altogether.  It
> is pretty much the standard practice for us to keep the existing
> behaviour the same and to make the new behaviour opt-in.
> 
> Having said that, I suspect that in the longer term, people would
> want to see this new behaviour with a bit of tweak become the new
> default.
> 
> The "tweak" I suspect is needed is to behave sensibly when "the
> first line" ends up to be too long a subject.  Whether we make this
> the new default or keep this optional, the issue exists either way.

The reason why I chose to make this an "opt-in" option was because there
currently doesn't exist a standard on how to write branch descriptions
like there does for commit messages (i.e. subject then body, subject
less than x characters). However, against best practices, some
developers like to have really long subjects. As a result, there's no
"real" way of telling whether the first paragraph is a long subject or a
short paragraph.

As a result, we should allow the cover subject to be read from the
branch description only if the developer explicitly chooses this (either
with `--infer-cover-subject` the config option). This way, we won't have
to deal with the ambiguity of deciding whether or not the first
paragraph is truly a subject and stepping on users' toes if we end up
deciding wrong.

Thoughts?

> 
> One way to make it behave sensibly with overly long first paragraph
> is to fall back to the current behaviour.  We can think about the way
> an ideally "tweaked" version of this patch uses the branch description
> like this:
> 
>  1. Preprocess and prepare the branch description string for use in
>     the next step.
> 
>     - If there is no branch description, then pretend as if "***
>       Subject Here ***" followed by a blank line and "*** Blurb here
>       ***" were given as the branch description in the step 2.
> 
>     - If the first paragraph of the description is overly long, then
>       prepend "*** Subject Here ***" followed by a blank line before
>       the branch description, and use that the branch description
>       string in the step 2 (this is the "tweak to make it behave
>       sensibly" change I suggested above).
> 
>     - Otherwise, use the given branch description in the step 2.
>       Optionally, when a backward-compatibility knob is in effect,
>       always prepend the "Subject Here" paragraph.  That way, step
>       2. would end up keeping the traditional behaviour.
> 
>  2. Split the first pragraph out of the branch description.  Use it
>     as the subject, and use the remainder in the body.
> 
> And if we view the behaviour that way, it becomes clear that the
> "--infer-cover-subject" is a fairly meaningless name for the option.
> We unconditionally use the branch description to fill in the subject
> and the body, but the traditional way and the updated one when the
> first paragraph is overly long use placeholder string for the
> subject instead.  I.e. a better name for the option may be something
> like --placeholder-subject-in-cover (as opposed to taking the
> subject in cover from the branch description), and it can be negated
> i.e. --no-placeholder-subject-in-cover, to force keeping the old
> behaviour.
> 
> And I suspect that the approach would allow the implementation to
> become simple and straight-forward.  The "branch description" needs
> to be prepared in a few different ways (i.e. if there is no
> branch.*.description, you'd fill a fixed string; after reading
> branch.*.description and measuring the first paragraph, you may
> prepend another fixed string), but after that is done, the actual
> generation of the cover letter will need NO conditional logic. It
> just needs to split that into the first paragraph to be used as the
> subject, and the remainder used in the body.
> 
> Hmm?
> 
> > @@ -887,6 +888,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
> >  		}
> >  		return 0;
> >  	}
> > +	if (!strcmp(var, "format.infercoversubject")) {
> > +		infer_cover_subject = git_config_bool(var, value);
> > +		return 0;
> > +	}
> >  
> >  	return git_log_config(var, value, cb);
> >  }
> > @@ -993,20 +998,6 @@ static void print_signature(FILE *file)
> >  	putc('\n', file);
> >  }
> >  
> > -static void add_branch_description(struct strbuf *buf, const char *branch_name)
> > -{
> > -	struct strbuf desc = STRBUF_INIT;
> > -	if (!branch_name || !*branch_name)
> > -		return;
> > -	read_branch_desc(&desc, branch_name);
> > -	if (desc.len) {
> > -		strbuf_addch(buf, '\n');
> > -		strbuf_addbuf(buf, &desc);
> > -		strbuf_addch(buf, '\n');
> > -	}
> > -	strbuf_release(&desc);
> > -}
> > -
> >  static char *find_branch_name(struct rev_info *rev)
> >  {
> >  	int i, positive = -1;
> > @@ -1057,13 +1048,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
> >  			      struct commit *origin,
> >  			      int nr, struct commit **list,
> >  			      const char *branch_name,
> > +			      int infer_subject,
> >  			      int quiet)
> >  {
> >  	const char *committer;
> > -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> > -	const char *msg;
> > +	const char *subject = "*** SUBJECT HERE ***";
> > +	const char *body = "*** BLURB HERE ***";
> > +	const char *description = NULL;
> >  	struct shortlog log;
> >  	struct strbuf sb = STRBUF_INIT;
> > +	struct strbuf description_sb = STRBUF_INIT;
> > +	struct strbuf subject_sb = STRBUF_INIT;
> >  	int i;
> >  	const char *encoding = "UTF-8";
> >  	int need_8bit_cte = 0;
> > @@ -1091,17 +1086,34 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
> >  	if (!branch_name)
> >  		branch_name = find_branch_name(rev);
> >  
> > -	msg = body;
> > +	if (branch_name && *branch_name)
> > +		read_branch_desc(&description_sb, branch_name);
> > +
> > +	if (description_sb.len) {
> > +		if (infer_subject) {
> > +			description = format_subject(&subject_sb, description_sb.buf, " ");
> > +			subject = subject_sb.buf;
> > +		} else {
> > +			description = description_sb.buf;
> > +		}
> > +	}
> > +
> >  	pp.fmt = CMIT_FMT_EMAIL;
> >  	pp.date_mode.type = DATE_RFC2822;
> >  	pp.rev = rev;
> >  	pp.print_email_subject = 1;
> >  	pp_user_info(&pp, NULL, &sb, committer, encoding);
> > -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
> > -	pp_remainder(&pp, &msg, &sb, 0);
> > -	add_branch_description(&sb, branch_name);
> > +	pp_title_line(&pp, &subject, &sb, encoding, need_8bit_cte);
> > +	pp_remainder(&pp, &body, &sb, 0);
> > +	if (description) {
> > +		strbuf_addch(&sb, '\n');
> > +		strbuf_addstr(&sb, description);
> > +		strbuf_addch(&sb, '\n');
> > +	}
> >  	fprintf(rev->diffopt.file, "%s\n", sb.buf);
> >  
> > +	strbuf_release(&description_sb);
> > +	strbuf_release(&subject_sb);
> >  	strbuf_release(&sb);
> >  
> >  	shortlog_init(&log);
> > @@ -1577,6 +1589,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
> >  			    N_("Use [RFC PATCH] instead of [PATCH]"),
> >  			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
> > +		OPT_BOOL(0, "infer-cover-subject", &infer_cover_subject,
> > +			    N_("infer a cover letter subject from branch description")),
> >  		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
> >  			    N_("Use [<prefix>] instead of [PATCH]"),
> >  			    PARSE_OPT_NONEG, subject_prefix_callback },
> > @@ -1916,7 +1930,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  		if (thread)
> >  			gen_message_id(&rev, "cover");
> >  		make_cover_letter(&rev, use_stdout,
> > -				  origin, nr, list, branch_name, quiet);
> > +				  origin, nr, list, branch_name, infer_cover_subject, quiet);
> >  		print_bases(&bases, rev.diffopt.file);
> >  		print_signature(rev.diffopt.file);
> >  		total++;
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 7b8c8fe136..94a3191aca 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -822,7 +822,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
> >  '
> >  
> >  test_expect_success 'get git version' '
> > -	git_version="$(git --version | sed "s/.* //")"
> > +	git_version="$(git --version >version && sed "s/.* //" <version)"
> >  '
> >  
> >  signature() {
> > @@ -1516,6 +1516,39 @@ test_expect_success 'format patch ignores color.ui' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'cover letter with config subject' '
> > +	test_config branch.rebuild-1.description "config subject
> > +
> > +body" &&
> > +	test_config format.inferCoverSubject true &&
> > +	git checkout rebuild-1 &&
> > +	git format-patch --stdout --cover-letter master >actual &&
> > +	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
> > +	grep "^body" actual
> > +'
> > +
> > +test_expect_success 'cover letter with command-line subject' '
> > +	test_config branch.rebuild-1.description "command-line subject
> > +
> > +body" &&
> > +	git checkout rebuild-1 &&
> > +	git format-patch --stdout --cover-letter --infer-cover-subject master >actual &&
> > +	grep "^Subject: \[PATCH 0/2\] command-line subject$" actual &&
> > +	grep "^body" actual
> > +'
> > +
> > +test_expect_success 'cover letter with command-line --no-infer-cover-subject overrides config' '
> > +	test_config branch.rebuild-1.description "config subject
> > +
> > +body" &&
> > +	test_config format.inferCoverSubject true &&
> > +	git checkout rebuild-1 &&
> > +	git format-patch --stdout --cover-letter --no-infer-cover-subject master >actual &&
> > +	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
> > +	grep "^config subject" actual &&
> > +	grep "^body" actual
> > +'
> > +
> >  test_expect_success 'cover letter using branch description (1)' '
> >  	git checkout rebuild-1 &&
> >  	test_config branch.rebuild-1.description hello &&
