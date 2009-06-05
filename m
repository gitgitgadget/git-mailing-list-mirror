From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 11:30:32 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:45:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcYD-0004vj-ME
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbZFEQpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbZFEQpo
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:45:44 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:18901 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZFEQpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 12:45:43 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2009 12:45:43 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Best way to merge two repos with same content, different history
Thread-Index: Acnl+vIAIFFVbrlOSWmycAg7zDze+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120807>

Hi all,
	We're converting out of CVS after 10 years... The cvs2git
conversion takes around 4-5 days, and there doesn't seem to be any way
to speed that up.  So, our current plan is to take the tip of the
branches that we need for the next week, and import each of those
branches into its own clean git repo (top-skim).  Then we'll work out of
those repos while the conversion is in process (presumably creating
branches in those repos as needed).  Once the conversion is finished,
we'll need to get all the work done in the top-skimmed repos merged into
the converted repo so that we end up with little to no developer down
time, and all of our history, pre and post conversion in one repo.
	I'm testing all of this in advance, of course, and the tricky
part at the moment is how to "stitch" the commits from the top-skim
repos back onto the converted repo when the conversion is done.  The
file content of the initial commit for the skimmed repo is identical to
the last commit for the respective branch in the converted repo, but the
SHA1s are different, presumably because the history of the content is
different.

	Stated another way, I have two repositories, "new" and "old",
where the files in the initial commit on branch "B1" in "new" have
exactly the same content as the last commit on branch "B1" in "old".
There also exist various branches in "new" based on "B1".  I'd like to
merge all the commits from "new" into "old", but the SHA1s are
different, presumably because the history leading up to those points are
different.

	Other than using manually format-patch on every branch in new,
then applying the patches (presumably with regular old patch, since the
ancestor commit IDs won't match), is there any "good" way to merge "new"
into "old"?

Thanks,	


--

Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere
Learn more at www.mqsoftware.com 
