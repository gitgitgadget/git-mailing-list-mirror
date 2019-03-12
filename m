Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148EB20248
	for <e@80x24.org>; Tue, 12 Mar 2019 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCLSWN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 14:22:13 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:53494 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCLSWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 14:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lWUBBsc1GP35eHwNaaS9+6EHmfiEyTg1A+bzjbHfVoE=; b=KhW1FxHpSCyfpeD+l4wvrH0IO
        7T8ptnxFLkh8HNgxDr9KFYuNjqu3TBH5aUV5uO2ArDyHXOFcGAzRRzCoTfhg7fN4F7i8MgZm/l+m3
        zhJ3Cue6jTefIZTDZegVhOIxmb4j7KiypV2jwP2PvL+UATa9WyMFhPjXGVp1Q4PB63w3TEBJgpt7o
        Y0dn8cbI2tjeGxoRGRk2uIvIFHk86StcOqsKFLQSLZW7Jlfx7bMUg+bjoUEa1X4dK8bVgxdsV8HGK
        nNHz0TzH+gCjyG3RPtAPm2KimsUpLUJbQ8s9s727YqqBoZQXD7cW9dJbwItAgNI8XeCwdaO5Gddc/
        Y2zlkR0Bg==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:58096 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h3m2U-00BdwH-SZ; Tue, 12 Mar 2019 14:22:11 -0400
Date:   Tue, 12 Mar 2019 14:22:08 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Bryan Turner <bturner@atlassian.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
In-Reply-To: <CAGyf7-FDLA7zZ9y3GyyVsF38hmm8E+-4+n8gAtmYnp4g7E7=Ug@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903121421140.18110@localhost.localdomain>
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain> <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com> <alpine.LFD.2.21.1903121359480.17390@localhost.localdomain>
 <CAGyf7-FDLA7zZ9y3GyyVsF38hmm8E+-4+n8gAtmYnp4g7E7=Ug@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 Mar 2019, Bryan Turner wrote:

> On Tue, Mar 12, 2019 at 11:01 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> > On Tue, 12 Mar 2019, Bryan Turner wrote:
> >
> > > On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > > >
> > > >   never noticed this before ... when i do a regular "git commit" and
> > > > enter my "vi" edit session and change my mind, i can bail with ":q!",
> > > > regardless of what i've set up as a commit message, and i'll see:
> > > >
> > > >   Aborting commit due to empty commit message.
> > > >
> > > > however, i was just playing with "git revert" and, after i ran:
> > > >
> > > >   $ git revert <commit SHA>
> > > >
> > > >   again, simulating that i changed my mind, i just typed ":q!", but
> > > > the revert went ahead, anyway. i tried again, this time completely
> > > > deleting all the lines from the commit msg (as the template
> > > > suggested), but the revert *still* completed after typing ":q!".
> > > >
> > > >   it was only after deleting all the lines and using ":wq" that the
> > > > revert was cancelled:
> > > >
> > > >   Aborting commit due to empty commit message.
> > > >
> > > > that seems ... inconsistent. am i misunderstanding something?
> > >
> > > When you're doing a fresh commit, the .git/COMMIT_MSG is "empty". It
> > > has whitespace and comments, but no _usable_ lines. So when you :q!,
> > > the commit is aborted because nothing Git can use as a commit
> > > message was saved to the file and so it's still "empty".
> >
> >   no, if i enter the commit edit session, type some _usable_ lines,
> > then type ":q!", it *still* aborts the commit because of an empty
> > commit message. try it and tell me if it behaves differently for you.
>
> Sorry, perhaps I was unclear. Even if you _type_ something, unless
> you :w it's not _written_. So using :q! at that point is the same as
> if you typed nothing.
>
> But if you type something, then :w, then _as a separate command_, do
> :q!, the commit _will_ be done.
>
> Is that more clear, I hope?
> Bryan

  yes, i appreciate all the clarification.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
