From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 09:05:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705100901320.3986@woody.linux-foundation.org>
References: <20070506195230.GA30339@mellanox.co.il>  <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
  <20070510095156.GC13655@mellanox.co.il>
 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmB8j-0006tU-Vd
	for gcvg-git@gmane.org; Thu, 10 May 2007 18:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbXEJQFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbXEJQFK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 12:05:10 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:42918 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754627AbXEJQFI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 12:05:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4AG51Yp022221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 09:05:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4AG50Jn024679;
	Thu, 10 May 2007 09:05:01 -0700
In-Reply-To: <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
X-Spam-Status: No, hits=-3.48 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46874>



On Thu, 10 May 2007, Alex Riesen wrote:
> 
> There is only one bit of flags ever used. What are the others for?

I actually think it tends to be better to have a "flags" field rather than 
a boolean, even if it only ends up having one flag.

> Why use negative logic?

This one I agree with. Ity would be nicer with CONNECT_VERBOSE than with 
NET_QUIET, and having the tests be

	if (flags & CONNECT_VERBOSE)
		..

instead.

> What was wrong with plain "int verbose"?

I could see wanting to add flags to do things like disable insecure 
connections etc, so there's certainly nothing saying that "verbose" is the 
only valid way to do things.

> What addresses were tried by connect?

That would be _really_ verbose. Maybe a CONNECT_EXTRA_VERBOSE?

		Linus
