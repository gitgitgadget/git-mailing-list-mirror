From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 16:45:07 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001261639550.17519@localhost.localdomain>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr> <7vljfkxxj9.fsf@alter.siamese.dyndns.org> <fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Juliusz Chroboczek <jch@pps.jussieu.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 01:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZw32-00019f-SA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 01:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0A0AqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117Ab0A0AqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 19:46:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51332 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751305Ab0A0AqP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 19:46:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0R0j7a6002978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jan 2010 16:45:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0R0j78X000603;
	Tue, 26 Jan 2010 16:45:07 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.446 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138093>



On Wed, 27 Jan 2010, Sverre Rabbelier wrote:
> 
> I would imagine that the checksum is taken over just the actual commit
> message, perhaps author information, and use the patch-id for the
> patch itself, that way any comments after triple dash would be ignored, right?

That wouldn't work either. People can, should, and do add extra things to 
the message before applying it.

Examples of things I tend to add/change in the commit message:
 - add ack's from people in the same thread
 - add "Cc: stable@kernel.org" 
 - re-flow paragraphs when somebody uses a mailer that makes a mess of it.
 - occasionally fix spelling and grammar

so if there is some checksum that screws that up and requires me to then 
use a "--force" flag to apply it, that would be a bad thing.

I also do edit patches manually too. Having lived with people sending me 
patches for the last almost twenty years, I can edit patches in my sleep. 
Doing things like renaming new variables etc by search-and-replace on the 
patch may not be something I do _often_, but it happens.

In short, it might make sense to have some anti-corruption logic, but I 
suspect it needs a lot of thought. 

		Linus
