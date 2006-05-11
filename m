From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Thu, 11 May 2006 12:10:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605111207200.3866@g5.osdl.org>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
 <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org> <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 21:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeGZ7-000097-Cp
	for gcvg-git@gmane.org; Thu, 11 May 2006 21:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEKTLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWEKTLK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 15:11:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWEKTLI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 15:11:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4BJB1tH001072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 May 2006 12:11:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4BJAxdU023717;
	Thu, 11 May 2006 12:10:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19911>



On Thu, 11 May 2006, Junio C Hamano wrote:
> 
> Is uint32_t guaranteed to be exactly 32-bit, or merely enough to
> hold 32-bit?

I think it's guaranteed to be 32-bit, but regardless, the current git 
headers already assume that "unsigned int" is 32-bit.

Which is a pretty safe assumption for at least the next ten years or so, 
possibly much longer. So I don't think we need to worry _too_ much about 
this. I think it's more important to try to get git working on Windows, 
than on 16-bit DOS or on a PDP-9, or one of the odd cray machines.

		Linus
