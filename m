From: "Pico Geyer" <picogeyer@gmail.com>
Subject: Help using Git(-svn) for specific use case
Date: Mon, 15 Sep 2008 14:50:00 +0200
Message-ID: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 14:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfDXq-0001A1-Q8
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 14:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbYIOMuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 08:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYIOMuD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 08:50:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:22455 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbYIOMuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 08:50:00 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2034420wfd.4
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=FmrA68PYoN7A1PigukXPbTt0rL0icBX8W+bmHC1c294=;
        b=cwiuxBNHczzbvtgEie79PUPNEzBfun0tA7/IRy/+7HelesbF0y8Nip4MtO5Y0gRn1/
         ksBUH0Otd3QNpmLtTtloH+VSNffG4LSm1/DL4tCOotCPcdLUbXh5/r4txclwNq5II06F
         yZOFSbGZI5xPU+0KX1jhw4i0YaUMunxbKIx6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FYURrcPxBGq4F90a6Spd2olbmAxP08R/PT2KBJ+G0MysbywlYB5JQOCx5s4HsmynNf
         bZjDJq3VpgzQgN/0N5OHjD8kzFB0vxG7vtFLxAutdReDNRMuGOJDEj+f6O+kyWBwzlod
         RV32xZ5bcX+CHQVWtiMPEl2xgSrnGSHZk/Yik=
Received: by 10.141.123.4 with SMTP id a4mr4733084rvn.294.1221483000173;
        Mon, 15 Sep 2008 05:50:00 -0700 (PDT)
Received: by 10.141.193.16 with HTTP; Mon, 15 Sep 2008 05:50:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95906>

Hi all.

I'd like to start using Git within our company. I'm still trying to
determine if Git can work in our scenario.
May be someone can offer some advice.
Our scenario is as follows:
We have a handful of developers which work at a branch office. This
office has a rather slow internet connection.
At the head office, we are (still) using a Subversion server to host
our source code.
At the branch office, we would like to do the following:
* Fetch the latest code from the subversion server.
* Push changes that we have made at the remote office back to upstream
SVN server.
* Be able to share source code changes locally (at the branch office)
between developers.

The solution that I imagined is that we would setup a server (lets
call it A) at the branch office with a Git repository, that all the
developers can access.
Developers would then clone the server repository A, make mods and
then push changes back to A.
It would be nice if git users could commit to a subversion branch.
A merge master would then (as necessary) use svn dcommit to push the
changes up to the svn server.
Is this scenario possible?

>From the git-svn man page: "git-clone does not clone branches under
the refs/remotes/ hierarchy or any git-svn metadata, or config. So
repositories created and managed with using git-svn should use rsync
for cloning, if cloning is to be done at all."
Does that mean that one should not push changes to a repository that
was created with "git svn clone ..."?

Thanks in advance for any advice.

Pico Geyer
