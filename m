From: David Howells <dhowells@redhat.com>
Subject: How best to handle multiple-authorship commits in GIT?
Date: Thu, 02 Feb 2012 12:25:09 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <21056.1328185509@redhat.com>
Cc: dhowells@redhat.com, valerie.aurora@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 13:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsvj9-0002Sf-C9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab2BBMZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 07:25:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904Ab2BBMZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 07:25:14 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q12CPC1V019970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 2 Feb 2012 07:25:13 -0500
Received: from redhat.com ([10.3.112.8])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q12CP9Yh008136;
	Thu, 2 Feb 2012 07:25:11 -0500
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189638>


Hi,

I've been assigned a stack of patches to maintain and try and get upstream by
my employer.  Most of the patches currently have the authorship set to Val,
but since I'll be maintaining them if they go in upstream and I've changed
them a lot, I feel I should reassign the author field to myself so people
pester me rather than Val with questions about them.  However, I don't want to
deny Val or any other contributor credit for their work on the patches.

I can see a number of ways of doing this, and am wondering which will be best:

 (1) Ascribe multiple authorship directly in the commit.  I suspect this would
     require a change to GIT and its associated tools.  That way I could put my
     name in the priority pestering spot, but doing a search on authorship
     would still credit Val and others.

 (2) Add an extra tag 'Originally-authored-by' (or maybe 'Coauthored-by' as I
     saw someone recommend) in amongst the 'Signed-off-by' list.  But that
     doesn't give them credit in a gitweb search without changing gitweb.

 (3) Don't actually modify Val's commits to bring them up to date, but rather
     create a historical GIT tree with Val's commits committed as-are and then
     add my changes to the top in a number of large merge commits (there have
     been multiple major breakages due to different merge windows).

     I dislike this approach because it doesn't produce a nice set of patches I
     can give to someone to review (which is a must).  Plus, for the most part,
     it's actually easier to port Val's patches individually.

Can GIT be modified to do (1)?  Gitweb's display need only show one of the
authors in the single-row-per-patch list mode, but should find a patch by any
of the authors in an author search and should display all the authors in the
commit display.

David
