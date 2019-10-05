Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019731F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfJEVBm (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:01:42 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50241 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJEVBm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 17:01:42 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 62E4340003;
        Sat,  5 Oct 2019 21:01:39 +0000 (UTC)
Date:   Sun, 6 Oct 2019 02:31:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Harish Karumuthil <harish2704@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Message-ID: <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/19 01:46AM, Harish Karumuthil wrote:
> Hi All,
> 
> From https://www.kernel.org/doc/html/v4.10/process/email-clients.html, I
> understood that, my current email client ( that is gmail web ) is not good
> for submitting patches. So I was tying to setup a mail client which is
> compatible with `git send-mail`. But I was not able to get a satisfactory
> result in that.

You don't need to "set up" an email client with git-send-email. 
git-send-email is an email client itself. Well, one which can only send 
emails.

So what you should do is run `git format-patch -o feature master..HEAD`, 
assuming your feature branch is checked out. This will give you a set of 
'.patch' files depending on how many commits you made in your branch in 
the folder feature/. Then, you can run 

  git send-email --to='Pratyush Yadav <me@yadavpratyush.com>' --cc='<git@vger.kernel.org>' feature/*.patch

This will send all your patch files via email to me with the git list in 
Cc. You can add multiple '--to' and '--cc' options to send it to 
multiple people.

Try sending the patches to yourself to experiment around with it.

A pretty good tutorial to configuring and using git-send-email can be 
found at [0]. And of course, read the man page.

These instructions are for Linux, but you can probably do something 
similar in Windows too (if you're using Windows that is).
 
> For now, I followed the instruction of Johannes Schindelin and submitted a
> pull request . Please see https://github.com/gitgitgadget/git/pull/376

You haven't sent '/submit' over there, so those emails aren't in the 
list (and my inbox) yet. You need to comment with '/submit' (without the 
quotes) to tell GitGitGadget to send your PR as email.

But I see that Dscho has left a comment over there, so you should 
probably address that first. You probably need to amend the commit, 
force push, and then comment with '/submit'. But I'm not a 100% sure 
because I haven't used GitHub PRs a lot.
 
> ---------
> @ Pratyush: Regarding your comments,
> 
> 
> > A pretty nice way of doing it. But I would _really_ like it if there was
> > an option in the "create tool" dialog to specify the shortcut. People of
> > a gui tool shouldn't have to mess around with config files as much as
> > possible.
> 
> I agree with this, But that may require some more profficiency in TCL/TK
> programming which I don't have. This is the first time I am looking into a
> TCL/TK source code.
> Any way I will try to integrate the gui gradually in feature. But
> unfortunatly, I may not be able to do that now.

Please do whatever you can. I will try to add a patch on top of yours to 
add the GUI option.
 
> > David has advocated inter-operability between git-gui and git-cola.
> > While I personally don't know how many people actually use both the
> > tools at the same time, it doesn't sound like a bad idea either.
> >
> > So, sharing shortcuts with git-cola would be nice. Of course, it would
> > then mean that we would have to parse the config parameter before
> > feeding them to `bind`. I don't suppose that should be something too
> > complicated to do, but I admit I haven't looked too deeply into it.
> 
> IMHO, Using a uniform shortcut-key code/foramat for both application can be
> considered as nice feature.
> But, whether we should share common shortcut-scheme with both application is
> a different question.
> Currently, both apps don't have a common shortcut-scheme. So in this
> situation, only sharing custom-tool's shortcut-scheme with both applications
> doesn't look like a good  idea to me 

Makes sense.
 
> > Are you sure that is a good idea? I think we should at least make 
> > sure
> > we are not binding some illegal sequence, and if we are, we should warn
> > the user about it. And a much more important case would be when a user
> > over-writes a pre-existing shortcut for other commands like "commit",
> > "reset", etc. In that case, the menu entires of those commands would
> > still be labelled with the shortcut, but it won't actually work.
> 
> I agree with you. It is an important point. After reading this, I checked
> current status of these issues. What I found is given below.
> 
> 1. When user provides an invalid sequence for the shortcut, it will cuase the
> entire gitgui application to crash at the startup
> 
> 2. When user tries to overwrite existing shortcut, it will not have any
> effect. Because, built in shortcuts will overwrite user provided one. But
> still, wrong menu accelerator label will persist for custom tools

One point I forgot to mention earlier was that I'm honestly not a big 
fan of separating the binding and accelerator label. I understand that 
you might not have the time to do this, but I think it is still worth 
mentioning. Maybe I will implement something like that over your patch. 
But it would certainly be nice if you can figure it out :).

Either ways, detecting an existing shortcut is pretty easy. The `bind` 
man page [1] says:

  If sequence is specified without a script, then the script currently 
  bound to sequence is returned, or an empty string is returned if there 
  is no binding for sequence.

So you can use this to find out if there is a binding conflict, and warn 
the user.

> Since #1 is a serious issue, I tried to find out the function which does the
> keycode validation, but I haven't succeded till now. ( I found the C function
> name  which is "TkStringToKeysym" from TK source, but I couldn't find its TCL
> binding ). It will be helpful if any one can help me on this.

I really think you shouldn't dive around in the C parts of Tcl. I 
haven't looked too deeply into this, but you can probably wrap your bind 
calls in `catch` [2] and handle errors from there. Again, I haven't 
tried actually doing this, so you do need to check first.

You can find examples of how to use `catch` in our codebase. Just search 
for it.

[0] https://www.freedesktop.org/wiki/Software/PulseAudio/HowToUseGitSendEmail/
[1] https://www.tcl.tk/man/tcl8.4/TkCmd/bind.htm
[2] https://www.tcl.tk/man/tcl8.4/TclCmd/catch.htm

-- 
Regards,
Pratyush Yadav
