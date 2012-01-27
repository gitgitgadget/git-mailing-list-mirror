From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL] svn-fe updates for master or next
Date: Thu, 26 Jan 2012 18:33:46 -0600
Message-ID: <20120127003258.GA6946@burratino>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
 <20120127001041.GB6158@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZlS-00041s-8O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2A0Ad6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:33:58 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36131 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2A0Ad5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:33:57 -0500
Received: by ggnb1 with SMTP id b1so584929ggn.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hWcCLjLhwvxlSIqI+Bi2rSLHPiPE4swsLys7xHbIxO4=;
        b=iE7XC7VeAx8CBcLKlU7Ym6rZ8Vn9/x/+KPnYckiDh9ifaF114Bwd7fBOzRMsQSjkN7
         P9rODrEK4hSfQKbEFoQZ85uRaAi1WO2nzTZHtyAdZcWdLcjEGN4As33KQcK81mOgZVzm
         57mD3vh4JscebCN7cSK4KhHOp2vILLCxlxaxk=
Received: by 10.236.154.137 with SMTP id h9mr6874285yhk.91.1327624434953;
        Thu, 26 Jan 2012 16:33:54 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p63sm9908491yhj.22.2012.01.26.16.33.53
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jan 2012 16:33:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120127001041.GB6158@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189178>

Jonathan Nieder wrote:

> Test results from the svn-fe branch would be interesting.  I am
> particularly nervous about asking Junio to pull changes to
> contrib/svn-fe that might break

Eh, you only live once.

Junio, please pull

  git://repo.or.cz/git/jrn.git svn-fe

to get the following changes since commit ec014eac0e9e6f30cbbca616090fa2ecf74797e7:

  Git 1.7.5 (2011-04-23 23:36:32 -0700)

up to c5bcbcdcfa1e2a1977497cb3a342c0365c8d78d6:

  vcs-svn: reset first_commit_done in fast_export_init (2011-06-23 10:04:36 -0500)

I'd even be okay with pulling this for v1.7.9, but application for the
next release would also be fine with me.  It simplifies svn-fe a great
deal and fulfills a longstanding wish: support for dumps with deltas
in them.  The cost is that commandline usage of the svn-fe tool
becomes a little more complicated since it no longer keeps state
itself but instead reads blobs back from fast-import in order to copy
them between revisions and apply deltas to them.

Sorry I've taken so long to get to this, and thanks to David for the
prodding.

----------------------------------------------------------------
David Barr (9):
      vcs-svn: set up channel to read fast-import cat-blob response
      vcs-svn: quote paths correctly for ls command
      vcs-svn: use mark from previous import for parent commit
      vcs-svn: pass paths through to fast-import
      vcs-svn: drop string_pool
      vcs-svn: drop treap
      vcs-svn: drop obj_pool
      vcs-svn: avoid using ls command twice
      vcs-svn: implement text-delta handling

Dmitry Ivankov (2):
      vcs-svn: do not initialize report_buffer twice
      vcs-svn: reset first_commit_done in fast_export_init

Jonathan Nieder (31):
      vcs-svn: use higher mark numbers for blobs
      vcs-svn: save marks for imported commits
      vcs-svn: add a comment before each commit
      vcs-svn: eliminate repo_tree structure
      vcs-svn: handle filenames with dq correctly
      Merge branch 'db/length-as-hash' (early part) into db/svn-fe-code-purge
      Merge branch 'db/strbufs-for-metadata' into db/svn-fe-code-purge
      Makefile: list one vcs-svn/xdiff object or header per line
      vcs-svn: learn to maintain a sliding view of a file
      vcs-svn: make buffer_read_binary API more convenient
      vcs-svn: skeleton of an svn delta parser
      vcs-svn: parse svndiff0 window header
      vcs-svn: read the preimage when applying deltas
      vcs-svn: read inline data from deltas
      vcs-svn: read instructions from deltas
      vcs-svn: implement copyfrom_data delta instruction
      vcs-svn: verify that deltas consume all inline data
      vcs-svn: let deltas use data from postimage
      vcs-svn: let deltas use data from preimage
      Merge commit 'v1.7.5' into svn-fe
      Merge branch 'db/vcs-svn-incremental' into svn-fe
      Merge branch 'db/svn-fe-code-purge' into svn-fe
      Merge branch 'db/delta-applier' into db/text-delta
      test-svn-fe: split off "test-svn-fe -d" into a separate function
      vcs-svn: cap number of bytes read from sliding view
      Merge branch 'db/delta-applier' into svn-fe
      Merge branch 'db/delta-applier' into db/text-delta
      vcs-svn: guard against overflow when computing preimage length
      vcs-svn: avoid hangs from corrupt deltas
      Merge branch 'db/text-delta' into svn-fe
      Merge branch 'db/text-delta' into svn-fe

 .gitignore                |    3 -
 Makefile                  |   58 +++++---
 contrib/svn-fe/svn-fe.txt |    9 +-
 t/t0080-vcs-svn.sh        |  117 ---------------
 t/t0081-line-buffer.sh    |  106 +-------------
 t/t9010-svn-fe.sh         |  365 ++++++++++++++++++++++++++++++++++++++-------
 t/t9011-svn-da.sh         |  248 ++++++++++++++++++++++++++++++
 test-obj-pool.c           |  116 --------------
 test-string-pool.c        |   31 ----
 test-svn-fe.c             |   50 ++++++-
 test-treap.c              |   70 ---------
 vcs-svn/LICENSE           |    3 +-
 vcs-svn/fast_export.c     |  253 +++++++++++++++++++++++++++++--
 vcs-svn/fast_export.h     |   26 +++-
 vcs-svn/line_buffer.c     |    6 +-
 vcs-svn/line_buffer.h     |    2 +-
 vcs-svn/obj_pool.h        |   61 --------
 vcs-svn/repo_tree.c       |  330 ++++-------------------------------------
 vcs-svn/repo_tree.h       |   12 +-
 vcs-svn/sliding_window.c  |   79 ++++++++++
 vcs-svn/sliding_window.h  |   18 +++
 vcs-svn/string_pool.c     |  102 -------------
 vcs-svn/string_pool.h     |   11 --
 vcs-svn/string_pool.txt   |   43 ------
 vcs-svn/svndiff.c         |  308 ++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h         |   10 ++
 vcs-svn/svndump.c         |  117 ++++++++++-----
 vcs-svn/trp.h             |  237 -----------------------------
 vcs-svn/trp.txt           |  109 --------------
 29 files changed, 1434 insertions(+), 1466 deletions(-)
 delete mode 100755 t/t0080-vcs-svn.sh
 create mode 100755 t/t9011-svn-da.sh
 delete mode 100644 test-obj-pool.c
 delete mode 100644 test-string-pool.c
 delete mode 100644 test-treap.c
 delete mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/sliding_window.c
 create mode 100644 vcs-svn/sliding_window.h
 delete mode 100644 vcs-svn/string_pool.c
 delete mode 100644 vcs-svn/string_pool.h
 delete mode 100644 vcs-svn/string_pool.txt
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h
 delete mode 100644 vcs-svn/trp.h
 delete mode 100644 vcs-svn/trp.txt
