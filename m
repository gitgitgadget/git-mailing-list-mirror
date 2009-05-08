From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH/RFC RESEND 0/2] git subtree: an alternative to git submodule
Date: Fri,  8 May 2009 18:39:07 -0400
Message-ID: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 00:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Ylg-0003Ry-01
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZEHWmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbZEHWmA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 18:42:00 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35698 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbZEHWmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 18:42:00 -0400
Received: by fxm2 with SMTP id 2so1646385fxm.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=4iq+k8PRzpGSw2LfcRfk98UwlNTczG69TLF/927o4A4=;
        b=VmH06S6xa4s0zzjDFZ6EJrV0elgc71d9PJZwMVv697Oh0HePVOQgLUeRSksLUr6abJ
         eDF+K/IZEcqeFOpqys4olO/Ks17Ghzn1YtUKYNcQG8TkfNdT8H6G5JLFwgMNAzldzUv7
         EeSloZolIxqWsLdVwV6IvibqbPsJ2ofUEt87Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BS5cUGkeo5TWmkCgL42sUT/edCNJTR73cROyBDrqzzylvBNjVVXbB+mr6YdnF7Zpba
         yctu8Zy2PlikG0I6nCQBo49fBnRi/Q65CmULFIgYmmO0Du3oXZ46oghSlOGQNNRrlQiL
         s1BMbSOlPyP3ezpHOQcvkn9oL3f4HayTNwrGI=
Received: by 10.103.213.10 with SMTP id p10mr2656325muq.49.1241822519740;
        Fri, 08 May 2009 15:41:59 -0700 (PDT)
Received: from afterlife.apenwarr.local (CPE001c10b0d47a-CM00195efb67e8.cpe.net.cable.rogers.com [99.249.243.14])
        by mx.google.com with ESMTPS id t10sm3647183muh.30.2009.05.08.15.41.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 15:41:59 -0700 (PDT)
Received: by afterlife.apenwarr.local (sSMTP sendmail emulation); Fri, 08 May 2009 18:39:12 -0400
X-Mailer: git-send-email 1.6.3.2.g3d624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118635>

Hi all,

I first sent out this patch set a couple of weeks ago
(http://article.gmane.org/gmane.comp.version-control.git/117612) and got a
couple of positive comments, but no negative ones, so I'm guessing people
haven't reviewed it as closely as I would have hoped :)

git subtree has these subcommands:

 - add: connect a given commit to a given subtree, basically using the
   occasionally-documented 'git read-tree --prefix; git commit' trick.

 - merge: a user-friendlier form of 'git merge -s subtree'

 - pull: likewise, but for git pull

 - split: (the magical part!) generate a new commit series from the given
   prefix, so you can submit subtree changes *back* to the upstream project
   you merged in the first place. 

Does anyone have any comments on what it would take to get the git subtree
stuff accepted into git?

Thanks,

Avery


Avery Pennarun (2):
  Add 'git subtree' command for tracking history of subtrees
    separately.
  Automated test script for 'git subtree'.

 .gitignore       |    1 +
 Makefile         |    1 +
 command-list.txt |    1 +
 git-subtree.sh   |  435 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 subtree-test.sh  |  206 ++++++++++++++++++++++++++
 5 files changed, 644 insertions(+), 0 deletions(-)
 create mode 100755 git-subtree.sh
 create mode 100755 subtree-test.sh
