From: Christian Soltenborn <christian@soltenborn.de>
Subject: Git crash on different versions, including current
Date: Sat, 29 Aug 2015 10:41:45 +0200
Message-ID: <55E17049.8030706@soltenborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 10:47:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVbmx-00018b-4A
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 10:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbH2Iq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 04:46:59 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:35825 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbbH2Iq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 04:46:57 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2015 04:46:57 EDT
Received: from [95.223.81.151] (helo=[192.168.1.5])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <christian@soltenborn.de>)
	id 1ZVbhh-00041F-So
	for git@vger.kernel.org; Sat, 29 Aug 2015 10:41:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
X-Df-Sender: Y2hyaXN0aWFuQHNvbHRlbmJvcm4uZGU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276771>

Hi everybody,

today I ran into a git issue on Windows 7/64. My directory structure
looks like this, and I wondered why the content of a dir wouldn't get added.

C:\Users\chris\git\GoogleTestExtension
-- .git
-- ConsoleApplication1 (new)
----- gtest-1.7.0 dir (does not get added)
----- stuff that has been successfully added
-- more stuff that's already under git control

So here's about what I did:
- Looked at it with Git Gui, noticed that gtest-1.7.0 is a submodule
- Deleted gtest-1.7.0/.git
- performed git add --all . within the gtest-1.7.0 dir => crash, output
below
- installed git 2.5.0
- uninstalled git 1.9.1
- deleted lock file
- performed git add --all . within the gtest-1.7.0 dir => crash, output
below

I could provide the according dir for reproducing the issue (I will now
zip it for reference) - if anybody is interested, drop me an email.

All the best
Christian



Output with git 1.9.1:

C:\Users\chris\git\GoogleTestExtension\ConsoleApplication1\gtest-1.7.0>git
add --all .
A
This application has requested the Runtime to terminate it in an unusual
way.
Please contact the application's support team for more information.
Assertion failed: item->nowildcard_len <= item->len && item->prefix <=
item->len, file pathspec.c, line 317



Output with git 2.5.0:

C:\Users\chris\git\GoogleTestExtension\ConsoleApplication1\gtest-1.7.0>git
add --all .

This application has requested the Runtime to terminate it in an unusual
way.
Please contact the application's support team for more information.
A s s e r t i o n   f a i l e d !

 P r o g r a m :   C : \ P r o g r a m   F i l e s \ G i t \ m i n g w 6
4 \ b i n \ g i t . e x e
 F i l e :   p a t h s p e c . c ,   L i n e   3 1 7

 E x p r e s s i o n :   i t e m - > n o w i l d c a r d _ l e n   < =
 i t e m - > l e n   & &   i t e m - > p r e f i x   < =   i t e m - > l
e n--
Dylan Thomas: "An alcoholic is someone you don't like who drinks as much
as you do."
