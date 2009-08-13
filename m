From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: rebase-with-history -- a technique for rebasing without trashing
	your repo history
Date: Thu, 13 Aug 2009 14:46:07 +0200
Message-ID: <4A840B0F.9060003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Bazaar <bazaar@lists.canonical.com>,
	Git Mailing List <git@vger.kernel.org>,
	mercurial mailing list <mercurial@selenic.com>
X-From: bazaar-bounces@lists.canonical.com Thu Aug 13 14:46:25 2009
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZhJ-00016Q-3v
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 13 Aug 2009 14:46:25 +0200
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1MbZhA-0004y6-Tx; Thu, 13 Aug 2009 13:46:16 +0100
Received: from einhorn.in-berlin.de ([192.109.42.8])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <mhagger@alum.mit.edu>) id 1MbZh5-0004wp-I7
	for bazaar@lists.canonical.com; Thu, 13 Aug 2009 13:46:11 +0100
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (p4FC1FAB6.dip.t-dialin.net [79.193.250.182])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	n7DCk9hL028299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Aug 2009 14:46:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.8.1.22) Gecko/20090608 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Topics: everythingelse
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125819>

Sorry to cross-post, but I think this might be interesting to all three
projects...

I've been thinking a lot about the problems of tracking upstream changes
while developing a feature branch.  As I think everybody knows, both
rebasing and merging have serious disadvantages for this use case.
Rebasing discards history and makes it difficult to share
work-in-progress with others, whereas merging makes it difficult to
prepare a clean patch series that is suitable for submission upstream.

I've written some articles describing another possibility, which
combines the advantages of both methods.  The key idea is to retain
rebase history correctly, on a patch-by-patch level.  The resulting DAG
retains enough history to prevent problems with merge conflicts
downstream, while also allowing the patch series to be kept tidy.

(Please note that this technique only works for the typical "tracking
upstream" type of rebase; it doesn't help with rebases whose goals are
changing the order of commits, moving only part of a branch, rewriting
commits, etc.)

For more information, please see the full articles:

* A truce in the merge vs. rebase war? [1]
* Upstream rebase Just Works=E2=84=A2 if history is retained [2]
* Rebase with history -- implementation ideas [3]

I'd appreciate feedback!

Michael

[1]
http://softwareswirl.blogspot.com/2009/04/truce-in-merge-vs-rebase-war.ht=
ml
[2]
http://softwareswirl.blogspot.com/2009/08/upstream-rebase-just-works-if-h=
istory.html
[3]
http://softwareswirl.blogspot.com/2009/08/rebase-with-history-implementat=
ion.html
