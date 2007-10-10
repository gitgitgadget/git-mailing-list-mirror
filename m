From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: git branch performance problem?
Date: Wed, 10 Oct 2007 17:22:29 -0300
Message-ID: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 22:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifi4n-0003Vm-D5
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 22:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbXJJUWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 16:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbXJJUWc
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 16:22:32 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:23130 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbXJJUWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 16:22:31 -0400
Received: by py-out-1112.google.com with SMTP id u77so602357pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=eVTLZYXV/O09nSRZAkgR1oTH4GuW5uN9rl96cV8lW04=;
        b=HkgtpluldWk5GpSEEGueEWqWbuhJfIEnhxVWPPihFvH6aF/3WZ6PlarrFhWwkNr+FLHvlS3Jee2jYHmOtaihsO8d7qVMU0Ff8zUDi9OHORT4GmyX18bbm0bvKqVXXIx6BnCgQPS/afo92FJdTRZgNOvonz6iR5yxoyhseUsvBXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DWLUXyGBLa1WvrgOr/UIDEjFXO2XskRhshRwIAmhOEWr9x+Fu+sHndl7aK+X8Q4fpDCmYwbVK3ann4aOEq+rM2u//0Pqt74OCLBbi1CFDxc/s2Ox0ewdoZtMcyWkUR3ErRNt/Gfg/ZaL1/r+i61PrKWvs3g2GSuAE9RGziuKWNk=
Received: by 10.65.192.19 with SMTP id u19mr2304575qbp.1192047749665;
        Wed, 10 Oct 2007 13:22:29 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 13:22:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60539>

Hello,

I'm seeing very slow performance with 'git-branch'.  Is this the
canonical way to find out the current branch? ( I know I can look into
.git/HEAD, but how likely is that to break in the future?)

hanwen@lilypond:/tmp/z$ time git branch
* foo
  master

real    0m0.307s
user    0m0.232s
sys     0m0.038s

hanwen@lilypond:/tmp/z$ git --version
git version 1.5.1.rc1.949.g322bc


On NFS this takes 5 seconds. Note that I have a humongous amount of
remotes, but those should not be examined without -r, right?

hanwen@lilypond:/tmp/z$ find .git/refs/remotes | wc -l
1856

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
