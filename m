From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to add folder NON RECURSIVELY ?
Date: Tue, 03 Apr 2012 14:08:38 +0200
Message-ID: <vpqzkatc915.fsf@bauges.imag.fr>
References: <20120403173111.5329d7ed@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Apr 03 14:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF2XZ-00009s-KR
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 14:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab2DCMIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 08:08:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35683 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab2DCMIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 08:08:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q33C3DH3016021
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Apr 2012 14:03:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SF2XP-0001X1-CG; Tue, 03 Apr 2012 14:08:39 +0200
In-Reply-To: <20120403173111.5329d7ed@shiva.selfip.org> (J. Bakshi's message
	of "Tue, 3 Apr 2012 17:31:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Apr 2012 14:03:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q33C3DH3016021
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334059394.47837@csA/TflNkApr9YhQ1T2Flw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194615>

"J. Bakshi" <joydeep.bakshi@infoservices.in> writes:

> I like to add the folder structure in a way that only foo/dir1/file1 is added to
> the git. foo/dir2 and foo/dir3 should be added to the git also to show
> the directory
> structure and not the contents of those folder.

Git doesn't record the existance of directories. For Git, a directory
exists if and only if it has some files in it. So, "foo/dir2 and
foo/dir3 should be added to the git" cannot be done in Git.

A common workaround is to create a dummy file, typically .gitignore,
within the directories you want to add. Depending on the intended use of
the directory, you may want this file to be empty (to tell your
collaborators "there's nothing here for now, but there will be later"),
or to contain '*' to mean "there will never be any tracked files in this
directory".

IOW,

touch foo/dir2/.gitignore foo/dir3/.gitignore
git add foo/dir2/.gitignore foo/dir3/.gitignore

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
