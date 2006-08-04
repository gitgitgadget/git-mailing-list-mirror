From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 10:29:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> 
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> 
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>  <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
  <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> 
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> 
 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> 
 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> 
 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 19:30:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G93Ur-0003V6-WA
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 19:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbWHDRaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWHDRaB
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 13:30:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161337AbWHDRaA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 13:30:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74HTwnW032281
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 10:29:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74HTvGm008573;
	Fri, 4 Aug 2006 10:29:57 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24812>



On Fri, 4 Aug 2006, Jon Smirl wrote:
> 
> I'll end up with 110,000 pack files. I suspect when I run repack over
> that it is going to take 24hrs or more, but maybe not since everything
> may be small enough to run in RAM.

You may definitely want to pack the pack-files together every once in a 
while. Doing so is not that hard: just list all the objects in all the 
pack-files you want to merge, which in turn is trivial from reading the 
index of the pack-files (and then you do want to do the filename, 
although you can just use the pack-file name if you want to). 

But yeah, it's going to be expensive whatever you do. It's a big repo.

		Linus
