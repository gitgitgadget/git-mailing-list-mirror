From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Wed, 11 Jan 2006 12:42:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
 <1136849810.11717.518.camel@brick.watson.ibm.com> <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net> <1136924980.11717.603.camel@brick.watson.ibm.com>
 <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net> <1136945538.11717.643.camel@brick.watson.ibm.com>
 <7v4q4bwavi.fsf@assigned-by-dhcp.cox.net> <1136999157.11717.658.camel@brick.watson.ibm.com>
 <7vek3esdw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Ostrowski <mostrows@watson.ibm.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 21:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewmny-0007tD-J8
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWAKUmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAKUmp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:42:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbWAKUmo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 15:42:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0BKgcDZ004130
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jan 2006 12:42:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0BKgZZt007103;
	Wed, 11 Jan 2006 12:42:36 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek3esdw0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14513>



On Wed, 11 Jan 2006, Junio C Hamano wrote:
> 
> For your (primarily Michal, but other interested parties as
> well) reference, here is the diff between your patch in the
> message I am replying to and what I placed in the "pu" branch
> last night.

Tangentially related note: maybe we should try to move to a "spawn()" like 
interface so that it could port better to native Windows interfaces?

Even under Linux, using vfork()+exec() is actually faster than a regular 
fork/exec, so there are potential advantages.

The real advantage of fork+exec is how you can do arbitrary setup between 
the two, without needing insanely complex rules for file descriptors etc. 
But maybe we don't have tons of those issues?

		Linus
