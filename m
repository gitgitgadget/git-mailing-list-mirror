From: Gregg Leichtman <gslaccts@verizon.net>
Subject: git log over restricts output when using --follow?
Date: Tue, 07 Sep 2010 20:15:42 -0400
Message-ID: <4C86D5AE.6030302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 02:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot8Kh-0002gF-Lg
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 02:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0IHAQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 20:16:05 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:51648 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab0IHAQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 20:16:04 -0400
Received: from [192.168.1.2] ([unknown] [108.16.32.164])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L8E00N3JJE74T4P@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 07 Sep 2010 19:15:44 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.8) Gecko/20100802
 SUSE/3.1.2 Lightning/1.0b2 Thunderbird/3.1.2 ThunderBrowse/3.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155750>



Before I post this as a possible defect, I wanted to check here.

On the following server:

|gsl@aragorn:~/gitTest> uname -a
Linux aragorn 2.6.31.12-0.2-default #1 SMP 2010-03-16 21:25:39 +0100 i686 i686 i386 GNU/Linux

gsl@aragorn:~/gitTest> cat /etc/SuSE-release

openSUSE 11.2 (i586)
VERSION = 11.2
|

I use the following git:

|gsl@aragorn:~/gitTest> git --version
git version 1.7.2.3

|

I get (with a bash alias of |gitnp='git --no-pager'|):

(1)

|gsl@aragorn:~/gitTest> gitnp log --pretty=oneline junk.txt
500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
594ceed7a0fb35a860a6e2cb913d5398f09a861f 1st mod junk.txt
df271b2ebd5801bd8d827b0630577cad51c40896 initial junk.txt
|

(2)

|gsl@aragorn:~/gitTest> gitnp log --follow --pretty=oneline junk.txt
500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
594ceed7a0fb35a860a6e2cb913d5398f09a861f 1st mod junk.txt
df271b2ebd5801bd8d827b0630577cad51c40896 initial junk.txt
|

(3)

|gsl@aragorn:~/gitTest> gitnp log -2 --follow --pretty=oneline junk.txt
500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
|

(4)

|gsl@aragorn:~/gitTest> gitnp log -2 --pretty=oneline junk.txt
500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
594ceed7a0fb35a860a6e2cb913d5398f09a861f 1st mod junk.txt
|

Why don't I see 2 output lines for item (3) above?

-=> Gregg <=-
