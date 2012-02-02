From: David Howells <dhowells@redhat.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 02 Feb 2012 20:33:31 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <17890.1328214811@redhat.com>
References: <CAH6sp9P8ehXoC075dcK9ni5rJBV9iCZmLHTBr-UR+-jbD3c6Ww@mail.gmail.com> <21056.1328185509@redhat.com>
Cc: dhowells@redhat.com, git@vger.kernel.org, valerie.aurora@gmail.com
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3Li-0001F5-PY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab2BBUdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:33:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968Ab2BBUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:33:37 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q12KXaCJ017500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 2 Feb 2012 15:33:36 -0500
Received: from redhat.com ([10.3.112.8])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q12KXWaf030969;
	Thu, 2 Feb 2012 15:33:34 -0500
In-Reply-To: <CAH6sp9P8ehXoC075dcK9ni5rJBV9iCZmLHTBr-UR+-jbD3c6Ww@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189700>

Frans Klaver <fransklaver@gmail.com> wrote:

> I always thought of the author field as being an indication of who is
> ultimately responsible for its implementation (the one in the
> pestering spot).

Define 'ultimate responsibility for an implementation'.  I'm further developing
patches that Val has (at least partially) implemented.  By Val's admission some
of the patches she further developed beyond what Jan Blunck had implemented.
The chain may extend further.  To that end all three of us are authors of some
of the patches.

However, if you meant 'maintenance' rather than 'implementation', then, yes,
that would be me (for the moment at least).  But if that's the case, then
shouldn't it be 'Maintainer' and not 'Author'?  And, besides, that's what the
MAINTAINERS file is for.

> (1) may seem desirous, but doesn't (2) seem like a cleaner and more
> maintainable solution?

No.  I would say that properly supporting multiple authors in the commit object
is the cleaner solution.  It's not the *easier* solution, however, and would
require an upgrade to the version of GIT used to parse these commits.  That
I'll grant you.

> Gitweb will show the entire log message if people are interested in the
> exact change, right?

But if I say to Gitweb "show me the patches authored by Val" it will *not* turn
up these patches, and in that way will deny Val credit.  Yes, you can see that
Val altered that patch if you look at that patch directly - but you have to
know where to go and look, in which case you already know or suspect that Val
is credited with patches in that area.

So to make (2) work, Gitweb needs to search for the additional authoring fields
when asked to credit people with the patches they've worked on.

Similarly gitk and possibly other tools would need to do the same.

*That* would be fine by me, I suppose.  I don't think it's the correct way to
do it, but it might be the logical way since this wasn't build in from the
beginning - and the main thing would be to turn up the prior or joint
authorship to author-based searches.

David
