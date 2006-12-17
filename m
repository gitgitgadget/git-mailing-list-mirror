X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Dec 2006 00:38:34 +0100
Message-ID: <200612180038.34525.Josef.Weidendorfer@gmx.de>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <em1vgj$bc3$1@sea.gmane.org> <20061217173534.GA16838@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 23:38:58 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <20061217173534.GA16838@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34713>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5am-0004lL-Ub for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753232AbWLQXis (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbWLQXis
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:38:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:48995 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753232AbWLQXis
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 18:38:48 -0500
Received: (qmail invoked by alias); 17 Dec 2006 23:38:46 -0000
Received: from p549680A1.dip0.t-ipconnect.de (EHLO noname) [84.150.128.161]
 by mail.gmx.net (mp035) with SMTP; 18 Dec 2006 00:38:46 +0100
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On Sunday 17 December 2006 18:35, Yann Dirson wrote:
> An idea I had to handle that case, and which could be useful with the
> current problem, as well as others, like dealing with stgit's patch
> logging, would be to define "reachable commits" using a modular
> architecture.  That way we would be able to select what we want
> fsck-object/prune to consider reachable, in objects reachable from:
> 
> - raw "parents" field of commit objects
> - the latter as modified by info/grafts
> - reflogs
> - stgit patchlogs

Could be interesting for pruning support in submodules, too.

> The set of rules to consider could be declared in repo-config, thus
> stgit would be able to declare that its patchlogs should not be ignored,
> and people wishing to prune commits hidden by grafts in one repo could
> just remove the "raw-parents" rule from their repo's config.
> 
> Obviously, mentionning stgit-specific rules here immediately suggests a
> plugin-based architecture.

Isn't it enough to specify further subdirectories of .git/, holding
references which should be taken into account while pruning?
Hmm.. Grafting would be a special case.

