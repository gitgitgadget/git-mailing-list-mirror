From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git-remote-hg 0.2
Date: Fri, 09 May 2014 09:50:12 -0500
Message-ID: <536ceb245228e_6bf0154f30c9e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	Torsten =?UTF-8?B?QsO2Z2Vyc2hhdXNlbg==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 16:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wim8K-000275-AP
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 16:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbaEIOuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 10:50:40 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:47623 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080AbaEIOuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 10:50:18 -0400
Received: by mail-yh0-f52.google.com with SMTP id z6so3430595yhz.39
        for <git@vger.kernel.org>; Fri, 09 May 2014 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=+h0z68xJu/B0aguKev08ed7N//QBpYKKnaUNUs6FKcY=;
        b=jN+dI+FHao1qAG862rDDyKKn+IMywkN1q4DtDrTXPxdKffoDMauEf3Qxed3vFBssFJ
         j1zROOL/I+bb6dBMLcTZ+fTJbARctA0lmnj8YH4Jse9KFxy0O1FsN1mzA1EJq92Ji4g0
         9sr56T81TbI88LiJj9aRbs8oKkPrG+SH24jJ+5zZg4iUcIFcrqI6wsX0QgcCHCBcYCxG
         nCXl+OGvJpdNQbyoX1Hgsn1kv/o80N2hsVypQ/c/MT1xn5DCHNyrx9LziYkmnSqSv3JF
         aoHHFMW2Cu7F1Q8Ov9C243gu1xlOVPS+JbqwbQj92u0ybAR4rWoOUTXRLX7S6WAgr2WF
         pP3g==
X-Received: by 10.236.140.16 with SMTP id d16mr15860271yhj.55.1399647018200;
        Fri, 09 May 2014 07:50:18 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm6448579yhk.23.2014.05.09.07.50.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 07:50:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248561>

Hi,

git-remote-hg is a bidirectional bridge between Git and Mercurial. It is
production-ready, has been widely tested, and was previously part of
git.git.

Junio C Hamano has retracted from his previous statements where he
wanted these tools to become part of the Git core and distributed by
default.

It is obviously production ready so it doesn't belong in contrib/
either.

Since there's no path forward, it has been split into a separate
out-of-tree project.

This will hurt our users, but it's better than having dubious prospects
of when and how these tools will be part of the core, if such a thing
was even possible to begin with.

Changes from v1.9 upstream:

 * Add manpage
 * Fix regression that will become active in Git v2.0
 * Do not fail on invalid bookmarks
 * Skip multiple heads (hg has such a thing)
 * Ported tests from gitifyhg
 * Add support for Mercurial v3.0
 * Fixes for failed imports

If you use ArchLinux, you can use the package I wrote[1].

Enjoy :)

https://github.com/felipec/git-remote-hg

Daniel Liew (1):
      Use internal clone's hgrc

Felipe Contreras (22):
      Reorganize tests
      Add README
      build: add install target
      doc: add manpage
      Always normalize paths
      Fix parsing of custom committer
      Update to 'public' phase when pushing
      Store marks only on success
      Properly detect missing contexts
      test: split into setup test
      remote-hg: make sure we omit multiple heads
      Simplify hg-git regex
      Add more tests
      test: dd file operation tests
      test: trivial cleanups and fixes
      Add support for hg v3.0
      test: trivial style cleanups
      test: fix redirection style
      travis: add initial configuration
      readme: fix link location
      test: add missing redirection
      Use python2 instead of python

Max Horn (1):
      Do not fail on invalid bookmarks

[1] https://aur.archlinux.org/packages/git-remote-hg/

-- 
Felipe Contreras
