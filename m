X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Mon, 27 Nov 2006 01:59:14 +0100
Message-ID: <200611270159.14925.Josef.Weidendorfer@gmx.de>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <20061126033433.GD29394@spearce.org> <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 00:59:35 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32375>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoUqB-0002Yo-Mt for gcvg-git@gmane.org; Mon, 27 Nov
 2006 01:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755695AbWK0A7S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755703AbWK0A7S
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 19:59:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:54984 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755695AbWK0A7S (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 19:59:18 -0500
Received: (qmail invoked by alias); 27 Nov 2006 00:59:16 -0000
Received: from p5496967F.dip0.t-ipconnect.de (EHLO noname) [84.150.150.127]
 by mail.gmx.net (mp018) with SMTP; 27 Nov 2006 01:59:16 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sunday 26 November 2006 04:58, Junio C Hamano wrote:
> > git-clone should skip rewinding branches by default, unless the user
> > adds an option (e.g. --include-rewinding-branches).  This way new
> > users to git.git don't get the `pu` branch unless they really mean
> > to get it, at which point they have hopefully also read the upstream's
> > description of the `pu` branch and its rewinding policy, and can
> > at least start to grasp what is going to happen if they start to
> > work with the branch.
> 
> I like this approach very much.

I am not so sure about this. IMHO, any user expects to see "pu" branch
cloned too after cloning git.git (at least me, and a newbie probably too).

I agree about the remote branch description saying that "pu" branch will
be rewinded. git-clone should set "+" before such a branch.

As said, the real problem begins when the user tries to branch off her
own local branch from "pu". At this point, "git branch" or
"git checkout -b ..." should warn the user that he has to expect troubles
when branching off from such a branch, and only allow it with a
"--force" option.

