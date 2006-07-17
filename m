From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 10:56:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607171055230.15611@evo.osdl.org>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 19:55:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2XJL-0001sM-4U
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 19:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWGQRy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWGQRy7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 13:54:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751097AbWGQRy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 13:54:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6HHshnW026306
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Jul 2006 10:54:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6HHsYn2017591;
	Mon, 17 Jul 2006 10:54:39 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.621 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23978>


On Mon, 17 Jul 2006, Johannes Schindelin wrote:
> 
> So we could introduce a second mmap() which is normally the same as 
> mmap(), except for windows, where it is a rename() and unlink() safe 
> version of mmap() by reading the thing into RAM. Not very pretty.

Well, not too ugly either.

Imagine having a "map_packfile()" interface, and letting different targets 
just implement their own version. That doesn't sound too bad, does it?

		Linus
