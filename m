Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C21AC3276F
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4D22085B
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 02:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="DBo72dz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgACC7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:59:30 -0500
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:57255 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgACC7a (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Jan 2020 21:59:30 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 21:59:30 EST
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id nCfYigmZqPI8pnD3ai5QgL; Fri, 03 Jan 2020 02:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1578019882;
        bh=kkHKsKnUC34KHB28Iml/a6Qui2Y2w3A7DP9gGZCwhbc=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DBo72dz5BuRobdWzjJKO6UiKq3/P0Xm9YLYhwKrMMesNalmmfrrFaLnGsixdKVOfX
         p5KcYt7StQXSZZ9pu0ivArvzogcIuc7CQibn6hDuktxcR/MCb12ECree9ClTLjUiIX
         CQwHDbybgchKtI25eAvoLYakAXTMx2AG5gOB8UMKLK1WLvpvsxOMd6hsXiisspP1cw
         xT4lN7baxodou0ezN8mjaxnwn6c0J1IulBaVj1K9EjPy9ZSm0fSnec+ytdfRIm6eFU
         Zu8Fsb0ZQ7+wRBH3cD/oYfD6FrFb7xkpcz5lNdvm+etviItc4PjV6RzP3HJZYET/go
         JFNESsy/S/aYQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a11f:631c:ead1:2b1f])
        by resomta-po-18v.sys.comcast.net with ESMTPSA
        id nD3UiaHKugIKLnD3ZiO4gK; Fri, 03 Jan 2020 02:51:21 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Date:   Thu, 2 Jan 2020 18:51:15 -0800
From:   Matthew DeVore <matvore@comcast.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com,
        johannes.schindelin@gmx.de, phillip.wood123@gmail.com
Subject: Re: [RFC] xl command for visualizing recent history
Message-ID: <20200103025115.GA6521@comcast.net>
References: <20191029003023.122196-1-matvore@google.com>
 <20191031003929.GA22855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031003929.GA22855@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for going dark on this topic. I'm still interested in working on this.
I've gotten so much feedback that I fear I won't be able to respond to all of
it in a thorough manner, but if that's the case, rest assured I have read your
feedback at least twice (including that from Phillip and Dscho) and will take
it into consideration going forward.

On Wed, Oct 30, 2019 at 05:39:29PM -0700, Emily Shaffer wrote:
> 
> Good to hear from you. One comment - the subject of your mail is "[RFC]"
> but I think folks are used to receiving mails with RFC patches if the
> subject line is formatted like it comes out of 'git format-patch' - that
> is, [RFC PATCH].
> 

Thanks for the tip.

> > 
> > "git xl" shows a graph of recent history, including all existing
> > branches (unless flagged with a config option) and their upstream
> > counterparts.  It is named such because it is easy to type and the
> > letter "x" looks like a small graph.
> 
> For me, that's not a very compelling reason to name something, and the
> only command with such a cryptic name in Git that I can think of is 'git
> am'. (mv, gc, rm, and p4 are somewhat self explanatory, and everything
> else besides 'gitk' is named with a full word.)

My thinking was that this would be a very common command, so it ought to be easy
to type. It would also be learned pretty early. I can't blame you for disliking
cryptic names, though. Here are some other ideas:

 - wip: for "work in progress" since it shows your repo minus upstreamed content
 - xlog: for "x" that looks like a graph (also, it sounds like "extended") and
   "log"
 - logx or log-x: for the same reason as above

I'll be working on the "ephemeral ref" portion of this as a separate work item
for now, which doesn't require settling on a name immediately.

> It looks like there's a decent amount of this commit message which
> really ought to be a note to the reviewers instead. Everything above the
> '---' goes into the commit message; everything below it will get
> scrubbed when the patch is applied, so you can give more casual notes
> there - for example this paragraph, as well as "Omissions I might/will
> fix".
> 

Good point, I didn't know about the "---" convention, so I'll keep this in mind.

> 
> If you're worried about folks using something like this in a script (and
> I would be, given that it's dynamically assigning nicknames to hashes)
> then you probably ought to mark it as a porcelain command in
> command-list.txt.
> 

I've made a note to add this to command-list.txt.

Thank you,
Matt
