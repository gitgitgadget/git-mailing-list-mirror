From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Fri, 01 Feb 2008 16:50:55 -0800
Message-ID: <47A3BE6F.6080304@saville.com>
References: <47A39DFD.9020905@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 01:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL6bY-0006ft-Nk
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 01:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbYBBAvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 19:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbYBBAvB
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 19:51:01 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:10501 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbYBBAvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 19:51:00 -0500
Received: by an-out-0708.google.com with SMTP id d31so324526and.103
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 16:50:59 -0800 (PST)
Received: by 10.100.239.11 with SMTP id m11mr8644787anh.87.1201913459152;
        Fri, 01 Feb 2008 16:50:59 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id m33sm4935906ele.17.2008.02.01.16.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Feb 2008 16:50:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <47A39DFD.9020905@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72198>

Wink Saville wrote:
> I was doing an git-svn dcommit and got a seg fault. The first
> phase of updating svn completed and then it seg faulted on the
> second. So I suspect I'm out of sync and need to recover,
> any guidance appreciated.
>
> If it's any help the svn repo is at 
> http://async-msgcomp.googlecode.com/svn.
> If someone needs it I happen to have a backup of the git repo before
> doing the commit and then after the seg fault.
>
> If there is any other information that someone needs I can try
> to supply it.
>
> Cheers,
>
> Wink Saville
<snip/>


<As an update, I first tried to re-execute the dcommit, but that didn't 
work: />

wink@ic2d1:$ git-svn dcommit
Committing to https://async-msgcomp.googlecode.com/svn/trunk ...
Merge conflict during commit: Your file or directory 
'android/hmc/src/com/saville' is probably out-of-date: The version 
resource does not correspond to the resource within the transaction.  
Either the requested version resource is out of date (needs to be 
updated), or the requested version resource is newer than the 
transaction root (restart the commit). at /usr/bin/git-svn line 420

<I than did a rebase that got me back in sync: />

wink@ic2d1:$ git-svn rebase
Index mismatch: 94bbfa6d433192de71060d1274f0b0eab8f49a30 != 
2fcd3a5cc5a9ca062a41d0ff5ac30073f4fa23b0
rereading 8ce31b64294bdb063c64c50b9358533ac8746af4
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
r52 = 2336c1c70e92d572f5a1b248249b4f857142bc51 (git-svn)
First, rewinding head to replay your work on top of it...
HEAD is now at 2336c1c... Refactor to reduce duplicated code and have 
pure Java Hmc/ActiveHmc.
Nothing to do.
