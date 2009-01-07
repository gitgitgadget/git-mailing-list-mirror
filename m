From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 12:09:01 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901071159060.17115@alien.or.mcafeemobile.com>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
 <alpine.DEB.1.00.0901071924350.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKejU-0008N0-Td
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZAGUJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbZAGUJF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:09:05 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:55945 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZAGUJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:09:04 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2C4EC9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 7 Jan 2009 15:09:02 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.DEB.1.00.0901071924350.7496@intel-tinevez-2-302>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104825>

On Wed, 7 Jan 2009, Johannes Schindelin wrote:

> Heh.
> 
> Could it be that you misread my patch, and assumed that I faked an 
> xdfenv?
> 
> I did not, but instead faked two mmfiles, which is only as simple as I did 
> it because in git.git, we only have contiguous mmfiles.  (I recall that 
> libxdiff allows for ropes instead of arrays.)
> 
> The way I did it has one big shortcoming: I need to prepare an xdfenv for 
> the subfiles even if I already prepared one for the complete files.  IOW 
> the lines are rehashed all over again.

I told you I just glanced at the code :)
In that way, if you guys decide to merge this new algo, you'll need to 
split the prepare from the optimize, and feed it with an already prepared 
env.
Before going that way, have you ever tried to tweak xdl_cleanup_records 
and xdl_clean_mmatch to reduce the level of optimization, and see the 
results you get? It is possible that you won't need two different algos 
inside git.



- Davide
