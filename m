From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 22:13:09 -0400
Message-ID: <3BE9DFB5-81F9-40D6-A637-6C3C232394A6@gernhardtsoftware.com>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com> <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 01 04:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP2ac-0000WU-ID
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 04:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463Ab2EACNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 22:13:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49508 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab2EACNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 22:13:12 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 28CB61FFC0EB; Tue,  1 May 2012 02:13:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 699E31FFC015;
	Tue,  1 May 2012 02:13:01 +0000 (UTC)
In-Reply-To: <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196647>


On Apr 30, 2012, at 12:38 PM, Thomas Rast wrote:

> I can reproduce this.  The problem is that __WORDSIZE is not defined,
> either because it's Darwin or because the GCC is too old.  It winds up
> compiling the 32-bit case, which of course doesn't work for 64-bit
> builds.

Great.  I was worried about having to help you debug it via e-mail round-trips.  :-D

> Perhaps we can rewrite it in terms of sizeof(long) like this?

It does work for me, and seems pretty valid to me since long is actually the type you're storing it in.

~~ Brian G.
