From: Lyle <webmaster@cosmicperl.com>
Subject: x permission lost on Windows merge
Date: Sat, 19 Feb 2011 20:29:37 +0000
Message-ID: <4D602831.8060200@cosmicperl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 21:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqtqf-0005Py-4F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 21:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab1BSU4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 15:56:07 -0500
Received: from ns.cosmichost.co.uk ([213.133.65.196]:51495 "EHLO
	cosmichost.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab1BSU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 15:56:06 -0500
X-Greylist: delayed 1575 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Feb 2011 15:56:06 EST
Received: from [127.0.0.1] (unknown [78.86.207.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: cosmicperl)
	by cosmichost.co.uk (Postfix) with ESMTP id 658DC10082A
	for <git@vger.kernel.org>; Sat, 19 Feb 2011 20:29:46 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Antivirus: avast! (VPS 110219-0, 19/02/2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167382>

Hi All,
   I was just on IRC chatting about this issue. What I'm finding is that 
if a merge happens on a Windows git repo the x permission is lost, 
example (filename changed):

filename.pl

----------------------------- filename.pl -----------------------------
index 0388de4,94d7e76..9c31830
mode 100755,100755..100644

As you can see, both of the modified files are 0755 but the merged file 
is 0644. I know windows files don't have the x permission, which 
explains why the newly created merged file would be missing the x, but 
surely with filemode = false the behaviour should be to carry over the x 
from the two modified files?

This is causing me problems when the merged file gets pulled back onto 
Linux systems where it needs the x permission.


Lyle
