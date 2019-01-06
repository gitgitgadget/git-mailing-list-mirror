Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1B4211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 17:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfAFR7I (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 12:59:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37026 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAFR7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 12:59:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5446399wmd.2
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Il94NRMVoQA5wcPlxwuslf99BfTAKU63iQNcELfkOls=;
        b=Y5mBqcWb3FcdLzDw0QtrQDIT2Wy+taC/1h4zNmbBGsnMXqVF1qBU9zwXLttFMUdAgi
         3O/1hdsENC2A/DQ0ATjwAxnfFmoO+dd3iBYJE+y2YjqETEThnDLShhmDeS2ArGFoEKRs
         CQ6izYxgSUi2hT4tFMTkbdzk26OVpKgUjZ1b0jSjnanpt2i520cTsHpnFFVUbMqg+0gA
         Mk2LBpkEUIXxOsFdp4GlFOo1h0Q1z96EyUgFdQC/ZYJjlZgSHIJOjVEXf7k1k/xKmiPr
         rAykc9g5ldGCQLnTKlOF4pcacG6TNHOgf95doMQUbfwFAHn4e3oPsM/4K6wXEgo84leu
         VDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Il94NRMVoQA5wcPlxwuslf99BfTAKU63iQNcELfkOls=;
        b=HyRuToPjaaLOocEH51yw1qugbD2dmhGK7AXZPI8m2xmAwkTwTV+IrfTSF2+kFnH0g9
         pPbgbsaNWhlIy1Agpvur/dK1aXvHyK0q6Jvrey727C29mh2ocN/q41WPbGWA6vf2YvD9
         28dl9x3gF90CgD0hnqk+o6JhaKR/zd54uIKP+C7XZ4k8GBD70RZKTES0uZ9rvF+ziSMD
         4PVNZN1yIv8ox9ymweWQtErmENwFUOKhGiwE4QF0fNLlisqso/k10O9yM8VUNOQSVa7c
         TV2oYg+whzNloc9wGsEV/dmqWfYdD05xZ4VPe4LtYTPGMkoqIB7JrLIR08HklflmNr08
         x/1g==
X-Gm-Message-State: AJcUukdGQkeUHCUDqN5wAJ6pn33QkunwcqfDWqGPWy+zcXu+TpTlz8jY
        c5X+Ob+Q7TgWuDml2VMLfwE=
X-Google-Smtp-Source: ALg8bN4uNHV1CjzjD2iIxswbKN1UweJ29qPWBSljdC71PRfQrCxTQIqUisTdkjDm33tkqm54TSA7nw==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr6576208wmb.80.1546797543986;
        Sun, 06 Jan 2019 09:59:03 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id b18sm48227831wrw.83.2019.01.06.09.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 09:59:03 -0800 (PST)
Date:   Sun, 6 Jan 2019 17:59:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] t5570: drop racy test
Message-ID: <20190106175901.GD25639@hank.intra.tgummerer.com>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
 <20181126164252.GA27711@sigill.intra.peff.net>
 <20181220164150.GB25639@hank.intra.tgummerer.com>
 <20181220171438.GA6684@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1812211638180.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812211638180.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21, Johannes Schindelin wrote:
> Hi Thomas & Peff,
> 
> On Thu, 20 Dec 2018, Jeff King wrote:
> 
> > On Thu, Dec 20, 2018 at 04:41:50PM +0000, Thomas Gummerer wrote:
> > 
> > > Dscho also mentioned on #git-devel a while ago that he may have a look
> > > at actually making this test race-proof, but I guess he's been busy
> > > with the 2.20 release.
> 
> And GitGitGadget. And working on the Azure Pipelines support. And
> mentoring two interns.
> 
> This is what I still have in my internal ticket:
> 
> 	Try to work around occasional t5570 failures in Git's test suite
> 
> 	Seems that there is a race condition in
> 	https://github.com/git/git/blob/master/t/lib-git-daemon.sh#L48-L69
> 	that could possibly be solved by writing to the daemon.log
> 	directly, and showing the output only via `tail -f` (and only when
> 	running in verbose mode, as it simply won't make sense otherwise).
> 
> However, if the preferred route is to go ahead and just remove that test
> altogether, I'm fine with that, too.

Right, I was of course completely unaware of that internal ticket.  If
you still want to go that way there are certainly no objections from
me.  I just want to make sure not more users run into this racyness,
and I guess you also may have more important/interesting things to
work on.

> The only reason, in my mind, why we still have `git-daemon` is that it
> allows for easy standing up your own Git server, e.g. as an ad-hoc way to
> collaborate in a small ad-hoc team. If we ever get to the point where we
> can stand up a minimal HTTP/HTTPS server with an internal Git command (not
> requiring sysadmin privileges), from my point of view `git-daemon` can
> even go the way of the Kale Island (but for much better reasons [*1*]).
> 
> > > I'm also not sure it's worth spending a lot of time trying to fix this
> > > test, but I'd definitely be happy if someone proposes a different
> > > solution.
> > 
> > Yeah. I'm sure it's fixable with enough effort, but I just think there
> > are more interesting and important things to work on.
> > 
> > > --- >8 ---
> > > Subject: [PATCH] t5570: drop racy test
> > 
> > So yeah, I'm still fine with this. But...
> > 
> > > ---
> > >  t/t5570-git-daemon.sh | 13 -------------
> > >  1 file changed, 13 deletions(-)
> > 
> > This is the only user of daemon.log, so we could drop those bits from
> > lib-git-daemon.sh, too. That would also prevent people from adding new
> > tests, thinking that this was somehow not horribly racy). I.e.,
> > reverting 314a73d658 (t/lib-git-daemon: record daemon log, 2018-01-25).

Right that makes sense.  I sent that as patch 2/1, but I'm happy to
squash those into one if that's preferred.

> Indeed, that would be good.
> 
> The only reason to keep daemon.log that I can think of is to make
> debugging easier, but then, if it should become necessary, it is probably
> easier to freopen() stdout or stderr into a file in `git daemon`, anyway.

We do still print the output when tests are run in verbose mode, which
should be just as good as having the log in a separate file in most
cases I suspect.

> Ciao,
> Dscho
> 
> Footnote *1*: Kale Island, along with Rapita, Rehana, Kakatina and Zollies
> is prominently featured in a scientific article at
> http://iopscience.iop.org/article/10.1088/1748-9326/11/5/054011 that is on
> my "important papers I read in 2018" list.
