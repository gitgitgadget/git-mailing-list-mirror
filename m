From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 15:47:14 +0100
Message-ID: <fq6hhi$cub$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 15:48:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUk3O-0000OL-Iz
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 15:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbYB1Ord (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 09:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbYB1Ord
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 09:47:33 -0500
Received: from main.gmane.org ([80.91.229.2]:36911 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbYB1Orc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 09:47:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JUk2d-0007Ra-L9
	for git@vger.kernel.org; Thu, 28 Feb 2008 14:47:23 +0000
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 14:47:23 +0000
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 14:47:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75402>

Hi,

I was getting a lot of "no newline at end of file" warnings with GCC, so 
I decided to fix these files in my clean working tree with

for i in `find . -iname "*.c" -o -iname "*.cc" -o -iname "*.cpp" -o 
-iname "*.h" -o -iname "*.hpp"`; do
     echo $i
     echo wq | ed $i > /dev/null 2>&1
done

Afterwards, I wanted so see a list of files that were actually affected, 
but to my wonderment "git diff --name-status" did not list any files, 
although both "git diff" and "gitk" showed the diffs correctly.

Is this a bug in "--name-status" that is does not detected changes if 
only a final newline has been added, or am I missing something?

Thanks.

-- 
Sebastian Schuberth

