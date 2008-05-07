From: max roth <maxrothca@gmail.com>
Subject: Windows version of git unable to pull from OSX version of git
Date: Wed, 7 May 2008 09:49:34 -0700
Message-ID: <B80595C2-5905-4061-A2F6-4D83B6706668@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 18:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmqZ-0001S8-VK
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbYEGQtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYEGQti
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:49:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:2564 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYEGQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:49:36 -0400
Received: by rv-out-0506.google.com with SMTP id l9so454056rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=j/mf9Llu8W90oQt5cnoUV8I9pBD5bcK4IMKdwLfuhBo=;
        b=LMwDIlBcNbbuDm5R2HshEo1Hf3hHY4H2uH77w2Yi2pT/350f0QGmQPNK+uHpQ/I2p5WJ74Q25z2s8MqmeY9qW7EqYJUDCpSOC2xuUKuJEsfgtQMjEknfmY7AJBd2E+x529Dc2JMsAD/94QrWgRfXcotue6DvUwwqQuzBKvylQcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=V3cQJoG+Pht22fzL6/9BvDHIXLfRb1NO1AeGLG/c4xLua6bhR3sZnK1YsOPbRYpMImYcCq68IAQe7tFY41Qks7V3LVX8Ufj35sRXCFj3yMZ7CtJLh4s5HD6eYdL2ZmkYjtTjtkOpm/szhZ6/Yk4HXPZlQbNAHZL/W7vGtXZo5is=
Received: by 10.140.201.1 with SMTP id y1mr1045980rvf.246.1210178975857;
        Wed, 07 May 2008 09:49:35 -0700 (PDT)
Received: from ?10.0.1.200? ( [72.211.218.145])
        by mx.google.com with ESMTPS id f21sm3109451rvb.0.2008.05.07.09.49.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 May 2008 09:49:35 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81464>

I have two repositories on my OSX partition that work perfect.  When I
dual boot into windows, I want to clone the project.  I've installed
cygwin/git and have the osx drive mounted on Z: . I can't seem to do a
git submodule update in windows under cygwin without getting errors
(the same commands work fine when I am booted into OSX).  I've tried
both the cygwin and msysgit, and they both exhibit the same problem.

$ git submodule update
Initialized empty Git repository in /cygdrive/d/Visual Studio Projects/
project/base/.git/
Submodule path 'base': checked out
'745659513bf3bbd1e57ac26a99101a200a42a97a'
Initialized empty Git repository in /cygdrive/d/Visual Studio Projects/
project/common/.git/
fatal: git-upload-pack: cannot find object
016f0e3580a263d441a246e74e27d6c73960e
524:
fatal: The remote end hung up unexpectedly
Clone of '/cygdrive/z/Users/max/git_repositories/common/.git' into
submodule path 'common' failed

max@m-ff21e0b3bd974 /cygdrive/z/Users/max/git_repositories/test7
$ git submodule update
Initialized empty Git repository in /cygdrive/z/Users/max/
git_repositories/test7/base/.git/
error: index file ./objects/pack/
pack-65a6edbb59ff536215053396a58386692ac7e067.idx is too small
error: index file ./objects/pack/
pack-65a6edbb59ff536215053396a58386692ac7e067.idx is too small
fatal: git-upload-pack: cannot find object
25ee9b0c85086b830e4d4c9eda6bd7bd5dd85
ee2:
fatal: The remote end hung up unexpectedly
Clone of '/cygdrive/z/Users/max/git_repositories/project/.git' into
submodule path 'base' failed


Any ideas? I've tried git gc to fix any problems but it returns fine.  
git fsck
warns of dangling binary blobs but that's it. I've also
tried to copy the git repositories over to the windows partition but the
error is identical. Any help is appreciated. I don't want to go back  
to SVN :-(
