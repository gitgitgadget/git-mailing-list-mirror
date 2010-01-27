From: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Heulin?= <frederic.heulin@free.fr>
Subject: [problem] out of memory
Date: Wed, 27 Jan 2010 18:16:36 +0100 (CET)
Message-ID: <821836537.2475221264612596403.JavaMail.root@spooler9-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 18:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaBVZ-00076j-V7
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 18:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab0A0RQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 12:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113Ab0A0RQo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 12:16:44 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:43544 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab0A0RQo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 12:16:44 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 6BEC24C8125
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 18:16:38 +0100 (CET)
Received: from spooler9-g27.priv.proxad.net (spooler9-g27.priv.proxad.net [172.20.243.232])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8B5EE4C8201
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 18:16:36 +0100 (CET)
X-Originating-IP: [83.145.84.28]
X-Mailer: Zimbra 5.0 (ZimbraWebClient - FF3.0 (Linux)/5.0.15_GA_2815.UBUNTU8_64)
X-Authenticated-User: frederic.heulin@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138172>

Hi All,

I have a cvs repository I try to convert to git.
I have used cvs2git (1 week old) to get the dumps from cvs.
To be able to do the fast-import import into the new git.
I had to use a bigger machine than mine (the big is 64bits, 8GB ram, mi=
ne is 32bits,4GB ram)
because on my machine git ran out of memory.
Once converted, I tried to do a clone, it ran out of memory on my machi=
ne.

 - version used for gitc
   - on my machine : 1.6.6.1
   - on the big machine : 1.5.6.5 (debian lenny)

 - Here's the list of the commands that failed out of memory (stop at 2=
=2E7GB memory consumed):
git for-each-ref
git rev-list --branches --tags

 - this command succeeded :
git rev-list --branches (80MB consumed)

 - some packing have been done :
git repack -a -d -f=20
git pack-ref --all
(on the big machine, it fails on mine)

after the git commands keep failing out of memory, 'git rev-list --bran=
ches' included.

 - there is 2159 refs in the repository.

 - git count-objects -v gives :

count: 0
size: 0
in-pack: 133986
packs: 1
size-pack: 365678
prune-packable: 0
garbage: 0

 - I still have a copy of the cvs and git repositories for testing.

Thanks in advance for any help,
=46r=C3=A9d=C3=A9ric Heulin.
