Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3DF1F461
	for <e@80x24.org>; Fri, 17 May 2019 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEQQyI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 12:54:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40840 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQQyI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 12:54:08 -0400
Received: by mail-io1-f66.google.com with SMTP id s20so6021446ioj.7
        for <git@vger.kernel.org>; Fri, 17 May 2019 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=me5eH0mGk+7NhywuHhUvxxH7u0icYO9JNs0lRdPbqIQ=;
        b=AAagLzOs0/JShx8IiwDSofOii7tIOVT6iioe26LYLtIfSji8kiRGB6ZiXnwNZl+GQt
         ibVGQbKRm54PRo6BzjqtLl1UrrvWhFHlfvkWVBkDByZ/bOKQjfiRVrFOwNhRyZQGTGhX
         FBRM7Zm4/GgAAi/4y2N3Kxv+LSZMioZ2SvI6F4bH8da6rKsHIudWjfz85Qq/K1cAc1Gr
         /ahbQHy7F+nnysdgZ26x4kh+n2tq8tlz+1Ly7TPYlEcbHKQJNfLb8KbTJRSKar2CH/Es
         yTkRPu+G7VgUMX9nwAYB2TRm6KBZYYLQPhum8R3oNrY/uYFjmwcKmk2k3v4XwacsQRzL
         +gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=me5eH0mGk+7NhywuHhUvxxH7u0icYO9JNs0lRdPbqIQ=;
        b=sKwtduR5KFlguiOMgNK7dL9NQiwAYIXP7FnTvEh2vGN9HoAe3zq7UdfP7oI+/2dvhX
         Q4hKXvW6PqYKjbH8eKLLD18Blry133Gx7lXsXxQTFNUWQS2kzFO+cemwolHKz5oi3J1U
         HVISTZO/jefTrR6PzAN/aeoV+61yDSIO9lvsAlzRHMoQ5hEzGiPfaVSWqnbGGQCyrKSm
         ma5ROAkkQchdDQEuJHybEWDUnH20su0NMQ9JMM31JkTNBZmKkPrLZphqgW3veDPyyuGc
         TdAkhNv6JiapG9dU3yYReIqOqNM5grW/G4TUpx21e9OscJmZE/LedKHSg71CXO4swrkh
         rBYw==
X-Gm-Message-State: APjAAAU2rFVhzQtmWgCFB+pker2rElCwEBhd8Zxvo1U5a55gbR1pkXWG
        db31plDzpeeWitWGjBukNjQ=
X-Google-Smtp-Source: APXvYqyYdy34U/b4gheUri9OoS8/TmRRgvZ9cGMCJrloyOgXDwTbVQlzebW82qLRJD7QZYdbJwBnPA==
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr11807776iog.248.1558112047266;
        Fri, 17 May 2019 09:54:07 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id d24sm704212ioo.21.2019.05.17.09.54.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 09:54:06 -0700 (PDT)
Date:   Fri, 17 May 2019 12:54:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/6] teach branch-specific options for format-patch
Message-ID: <20190517165405.GA2541@archbookpro.localdomain>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <cover.1558052674.git.liu.denton@gmail.com>
 <xmqqk1ep3ejv.fsf@gitster-ct.c.googlers.com>
 <20190517072515.GA22326@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517072515.GA22326@archbookpro.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I just realised that my use-cases wouldn't be fully covered with the
onBranch configuration option.

