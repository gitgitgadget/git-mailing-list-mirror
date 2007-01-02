From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 2 Jan 2007 10:48:50 -0800 (PST)
Message-ID: <560316.34562.qm@web31812.mail.mud.yahoo.com>
References: <7vy7omyuaf.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 19:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ogw-000509-TM
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 19:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbXABSsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 13:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbXABSsv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 13:48:51 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:46583 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754908AbXABSsv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jan 2007 13:48:51 -0500
Received: (qmail 35040 invoked by uid 60001); 2 Jan 2007 18:48:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Nhe6aTclA0Ni4XHk3mHF/hTxMEetJMooYBRFCNUFEQzU/oQ0seIEYtliHjZ8UQE9X7AhZvTHau/KSU8Q8ldPuyawKbCwe61BXpHsrUCYxbsvKBK3s+QSu7R6r4jW6agB3VG2vbOW91+xGimzQXBzZ8gNQykJuPUDC6roXcuTHOo=;
X-YMail-OSG: Hpkf6mEVM1nBY8r9VrlA0qdPTdigOHhHgKeFHQ6zS2tRKuvidTxKNsb8MWeJEpoyR6RhVCxmgLPvhWVrAcc3N2JGqWk5B1TAExpxhZ66dBdPVkXQ5O1StE3aG5b4IPWaGcEbxxb80VZuS1AWYXxNE.saUnWI9oW1anVM7yZ27MG6iW0EJSXjgNXQ
Received: from [71.84.31.238] by web31812.mail.mud.yahoo.com via HTTP; Tue, 02 Jan 2007 10:48:50 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7omyuaf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35796>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Questions:
> >
> > What is the reasonining of defining branch.<name>.merge to point
> > to the "remote's setup"?
> 
> See list archives.  
> 
> Because you are not required to use remote tracking branches.

Then why does it point to the _remote_ mapping?  One shouldn't
care what it is, and how it looks in the remote repo.  That is
handled by [remote].  In [branch] I shouldn't have to have any
absolute references, i.e. branch.<name>.remote points to [remote],
and branch.<name>.merge should only give a _branch_ name,
whose remote-to-local mapping (which preserves the branch name)
can be found by dereferencing branch.<name>.remote to get to
remote.<rname>.fetch.

Think of it as DB schema normalization.

     Luben


> By the way, I think we allow the name of the remote tracking
> branch as well, but we do not advertise it -- always using
> remote's name consistently is much less confusing.
> 
> > The reasoning is that the remote's setup should only leak into
> > [remote] and no further.  I.e. [remote] is the only one concerned
> > with the mapping between the remote repo and the local repo.
> 
> No.  Remote is not about mapping -- if mapping is there you can
> talk about it, but that is optional.
> 
> 
