From: Stephan Classen <stephan.classen@inventage.com>
Subject: git svn fetch stops at revision 1485500
Date: Sun, 03 Nov 2013 11:19:23 +0100
Message-ID: <5276232B.8020205@inventage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 11:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vcutl-0008Ak-Di
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 11:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3KCK1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 05:27:07 -0500
Received: from www.inventage.com ([62.12.129.170]:33322 "EHLO
	scapa.inventage.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529Ab3KCK1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 05:27:06 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Nov 2013 05:27:06 EST
Received: from localhost (localhost [127.0.0.1])
	by scapa.inventage.com (Postfix) with ESMTP id 23E60E94626
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 11:19:24 +0100 (CET)
Received: from scapa.inventage.com ([127.0.0.1])
	by localhost (scapa.inventage.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 2f_JZ_NcqUDa for <git@vger.kernel.org>;
	Sun,  3 Nov 2013 11:19:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by scapa.inventage.com (Postfix) with ESMTP id C3A32E94640
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 11:19:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at inventage.com
Received: from scapa.inventage.com ([127.0.0.1])
	by localhost (scapa.inventage.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JvUj7e37L6wI for <git@vger.kernel.org>;
	Sun,  3 Nov 2013 11:19:23 +0100 (CET)
Received: from [192.168.1.103] (195-202-219-190.dynamic.hispeed.ch [195.202.219.190])
	by scapa.inventage.com (Postfix) with ESMTPSA id 9904CE94626
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 11:19:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237258>

I hope this is the right place to post this.

When trying to fetch a very large svn using git svn it always terminates 
at commit 1485500.
this is easily reproducible:

git svn init -s https://svn.apache.org/repos/asf/onami/trunk
git svn fetch -r 1480000:HEAD

The commit 1485500 is not in the subtree of the svn I'm trying to fetch 
but in some unrelated place. So I think it is not the commit which 
causes the problem but an overflow of some kind.

The command terminates without an error but after the command has 
terminated nothing shows up in my local git repo.
There are no commits and no branches. I expected at least trunk to be 
available.

Thank you for your help
Stephan
