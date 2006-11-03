X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Fri, 03 Nov 2006 11:53:34 -0800
Message-ID: <7v7iyc71dt.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061103074857.GA15972@diana.vm.bytemark.co.uk>
	<7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611030741530.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 19:54:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611030741530.25218@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 3 Nov 2006 08:10:29 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30879>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg56h-0003Fe-3M for gcvg-git@gmane.org; Fri, 03 Nov
 2006 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753508AbWKCTxg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbWKCTxg
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 14:53:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37073 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1753508AbWKCTxf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 14:53:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103195334.VNVO6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 14:53:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iKtD1V0071kojtg0000000 Fri, 03 Nov 2006
 14:53:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 3 Nov 2006, Junio C Hamano wrote:
>> 
>> 	[remote."gitster"]
>
> Btw, why the '.'? It doesn't even work with a dot, you have to have a 
> space, which is also a lot more readable..

Untested example ;-).

I do not have to use any of these in real life because I work in
repositories laid out without separate remotes.

> This would basically require that "git-parse-remote" be re-written as a 
> native builtin, because quite frankly, it would be too damn painful any 
> other way, but it really shouldn't be that nasty. In fact, I think we 
> should have done that long ago, because the shell-code is just horrid for 
> things like this.

I agree.

I am rediscovering git-cvsimport and git-cvsexportcommit right
now, and one thing I wished was git-cvsimport to have worked as
if it is a git-fetch of an exotic flavor.  Integrating it into
git-fetch so that "URL: cvs://repo.si.to/ry" in .git/remotes
would do a sensible thing and make git-cvsimport honor
"Pull: HEAD:remotes/cvs/master" would both need some work in
parse-remote, and doing anything more complicated than the
current parse-remote in shell is quite painful.
