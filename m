From: Nicolas Stroppa <nstroppa@computing.dcu.ie>
Subject: git-svnimport and tags
Date: Fri, 13 Oct 2006 15:44:55 +0100
Message-ID: <452FA667.1060003@computing.dcu.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 13 16:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYOIs-00071p-GO
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 16:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJMOqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 10:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWJMOqM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 10:46:12 -0400
Received: from mailhost.computing.dcu.ie ([136.206.11.247]:58037 "EHLO
	mailhost.computing.dcu.ie") by vger.kernel.org with ESMTP
	id S1750952AbWJMOqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 10:46:11 -0400
Received: from [136.206.19.27] (pg-27.computing.dcu.ie [136.206.19.27])
	by mailhost.computing.dcu.ie (8.13.2/8.13.2) with ESMTP id k9DEk4mH024883
	for <git@vger.kernel.org.>; Fri, 13 Oct 2006 14:46:04 GMT
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28849>

Hello,


A small report. (I am using cogito-0.18 and git 1.4.2.3.)
I have imported an SVN project using git-svnimport.
This project has several tags. Here is what I get with one the tags.

tricatel $ git-cat-file tag `cat .git/refs/tags/alanis-0.9.4`
object [...]
type commit
tag alanis-0.9.4
tagger nico <nico>


If I do the same thing on a git repository created from scratch, I get:

tricatel $ git-cat-file tag `cat .git/refs/tags/alanis-0.9.4`
object [...]
type commit
tag alanis-0.9.4
tagger nico <nico@[...]> 1160736694 +0100

The date information is missing in the first case, which confuses
cg-tag-show:
tricatel $ cg-tag-show alanis-0.9.4
[...]
cg-Xlib: line 215: nico <n (nic * 3600 + co> * 60):
syntax error in expression (error token is "(nic * 3600 + co> * 60)")

I don't know if cg-tag-show should be more robust or if the date
information should be in the tag.

 Cheers,
 nicolas



-- 
 _____________________________________________________________
/
| Nicolas Stroppa - nstroppa@computing.dcu.ie - +353-1-7006912
| School of Computing, Dublin City University,
| Glasnevin, Dublin 9, Ireland.
| http://www.computing.dcu.ie/~nstroppa
\_____________________________________________________________
