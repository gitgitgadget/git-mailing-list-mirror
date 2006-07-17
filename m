From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 08:43:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 17:45:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2VEJ-0006ud-F8
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 17:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWGQPlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 11:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWGQPlv
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 11:41:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750858AbWGQPlv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 11:41:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6HFfgnW018355
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Jul 2006 08:41:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6HFfemh011967;
	Mon, 17 Jul 2006 08:41:41 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.631 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23973>



On Mon, 17 Jul 2006, Johannes Schindelin wrote:
> 
> But note that we usually use the whole contents of the mmap()ed file 
> anyway.

Not for pack-files, though. You may have a half-gigabyte pack-file, and 
only use a small small fraction of it.

(You also never really rename them, so windows should be fine for that 
case)

		Linus
