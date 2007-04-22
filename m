From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver
 definition.
Date: Sat, 21 Apr 2007 22:47:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704212243080.9964@woody.linux-foundation.org>
References: <11771520591529-git-send-email-junkio@cox.net>
 <11771520591703-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 07:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfUvP-0008Lh-FF
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 07:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbXDVFra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 01:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbXDVFra
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 01:47:30 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:48705 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753863AbXDVFr3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 01:47:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3M5lP8H020528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Apr 2007 22:47:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3M5lOrv020551;
	Sat, 21 Apr 2007 22:47:24 -0700
In-Reply-To: <11771520591703-git-send-email-junkio@cox.net>
X-Spam-Status: No, hits=-3.542 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45214>



On Sat, 21 Apr 2007, Junio C Hamano wrote:
>
> The interface is similar to the custom low-level merge drivers.
> 
> First you configure your filter driver by defining 'filter.<name>.*'
> variables in the configuration.
> 
> 	filter.<name>.clean	filter command to run upon checkin
> 	filter.<name>.smudge	filter command to run upon checkout

I have to say, I'm obviously not a huge fan of playing games, but the 
diffs are very clean.

Are they actually *useful?* I dunno. I'm a bit nervous about what this 
means for any actual user of the feature, but I have to admit to being 
charmed by a clean implementation. 

I suspect that this gets some complaining off our back, but I *also* 
suspect that people will actually end up really screwing themselves with 
something like this and then blaming us and causing a huge pain down the 
line when we've supported this and people want "extended semantics" that 
are no longer clean.

But I'm not sure how valid an argument that really is. I do happen to 
believe in the "give them rope" philosophy. I think you can probably screw 
yourself royally with this, but hey, anybody who does that only has 
himself to blame ...

		Linus
