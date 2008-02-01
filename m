From: Wink Saville <wink@saville.com>
Subject: git-svn segmetation fault
Date: Fri, 01 Feb 2008 14:32:29 -0800
Message-ID: <47A39DFD.9020905@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 23:33:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL4Rs-0007vd-Ai
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 23:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbYBAWcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 17:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbYBAWcf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 17:32:35 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:57214 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbYBAWce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 17:32:34 -0500
Received: by an-out-0708.google.com with SMTP id d31so315900and.103
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 14:32:32 -0800 (PST)
Received: by 10.100.242.20 with SMTP id p20mr8489479anh.1.1201905152600;
        Fri, 01 Feb 2008 14:32:32 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id m33sm4711518ele.17.2008.02.01.14.32.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Feb 2008 14:32:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72185>

I was doing an git-svn dcommit and got a seg fault. The first
phase of updating svn completed and then it seg faulted on the
second. So I suspect I'm out of sync and need to recover,
any guidance appreciated.

If it's any help the svn repo is at http://async-msgcomp.googlecode.com/svn.
If someone needs it I happen to have a backup of the git repo before
doing the commit and then after the seg fault.

If there is any other information that someone needs I can try
to supply it.

Cheers,

Wink Saville

<info>

<Apparently there is no core dump file as ulimit -c is 0: />
wink@ic2d1:$ ulimit -c
0

<here is the linux version: />
wink@ic2d1:$ uname -a
Linux ic2d1 2.6.22-14-generic #1 SMP Tue Dec 18 05:28:27 UTC 2007 x86_64 
GNU/Linux

<here is the git version: />
wink@ic2d1:$ git --version
git version 1.5.3.8

<Here is the data from /var/log/kern.log: />
Feb  1 13:51:31 ic2d1 kernel: [17438.627780] git-svn[21111]: segfault at 
0000000000000010 rip 00002acfb82ac1ff rsp 00007ffff937d0d0 error 6

<Here is the command and data output: />
wink@ic2d1:$ git-svn dcommit
Committing to https://async-msgcomp.googlecode.com/svn/trunk ...
        C       android/mc/src/com/saville/android/mc/ActiveMc.java => 
android/hmc/src/com/saville/hmc/ActiveHmc.java
        C       java/msgcomp/src/com/saville/msgcomp/IMc.java => 
android/hmc/src/com/saville/hmc/Hmc.java
        C       android/mc/src/com/saville/android/mc/ActiveMc.java => 
android/mc/src/com/saville/mc/ActiveMc.java
        C       java/msgcomp/src/com/saville/msgcomp/IMc.java => 
android/mc/src/com/saville/mc/MsgPump.java
        C       java/msgcomp/src/com/saville/msgcomp/IMc.java => 
java/hmc/src/com/saville/hmc/Hmc.java
        C       android/hmc/src/com/saville/android/testhmc/TestHmc.java 
=> java/hmc/src/com/saville/testhmc/Test.java
        C       java/msgcomp/src/com/saville/msgcomp/IMc.java => 
java/msgcomp/src/com/saville/msgcomp/IHmc.java
        C       java/mc/src/com/saville/mc/Mc.java => java/src/McBase.java
        C       java/mc/src/com/saville/mc/McMgr.java => java/src/McMgr.java
        R       java/TestClient1/AGPLv3.LICENSE => AGPLv3.LICENSE
        R       android/TestNet1/COPYING => COPYING
        R       android/TestNet1/COPYING.LESSER => COPYING.LESSER
        R       android/mc/src/com/saville/android/mc/McActivity.java => 
android/mc/src/com/saville/mc/McActivity.java
        R       android/mc/src/com/saville/android/mc/McService.java => 
android/mc/src/com/saville/mc/McService.java
        R       android/mc/src/com/saville/android/mc/ActiveMc.java => 
java/hmc/src/com/saville/hmc/ActiveHmc.java
        R       
android/hmc/src/com/saville/android/testhmc/TestDeferredMsgs.java => 
java/hmc/src/com/saville/testhmc/TestDeferredMsgs.java
        R       
android/hmc/src/com/saville/android/testhmc/TestHmcClient.java => 
java/hmc/src/com/saville/testhmc/TestHmcClient.java
        R       
android/hmc/src/com/saville/android/testhmc/TestHmcServer.java => 
java/hmc/src/com/saville/testhmc/TestHmcServer.java
        R       
