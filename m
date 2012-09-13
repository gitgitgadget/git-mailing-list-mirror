From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: is this behaviour expected for "git clone --single-branch"?
Date: Thu, 13 Sep 2012 20:38:28 +0200
Message-ID: <CAN0XMOJsVOCzp2_BOQVUKy3cV8JA9AG+=Bw4tC2ZzDfK0AcQVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEJD-00071f-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab2IMSia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:38:30 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35819 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab2IMSi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:38:29 -0400
Received: by wibhi8 with SMTP id hi8so7268093wib.1
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=hvuEE9r17iDbHxhIX7myz5FkNfjXQqZt8desQoOFS/8=;
        b=Nv6KcFL7ESzQrItqTzDFd0GYZ5pDA5FrK7hQUJXkk7avXkiGzToN0L2GKgpXW5P5yg
         CkEEPwznfcrR5HvL4XQTTK+4TyHbKoOvJ4sMb+KDJp8eofDeNe0KLSzCY/xsOSMb6jE+
         hxLI2Ek2hLa5lfUWDiHozDNuxRzOkcUFczpk3RqZ3UnBYWe9ln1gjbOc0CgjPtfxx04a
         CyG6jBLLUevl6FL0SRmSasa1QTmd54WV9r8X4yvhy8hGeqO8sceTf21XkvOziJR3/zx/
         ve+rQmo7OhUAx+BPAyMY+/mezwItt5kJjb9QujcWAeMb74fdKdfK0kBmgqC6ooRzeeQZ
         pbfQ==
Received: by 10.216.42.65 with SMTP id i43mr35795web.208.1347561508313; Thu,
 13 Sep 2012 11:38:28 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Thu, 13 Sep 2012 11:38:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205408>

Hi,

I know people which have a separate directory for every
branch. In this case it doesn't make sense to download
the whole repo with all branches. So I guess the
"--single-branch" option is the solution in that case!?!
But I'm wondering about it's behaviour.

# first clone the branch of the repo
$git clone --single-branch --branch master myrepo ./master
$cd master

# now calling "git branch -a" to see what I have
$git branch -a
*master
remotes/origin/HEAD -> origin/master
remotes/origin/master

# fine, now pulling from origin
$git pull
From myrepo
* [new branch]  foo  -> origin/foo
* [new branch] bar -> origin/bar
...

Hm?

# looking again to my branches
$git branch -a
*master
remotes/origin/HEAD -> origin/master
remotes/origin/master
remotes/origin/bar
remotes/origin/foo
...

After cloning (or fetching), I now have all branches which is not
what I want, because I'm only interested in the one I've cloned.
I think it's not very useful for the use-case of having one directory
for one branch.

$git version
git version 1.7.12.395.g6b149ce

Thanks
