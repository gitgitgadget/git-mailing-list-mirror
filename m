From: Yuri <yuri@rawbw.com>
Subject: Can't get 'git archive' to work
Date: Sun, 6 Dec 2015 21:31:06 -0800
Message-ID: <5665199A.7070304@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 06:44:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5oaw-0003AT-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 06:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbbLGFoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 00:44:15 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:57573 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbbLGFoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 00:44:14 -0500
X-Greylist: delayed 787 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2015 00:44:14 EST
Received: from yuri.doctorlan.com (c-50-184-63-128.hsd1.ca.comcast.net [50.184.63.128])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id tB75V6qx063189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 6 Dec 2015 21:31:06 -0800 (PST)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-50-184-63-128.hsd1.ca.comcast.net [50.184.63.128] claimed to be yuri.doctorlan.com
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282082>

Getting the errors, see below.

Why "operation is not supported" through http and https? 'archive' is 
supposed to be the most efficient operation to get the specific snapshot 
of the repository, and it should be available without authentication.

In case of ssh with the key there is the strange error message about 
"core.gitProxy". What is this about? I am not using a proxy.

I couldn't get git archive to work even once.

# through ssh with an active ssh key
$ git archive --format=tar --remote=git@github.com:yurivict/vm-to-tor.git
Invalid command: 'git-upload-archive 'yurivict/vm-to-tor.git''
   You appear to be using ssh to clone a git:// URL.
   Make sure your core.gitProxy config option and the
   GIT_PROXY_COMMAND environment variable are NOT set.
fatal: The remote end hung up unexpectedly

# through ssh without an ssh key
$  git archive --format=tar --remote=git@github.com:yurivict/vm-to-tor.git
Permission denied (publickey).
fatal: The remote end hung up unexpectedly

# through https
$  git archive --format=tar 
--remote=https://github.com/yurivict/vm-to-tor.git
fatal: Operation not supported by protocol.

# through http
$  git archive --format=tar 
--remote=http://github.com/yurivict/vm-to-tor.git
fatal: Operation not supported by protocol.


git-2.6.2 on FreeBSD 10.2

Yuri
