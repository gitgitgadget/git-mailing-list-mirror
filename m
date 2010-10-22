From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: format-patch broken [Was: fetch and bundle don't work in
 (semi-)broken repo]
Date: Thu, 21 Oct 2010 23:53:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010212235410.2764@xanadu.home>
References: <20101019160957.GK11713@pengutronix.de>
 <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de>
 <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
 <20101019210233.GA32029@burratino>
 <alpine.LFD.2.00.1010192154200.2764@xanadu.home>
 <20101020074122.GC28166@pengutronix.de>
 <alpine.LFD.2.00.1010200937200.2764@xanadu.home>
 <20101020150810.GE19834@pengutronix.de>
 <alpine.LFD.2.00.1010201301130.2764@xanadu.home>
 <20101021071106.GG19834@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_6jFQTGsltTlHP4+W2c/n6A)"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 22 05:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P98hO-0003Hz-7j
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 05:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab0JVDxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 23:53:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38508 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0JVDxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 23:53:38 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAO006W6AT7N0B1@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Oct 2010 23:53:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101021071106.GG19834@pengutronix.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1010212350370.2764@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159634>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_6jFQTGsltTlHP4+W2c/n6A)
Content-id: <alpine.LFD.2.00.1010212350371.2764@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Thu, 21 Oct 2010, Uwe Kleine-König wrote:

> Ah, you only need 16edb8381f2f2dabec9cc59f4a3d8c9ead899668 to make
> format-patch work, but still 09b3f464a50111071f7740056b98fa8f36133347 is
> missing for this tree.  This doesn't hurt format-patch as it's enough
> for it to know that this entry didn't change.  So format-patch needs
> less information than bundle/fetch and it's OK that the former succeeds
> and the latter fails.

No it is not.  In theory both format-patch and fetch/bundle should 
require the exact same information.

> [...]
> 
> No, that's not the (only) problem,
> 40aaeb204dc04d3cf15c060133f65538b43b13b0 is needed, git format-patch is
> just ignorant enough and invents something different:
> 
> 	username@hostname:~/path/linux-2.6$ git rev-list linus/master..sectionmismatches
> 	eb84720860a90769473b42215a4cb67ee5efe7a7
> 	2e14a5c831032fa489384763087f4a03d88607cb
> 	00b18e8058e98927e2e4eae32deae7e58f47467c
> 	1ad328f663128b5c6e6b4af1ac2da1b443dba530
> 	2a0e4c23a34c78891db685b2b4851705fd36d656
> 	089d061c26b00a5b8dbb9e70b81d36a97e1daded
> 	b7ce4ec88f1bdfbe49fa7ef12df8f985d705605a
> 	b40acb01793933cd6baaaf826f3fef6dd734f72b
> 	780e3d47d067b54b17bcac3794d62825e8e60422
> 	ce06129cf7bbf85afe4fc127afc957d36ba4e9e4
> 	c2172d687578e7eb037a232802a4a8c6de1b0eea
> 	0c23684f39714a72f54036ca2be36e8894794b66
> 	cea2a0668ee1a9dc3617a810954a41c7701a08e9
> 	2bd6ff604ac3aa4c96636dda1ad80a289205ccba
> 	7591700d538d08f2e8327bb439b6cb0488e13f3e
> 
> 	username@hostname:~/path/linux-2.6$ git diff-tree -r 7591700d538d08f2e8327bb439b6cb0488e13f3e
> 	7591700d538d08f2e8327bb439b6cb0488e13f3e
> 	:100644 100644 1b4afd2e6ca089de0babdacc5781426ef118da5c 40aaeb204dc04d3cf15c060133f65538b43b13b0 M	lib/Kconfig.debug
> 
> 	commit 7591700d538d08f2e8327bb439b6cb0488e13f3e
> 	Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 	Date:   Wed Aug 4 08:52:56 2010 +0200
> 
> 	    wip: enable DEBUG_SECTION_MISMATCH
> 
> 	diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> 	index 1b4afd2..40aaeb2 100644
> 	--- a/lib/Kconfig.debug
> 	+++ b/lib/Kconfig.debug
> 	@@ -1,1157 +0,0 @@
> 	-
> 	-config PRINTK_TIME
> 	-	bool "Show timing information on printks"
> 	-	depends on PRINTK
> 	-	help
> 	-	  Selecting this option causes timing information to be
> 	-	  included in printk output.  This allows you to measure
> 	-	  the interval between kernel operations, including bootup
> 	-	  operations.  This is useful for identifying long delays
> 
> So format-patch assumes that lib/Kconfig.debug became empty because of
> not knowing what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is.
> 
> So it's not git-bundle/git-fetch that is broken, but format-patch.

Or rather the low-level diff code.

diff --git a/diff.c b/diff.c
index 4732b32..b2839f9 100644
--- a/diff.c
+++ b/diff.c
@@ -2386,10 +2386,14 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	}
 	else {
 		enum object_type type;
-		if (size_only)
+		if (size_only) {
 			type = sha1_object_info(s->sha1, &s->size);
-		else {
+			if (type < 0)
+				die("unable to read %s", sha1_to_hex(s->sha1));
+		} else {
 			s->data = read_sha1_file(s->sha1, &type, &s->size);
+			if (!s->data)
+				die("unable to read %s", sha1_to_hex(s->sha1));
 			s->should_free = 1;
 		}
 	}


Nicolas

--Boundary_(ID_6jFQTGsltTlHP4+W2c/n6A)--
