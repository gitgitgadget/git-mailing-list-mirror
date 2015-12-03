From: Ronny Borchert <rborchert@live.de>
Subject: change to allow cross compile ARM and MIPS
Date: Thu, 3 Dec 2015 20:44:19 +0000 (UTC)
Message-ID: <loom.20151203T213355-444@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 21:50:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4apS-000073-I6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbbLCUuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:50:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:44723 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbbLCUuI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:50:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a4apI-0008GJ-Mh
	for git@vger.kernel.org; Thu, 03 Dec 2015 21:50:04 +0100
Received: from p4FD70435.dip0.t-ipconnect.de ([79.215.4.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 21:50:04 +0100
Received: from rborchert by p4FD70435.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 21:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.215.4.53 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281970>

I was trying to build git for MIPS. And found that configure.ac will 
compile some stuff on the host machine during configure step. So I am not 
sure how the inventor wants that it work.
My solution was to remove the parts with ac_cv_fread_reads_directories and 
ac_cv_snprintf_returns_bogus from configure.ac.

Because it seems that it is not enough to use arguments as described here:
https://www.gnu.org/software/automake/manual/html_node/Cross_002dCompilation
.html#Cross_002dCompilation

I mean would it be possible to specifiy both from outside?

i.e.
./configure ac_cv_fread_reads_directories=yes 
ac_cv_snprintf_returns_bogus=yes ...

This should overwrite any try of test with compile, so that any cross 
compile will build.
