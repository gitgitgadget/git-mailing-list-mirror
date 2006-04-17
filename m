From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE qgit-1.0rc2]
Date: Mon, 17 Apr 2006 13:38:35 +0200
Message-ID: <e5bfff550604170438s442c0e3dv375a1e053cb5ad1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 17 13:38:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVS3z-0006kc-ET
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 13:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDQLig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDQLig
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 07:38:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:54285 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWDQLig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 07:38:36 -0400
Received: by nz-out-0102.google.com with SMTP id 14so447759nzn
        for <git@vger.kernel.org>; Mon, 17 Apr 2006 04:38:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F/kKNyXOeAkjoeOqF11yzcIn//XVcFvc4JvlmZFH5TfqXQQIqEPIRKi+qxmtTOdM0N9Z/V6KWs6eaJ8mzTcMpNqOUZCDci+NEpITjN8t4a9XSM6IgKV6QQRhG//wlsxGOIQmERXnomWIdqT2cowziLscS55xEN6N0XWNzM5baLA=
Received: by 10.64.250.9 with SMTP id x9mr1293198qbh;
        Mon, 17 Apr 2006 04:38:35 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Mon, 17 Apr 2006 04:38:35 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18817>

Two new main features:

1) Thanks to Johannes's new --patch-with-stat option in git-diff-tree
we can now show stat info at the beginning of the patch. (Still not
working with merges)

2) A more then 20% speed up due to a heavy optimizing work on some
internal structures.
Interesting enough also the text size has been shrunk of 24KB.

Now qgit is really very very very fast :-)

In my old PC a complete Linux tree loading (on warmed-up cache) passes
from 6.8s to 5.4s.

As a fair compare:
$ /usr/bin/time git-rev-list --header --topo-order --boundary
--parents HEAD > /dev/null
2.24user 0.20system 0:02.45elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+13268minor)pagefaults 0swaps


DOWNLOAD

Tarball is at
http://prdownloads.sourceforge.net/qgit/qgit-1.2rc2.tar.bz2?download

Git archive is at
http://digilander.libero.it/mcostalba/scm/qgit.git

See http://digilander.libero.it/mcostalba/  for detailed download information.

NOTE NOTE: you probably need to clone again the repository due to some
deleted revisions in the git archive.

INSTALLATION

To install from tarball use:

./configure
make
make install-strip

To install from git archive:

git clone http://digilander.libero.it/mcostalba/scm/qgit.git
cd qgit
autoreconf -i
./configure
make
make install-strip

Or check the shipped README for detailed information.

CHANGELOG

 - show stat info in patch viewer. Use new --patch-with-stat
git-diff-tree option

- revisions storing update. Change revisions container and defer parsing

- use a circular buffer instead of a double buffer to load data

- defer graph lanes calculation. Drawing was already deferred

- remove useless option "File window always on top"

- pop-up a warning if external diff viewer fails to start

- add a pop-up menu in file list window

- avoid to show patches not in current StGIT branch

- fix StGIT commit to remove temporary files when finished

- small GUI tweaks


        Marco
