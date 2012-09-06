From: Spencer Rathbun <SRathbun@riverainc.com>
Subject: Git-svn not receiving post commit hook text from svn server
Date: Thu, 6 Sep 2012 08:17:26 -0400
Message-ID: <208E6718-B61F-4E76-B0C8-D28767561383@riverainc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9b6c-0007X4-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab2IFMWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 08:22:39 -0400
Received: from remote.riverainc.com ([74.142.1.242]:10948 "EHLO
	Remote.RiveraInc.Com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2IFMWi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 08:22:38 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2012 08:22:38 EDT
Received: from RCGXCH01.RCG.local (192.168.5.20) by Remote.riverainc.com
 (192.168.1.10) with Microsoft SMTP Server id 8.3.245.1; Thu, 6 Sep 2012
 08:17:06 -0400
Received: from RCGXCH01.RCG.local ([192.168.5.20]) by RCGXCH01.RCG.local
 ([192.168.5.20]) with mapi; Thu, 6 Sep 2012 08:17:06 -0400
Thread-Topic: Git-svn not receiving post commit hook text from svn server 
Thread-Index: Ac2MKYcTBXllUX6BQNSspjR3I3FoRg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204878>

Hello everyone,

I've run into a minor bug in the git svn integration. When I run git svn dcommit with git 1.7.12, it successfully sends the commit to the svn server and rebases if necessary. However, the svn server has a post commit hook which runs, and is supposed to return some text to the client.

Git does not display this text, though the hook runs server side, and git says the commit succeeded on the server.  According to the response I got from my question on SO:

http://stackoverflow.com/q/12264108/724357

The problem is caused by git svn using get_commit_editor() instead of get_commit_editor2(). Hacking a fix together is way down my priority list at the moment, so I just wanted to give you a quick bug report.

Regards,
Spencer Rathbun

This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.
