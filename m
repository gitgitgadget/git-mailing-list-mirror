Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A40C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3982077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 13:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJNbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:31:17 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47513 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 08:31:16 -0500
X-Originating-IP: 157.36.75.244
Received: from localhost (unknown [157.36.75.244])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 378EDFF807;
        Tue, 10 Dec 2019 13:31:09 +0000 (UTC)
Date:   Tue, 10 Dec 2019 19:01:05 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Vasili Novikov <vasilii.novikov@zivver.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
Message-ID: <20191210133105.apfim55w7osvskvh@yadavpratyush.com>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
 <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
 <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com>
 <20191210120219.zc4k5dih25ae3da6@yadavpratyush.com>
 <949c8fca-bf7d-ebde-4f28-10cf193c0411@zivver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949c8fca-bf7d-ebde-4f28-10cf193c0411@zivver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Cc Dscho who got dropped from the Cc list somewhere along the way)

Hi Vasili,

On 10/12/19 01:11PM, Vasili Novikov wrote:
> Hi all,
> Sorry if threading was broken: Thunderbird possibly doesn't fully support
> mbox import that I used. Or I did it unproperly. Either way, hope it's
> correct now.

Threading seems to works fine for you. I meant avoiding top posting. 
More explanation on top posting and bottom posting here 
http://www.idallen.com/topposting.html
 
> Thanks for explaining. I misunderstood the purpose of the window. If it's a
> slow ongoing task, then indeed it should not be closeable with Esc. I'd say
> it makes sense to allow Esc to work when it gets into "Success" state
> though, as in the screenshot.

Hmm, I like the idea. Does that work for you Dscho?
 
> 
> Thanks,
> Vasili
> 
> On 10/12/2019 13.02, Pratyush Yadav wrote:
> > Hi Vasili,
> > 
> > Please try to not top-post on the list.
> > 
> > On 09/12/19 04:53PM, Vasili Novikov wrote:
> > > What have console windows to do with git gui though? I'd work under the
> > 
> > Well, the window/popup in question is internally named "console" and is
> > defined in lib/console.tcl. It is used by many parts of git-gui that
> > need to execute a command and show the output to the user.
> > 
> > > following assumptions:
> > > * we're talking about a GUI window, not a TUI one
> > > * the window has no useful information at all except the fact that something
> > > has "finished", is "done". There are no actions that you can take except to
> > > dismiss the window.
> > It also shows you the output of a command currently in progress (like
> > git-push). My main argument with avoiding Escape is that people often
> > expect Escape to stop an ongoing command. In this case though, closing
> > the window does not actually stop the command. It keeps going on in the
> > background.
> > 
> > But since the window is gone, people might think the command they were
> > running has stopped, which might lead to some unexpected results.
> > 
> > > If we agree on the following assumptions, then I see these real-world
> > > examples:
> > > * Mousepad > About > Esc = closes the popup
> > > * Firefox > About > Esc = closes the popup
> > > * Thunar > select any file and ask its properties > Esc = closes the window
> > > * file-roller (GNOME compressed archive manager) > Extract archive > Observe
> > > success window upon completion > Esc = closes the window.
> > 
> > In this case, the thing is done. There is no ongoing task. Not quite the
> > case with the console window in git-gui, which can also show ongoing
> > tasks.
> > > Are there any real-world examples where `Ctrl W` or `Esc D` work but `Esc`
> > > doesn't, to consider these alternatives as more intuitive to users?

-- 
Regards,
Pratyush Yadav
