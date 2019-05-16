Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96351F461
	for <e@80x24.org>; Thu, 16 May 2019 03:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEPDL4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:11:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34014 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfEPDL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:11:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so862002plz.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYbI58yCS44TRI7JDClPcsZcxHSkGzkvc4ZilpwyfxM=;
        b=qb2nhnPsSQyz11Xr9kLEeFc7MWjG3lVLPbt40BvnxXi6NEHY8SkE9iyOSdTaFdrD1P
         iPflnmFXx1hTDZ1218zWbC4niYfs8avh9zCizcg7aUQiyplV3PBSuHIaJ0bXkKYJ0lnB
         0k9eMORxZ94ukk0T1/VcB/vR/+PVwNUR/ajNvl9JgmIMnWryhBCMWPzPbfg1izzQKOjE
         Fklu6gWf6hUt3ou9K5iYmvS/PuxRlpbq73ohamgtrVaMBriCXmrrFbmc6WfBaT3kPFEy
         5Cz6MsnbmSZtcCYhKIrTgnW6wUkAm+ykOYxUErzbJsMsLqZpmOb2BN/oIouqnZX8b8NX
         1UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYbI58yCS44TRI7JDClPcsZcxHSkGzkvc4ZilpwyfxM=;
        b=XtVHp/nlI/z1wKS2lPVAEiQMdEOPLVHVR68BB26uM7hYhytE0w0wvGUEu3ajH6S/g9
         ofzpxavsxYmNTvw5c+GAYlqUu7Q71jqJ+K82zjcV6iMxuYuSwHFJjUN/A3fz8Wbxfpsf
         SHCmoKL3Rqtdbcu+G4h13yBepNDN+dT3U2zFlP6HgVUHr0oIe+u4Vpi3JCuMKS/RTfOu
         OMr9MVn4A+Enwqw2qeIoJgvKIk3Mzw7e2xV9z071Ctr9ry1GXkA5sAZOmnOake20RMys
         JpF/XUH5Z7owYCezlUAUYDoiugh1/wQQkPtMgAzexMhqLbbmW0J8MFr7K6bWPNuEs5Pd
         5IZQ==
X-Gm-Message-State: APjAAAWvd5hqglkbfWGDgQyxaTnNe3SnqF7YACxhGNZxQ6cH496qHrm7
        7JiVCMf5Dlaic7gIKUIH1Jw=
X-Google-Smtp-Source: APXvYqwt3rCys1DwEccroOfzjVt+ra5Wg5ByVNJBtf9/G/6nFA8kNUGg8VfLGXBJdTN1p0wly2wKuQ==
X-Received: by 2002:a17:902:b606:: with SMTP id b6mr48685324pls.100.1557976315027;
        Wed, 15 May 2019 20:11:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e78sm8052333pfh.134.2019.05.15.20.11.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 20:11:54 -0700 (PDT)
Date:   Wed, 15 May 2019 20:11:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] grep: provide sane default to grep_source struct
Message-ID: <20190516022911.GA135875@google.com>
References: <20190516020023.61161-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516020023.61161-1-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> grep_buffer creates a struct grep_source gs and calls grep_source()
> with it. However, gs.name is null, which eventually produces a
> segmentation fault in
> grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
> not set.

Thanks for catching it.  Taking a step back, I think the problem is in
the definition of "struct grep_source":

	struct grep_source {
		char *name;

		enum grep_source_type {
			GREP_SOURCE_OID,
			GREP_SOURCE_FILE,
			GREP_SOURCE_BUF,
		} type;
		void *identifier;

		...
	};

What is the difference between a 'name' and an 'identifier'?  Who is
responsible for free()ing them?  Can they be NULL?  This is pretty
underdocumented for a public type.

If we take the point of view that 'name' should always be non-NULL,
then I wonder:

- can we document that?
- can grep_source_init enforce that?
- can we take advantage of that in grep_source as well, as a sanity
  check that the grep_source has been initialized?
- while we're here, can we describe what the field is used for
  (prefixing output with context before a ":", I believe)?

[...]
> This seems to be unreachable from existing commands but is reachable in
> the event that someone rolls their own revision walk and neglects to set
> rev_info->grep_filter->status_only.

init_revisions sets that field, so a caller would have to replace
grep_filter or unset status_only to trigger this.

>                                     Conceivably, someone might want to
> print all changed lines of all commits which match some regex.

Hm, does that work well?  The caller of grep_buffer in revision.c
doesn't seem to be careful about where in the output hits would be
printed, but I might be missing something.

[...]
> I ran into this issue while I was working on a tutorial on rolling your
> own revision walk. I didn't want to print all the lines associated with
> a matching change, but it didn't seem good that a seemingly-sane
> grep_filter config was segfaulting.

Good find, and thanks for taking the time to make it easier to debug for
the next person.

[...]
> Jonathan Nieder proposed alternatively adding some check to grep_source()
> to ensure that if opt->status_only is unset, gs->name must be non-NULL
> (and yell about it if not), as well as some extra comments indicating
> what assumptions are made about the data coming into functions like
> grep_source(). I'm fine with that as well (although I'm not sure it
> makes sense semantically to require a name which the user probably can't
> easily set, or else ban the user from printing LOC during grep). Mostly
> I'm happy with any solution besides a segfault with no error logging :)

Let's compare the two possibilities.

The advantage of "(in memory)" is that it Just Works, which should
make a nicer development experience with getting a new caller mostly
working on the way to getting them working just the way you want.

The disadvantage is that if we start outputting that in production, we
and static analyzers are less likely to notice.  In other words,
printing "(in memory)" is leaking details to the end user that do not
match what the end user asked for.  NULL would instead produce a
crash, prompting the author of the caller to fix it.

What was particularly pernicious about this example is that the NULL
dereference only occurs if the grep has a match.  So I suppose I'm
leaning toward (in addition to adding some comments to document the
struct) adding a check like

	if (!gs->name && !opt->status_only)
		BUG("grep calls that could print name require name");

to grep_source.

That would also sidestep the question of whether this debugging aid
should be translated. :)

Sensible?

Thanks,
Jonathan
