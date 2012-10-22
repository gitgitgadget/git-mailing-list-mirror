From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: git daemon test fails
Date: Mon, 22 Oct 2012 16:48:29 +0200
Message-ID: <001f01cdb064$4d7a95f0$e86fc1d0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJJA-00037c-S1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab2JVOsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:48:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2JVOsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:48:37 -0400
Received: from DualCore (dsdf-4d0a104c.pool.mediaWays.net [77.10.16.76])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LqaYA-1SwBUM0bGU-00eIJE; Mon, 22 Oct 2012 16:48:36 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2wYkh+ThA3SjCATDeiuxRhSMNreA==
Content-language: de
X-Provags-ID: V02:K0:bkVQw6jWYtDiKX87jQTCKK4eziQ1qMxa6BX4bE2obM1
 1unwNs8Y8vG2vi3+TOVvd8YQwhPOVh3wQ+Iqr+7xiPLjKQ1QEu
 iCUms1Hk+YEKOynMSKMn014uJ3qyzsdc1TqCdR/tHhMRQ/DsR2
 w+pXaFpDygafVGn7HT/mSiiUIYIY2HlxDEPo3MBz6A99kA+vED
 gxpl0c7wamkWiqfMK5R/vczLZa2oZVQFe6DDsvAJSKy2te6Al+
 eZTXgit+uVDEHhVPHA+1O8jo1lxt0CXUcSfIRuOcioK1f07ELP
 jy2qgPRHdGmlrjFa+rww8cXtVep3IXD6phBVXBi3DZW+goBlxx
 2+faZrH3N/ggIJgxwGHttA/wZsXdxroia2Fff983AEBKnW0EwQ
 MoU03PC1CNa9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208193>

Here's one test failing (on HP NonStop, git-1.8.0), which needs to get enable first.

/home/jojo/git/git/t $ PATH=/usr/local/bin:$PATH GIT_TEST_GIT_DAEMON=true bash ./t5570-git-daemon.sh
ok 1 - setup repository
ok 2 - create git-accessible bare repository
ok 3 - clone git repository
[946798748] Connection from 127.0.0.1:1569
[946798748] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[946798748] Request upload-pack for '/repo.git'
[577699972] [946798748] Disconnected
ok 4 - fetch changes via git protocol
[275710128] Connection from 127.0.0.1:1570
[275710128] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[275710128] Request upload-pack for '/repo.git'
[577699972] [275710128] Disconnected
not ok 5 - remote detects correct HEAD # TODO known breakage
ok 6 - prepare pack objects
ok 7 - fetch notices corrupt pack
[611254461] Connection from 127.0.0.1:1571
[611254461] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[611254461] Request upload-pack for '/repo_bad2.git'
[611254461] error: non-monotonic index ./objects/pack/pack-a8625557c4445f4dac0b3b70b03f0a619d8edbff.idx
[611254461] error: unable to find 8a64388133550192054d8f512739602b36fdd015
[611254461] error: non-monotonic index ./objects/pack/pack-a8625557c4445f4dac0b3b70b03f0a619d8edbff.idx
[611254461] error: non-monotonic index ./objects/pack/pack-a8625557c4445f4dac0b3b70b03f0a619d8edbff.idx
[611254461] error: refs/heads/master does not point to a valid object!
[611254461] error: non-monotonic index ./objects/pack/pack-a8625557c4445f4dac0b3b70b03f0a619d8edbff.idx
[611254461] error: refs/heads/other does not point to a valid object!
[611254461] error: git upload-pack: git-pack-objects died with error.
[611254461] fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
[577699972] [611254461] Disconnected (with error)
ok 8 - fetch notices corrupt idx
[711917757] Connection from 127.0.0.1:9908
[711917757] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[711917757] Request upload-pack for '/nowhere.git'
[711917757] '/home/jojo/git/git/t/trash directory.t5570-git-daemon/repo/nowhere.git' does not appear to be a git repository
[577699972] [711917757] Disconnected (with error)
ok 9 - clone non-existent
[779026621] Connection from 127.0.0.1:9909
[779026621] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[779026621] Request receive-pack for '/repo.git'
[779026621] 'receive-pack': service not enabled for '/home/jojo/git/git/t/trash directory.t5570-git-daemon/repo/repo.git'
[577699972] [779026621] Disconnected (with error)
ok 10 - push disabled
[846135485] Connection from 127.0.0.1:9910
[846135485] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[846135485] Request upload-pack for '/repo.git'
[846135485] '/home/jojo/git/git/t/trash directory.t5570-git-daemon/repo/repo.git' does not appear to be a git repository
[577699972] [846135485] Disconnected (with error)
ok 11 - read access denied
[913244349] Connection from 127.0.0.1:9911
[913244349] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[913244349] Request upload-pack for '/repo.git'
[913244349] '/home/jojo/git/git/t/trash directory.t5570-git-daemon/repo/repo.git': repository not exported.
[577699972] [913244349] Disconnected (with error)
ok 12 - not exported
[1013907645] Connection from 127.0.0.1:9912
[1013907645] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[1013907645] Request upload-pack for '/nowhere.git'
[1013907645] '/home/jojo/git/git/t/trash directory.t5570-git-daemon/repo/nowhere.git' does not appear to be a git repository
[577699972] [1013907645] Disconnected (with error)
not ok - 13 clone non-existent
#       test_remote_error    'no such repository'      clone nowhere.git
ok 14 - push disabled
ok 15 - read access denied
ok 16 - not exported
# still have 1 known breakage(s)
# failed 1 among remaining 15 test(s)
1..16

So one test fails. 
But in real live here on HP NonStop "git clone" fails for any repository larger than a certain size (56k?) and it fails on the
daemon side (as e.g. a "git clone git://Gitgub/com/git/git.git" works just fine)

$ git clone git://localhost/some-repo.git
Cloning into 'some-repo'...
remote: warning: no threads support, ignoring --threads
remote: Counting objects: 485, done.
remote: Compressing objects: 100% (472/472), done.    <<<< here it sits forever or until a timeout hits (if one is configured)
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

If I allow upload-archive, I get some 47k downloaded, then it hangs (and doesn't get killed by a timeout, so that "git-daemon
--timeout" only affects upload-pack apparently?)
Also it is always only a tar file, regardless whether I request zip, tar or tar.gz.

Any ideas anyone?

Bye, Jojo
