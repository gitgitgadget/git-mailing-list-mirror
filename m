From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Allow setting default diff options via
 diff.defaultOptions
Date: Thu, 9 Apr 2009 09:29:38 -0700 (PDT)
Message-ID: <alpine.GSO.2.00.0904090922160.15657@kiwi.cs.ucla.edu>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu>
 <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 18:33:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrxBo-00044Q-H8
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 18:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935506AbZDIQ36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 12:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935539AbZDIQ3y
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 12:29:54 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:61647 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935488AbZDIQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 12:29:51 -0400
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n39GTd3W010304;
	Thu, 9 Apr 2009 09:29:39 -0700 (PDT)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n39GTc7v010301;
	Thu, 9 Apr 2009 09:29:38 -0700 (PDT)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116179>

Johannes,

On Thu, 9 Apr 2009, Johannes Schindelin wrote:

> In the case of format-patch, though, I am pretty certain that I do not want 
> any diff.defaultOptions: the output is almost always intended for machine 
> consumption, so it is a different kind of cattle.

Just to clarify:  I agree.  I certainly would never want diff.defaultOptions to 
affect format-patch, and none of my patches did so.  The reason I brought up 
format-patch is because, without an opt_out mechanism, it's harder for the user 
to use `git diff` to produce patch output identical to format-patch.

> Now, it is easy to put a patch on top of my patch to support something like 
> --no-defaults.

With all due respect sir, I think you would find that if you sit down and 
attempt to add such functionality on top of your version, it would be an 
unpleasant experience.  I predict the code would quickly turn inelegant and 
fragile.  I believe it would prompt you to consider a redesign (assuming you 
work and think quickly, after about 15 minutes), and the obvious solution would 
closely resemble my v3:
  http://comments.gmane.org/gmane.comp.version-control.git/114021

                             -- Keith
