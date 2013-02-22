From: Eckhard Maass <eckhard.maass@gmx.net>
Subject: -B option of git log
Date: Fri, 22 Feb 2013 01:44:00 +0100
Message-ID: <5126BF50.6020500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 01:44:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8gka-0000F1-Qw
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 01:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab3BVAoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 19:44:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:51604 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab3BVAoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 19:44:04 -0500
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MfCFw-1UWNSd2je6-00OqIU for
 <git@vger.kernel.org>; Fri, 22 Feb 2013 01:44:01 +0100
Received: (qmail invoked by alias); 22 Feb 2013 00:44:01 -0000
Received: from 178-27-249-208-dynip.superkabel.de (EHLO [192.168.0.104]) [178.27.249.208]
  by mail.gmx.net (mp029) with SMTP; 22 Feb 2013 01:44:01 +0100
X-Authenticated: #1609611
X-Provags-ID: V01U2FsdGVkX191ZgxXJOh1ZnvpT1giV42P7piEYcFPEyyJJunZmf
	EUVpSpuPzI9XBt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216813>

Hello,

As far as I understand the documentation, -B of git-log should help
correct rename detection. But it does not seem to work for me.

Let me get a setup:

$> git init .
Initialized empty Git repository in /tmp/t2/.git/
$> echo 'Lorem ipsum doler sed. Lorem ipsum doler sed. Lorem ipsum doler
sed. Lorem ipsum doler sed.' > a
$> git add a
$> git commit -m 'Init.'
[master (root-commit) b78205c] Init.
 1 file changed, 1 insertion(+)
 create mode 100644 a
$> mv a b
$> echo 'new' > a
$> git add -A .
$> git commit -m '2nd.'
[master a30ca49] 2nd.
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 b

Now, I get the following:

$> git log --oneline -B20%/80% -M20% --name-status
a30ca49 2nd.
M       a
A       b
b78205c Init.
A       a

But I would expect that git-log shows me a rename from a to b and a new a.

What is my misunderstanding? (And I tried it also with files with a
couple of lines.)

SEcki
