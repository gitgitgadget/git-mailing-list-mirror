Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1750C1F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 09:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdKMJWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 04:22:51 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:38073 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdKMJWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 04:22:50 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:60392 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEAx7-00043b-4L; Mon, 13 Nov 2017 04:22:49 -0500
Date:   Mon, 13 Nov 2017 04:22:22 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Remove explanation of "--" from several man pages
In-Reply-To: <xmqq8tfaak6s.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711130357190.10471@localhost.localdomain>
References: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain> <xmqq8tfaak6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > There is no value in individual man pages explaining the purpose
> > of the "--" separator.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   unless every man page explains that option, it's pointless to
> > have just *some* man pages explaining it, so might as well remove
> > it from all of them.
>
> Please do not remove diffstat that format-patch gave you at this
> point.  While commenting on the hunk on "git add", I wanted to see
> if you touched "git rm", and the diffstat at front _is_ the go-to
> place to do so for reviewers.

  apologies, won't happen again.

> > diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> > index b700beaff..69d625285 100644
> > --- a/Documentation/git-add.txt
> > +++ b/Documentation/git-add.txt
> > @@ -180,11 +180,6 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
> >  	bit is only changed in the index, the files on disk are left
> >  	unchanged.
> >
> > -\--::
> > -	This option can be used to separate command-line options from
> > -	the list of files, (useful when filenames might be mistaken
> > -	for command-line options).
> > -
>
> I do not think if this removal alone is a good idea.
>
> Before this can happen, the description for "--" in other pages,
> (like gitcli(7), may need to be extended.  Right now, gitcli's
> mention of "--" is only about turning off disambiguation between
> revs and pathspecs, and it does not cover this case
>
> 	$ >./--foo-bar
> 	$ git add -- --foo-bar
>
> even though the description you are removing would have helped the
> reader to understand why "--" is there.  The hunk on "git rm" shares
> the same issue.

  i don't see the problem here ... in the above, "--foobar" is clearly
a pathspec. and if you think that's a special case that needs special
explanation, then that argument surely applies to several other
commands and their man pages.

  the main point here is that it's inconsistent to have *some* man
pages explicitly explain "--" and not have *all* of them explain it.
either they all should, or none of them should, and there's little
value in suggesting that the occasional man page somehow deserves
special treatment.

> >  Configuration
> >  -------------
> > diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> > index aa3b2bf2f..0ae2523e0 100644
> > --- a/Documentation/git-check-attr.txt
> > +++ b/Documentation/git-check-attr.txt
> > @@ -36,10 +36,6 @@ OPTIONS
> >  	If `--stdin` is also given, input paths are separated
> >  	with a NUL character instead of a linefeed character.
> >
> > -\--::
> > -	Interpret all preceding arguments as attributes and all following
> > -	arguments as path names.
> > -
>
> This also has a similar issue.  "--" here is not between revs and
> pathspecs but is between attributes and pathspecs.

  that can already be seen in the SYNOPSIS for that command, it does
not require further explanation:

  SYNOPSIS
       git check-attr [-a | --all | attr...] [--] pathname...

> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> > index d153c17e0..93ebb020c 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -171,9 +171,6 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
> >  and in the working tree ("w/<eolinfo>") are shown for regular files,
> >  followed by the  ("attr/<eolattr>").
> >
> > -\--::
> > -	Do not interpret any more arguments as options.
>
> These removals would become a good idea, once we say that we would
> use "--" to mean "you will not see any --flags after this point" (as
> commonly seen in programs that are not Git) somewhere central like
> gitcli(7).

  if you want to suggest some wording to make that happen, that would
be great, but i'm standing by my opinion that there is no rationale
for *any* man page explaining what "--" means when, as far as i can
tell, it always means the same thing.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