On Fri, May 17, 2019 at 03:25:15AM -0400, Denton Liu wrote:
> Hi Junio,
> 
> On Fri, May 17, 2019 at 01:12:04PM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > 
> > > diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> > > index dc77941c48..d387451573 100644
> > > --- a/Documentation/config/format.txt
> > > +++ b/Documentation/config/format.txt
> > > @@ -28,14 +28,22 @@ format.headers::
> > >  
> > >  format.to::
> > >  format.cc::
> > > +format.<branch-name>.to::
> > > +format.<branch-name>.cc::
> > >  	Additional recipients to include in a patch to be submitted
> > > -	by mail.  See the --to and --cc options in
> > > -	linkgit:git-format-patch[1].
> > > +	by mail.  For the <branch-name> options, the recipients are only
> > > +	included if patches are generated for the given <branch-name>.
> > > +	See the --to and --cc options in linkgit:git-format-patch[1].
> > 
> > An obvious question that somebody else may raise is:
> > 
> >     What makes the branch name that special?  What guarantees that
> >     it would stay to be the *only* thing that affects the choice of
> >     these variables?
> > 
> > An obvious answer to that is "nothing---we are painting ourselves in
> > a corner we cannot easily get out of with this design".
> > 
> > If we want to drive format-patch differently depending on the
> > combination of the worktree location *and* the branch the patches
> > are generated from, we can do something like:
> > 
> > 	[includeif "gitdir:/path/to/worktree/1"] path = one.inc
> > 	[includeif "gitdir:/path/to/worktree/2"] path = two.inc
> > 
> > and then have one.inc/two.inc have customized definition of these
> > format.<branch>.{to,cc,...} variables.
> > 
> > But at that point, Ævar's "wouldn't this fit better with includeif"
> > suggestion becomes more and more appropriate.  Once we invent the
> > way to combine the conditions for includeIf, it would benefit not
> > just this set of variables but all others that will follow in the
> > future.
> 
> Hmm, I'm starting to like Ævar's idea more the more I think about it.
> 

There is one limitation with onBranch. Suppose someone runs

	$ git checkout other
	$ git format-patch master..feature

Then, with onBranch, they'd use get the To and Cc of `other`. But with
`format.feature.*`, format-patch correctly handles this and will use
`feature`'s To and Cc.

> > 
> > Having said that, as long as we are fine with the plan to deprecate
> > and remove these three-level variables this patch introdues in the
> > future, I think it is OK to have them as a temporary stop-gap
> > measure.

With this new discovery, I'm not sure it'd be possible to deprecate it
without losing a use-case.

> > 
> > > +format.<branch-name>.coverSubject::
> > > +	When format-patch generates a cover letter for the given
> > > +	<branch-name>, use the specified subject for the cover letter
> > > +	instead of the generic template.
> > 
> > I still think it is a mistake that this has to be given separately
> > and possibly redundantly from the branch description.
> 
> I forgot about incorporating this. Since we don't need a branch-specific
> coverSubject anymore, we can push everything into a includeif since now
> format.<name>.coverSubject doesn't really need to exist.
> 
> I'm going to repurpose --cover-subject format.coverSubject to be a
> boolean option which'll mean "process the description and if you can
> extract a subject out of it, put it on the cover letter". This way, we
> can maintain backwards compatability in case users have some specific
> use-case.
> 
> Unless you'd like this processing to be the default behaviour? I'm
> impartial either way.
> 
> > 
> > > +static const char *branch_specific_config[] = {
> > > +	"branch",
> > > +	"format",
> > > +	NULL
> > > +};
> > 
> > Yuck.  This will break a workflow where a fixed branch with a known
> > configuration is deleted and recreated over and over again
> > (e.g. think of "for-linus" branches used for request-pull in each
> > merge window).
> 
> I suppose when we implement `onBranch`, you'd prefer `git branch -d` to
> also not discard those sections.
> 
> > 
> > >  static void delete_branch_config(const char *branchname)
> > >  {
> > >  	struct strbuf buf = STRBUF_INIT;
> > > -	strbuf_addf(&buf, "branch.%s", branchname);
> > > -	if (git_config_rename_section(buf.buf, NULL) < 0)
> > > -		warning(_("Update of config-file failed"));
> > > +	int i;
> > > +	for (i = 0; branch_specific_config[i]; i++) {
> > > +		strbuf_addf(&buf, "%s.%s", branch_specific_config[i], branchname);
> > > +		if (git_config_rename_section(buf.buf, NULL) < 0)
> > > +			warning(_("Update of config-file failed"));
> > > +		strbuf_reset(&buf);
> > > +	}
> > 
> > This will hardcode the unwarranted limitation that the second level
> > of the format.*.var hierarchy MUST be branch names and nothing else,
> > won't it?  
> > 
> 
> I was expecting it to only be branch names but now let's take a
> different approach.
> 
> Consider patches 3-6 dropped. I'd like to queue 1-2, though, since
> they're just cleanup patches.

In light of this, I don't plan on dropping 3-6 anymore. I'm going to
reroll the new behaviour of coverSubject.

> 
> Also, expect a onBranch patchset some time in the future (not the near
> future, school is busy).
> 
> Thanks for your feedback, Junio.
