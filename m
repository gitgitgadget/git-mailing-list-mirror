From: Jan Engelhardt <jengelh@medozas.de>
Subject: bugreport: git does not like subseconds
Date: Thu, 13 Nov 2008 17:26:29 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811131722360.13330@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 17:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0f2q-0007XY-Le
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYKMQ0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYKMQ0c
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:26:32 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:51431 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYKMQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 11:26:31 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 0A0DB18044A2F; Thu, 13 Nov 2008 17:26:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 033431C11C9E1
	for <git@vger.kernel.org>; Thu, 13 Nov 2008 17:26:30 +0100 (CET)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100882>



Git does not like subseconds in $GIT_{AUTHOR,COMMITTER}_DATE,
and somehow does time travel instead. Perhaps this is a Glibc
limitation? Running openSUSE 11's glibc-2.8(which is actually
a 2.7 snapshot I think: glibc-2.8-2008042513.tar.bz2).


$ git init
Initialized empty Git repository in /dev/shm/f/.git/
$ echo tomato >banana.c
$ git add banana.c
$ GIT_AUTHOR_DATE="2008-11-11 19:36:33.983771268 +0100" git ci -m 'foo'
Created initial commit e65a6b0: foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 banana.c
$ git log
commit e65a6b06c2ff3ef458cb16e7ee6f17ef39757538
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Mar 5 06:47:48 2001 +0100

    foo