android/hmc/src/com/saville/android/testhmc/TestUnhandledMsgs.java => 
java/hmc/src/com/saville/testhmc/TestUnhandledMsgs.java
        R       java/mc/src/com/saville/mc/Looper.java => 
java/mc/src/com/saville/mc/MsgPump.java
        R       android/hmc/src/com/saville/android/hmc/IState.java => 
java/msgcomp/src/com/saville/msgcomp/IState.java
        R       android/hmc/src/com/saville/android/hmc/State.java => 
java/msgcomp/src/com/saville/msgcomp/State.java
        R       android/hmc/src/com/saville/android/hmc/Hmc.java => 
java/src/HmcBase.java
        D       android/debug/COPYING
        D       android/debug/COPYING.LESSER
        D       android/hmc/COPYING
        D       android/hmc/COPYING.LESSER
        D       android/mc/COPYING
        D       android/mc/COPYING.LESSER
        D       android/mc/src/com/saville/android/mc/Mc.java
        D       android/mc/src/com/saville/android/mc/McMgr.java
        D       android/mctest/COPYING
        D       android/mctest/COPYING.LESSER
        D       android/serdes/COPYING
        D       android/serdes/COPYING.LESSER
        D       java/TestMsgPipe1/AGPLv3.LICENSE
        D       java/TestMsgPipe2/AGPLv3.LICENSE
        D       java/TestServer1/AGPLv3.LICENSE
        D       java/debug/COPYING
        D       java/debug/COPYING.LESSER
        D       java/mcmaster/AGPLv3.LICENSE
        D       java/msgcomp/COPYING
        D       java/msgcomp/COPYING.LESSER
        D       java/serdes/COPYING
        D       java/serdes/COPYING.LESSER
        M       android/TestNet1/.classpath
        M       
android/TestNet1/src/com/saville/android/testnet1/TestNet1.java
        M       android/hmc/.classpath
        M       android/hmc/src/com/saville/android/testhmc/TestHmc.java
        A       android/hmc/src/com/saville/hmc/HmcBase.java
        A       android/hmc/src/com/saville/testhmc
        M       android/mc/AndroidManifest.xml
        M       android/mc/src/com/saville/android/testmc/TestMc.java
        M       android/mc/src/com/saville/android/testmc/TestMcService.java
        A       android/mc/src/com/saville/mc/Mc.java
        A       android/mc/src/com/saville/mc/McBase.java
        A       android/mc/src/com/saville/mc/McMgr.java
        M       android/mctest/.classpath
        M       android/mctest/src/com/saville/android/mctest/McTest.java
        M       
android/mctest/src/com/saville/android/mctest/McTestClient.java
        A       java/hmc/.classpath
        A       java/hmc/.project
        A       java/hmc/src/TestHmc.java
        A       java/hmc/src/com/saville/hmc/HmcBase.java
        A       java/hmcbase/.classpath
        A       java/hmcbase/.project
        M       java/mc/src/TestMc.java
        M       java/mc/src/com/saville/mc/ActiveMc.java
        M       java/mc/src/com/saville/mc/Mc.java
        A       java/mc/src/com/saville/mc/McBase.java
        T       java/mc/src/com/saville/mc/McMgr.java
        M       java/mc/src/com/saville/mc/TcpMsgPipe.java
        A       java/msgcomp/src/com/saville/msgcomp/IActiveMc.java
        M       java/msgcomp/src/com/saville/msgcomp/IMc.java
        A       java/msgcomp/src/com/saville/msgcomp/IMcMgr.java
        M       java/msgcomp/src/com/saville/msgcomp/McId.java
Committed r52
        D       android/mc/COPYING.LESSER
        D       android/mc/COPYING
        M       android/mc/AndroidManifest.xml
        A       android/mc/src/com/saville/mc/Mc.java
        A       android/mc/src/com/saville/mc/McService.java
        A       android/mc/src/com/saville/mc/McMgr.java
        A       android/mc/src/com/saville/mc/MsgPump.java
        A       android/mc/src/com/saville/mc/McBase.java
        A       android/mc/src/com/saville/mc/ActiveMc.java
        A       android/mc/src/com/saville/mc/McActivity.java
        D       android/mc/src/com/saville/android/mc/Mc.java
        D       android/mc/src/com/saville/android/mc/McService.java
        D       android/mc/src/com/saville/android/mc/McMgr.java
        D       android/mc/src/com/saville/android/mc/ActiveMc.java
        D       android/mc/src/com/saville/android/mc/McActivity.java
        M       android/mc/src/com/saville/android/testmc/TestMc.java
        M       android/mc/src/com/saville/android/testmc/TestMcService.java
        D       android/mctest/COPYING.LESSER
        D       android/mctest/COPYING
        M       android/mctest/.classpath
        M       android/mctest/src/com/saville/android/mctest/McTest.java
        M       
