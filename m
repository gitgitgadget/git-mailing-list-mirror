From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 12:11:09 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901071210180.17115@alien.or.mcafeemobile.com>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0901071056470.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKell-0000h9-9H
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZAGULN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbZAGULN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:11:13 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:55951 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbZAGULM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:11:12 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2C4ECC> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 7 Jan 2009 15:11:09 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.LFD.2.00.0901071056470.3057@localhost.localdomain>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104826>

On Wed, 7 Jan 2009, Linus Torvalds wrote:

> On Wed, 7 Jan 2009, Davide Libenzi wrote:
> > 
> > xdiff allows for diffing ranges, and the most efficent method is exactly 
> > how you did ;)
> 
> No, the performance problem is how it needs to re-hash everything. xdiff 
> doesn't seem to have any way to use a "subset of the hash", so what the 
> patience diff does is to use a subset of the mmfile, and then that will 
> force all the rehashing to take place, which is kind of sad.
> 
> It would be nice (for patience diff) if it could partition the _hashes_ 
> instead of partitioning the _data_. That way it wouldn't need to rehash. 
> See?

Yeah, saw that afterwards ;)



- Davide
