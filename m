From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-cvsimport : fatal: 'Root_branche_2_0_*_' is not a valid tag
 name.
Date: Thu, 12 Feb 2009 10:32:24 +0100
Message-ID: <4993ECA8.9000900@alum.mit.edu>
References: <4993CF2C.6010704@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Prenom Nom <utilisateur_768@yahoo.fr>
X-From: git-owner@vger.kernel.org Thu Feb 12 10:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXXxG-0006iv-Hk
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbZBLJc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbZBLJc2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:32:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:32929 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbZBLJc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:32:27 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1C9WPrQ000355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 Feb 2009 10:32:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <4993CF2C.6010704@yahoo.fr>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109589>

Prenom Nom wrote:
> i'd like to import a project from CVS.

If you can do this as a one-time conversion, please consider using
cvs2git [1].

> The cvs commits are done using
> Cp1252 encoding charset. The thing is i cannot change the .git/config
> file since the repo is created by git-cvsimport. So how can i use the
> good charset ?

cvs2git can convert the encoding of filenames, log messages, and author
names during the conversion.

> during a run of git-cvsimport, i got this error :
> fatal: 'Root_branche_2_0_*_' is not a valid tag name.
> Cannot create tag Root_branche_2_0_*_: Bad file descriptor

cvs2git can arbitrarily transform tag and branch names during the
conversion via user-specified transformation rules.

> I can't use -p -b xxx since i would like to test branch merging in git
> so i need HEAD AND some CVS branch (you can't use -b 2 times for cvsps).
> 
> So i guess i won't be able to test git branch merging...

Long-term synchronization between CVS and git is fragile.  Consider
converting to git altogether.  If that is not possible for political or
technical reasons, consider converting your repository to Subversion
(IMHO a no-brainer in even the most conservative shop), then using
git-svn as a git-to-Subversion bridge (it is much more reliable than
git-to-CVS).

Michael

[1] http://cvs2svn.tigris.org/cvs2git.html
