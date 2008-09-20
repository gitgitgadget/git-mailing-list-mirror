From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 17:01:39 +0700
Message-ID: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJ6-00013g-GJ
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYITKCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 06:02:08 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYITKCH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:02:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYITKCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:06 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=f0rBYsI3x6nllFNF16BXMFSwFqlwg1fD/TtpsVqljZg=;
        b=uqZlgPymzH9HktpTdSqCYfKBNw489/tyGj9+qUSlY/56eB0K8zYJ2XW99k7arHREX7
         yImXMUcGM5njUSmK30+JOpLuqPXH3BV6vewPJnBAw4MlPBNI9+miabBStnuqAn410xBA
         mPI+7y+SbRKuRU/2GQIy1htlKO85c1t67oXtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=u5s/gFsGdbwjN3SUcIJcjEM/nJV/Vi7F4zvc8sL/i4GVgBhiJmQ7FXWxCKJiRsNw6C
         Ei1tgliNwhC8GqIczl4AwXET5OosPD0hjzJKKgQRniUJ3amVhkLIu4S6GIOuBkE11ct1
         caTW9VDLDxrpAyzoBMWXbyLkcDIHWeK5s8gMY=
Received: by 10.143.12.19 with SMTP id p19mr449890wfi.171.1221904924780;
        Sat, 20 Sep 2008 03:02:04 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 27sm3585450wfa.2.2008.09.20.03.02.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:02:03 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:01:53 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96338>

Main changes from the last round are:
 - The name is now "sparse checkout"
 - "git clone --path" =3D> "git clone --narrow-path"
 - "git checkout --path" =3D> "git checkout --reset-path"
 - New narrow spec (or "sparse patterns" from now) resembles
   .gitignore patterns
 - "git ls-files" now supports more fine-grained listing. It can now
   list checkout files, no-checkout files or orphaned (previously
   "overlay") files. --overlay is gone
 - "git status" shows orphaned entries and remedies
 - Documentation has been restructured to accompany code changes.
   Thanks to Jakub, Baz for lots of input.

=46or code changes, significant changes are:
  [03/14] ls-files: add options to support sparse checkout
  [10/14] ls-files: support "sparse patterns", used to form sparse chec=
kout areas

I hope I have addressed all the issues. If I miss anything, please spea=
k up.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (14):
  Extend index to save more flags
  Introduce CE_NO_CHECKOUT bit
  ls-files: add options to support sparse checkout
  update-index: refactor mark_valid() in preparation for new options
  update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT b=
it
  ls-files: Add tests for --sparse and friends
  Prevent diff machinery from examining worktree outside sparse checkou=
t
  checkout_entry(): CE_NO_CHECKOUT on checked out entries.
  grep: skip files outside sparse checkout area
  ls-files: support "sparse patterns", used to form sparse checkout are=
as
  unpack_trees(): add support for sparse checkout
  clone: support sparse checkout with --narrow-path option
  checkout: add new options to support sparse checkout
  wt-status: Show orphaned entries in "git status" output

 .gitignore                            |    1 +
 Documentation/git-checkout.txt        |  131 ++++++++++++++++++++-
 Documentation/git-clone.txt           |   10 ++-
 Documentation/git-grep.txt            |    4 +-
 Documentation/git-ls-files.txt        |   30 +++++-
 Documentation/git-update-index.txt    |   13 ++
 Makefile                              |    2 +-
 builtin-checkout.c                    |   37 ++++++
 builtin-clone.c                       |   13 ++
 builtin-grep.c                        |    7 +-
 builtin-ls-files.c                    |   60 +++++++++-
 builtin-update-index.c                |   40 ++++---
 cache.h                               |   69 ++++++++++-
 diff-lib.c                            |    5 +-
 diff.c                                |    4 +-
 entry.c                               |    1 +
 read-cache.c                          |   57 +++++++--
 t/t2011-checkout-sparse.sh            |  108 +++++++++++++++++
 t/t2104-update-index-no-checkout.sh   |   36 ++++++
 t/t3003-ls-files-narrow-match.sh      |   39 ++++++
 t/t3003/1                             |    3 +
 t/t3003/12                            |    6 +
 t/t3003/clone-escape                  |    4 +
 t/t3003/cur-12                        |    2 +
 t/t3003/root-sub-1                    |    1 +
 t/t3003/slash-1                       |    1 +
 t/t3003/sub-1                         |    2 +
 t/t3003/sub-only                      |    3 +
 t/t3003/subsub-slash                  |    3 +
 t/t3004-ls-files-sparse.sh            |   40 ++++++
 t/t3004/cached.expected               |    5 +
 t/t3004/deleted.expected              |    1 +
 t/t3004/everything.expected           |   10 ++
 t/t3004/modified.expected             |    2 +
 t/t3004/no-checkout.expected          |    2 +
 t/t3004/orphaned-no-checkout.expected |    3 +
 t/t3004/orphaned.expected             |    1 +
 t/t3004/others.expected               |    2 +
 t/t3004/sparse-cached.expected        |    3 +
 t/t3004/sparse-everything.expected    |   11 ++
 t/t5703-clone-narrow.sh               |   39 ++++++
 test-index-version.c                  |   14 ++
 unpack-trees.c                        |  210 +++++++++++++++++++++++++=
+++++++-
 unpack-trees.h                        |   22 ++++
 wt-status.c                           |   39 ++++++
 wt-status.h                           |    1 +
 46 files changed, 1047 insertions(+), 50 deletions(-)
 create mode 100755 t/t2011-checkout-sparse.sh
 create mode 100755 t/t2104-update-index-no-checkout.sh
 create mode 100755 t/t3003-ls-files-narrow-match.sh
 create mode 100644 t/t3003/1
 create mode 100644 t/t3003/12
 create mode 100644 t/t3003/clone-escape
 create mode 100644 t/t3003/cur-12
 create mode 100644 t/t3003/root-sub-1
 create mode 100644 t/t3003/slash-1
 create mode 100644 t/t3003/sub
 create mode 100644 t/t3003/sub-1
 create mode 100644 t/t3003/sub-only
 create mode 100644 t/t3003/subsub-slash
 create mode 100755 t/t3004-ls-files-sparse.sh
 create mode 100644 t/t3004/cached.expected
 create mode 100644 t/t3004/deleted.expected
 create mode 100644 t/t3004/everything.expected
 create mode 100644 t/t3004/modified.expected
 create mode 100644 t/t3004/no-checkout.expected
 create mode 100644 t/t3004/orphaned-no-checkout.expected
 create mode 100644 t/t3004/orphaned.expected
 create mode 100644 t/t3004/others.expected
 create mode 100644 t/t3004/sparse-cached.expected
 create mode 100644 t/t3004/sparse-everything.expected
 create mode 100755 t/t5703-clone-narrow.sh
 create mode 100644 test-index-version.c
