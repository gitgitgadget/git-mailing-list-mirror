Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10601FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbcLFSEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:04:04 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35670 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbcLFSED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:04:03 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so151720277pga.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3F8FYHtq5qjC9P4O/g3NDIr6K7cbe3H1elPxaZL6Mck=;
        b=K0P6Mhr4sZuCzyTe5J1mfmuk6Q3rX+bo5JCLSwagrrtN562Jn4QTjnkZO4X85elIO3
         fcnrdMuiStBl6AkPpHESEy8fQ/3HQM2UX2VW6OiCgBpLr7z8HP9XvfYUYhRmKQv6q8lp
         14kalArJvqLPsvsQcHEcH7ilWwXDKHyZRG1190A4lbcpDosf9odk3wEUC4ATAMW0ckk1
         uye3oIPsE6zMojD2lmPo2ti3/pwX6dO9/+LNRxZwctU2VgIvyFzay6cWTZ7ewXFoJBEP
         oZS3xlf0GGX/fcvqSZLZAbpeJav1TyASI/gsBTRwcAC2+AlF1D6d776o8MbLgIbjaW8J
         S+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3F8FYHtq5qjC9P4O/g3NDIr6K7cbe3H1elPxaZL6Mck=;
        b=e5bavDb2oGrhdsNk3aAidM+okCp3DXcNhRGOa/rbvLMaXlWuqEJ/0I0TzyENy4Lf5q
         fIX/yUeRAAF+BI24cDD99Pfn7zfczR+/acVDMZ76jxyyEcbE3CRa03vELx/g4I8yfVDC
         xHtulIz3WzFHiaOQRrrKdfbd3dG6ouHAHimy0MoXDWVVhhNQgGAbHv1yhXpw2mdsQbWx
         +EGRXPaCtmqCcaBzQEmoK2fCbgM5c6gqGnryC8a+GjhhgzGi1EkBRQWTEaDedG3vsCvs
         uqPO1rl46BPFM/uRXdAbd1z2r7hxzdeCRXeARmaJjy/YHmRPlD42iHHP4wTnNCx0Q9oo
         ezgQ==
X-Gm-Message-State: AKaTC03soOOxyvEtvk2UOxoj/7lIvSnT2SkG6xA+6KnUQXjVv6KnDtA0DYgQFZwpQziugCc+
X-Received: by 10.84.214.1 with SMTP id h1mr140762979pli.47.1481047442755;
        Tue, 06 Dec 2016 10:04:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e0c5:1a05:7bf2:5496])
        by smtp.gmail.com with ESMTPSA id v82sm36501118pfi.6.2016.12.06.10.04.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 10:04:01 -0800 (PST)
Date:   Tue, 6 Dec 2016 10:04:00 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Xie <emilyxxie@gmail.com>
Subject: Re: "git add -p ." raises an unexpected "warning: empty strings as
 pathspecs will be made invalid in upcoming releases. please use . instead if
 you meant to match all paths"
Message-ID: <20161206180400.GA103573@google.com>
References: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
 <20161130211100.GA18680@ikke.info>
 <xmqq7f7kd3pj.fsf@gitster.mtv.corp.google.com>
 <xmqqtwaobni5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwaobni5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> forgot to Cc: the author of the
> most relevant change to the issue, d426430e6e ("pathspec: warn on
> empty strings as pathspec", 2016-06-22).
> 
> > Kevin Daudt <me@ikke.info> writes:
> >
> >> On Wed, Nov 30, 2016 at 12:31:49PM -0800, Peter Urda wrote:
> >>> After upgrading to version 2.11.0 I am getting a warning about empty
> >>> strings as pathspecs while using 'patch'
> >>> 
> >>> - Ran 'git add -p .' from the root of my git repository.
> >>> 
> >>> - I was able to normally stage my changes, but was presented with a
> >>> "warning: empty strings as pathspecs will be made invalid in upcoming
> >>> releases. please use . instead if you meant to match all paths"
> >>> message.
> >>> 
> >>> - I expected no warning message since I included a "." with my original command.
> >>> 
> >>> I believe that I should not be seeing this warning message as I
> >>> included the requested "." pathspec.
> >
> > Yes, this seems to be caused by pathspec.c::prefix_pathspec()
> > overwriting the original pathspec "." into "".  The callchain
> > looks like this:
> >
> >     builtin/add.c::interactive_add()
> >      -> parse_pathspec()
> >         passes argv[] that has "." to the caller,
> >         receives pathspec whose pathspec->items[].original
> > 	is supposed to point at the unmolested original,
> >         but prefix_pathspec() munges "." into ""
> >      -> run_add_interactive()
> >         which runs "git add--interactive" with
> > 	pathspec->items[].original as pathspecs
> >
> >
> > Perhaps this would work it around, but there should be a better way
> > to fix it (like, making sure that what we call "original" indeed
> > stays "original").
> >
> >  builtin/add.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index e8fb80b36e..137097192d 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -167,9 +167,18 @@ int run_add_interactive(const char *revision, const char *patch_mode,
> >  	if (revision)
> >  		argv_array_push(&argv, revision);
> >  	argv_array_push(&argv, "--");
> > -	for (i = 0; i < pathspec->nr; i++)
> > +	for (i = 0; i < pathspec->nr; i++) {
> >  		/* pass original pathspec, to be re-parsed */
> > +		if (!*pathspec->items[i].original) {
> > +			/*
> > +			 * work around a misfeature in parse_pathspecs()
> > +			 * that munges "." into "".
> > +			 */
> > +			argv_array_push(&argv, ".");
> > +			continue;
> > +		}
> >  		argv_array_push(&argv, pathspec->items[i].original);
> > +	}
> >  
> >  	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
> >  	argv_array_clear(&argv);
> > @@ -180,7 +189,7 @@ int interactive_add(int argc, const char **argv, const char *prefix, int patch)
> >  {
> >  	struct pathspec pathspec;
> >  
> > -	parse_pathspec(&pathspec, 0,
> > +	parse_pathspec(&pathspec, 0,
> >  		       PATHSPEC_PREFER_FULL |
> >  		       PATHSPEC_SYMLINK_LEADING_PATH |
> >  		       PATHSPEC_PREFIX_ORIGIN,

I've been doing a bit of work trying to clean up the pathspec
initialization code and I believe this can be fixed without
having to add in this work around.  The code which does the munging is
always trying to prefix the pathspec regardless if there is a prefix or
not.  If instead its changed to only try and prefix the original if
there is indeed a prefix, then it should fix the munging.

I'll try to get the series I'm working on out in the next day.

-- 
Brandon Williams
