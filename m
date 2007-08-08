From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tests: added d2u to have unix style testfiles even in
 textmode
Date: Tue, 7 Aug 2007 20:03:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708071959470.23971@woody.linux-foundation.org>
References: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
 <11865269472595-git-send-email-prohaska@zib.de>
 <11865269472121-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIbq4-0007rg-RY
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbXHHDDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756708AbXHHDDz
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:03:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60084 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755108AbXHHDDy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 23:03:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l78339ri005714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 20:03:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l78333G2017801;
	Tue, 7 Aug 2007 20:03:03 -0700
In-Reply-To: <11865269472121-git-send-email-prohaska@zib.de>
X-Spam-Status: No, hits=-4.121 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_31,J_CHICKENPOX_84,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55293>



On Wed, 8 Aug 2007, Steffen Prohaska wrote:
>
> This is needed if the content of files is compared with
> precomputed sha1s or stored expected results.
> 
> ***WARNING***
> This patch is useful for testing and illustrating the problem
> but not thought to be applied to any official git branch.

Quite frankly, *much* rather than having d2u everywhere, why not make the 
default for DOS/Windows be to have

	[core]
		autocrlf=true

and then none of this should hopefully be needed.

(We still need to write the internal git objects using O_BINARY to make 
sure that cygwin doesn't corrupt binary data, but that's a totally 
different issue).

			Linus
