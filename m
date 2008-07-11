From: "Denis Bueno" <dbueno@gmail.com>
Subject: git cherry-pick before archive
Date: Fri, 11 Jul 2008 11:46:12 -0400
Message-ID: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKq3-0002VG-2k
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYGKPqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbYGKPqR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:46:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:39717 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYGKPqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:46:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1557642fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=DfNCZ5dFj4V1j9yz6mlmm8ZNCSL55AqnPblW/Q2fRcY=;
        b=BPMPbW9gOtUEQSgCEd9lmBKWXEtitxxvI50ycInctR2Puose5ME/hBb7vy+PhSdmV0
         IhDhiT0NeB9uqztRd4OUwDv/PousJqggemM1T+ThbHHzbBYp4hjuqKt5ZSdh7GjFagR9
         kmlIEzk5k+fuEmRDcXVTzkyTCs5B5zusZQgL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SCWy256EDq6plJVSvmpSY+r523kP/MO00e+VxU7DAbhnGdmg/y7jnDuHBRtK9WB0S5
         z9dnt7lUA/jwmJchnoWQlqxU8SuOPchlPZeLyG6DheWWrUQtYezWwTihZgzHCsBn77Ti
         wEUBl+MAKyUdadOFIj4vmUvnln2Z3RAu2n5/o=
Received: by 10.86.89.1 with SMTP id m1mr10039561fgb.68.1215791173114;
        Fri, 11 Jul 2008 08:46:13 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 11 Jul 2008 08:46:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88130>

Hi all,

I'm trying to use git archive to create a kind of "release" tarball of
my source.  I've got a patch (a commit) that I'd like to apply to the
tree before I call git archive on HEAD.  Currently my command is:

    git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz

If I were to actually modify my tree & history, I'd change the command to:

    git cherry-pick 97a1235ce674f7cf4df3129cd0ab1ae0793db392
    git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz
    git reset --hard HEAD^

But I'd rather not modify my history, if it's possible.  (This will
create a bunch of dangling commit objects over time, no?)

-- 
 Denis
