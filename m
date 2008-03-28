From: "Jeffrey Chang" <jeffrey.chang@duke.edu>
Subject: git clone out of memory. alternatives?
Date: Thu, 27 Mar 2008 22:29:47 -0400
Message-ID: <beb5fde90803271929u40a98915ifd05234476ab92f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 03:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf4MQ-0004w5-61
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 03:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbYC1C3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 22:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbYC1C3s
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 22:29:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:36426 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbYC1C3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 22:29:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so41151wah.23
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=CgjHMmC29Br0tzlVSGWT0Y3XkQ64Us6SpqjyNNnKaQ8=;
        b=Mt2NShKM1esolQy6Xr4Y0KwHxM7zKHMTj4SxbmP8Ez5khfB0D0F6s8Nm9K/dJB9kQG8zE6o02BWiCFuD9TJh9TvXl1rUuxDtpbZA4iugAtvIkXckWq4+Z8d5dMKcX7Yu3CMqaPHsuk5xmN7pTQuVF5qpHgBjkooeIYG6ezCcgbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=HzZJZnCRb2nwoA7SbGGq9EcIEgB3l095xSkMf2O9iOgeUCSEDx5pBIQk1AbnfL4H4nPKWkHhe5+AXhICUNKn1sJ99kZHKZ9fxM8D6Kb8aaFqPqTgMRBbCVRCSPg8gtaXIrCO/WaUx/00gQCNIBcmLgb7ekVAOJCklDlwlOB9NFA=
Received: by 10.114.107.19 with SMTP id f19mr2842775wac.113.1206671387317;
        Thu, 27 Mar 2008 19:29:47 -0700 (PDT)
Received: by 10.114.175.13 with HTTP; Thu, 27 Mar 2008 19:29:47 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 794bede76218a3d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78381>

Hello,

I am working with a large-ish git repository set up as a shared
repository.  I am the only user of this repository, and I access it
over ssh.

I am running into a problem where I can no longer clone the repository
on a new computer.  I get a message that seems to indicate that the
machine with the repository is running out of memory.

xigua:~/remotecvs jchang$ git clone [...]
Initialized empty Git repository in [...]
remote: Generating pack...
remote: Done counting 9122 objects.
remote: Deltifying 9122 objects...
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.
remote: fatal: out of memoryremote:
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed
fetch-pack from [...] failed.
xigua:~/remotecvs jchang$

Moving the repository to another machine is not an option, nor is
adding more RAM to that machine.

Is there any way to get around this problem?  For example:
- Can I run git clone in a way that uses less memory, such as cloning
a piece of the repository at a time?
- Can I export the entire repository as a file that can be loaded on
my target machine, like "svnadmin dump" for subversion?
- Can I just rsync the repository from another computer that already has a copy?
- Are there any other work-arounds to set up a copy of the repository
on my local machine?

Thanks,
Jeff
