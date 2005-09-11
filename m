From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 14:33:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750936AbVIKVe1@vger.kernel.org Sun Sep 11 23:35:47 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750936AbVIKVe1@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZUD-0004n5-It
	for glk-linux-kernel-3@gmane.org; Sun, 11 Sep 2005 23:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVIKVe1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 11 Sep 2005 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVIKVe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:34:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750930AbVIKVeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:34:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BLXLBo026902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 14:33:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BLXJKj023101;
	Sun, 11 Sep 2005 14:33:20 -0700
To: Roland Dreier <rolandd@cisco.com>
In-Reply-To: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8335>



On Sun, 11 Sep 2005, Linus Torvalds wrote:
> 
> The _git_ network transport is. rsync and http aren't.

Btw, there's no reason why a client-side thing couldn't just parse the 
"alternates" thing, and if it doesn't find the objects in the main object 
directory, go and fetch them from the alternates itself.

IOW, this is not a fundamental problem with alternates, it's just that
since there is no server-side smarts to handle it (ie just raw file access
with rsync/http), it needs to be handled at the client side instead.

		Linus
