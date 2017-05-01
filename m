Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD911F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934656AbdEAQuF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:50:05 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34087 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764294AbdEAQqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:46:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id e64so39359763pfd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJM17YJmNr5EVdfjC8KLNS8itSzQ17z6Ut9El9O0ZOs=;
        b=CTCshpCv+Ow5Q39JQIH+4oNJOBDN7gBmmwbDtGouO3hvMrQvpclMJPxmQsphmaS977
         VlmpyTYuG3wD8ECvmUuARq479z6vGvdPUetNz5eNhx7T7KrVCvNP1nO2w6vkih4jl6m9
         tzRE0+LK5pEr7lEMFEO4heVvW7ML2UEewVyErNBQs952a8pItZkrm5qQBQ7yQldHsJr7
         6+ihIyDFMT4EQ/H/txIop/zwPGtAJqgM89pWo4uox3zQoXE7prrSTvWv/X6YKIJZbxCv
         3zP0EBPtt8/VA73Dg9odz5Df5+QoJMsVAndFhmazJ4q2BO6Y6DrPSDBSnttxKZA8hbJ5
         2oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJM17YJmNr5EVdfjC8KLNS8itSzQ17z6Ut9El9O0ZOs=;
        b=a/MqPAz3VwL+GyXKiY+pwKi15IAYHm3WMRC3NwcraEwoYRIIKdsHUgVOu8N3cWqClw
         H7nIcuJ7qfUIlf20yuK9Qfgw8z3D3nfm0ukx2W9RBrktMcqJh9Kv+g3bX5uSEbxAxJtV
         k/kwpysje/EMmM8sO1wwOuW29bi99CP+ROt+JxGSslRbrzvlzGEd/9sicIJYxkvB8rjU
         OfCPMPl4q/x1FDGBThgoguG/heg1yTeryMEFvmnLqv1ISwmtjCrK54B1FZ35CJQWg+qg
         GCKfHGPiP+BIZtn4PonZp+7ZxEH/oCFFcZkdVAIxIwPzqcJb9Cs7hmRJ1fapADdl09eW
         ohDA==
X-Gm-Message-State: AN3rC/5NjoU2o3O6NzkkkEGStBaxkCdDoVSJ6gTAghQyWBugwib7DTu8
        4O+cbb0C0Yq8Qxhx
X-Received: by 10.98.147.202 with SMTP id r71mr27166036pfk.43.1493657177777;
        Mon, 01 May 2017 09:46:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id x65sm25814640pfb.111.2017.05.01.09.46.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 09:46:16 -0700 (PDT)
Date:   Mon, 1 May 2017 09:46:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
Message-ID: <20170501164615.GC39135@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170428235402.162251-6-bmwill@google.com>
 <xmqqmvaxgscr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvaxgscr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >  	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
> > +
> > +	if (has_commit) {
> > +		/*
> > +		 * Even if the submodule is checked out and the commit is
> > +		 * present, make sure it is reachable from a ref.
> > +		 */
> > +		struct child_process cp = CHILD_PROCESS_INIT;
> > +		struct strbuf out = STRBUF_INIT;
> > +
> > +		argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
> > +		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
> > +		argv_array_pushl(&cp.args, "--not", "--all", NULL);
> > +
> > +		prepare_submodule_repo_env(&cp.env_array);
> > +		cp.git_cmd = 1;
> > +		cp.no_stdin = 1;
> > +		cp.dir = path;
> > +
> > +		if (capture_command(&cp, &out, 1024) || out.len)
> > +			has_commit = 0;
> > +
> > +		strbuf_release(&out);
> > +	}
> > +
> >  	return has_commit;
> >  }
> 
> The "check-has-commit" we see in the pre-context is "we contaminated
> our in-core object store by tentatively borrowing from submodule's
> object store---now do we see these commits in our in-core view?"
> Which is a wrong thing to do from two separate point of view.  Even
> though the commit in question may be visible in our contaminated
> view, there is no guarantee that the commit exists in the object
> store of the correct submodule.  And of course the commit may exist
> but may not be anchored by any ref.
> 
> This patch fixes the latter, and if we remove that check-has-commit
> call before it, we can fix the former at the same time.

I noticed this when cleaning up this code but was unsure if I should
drop the "check-has-commit" bit.

> 
> There is value in leaving the check-has-commit code if we anticipate
> that we would very often have to say "no, the submodule does not
> have these commits"---a cheap but wrong check it does can be used as
> an optimization.  If we do not have the commit object anywhere,
> there is no chance we have it in the object store of the correct
> submodule and have it reachable from a ref, so we can fail without
> spawning rev-list which is expensive.

Mostly because it gave the code a way to fail quickly, of course I'm
making the assumption that polluting the object store than then checking
it is quicker than launching a child process (though I guess most things
are cheaper than launching a process ;)

-- 
Brandon Williams