android/mctest/src/com/saville/android/mctest/McTestClient.java
        D       android/serdes/COPYING.LESSER
        D       android/serdes/COPYING
        D       android/debug/COPYING.LESSER
        D       android/debug/COPYING
        D       android/hmc/COPYING.LESSER
        D       android/hmc/COPYING
        M       android/hmc/.classpath
        D       android/hmc/src/com/saville/android/hmc/State.java
        D       android/hmc/src/com/saville/android/hmc/Hmc.java
        D       android/hmc/src/com/saville/android/hmc/IState.java
        D       
android/hmc/src/com/saville/android/testhmc/TestHmcClient.java
        D       
android/hmc/src/com/saville/android/testhmc/TestDeferredMsgs.java
        D       
android/hmc/src/com/saville/android/testhmc/TestUnhandledMsgs.java
        D       
android/hmc/src/com/saville/android/testhmc/TestHmcServer.java
        M       android/hmc/src/com/saville/android/testhmc/TestHmc.java
        A       android/hmc/src/com/saville/hmc/HmcBase.java
        A       android/hmc/src/com/saville/hmc/ActiveHmc.java
        A       android/hmc/src/com/saville/hmc/Hmc.java
        A       android/hmc/src/com/saville/testhmc
        D       android/TestNet1/COPYING.LESSER
        D       android/TestNet1/COPYING
        M       android/TestNet1/.classpath
        M       
android/TestNet1/src/com/saville/android/testnet1/TestNet1.java
        M       java/mc/src/TestMc.java
        D       java/mc/src/com/saville/mc/Looper.java
        M       java/mc/src/com/saville/mc/Mc.java
        M       java/mc/src/com/saville/mc/McMgr.java
        A       java/mc/src/com/saville/mc/MsgPump.java
        A       java/mc/src/com/saville/mc/McBase.java
        M       java/mc/src/com/saville/mc/ActiveMc.java
        M       java/mc/src/com/saville/mc/TcpMsgPipe.java
        D       java/TestClient1/AGPLv3.LICENSE
        A       java/hmcbase/.classpath
        A       java/hmcbase/.project
        D       java/serdes/COPYING.LESSER
        D       java/serdes/COPYING
        D       java/msgcomp/COPYING.LESSER
        D       java/msgcomp/COPYING
        A       java/msgcomp/src/com/saville/msgcomp/IHmc.java
        A       java/msgcomp/src/com/saville/msgcomp/State.java
        A       java/msgcomp/src/com/saville/msgcomp/IActiveMc.java
        M       java/msgcomp/src/com/saville/msgcomp/IMc.java
        A       java/msgcomp/src/com/saville/msgcomp/IState.java
        M       java/msgcomp/src/com/saville/msgcomp/McId.java
        A       java/msgcomp/src/com/saville/msgcomp/IMcMgr.java
        D       java/TestMsgPipe1/AGPLv3.LICENSE
        D       java/debug/COPYING.LESSER
        D       java/debug/COPYING
        D       java/TestMsgPipe2/AGPLv3.LICENSE
        D       java/TestServer1/AGPLv3.LICENSE
        A       java/hmc/.classpath
        A       java/hmc/.project
        A       java/hmc/src/TestHmc.java
        A       java/hmc/src/com/saville/hmc/HmcBase.java
        A       java/hmc/src/com/saville/hmc/ActiveHmc.java
        A       java/hmc/src/com/saville/hmc/Hmc.java
        A       java/hmc/src/com/saville/testhmc/Test.java
        A       java/hmc/src/com/saville/testhmc/TestHmcClient.java
        A       java/hmc/src/com/saville/testhmc/TestDeferredMsgs.java
        A       java/hmc/src/com/saville/testhmc/TestUnhandledMsgs.java
        A       java/hmc/src/com/saville/testhmc/TestHmcServer.java
        A       java/src/HmcBase.java
        A       java/src/McMgr.java
        A       java/src/McBase.java
        D       java/mcmaster/AGPLv3.LICENSE
        A       COPYING.LESSER
        A       COPYING
        A       AGPLv3.LICENSE
Segmentation fault (core dumped)
