X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Creating new repos
Date: Fri, 27 Oct 2006 09:29:10 -0300
Message-ID: <200610271229.k9RCTARu016773@laptop13.inf.utfsm.cl>
NNTP-Posting-Date: Fri, 27 Oct 2006 12:30:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30325>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdQq2-0001nH-L8 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 14:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946256AbWJ0M3N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWJ0M3N
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 08:29:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39048 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1752154AbWJ0M3M (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 08:29:12 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9RCTAc4010322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 09:29:10 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9RCTARu016773 for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 09:29:10 -0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I'm trying to set up git repos for remote access here. I set up git-daemon
and got it working (some older repositories do work fine), but now:

  $ mkdir /var/scm/user/SomeRepo.git
  $ cd /var/scm/user/SomeRepo.git
  $ git --bare init-db
  $ touch git-daemon-export-ok

All OK, but then, from a remote machine:

  $ git clone git://git-server/user/SomeRepo.git
  fatal: no matching remote head
  fetch-pack from 'git://git-server/user/Test.git' failed.

The empty repo created by init-db should be cloneable, so as to get the ball
rolling easily.

You can't push into such an empty repository either.

Any suggestion of how to set up a server into which users can create their
own repos /without/ giving out full shell accounts?

Also, the behaviour of git-daemon is different when using git or ssh+git,
you need to give the full path for the later but not the former (given
--base-path=/var/scm):

  git://git-server/user/Test.git
  ssh+git://git-server/var/scm/user/Test.git

Is this intentional?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
