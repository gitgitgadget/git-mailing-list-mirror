From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Rebase a whole tree from one commit to another?
Date: Sat, 16 May 2009 15:49:06 +0200
Message-ID: <20090516134906.GA19110@localhost>
References: <4A0DC4CD.1030401@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat May 16 15:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5KGl-00079f-41
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 15:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbZEPNtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 09:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757581AbZEPNtI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 09:49:08 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:56260 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbZEPNtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 09:49:07 -0400
Received: from darc.dyndns.org ([84.154.123.237]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 16 May 2009 15:49:05 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M5KGB-000529-06; Sat, 16 May 2009 15:49:07 +0200
Content-Disposition: inline
In-Reply-To: <4A0DC4CD.1030401@dirk.my1.cc>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 16 May 2009 13:49:06.0071 (UTC) FILETIME=[14638A70:01C9D62D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119361>

On Fri, May 15, 2009 at 09:38:53PM +0200, Dirk S=FCsserott wrote:
>
>     git rebase new-master branch-a
>     git rebase branch-a   branch-b
>     git rebase branch-b   branch-c
>

You probably want something like

	git rebase new-master branch-a
	git rebase --onto branch-a branch-a@{1} branch-b
	git rebase --onto branch-b branch-b@{1} branch-c

instead, because if you have any conflicts during rebase, the rebased
commits will no longer be recognized as identical, causing even more
conflicts in the following rebases.
