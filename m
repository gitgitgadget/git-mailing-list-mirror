From: Tim Mooney <Tim.Mooney@ndsu.edu>
Subject: git 1.8.4.1 configure should ship TYPE_SOCKLEN_T source macro
Date: Fri, 25 Oct 2013 18:26:39 -0500 (CDT)
Message-ID: <alpine.SOC.2.11.1310251814410.29200@dogbert.cc.ndsu.NoDak.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 01:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZrEa-0005r7-J9
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 01:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab3JYXz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 19:55:57 -0400
Received: from dogbert.cc.ndsu.NoDak.edu ([134.129.106.23]:34675 "EHLO
	dogbert.cc.ndsu.NoDak.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab3JYXz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 19:55:56 -0400
X-Greylist: delayed 1756 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2013 19:55:56 EDT
Received: from dogbert.cc.ndsu.NoDak.edu (localhost [127.0.0.1])
	by dogbert.cc.ndsu.NoDak.edu (8.14.4+Sun/8.14.4) with ESMTP id r9PNQdlB029950
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 18:26:39 -0500 (CDT)
Received: from localhost (mooney@localhost)
	by dogbert.cc.ndsu.NoDak.edu (8.14.4+Sun/8.14.4/Submit) with ESMTP id r9PNQdGY029947
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 18:26:39 -0500 (CDT)
X-Authentication-Warning: dogbert.cc.ndsu.NoDak.edu: mooney owned process doing -bs
X-X-Sender: mooney@dogbert.cc.ndsu.NoDak.edu
User-Agent: Alpine 2.11 (SOC 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236726>


[git-scm.com/community doesn't say whether the address for bug reports
allows posting by non-list members, so hopefully this makes it through
the moderation process]

I'm building git 1.8.4.1 on x86_64-pc-solaris2.11 (OpenIndiana 151a8,
one of the opensource distributions that came out of the OpenSolaris
project).

Although git is quite portable, there are a couple of long-standing issues
with configure when building on Solaris (what libraries are needed for
socket() and related network functions, and how to get gettext()).  When
patching configure.ac for these issues, it's necessary to rebuild
configure from configure.ac.

Unfortunately, git doesn't include the one non-standard m4 macro it
depends on, TYPE_SOCKLEN_T.  This makes it impossible to completely
rebuild configure from configure.ac.

It would be nice if git would do what other packages do in this situation:
ship (probably in a "m4" or "build-aux" directory) all the non-standard
m4 macros that the package requires.

Note also that TYPE_SOCKLEN_T is the deprecated name of that macro, the
current version appears to be AX_TYPE_SOCKLEN_T.  See:

 	http://git.savannah.gnu.org/gitweb/?p=autoconf-archive.git;a=blob_plain;f=m4/ax_type_socklen_t.m4

If possible, please consider including this macro in future versions of
the git releases.

Thanks!

Tim
-- 
Tim Mooney                                             Tim.Mooney@ndsu.edu
Enterprise Computing & Infrastructure                  701-231-1076 (Voice)
Room 242-J6, IACC Building                             701-231-8541 (Fax)
North Dakota State University, Fargo, ND 58105-5164
