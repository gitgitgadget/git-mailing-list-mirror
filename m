From: Qingning Huo <qingninghuo@gmail.com>
Subject: out of memory error with git push and pull
Date: Wed, 1 Jun 2011 23:33:33 +0100
Message-ID: <BANLkTin3-XnVsVd1-CAiWDBzQG6m=a4Rvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 00:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRtyu-0005Lq-DK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804Ab1FAWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:33:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62487 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758458Ab1FAWde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:33:34 -0400
Received: by vws1 with SMTP id 1so235364vws.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=W4+CHlnMTLNzeOMCVY6kjYO/XkpaZrFY9IdNi9WMuXQ=;
        b=efwugxntEZL92NsgDzqgJwYEn8z6QSw0KVDNSFL+LKwYXVWhoSLPlq+ELaZUEOt7qv
         TaxVo3rJ5w5psnSY+YkxjpfiT+f4jKCsh6Jo7IPjF95adFaTsUysKtuoh/Sw+0uY7SlB
         4Hk6rz+MbL/6SHSY9b/l9ZK2b1L//04FecVFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=x2T3QSlCwbYuBW1RrP78PFmkP2decV9vR8wRmqJcyWU6L5st5GQj4Tg9nE3euFyy7u
         2/Zj01bPMsw0vjF9tDR8yBeffXRvXuYUl1SP3OoLeYvmz+HzZo3Em3Vl5zkv0PF4NumD
         LUPIBdapabkCGi6VRenyMka8Lj1AxAW8omySo=
Received: by 10.52.73.2 with SMTP id h2mr44301vdv.104.1306967613831; Wed, 01
 Jun 2011 15:33:33 -0700 (PDT)
Received: by 10.52.181.201 with HTTP; Wed, 1 Jun 2011 15:33:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174912>

Hi All,

I tried to use git to manage my digital photos but encountered some
problems. The typical file sizes are hundreds of KB or a few MB. In
total, about 15GB data in about 10,000 files. My intention is to get
them into a git repository and cloned into a few computers. Probably I
will make some occasionally changes like editing and deleting. But I
think most of the files would stay at version one.

The setup I used is a centralized repository for pulling from and
pushing into. There is a gitweb interface for the centralised repo.

I started by creating a small repository on the server (ubuntu), and
keeps pushing data into it from a windows machine (using cygwin). Half
way through the process, (after pushed about 8GB of data), I found
that I cannot run git push any more. This is the error message I got:

$ git push
Counting objects: 621, done.
Delta compression using up to 4 threads.
fatal: Out of memory? mmap failed: Cannot allocate memory
error: pack-objects died with strange error
error: failed to push some refs to 'ssh://huo@ubuntu/mnt/share/git/photo.git'

At the same time, I found that I cannot pull from this repository either.

$ git pull
remote: Counting objects: 8088, done.
error: pack-objects died of signal 983/8057)
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header

[The second line is probably "died of signal 9", because it was
counting ???/8057 upwards before the crash.]

I wonder whether anyone has tried using git in a similar scenario. Is
git capable of handling this kind of data? And, are there any settings
and/or command line options that I should use? I had a quick look of
git help push (and pull/fetch) but cannot see anything obvious.

BTW, I am using git version 1.7.0.4 on the ubuntu server, and version
1.7.2.3 for cygwin on the client side.

Thanks in advance.

Qingning
