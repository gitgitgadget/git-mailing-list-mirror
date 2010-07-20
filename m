From: Philip Kimmey <philip.kimmey@gmail.com>
Subject: Git & Paramiko: failed to push some refs to ...
Date: Mon, 19 Jul 2010 19:20:51 -0500
Message-ID: <AANLkTil0soA4pLGRZT-jgdOkB3s8qApG_h2a-UW2P_G5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 02:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob0a1-0008NO-61
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 02:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab0GTAU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 20:20:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63498 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab0GTAU6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 20:20:58 -0400
Received: by iwn7 with SMTP id 7so5146915iwn.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=/bAq/zbhuvBSM/LznLcAoJYdJlchbALElpFSfree3XM=;
        b=EOvEBsiEsQCiBfMa+Lgru3uySq6dBe3RzmsBgTLAi9DSfzo1AIW3NZp/y2nEwbHF7U
         1MUplHipKFYgD/e9hbubwRnheeBZYMcKmiJIWp19Pwb4wOOtK3uivs6Ek2n+H7RAo+n8
         fG5PaZf8N60UYQUJK2egJhLTpugNOJpW7y+WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=u38SKQ5A2Y3AnSJfkGWnTgci019Y6tDF+pySg2PG+EdCZEeOUbh2kVDfG38pwpzle+
         V1xcJzZUlI/X+TRMjImtnS6XcPLrgZij9poqaUa5UGaSm8W/nX5gU5aKyvyzcx+VQru4
         uht95xwo4mNMRFyvCmeIrqDk1OnSlRZFp4ifM=
Received: by 10.231.34.11 with SMTP id j11mr6457258ibd.120.1279585251417; Mon, 
	19 Jul 2010 17:20:51 -0700 (PDT)
Received: by 10.231.16.129 with HTTP; Mon, 19 Jul 2010 17:20:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151293>

If you prefer you can see the outline of my question at stackoverflow,
with better formatting than e-mail will afford:

http://stackoverflow.com/questions/3262161/git-failed-to-push-some-refs=
-to-with-custom-git-bridge

I am writing a Python ssh server using Paramiko. While it is very
powerful software, when using it to push git repositories, I run into
strange errors. The following is git's output on the client machine.

$ git push origin master
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 263 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
To git@localhost:/pckprojects/heyworld/
=A0=A0 d83f744..404debd =A0master -> master
error: failed to push some refs to 'git@localhost:/pckprojects/heyworld=
/'

=46rom the server side I have enough print statements to see the entire
transaction, which looks something like this:

git-receive-pack /home/www/data/project/heyworld/

OUT >>
00721ee2436e45c80236878132dc87d9e9fee6a81de5 refs/heads/master\x00
report-status delete-refs side-band-64k ofs-delta\n0000

IN >>
00841ee2436e45c80236878132dc87d9e9fee6a81de5
6054b3358787bafd1d96c0fdfbf016d620ccdf09 refs/heads/master\x00
report-status side-band-64k0000

IN >>
PACK\x00\x00\x00\x02\x00\x00\x00\x03\x96\x0ex\x9c\xa5\x8cM\x0e\xc2
\x14\x06\xf7\x9c\x82\x0b\xd8<(?\x8f\xc4\x18\xf7n\xbc\x02\xc2\x87%\x16\x=
db4\xb8\xf0\xf66\xbd\x82\xcb\x99d\xa6o\x80\x846\xd9!)\x1b\x0b\xb1\r1$dO=
\x05\xa6\xb0\xa3@\x06%D<\xb2\x16k\xdc\xf0\xeeRa/F\x07c\x13\x93\x1e\x1d{=
V\xa3\xce\x89}\x0e\x08\x05p\x91U\x86\x15\xf1\xd3\xa7e\x93\xf7\xa9\xceu\=
x95\xb7\xda\x1a\xbe\xf2\xbc\x1e8\xbc\x0e\xbc>[\xac\xf3\x90\x96v\x91J\xf=
b`X\xb3V\xf2D\x96H\xec\xb6\xd5\xde\xf1\xc7B4,\xe2\x07\xff\x8aF\xba\xaf\=
x01x\x9c340031Q\xc8H\xaddP\xd8P\xfcmzGg\x8aY\xc4\x8e\xad\xb1<\xca\x1b\x=
a3\x93\xee\xbd\x05\x00\xa8\xb4\x0c\x9by\xd3\xfe\xa0C\x86fU\x18\xbe\xa5\=
x86\xac5*\xf7\x11\x89\x8b9$x\x9c\x0b\x8b\x9a\x10\xc6\x92\x9b\x9a\xcf\x0=
5\x00\x0f\xb2\x02\xe6=3D\x12?\xde\x1f\x9a=3Dv\x0c3c\xf66\xc6\xcc1y\xe4\=
xb8\xa0

OUT >>
0030\x01000eunpack ok\n009krf/ed/atr0000

CLOSE CONNECTION

This looks healthy to me, but I'm of course not that familiar with the
details. In addition, as far as I can tell, master does in fact get
updated and everything properly, so I have no idea where that error
message is coming from. If I use openssh-server instead of my Paramiko
server, the same actions on the client work fine.

Thanks for the help!

Sincerely,
Philip Kimmey
