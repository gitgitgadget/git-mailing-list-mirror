X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Fri, 8 Dec 2006 06:27:05 +0100
Message-ID: <20061208052705.GA4318@steel.home>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com> <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net> <20061207221503.GA4990@steel.home> <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 05:27:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: JrMZN0ZdweC8oY-t1jPh+pSGq+kgtunqfVIf0y-BbwAmSTbcZj-JkK
X-TOI-MSGID: f1093203-989a-4a0e-a37a-81b3f3b85e11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33657>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsYGe-00068n-2r for gcvg-git@gmane.org; Fri, 08 Dec
 2006 06:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424630AbWLHF1R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 00:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424631AbWLHF1R
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 00:27:17 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:60381 "EHLO
 mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1424630AbWLHF1Q (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 00:27:16 -0500
Received: from fwd30.aul.t-online.de  by mailout10.sul.t-online.com with smtp
  id 1GsYGO-0007ku-01; Fri, 08 Dec 2006 06:27:12 +0100
Received: from tigra.home
 (JrMZN0ZdweC8oY-t1jPh+pSGq+kgtunqfVIf0y-BbwAmSTbcZj-JkK@[84.163.120.110]) by
 fwd30.sul.t-online.de with esmtp id 1GsYGI-1dT2u00; Fri, 8 Dec 2006 06:27:06
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id F12C7277AF; Fri,  8 Dec 2006 06:27:05 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GsYGH-0001BF-Rl; Fri, 08 Dec 2006 06:27:05 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano, Thu, Dec 07, 2006 23:29:54 +0100:
> > But aside from me trying ignoreState, can anyone help me with that
> > question regarding checking if the index is any different from HEAD?
> 
> Comparing index and HEAD should be cheap on a system with slow
> lstat(), I think, as "git-diff-index --cached HEAD" should just
> ignore the working tree altogether.  Is that what you want?
> 

yes, except that it'll compare the whole trees. Could I make it stop
at first mismatch? "-q|--quiet" for git-diff-index perhaps?
It's just not only stat, but also, open, read, mmap (yes, I try to use
it for packs) and close are really slow here as well.
