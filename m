From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/4] Eliminate warnings under Sun Studio
Date: Wed, 21 Dec 2011 01:18:18 +0000
Message-ID: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdAp7-0001PP-Kt
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab1LUBSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:18:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52700 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab1LUBSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:18:20 -0500
Received: by eekc4 with SMTP id c4so7119243eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=l0MaGpKwraOEB7jMsHjMKeIXRKUlvxb3cdsNv8lzD6U=;
        b=UnhWipfH5NUsISJp2sId75lP2MI48x2/uC1jsKzRMMD54+kFvmWYD48KmrdIo+7oTR
         5uENMGF2bdUB7iwtypUgA3XerNIg8ugNGRuPQbLHb8OSChN1tdRh0ekwr/tOjScZ3cr8
         cUSWADr6qUon3wq1B78SK+nck/fTHYuG0Tkbo=
Received: by 10.213.20.217 with SMTP id g25mr3971274ebb.82.1324430299006;
        Tue, 20 Dec 2011 17:18:19 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z43sm14054237eef.7.2011.12.20.17.18.18
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 17:18:18 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187540>

This patch series eliminates warnings under Sun Studio. The first two
patches address actual (but obviously minor) issues, the third is a
nit, and the fourth disables a warning Sun Studio gets wrong.

I'm not sure whether we want the verbose code needed in the forth to
disable warnings under specific compilers, but since it's a rare
enough case and saves people compiling the code from wondering about
it's it's probably warranted. It's a verbose way to get rid of it
though.

I've CC'd people involved in the code touched by the first two, but
the second two are generic enough that I've decided not to bother the
original authors.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  Fix an enum assignment issue spotted by Sun Studio
  Fix a bitwise negation assignment issue spotted by Sun Studio
  Appease Sun Studio by renaming "tmpfile"
  Suppress "statement not reached" warnings under Sun Studio

 builtin/fast-export.c |    4 ++--
 builtin/index-pack.c  |    6 +++---
 fast-import.c         |    8 ++++----
 pack-write.c          |    6 +++---
 read-cache.c          |    6 ++++++
 sha1_file.c           |   12 ++++++------
 test-treap.c          |    2 +-
 vcs-svn/repo_tree.c   |    2 +-
 vcs-svn/string_pool.c |    4 ++--
 xdiff/xutils.c        |    6 ++++++
 10 files changed, 34 insertions(+), 22 deletions(-)

--=20
1.7.7.3
