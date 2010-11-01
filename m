From: Delan Azabani <delan@azabani.com>
Subject: can't redirect git's progress output (stderr)
Date: Mon, 01 Nov 2010 20:40:30 +0800
Message-ID: <4CCEB53E.9080102@azabani.com>
Reply-To: delan@azabani.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 14:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCu9g-0003z4-TU
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 14:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704Ab0KANK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 09:10:26 -0400
Received: from mailout02.server-system.net ([64.207.129.77]:33866 "EHLO
	mailout02.server-system.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756107Ab0KANKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 09:10:25 -0400
X-Greylist: delayed 1227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2010 09:10:25 EDT
Received: from n12.c03.server-system.net ([72.47.224.12])
	by mailout02.server-system.net with esmtp (Exim 4.63)
	(envelope-from <delan@azabani.com>)
	id 1PCtiw-0004uV-It
	for git@vger.kernel.org; Mon, 01 Nov 2010 05:42:54 -0700
Received: from d122-104-96-89.per20.wa.optusnet.com.au ([122.104.96.89]:60366 helo=[192.168.0.2])
	by n12.c03.server-system.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.63)
	(envelope-from <delan@azabani.com>)
	id 1PCtiG-0003wq-4L
	for git@vger.kernel.org; Mon, 01 Nov 2010 05:42:17 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.2
X-Authenticated-User: 85653 delan@azabani.com
X-Spam-Status: "score=3.1 tests=ALL_TRUSTED, RATWARE_GECKO_BUILD version=3.1.7
	cmae=v=1.0 c=1 a=8iKER7Z6dZ8A:10 a=czvaGDW3OmgA:10 a=8nJEP1OIZ-IA:10
	a=IARxn6uqMOWH7BTB5UwA:9 a=TJM1hnZ5FR1hTp6i7GcA:7 a=sN6dlCKUxoBK9yMWyQuvP_YKneYA:4
	a=wPNLvfGTeEIA:10 xcat=Undefined/Undefined"
X-Spam-Level: ***
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160481>

Hi all,

I'm writing a URI handler for git that uses bash/zenity to allow the
user to clone a git repository when a git:// link is clicked in a browser.

I'm having a bit of trouble getting git's output into zenity, however.
git outputs its progress messages (everything except the "Initializing"
message) on stderr, which shouldn't be a problem. Something weird has
happened though; the moment I try to pipe git's stderr to stdout or a
file, it disappears.

A simple way to test this:

git clone git://your.favourite/git/repo 2> file1
git clone git://your.favourite/git/repo 2>&1 > file2

file1 will be empty (why?) and file2 will contain only the
"Initializing" message, which came from stdout.

TL;DR why can't I pipe git's stderr output?

Help would be greatly appreciated; thanks in advance.
