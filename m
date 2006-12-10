X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 14:33:06 -0800
Message-ID: <7vlklf2xgd.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612101030390.12500@woody.osdl.org>
	<7vpsar4fcu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612101326420.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 22:33:37 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612101326420.12500@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 10 Dec 2006 13:31:56 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33944>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXEU-0002hS-QU for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760247AbWLJWdK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759949AbWLJWdK
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:33:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34488 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759967AbWLJWdI (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 17:33:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210223307.HRI29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 17:33:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xAYV1V00F1kojtg0000000; Sun, 10 Dec 2006
 17:32:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 10 Dec 2006, Junio C Hamano wrote:
>> 
>> That is fine by me.  We would benefit from an empty blob and an
>> empty tree.
>
> I was wondering if we ever had any special case where we wanted the empty 
> blob, and couldn't come up with any.

After saying that I was thinking about the same.  Empty blob is
not all that useful (and let's not bring up the "empty commit"
in this discussion pretty please).

> In contrast, the empty tree clearly ends up being an interesting special 
> case that actually gets used occasionally, ie here we had two independent 
> uses for the same thing..

Two?

I sent out a patch with comment about an issue I worry about.

I do not think the empty-tree case matters in practice because
we do not allow an empty tree to be committed, but if we add
empty blob to the set of "well known objects", the backward
compatibility issue becomes real.
