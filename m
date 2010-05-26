From: Konrad Karl <kk_konrad@gmx.at>
Subject: .gitignore: according to what rules does this work
Date: Wed, 26 May 2010 18:23:06 +0200
Message-ID: <2033.90713218159$1274891002@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 18:23:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHJO1-0007AF-LK
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 18:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0EZQXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 12:23:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:60008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755054Ab0EZQXK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 12:23:10 -0400
Received: (qmail invoked by alias); 26 May 2010 16:23:08 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp011) with SMTP; 26 May 2010 18:23:08 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX19bpUxju3Bb+Vuajl1ZrGT5WihOE5oLOhXRzkELQ3
	i5ZWamkeZhjLGA
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147809>

I have the following directory layout and want to exclude
dir2 .. dirN

The following arrangement of .gitignore seems to work ok
but I was unable to find docs about the double asterisks.

./.gitignore:

*
*/
!.gitignore
!/dir1/


dir1/.gitignore:

!**
!**/

these two lines seem to be enough to have all subdirectories
within dir1 being included (which is desired) but why?

|-- .gitignore
|-- dir1
|   |-- .gitignore
|   |-- file1
|   |-- subdir1
|   |   |-- file1
|   |   `-- subsubdir1
|   |       |-- file1
|   |       `-- subsubsubdir1
|   |           `-- file1
|   `-- subdir2
|       `-- file1
|-- dir2
|   `-- file1
.
.
.
--- dirN
    `--file1

git add . says:
....
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   .gitignore
#       new file:   dir1/.gitignore
#       new file:   dir1/file1
#       new file:   dir1/subdir1/file1
#       new file:   dir1/subdir1/subsubdir1/file1
#       new file:   dir1/subdir1/subsubdir1/subsubsubdir1/file1
#       new file:   dir1/subdir2/file1

Before discovering this I was playing like this:

!*
!*/
!*/*
!*/*/ 

and so on.

Greetings,
Konrad
