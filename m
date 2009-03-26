From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: problems with multipl hosts access git-cvsserver after a git push
Date: Thu, 26 Mar 2009 12:31:32 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0FBD1@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 18:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmtS6-0004hz-QI
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 18:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbZCZRbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 13:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbZCZRbg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 13:31:36 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:38908 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbZCZRbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 13:31:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems with multipl hosts access git-cvsserver after a git push
Thread-Index: AcmuOLSuSFKD09t5SvuYqp5+EAmLsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114807>

Hi,  I'm looking at moving from cvs to git and I'm working on our build
process. There are a few machines where we don't have git and were
hoping to use git-cvsserver to provide read only access for the builds,
but I've run into a bit of a snag.

The build process begins a checkout on all the build machines
simultaneously, it looks as though when this happens have changes have
been pushed, the first cvs pull is updating the database to reflect the
git repo, other cvs clients are blocked and give up after awhile.....

Any thoughts how to "fix" this?  I suppose I could just stop doing the
simultaneous pulls for cvs but that's a bigger change than I wanted to
make.  The only other idea I've come up with is to run a separate
git-cvsserver for each host that must use cvs (there's only a few), that
way it can't be blocked by another host, but that's kind of clunky to
manage....

cvs checkout: warning: unrecognized response `DBD::SQLite::st execute
failed: database is locked(5) at dbdimp.c line 403 at
/usr/local/bin/git-cvsserver line 3253, <FILELIST> chunk 2.' from cvs
server
cvs checkout: warning: unrecognized response `DBD::SQLite::st execute
failed: database is locked(5) at dbdimp.c line 403 at
/usr/local/bin/git-cvsserver line 3326.' from cvs server 

... (message repeated many times with only small variations) ...

cvs checkout: warning: unrecognized response `DBD::SQLite::st execute
failed: database is locked(21) at dbdimp.c line 376 at
/usr/local/bin/git-cvsserver line 3326.' from cvs server
cvs checkout: warning: unrecognized response `DBD::SQLite::st execute
failed: database is locked(21) at dbdimp.c line 376 at
/usr/local/bin/git-cvsserver line 3331.' from cvs server
cvs [checkout aborted]: end of file from server (consult above messages
if any)

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
