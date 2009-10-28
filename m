From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add '--bisect' revision machinery argument
Date: Wed, 28 Oct 2009 16:32:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910281631400.31845@localhost.localdomain>
References: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain> <7viqdzgls9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3I0y-0008B3-U4
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 00:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbZJ1XdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZJ1XdE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 19:33:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47517 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752095AbZJ1XdD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 19:33:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n9SNX0Dn014415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Oct 2009 16:33:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n9SNWxRF024965;
	Wed, 28 Oct 2009 16:33:00 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7viqdzgls9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131510>



On Wed, 28 Oct 2009, Junio C Hamano wrote:
> 
> This shows a very nice direction to evolve, but your patch as-is breaks
> "rev-list --bisect", I think.

I think you're right. I tested git rev-parse, and the 'git log' machinery, 
but I didn't think about the fact that we already had a meaning 
for '--bisect' in rev-list.

> Also, the helper of "git bisect" can and probably should be taught to just
> ask this new behaviour from the revision machinery, instead of collecting
> good and bad refs itself using bisect.c::read_bisect_refs().

Yeah. And git-bisect.sh can be simplified too.

		Linus
