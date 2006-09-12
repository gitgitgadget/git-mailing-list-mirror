From: Andreas Ericsson <ae@op5.se>
Subject: qgit segfaults after b237b00
Date: Tue, 12 Sep 2006 12:01:27 +0200
Message-ID: <45068577.2020608@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 12 12:02:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN55z-0003nF-3A
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 12:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWILKBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 06:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWILKBb
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 06:01:31 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:53941 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965187AbWILKBa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 06:01:30 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 6650A6BD55; Tue, 12 Sep 2006 12:01:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 56C896BCDE
	for <git@vger.kernel.org>; Tue, 12 Sep 2006 12:01:28 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26887>

What subject says, really. Tried cold cache, hot cache, with and without 
qgit.dat, 3 different repos and 14 different repo-tips. Same result 
every time. A segfault before anything is drawn.

Backtrace isn't very helpful (to me anyways):
#0  0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0x458525d2 in QGVector::insert () from /usr/lib/qt-3.3/lib/libqt-mt.so.3
#2  0x080aa19a in MainImpl::setupPixmaps (this=0x8191520, h=18)
     at /usr/lib/qt-3.3/include/qptrvector.h:67
#3  0x080b1ad1 in MainImpl::adjustFontSize (this=0x8191520, delta=0)
     at mainimpl.cpp:981
#4  0x080bae05 in MainImpl (this=0x8191520, cd=@0xbf92b094, p=0x0, name=0x0)
     at mainimpl.cpp:142
#5  0x080c4cdf in main (argc=0, argv=0x0) at qgit.cpp:14
(gdb) quit

c++ is a scary thing to me, and my familiarity with QT is akin to the 
common cavemans grasp of piloting fighter-jets. I thus refrain from 
guessing where the problem might be.

qgit-1.5.1 works wonderfully, so I've reset to that and am using it 
meanwhile.

btw, kudos for a great tool.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
