From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] GIT 1.5.1.2
Date: Sun, 22 Apr 2007 10:22:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
 <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751197AbXDVRWx@vger.kernel.org Sun Apr 22 19:23:31 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751197AbXDVRWx@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hffma-0000hM-Mg
	for glk-linux-kernel-3@gmane.org; Sun, 22 Apr 2007 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXDVRWx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 22 Apr 2007 13:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbXDVRWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Apr 2007 13:22:53 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:50333 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbXDVRWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Apr 2007 13:22:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MHMmqh020954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 10:22:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MHMlVU030487;
	Sun, 22 Apr 2007 10:22:48 -0700
In-Reply-To: <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.542 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45252>



On Sat, 21 Apr 2007, Junio C Hamano wrote:
>
> The latest maintenance release GIT 1.5.1.2 is available at the
> usual places:

Well, by "available" you probably mean "not available", because it doesn't 
actually work.

I get EPERM on pack-e00affefe0f779d0f9b0507aef25a1733f4a9117.idx/pack, 
because they are

	-r-------- 1 junio junio  1120880
	-r-------- 1 junio junio 15709370

respectively.

As a result, nothing really works, ie:

	[torvalds@hera git.git]$ git log
	error: Could not read 42c4b58059fa9af65e90f2c418bb551e30d1d32f

and doing a "git pull" will just result in lots of

	error: refs/heads/maint does not point to a valid object!
	error: refs/heads/next does not point to a valid object!
	error: refs/heads/todo does not point to a valid object!
	...

which is perhaps a bit of a misleading error message (technically true, 
but ..)

Oops.

		Linus
