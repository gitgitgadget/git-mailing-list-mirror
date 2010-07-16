From: =?ISO-8859-1?Q?Jean-Philippe_Gari=E9py?= 
	<jean-philippe.gariepy@nuecho.com>
Subject: git clean -X behaviour when .gitignore has sub-directory entries
Date: Fri, 16 Jul 2010 15:05:45 -0400
Organization: Nu Echo
Message-ID: <4C40AD89.1070005@nuecho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 21:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqLo-00050w-2z
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024Ab0GPTNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 15:13:23 -0400
Received: from m.nuecho.com ([64.119.213.149]:40717 "EHLO m.nuecho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759020Ab0GPTNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:13:21 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2010 15:13:21 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by m.nuecho.com (Postfix) with ESMTP id 82146BF0123
	for <git@vger.kernel.org>; Fri, 16 Jul 2010 15:05:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at z.nuecho.com
Received: from m.nuecho.com ([127.0.0.1])
	by localhost (zimbra.nuecho.ad [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucmizqpuwsAY for <git@vger.kernel.org>;
	Fri, 16 Jul 2010 15:05:52 -0400 (EDT)
Received: from burton.nuecho.ad (modemcable108.22-130-66.mc.videotron.ca [66.130.22.108])
	by m.nuecho.com (Postfix) with ESMTPSA id 280BDBF010F
	for <git@vger.kernel.org>; Fri, 16 Jul 2010 15:05:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151162>

Hi,

When using sub-directory entries in .gitignore, "git clean -X" doesn't=20
clean the ignored sub-directory.

$ git init test
Initialized empty Git repository in /home/jpgariep/git/test/.git/
$ cd test/
$ mkdir -p a/b/c
$ touch a/b/c/test
$ echo '/a/b/' > .gitignore
$ git add .gitignore
$ git commit -m "Added .gitignore."
[master (root-commit) 94e2825] Added .gitignore.
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 .gitignore
$ git status
# On branch master
nothing to commit (working directory clean)
$ git clean -X -d -f
$ ls a
b

Why is b still there?


Thanks.

--=20
Jean-Philippe Gari=E9py
