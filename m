From: "seventh guardian" <seventhguardian@gmail.com>
Subject: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 14:45:22 +0100
Message-ID: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 15:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiVCO-000364-LN
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 15:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYDFNpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 09:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYDFNpY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 09:45:24 -0400
Received: from el-out-1112.google.com ([209.85.162.183]:6300 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbYDFNpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 09:45:24 -0400
Received: by el-out-1112.google.com with SMTP id v27so594947ele.17
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=bCFi/UkBqKyqUqsnRlIs/RjqMKYHdhRp54+q207htXo=;
        b=lxFdLCPJhrGELFJl9CSdo8uD2q48CbrT5I8TlcNuOUD+z7Zc180FNgtLJ2hO8wxsNcztEe2dMMRtDwY0+GVgRvs+GYdbShvceXco0A1IVHBX90+3ENlDRGPJzv5f09AWwp9a5lBgLMMCIE/LvO4B89vJ6zeuI5XGx1Wj3ZsPnvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=vYA6ZBCbDTBICJetbTGcQNu7v6gSaqvbPjFtXk5b6kAGfK1Z3qaLGdjXhUEFr6Cj/gjazWlcUxhX6lzc9p4E1gEAxrsaklxr7Z6EMoEWBhXffCTtUxs2KmXVoVGd6IhQtSybdsHHRz4S81jS+Etks5Ukf+FpRlu8tWjn4XjzCS0=
Received: by 10.114.88.20 with SMTP id l20mr1638803wab.157.1207489522775;
        Sun, 06 Apr 2008 06:45:22 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 06:45:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78891>

Hello,

First of all I kindly ask you to put my e-mail in CC as I'm not
subscribed to the list. Secondly, I did try to find similar issues on
the archives, but failed to do so. I apologize if this is not a bug.

I keep some local git repositories on my laptop, which are also used
by other machines on my home network. In order to avoid unnecessary
burden on the master servers, I've tried keeping a "local master" on
the laptop and clone the repo's over ssh on the other machines.

I have some local commits on some of the "local master" repo's, and
that's where the problems start: while cloning over ssh works fine for
the unchanged repo's, those which have local commits are impossible to
clone. The error on the "slave" machines is this:

 $ git-clone ssh://<host>/<path>
Initialized empty Git repository in <path>/.git/
Password:
remote: Counting objects: 132468, done.
remote: Compressing objects: 100% (25543/25543), done.
remote: Total 132468 (delta 107355), reused 130574 (delta 105466)
Receiving objects: 100% (132468/132468), 42.12 MiB | 4161 KiB/s, done.
Resolving deltas: 100% (107355/107355), done.
error: Trying to write ref REMOTE_HEAD with nonexistant object
f7a51afd56964cb0f10178353315d2680832ea54
fatal: Cannot update the ref 'REMOTE_HEAD'.
Warning: Remote HEAD refers to nonexistent ref, unable to checkout.

where I've "obfuscated" the hostname and the repository path. I'm
using the latest version, 1.5.4.5.

Thanks,
  Renato Caldas
