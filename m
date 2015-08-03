From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.8
Date: Mon, 03 Aug 2015 15:22:15 -0700
Message-ID: <xmqqwpxc57xk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 00:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMO7s-0006dO-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbbHCWWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2015 18:22:18 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35510 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbbHCWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:22:17 -0400
Received: by pasy3 with SMTP id y3so23946436pas.2;
        Mon, 03 Aug 2015 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=0aujYgmXUAhbJ+8bcEFnxf9S9l5NTTGAKJqEEKhpOfQ=;
        b=JeKTbvebPz/6G2ah6Svuhxq8PqvXzKkEQFCCbFIrzVol9zeNEVaJEO5R0yFSv6NdUt
         4l2o+Mt0ZC8KSFa7s2YOgo/aIpeXyQXXK0NRXArvPVP1zPYjdlQDWciF/3xjyh40NsIz
         n3g1HYwrXKRnEt+golWTiiWMXqjnO/tRf1rsTNCM48/lrBmB7ID89rJvaHNQnTEHJS8P
         Zo0RCPDCxeYLros4Jar73DmgY5gRxLEe0pBPfp+aRCWk0QVboalShrkd1FHM8kvJmmmt
         67iHNXB8pGMgv7MWk2OMahRfLLpAb6tB8rjmcOVnm6kW0tbd/0K5JrN2eiJpUS0h7Mrb
         32eg==
X-Received: by 10.66.66.163 with SMTP id g3mr589920pat.85.1438640536693;
        Mon, 03 Aug 2015 15:22:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id e8sm18633537pdm.13.2015.08.03.15.22.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 15:22:16 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275221>

A maintenance release Git v2.4.8 is now available at the usual
places.  This contains remaining fixes that are in v2.5 but have
been lacking in 2.4.x maintenance track so far.  It will hopefully
be the last 2.4.x update at least for now.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.8'
tag and some of them have the 'maint-2.4' branch that the tag
points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.8 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.7
------------------

 * Abandoning an already applied change in "git rebase -i" with
   "--continue" left CHERRY_PICK_HEAD and confused later steps.

 * Various fixes around "git am" that applies a patch to a history
   that is not there yet.

 * "git for-each-ref" reported "missing object" for 0{40} when it
   encounters a broken ref.  The lack of object whose name is 0{40} is
   not the problem; the ref being broken is.

 * "git commit --cleanup=3Dscissors" was not careful enough to protect
   against getting fooled by a line that looked like scissors.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.7 are as follows:

Johannes Schindelin (2):
      t3404: demonstrate CHERRY_PICK_HEAD bug
      rebase -i: do not leave a CHERRY_PICK_HEAD file behind

Junio C Hamano (1):
      Git 2.4.8

Michael Haggerty (4):
      t6301: new tests of for-each-ref error handling
      for-each-ref: report broken references correctly
      read_loose_refs(): simplify function logic
      read_loose_refs(): treat NULL_SHA1 loose references as broken

Paul Tan (6):
      am --skip: revert changes introduced by failed 3way merge
      am -3: support 3way merge on unborn branch
      am --skip: support skipping while on unborn branch
      am --abort: revert changes introduced by failed 3way merge
      am --abort: support aborting to unborn branch
      am --abort: keep unrelated commits on unborn branch

SZEDER G=C3=A1bor (2):
      completion: teach 'scissors' mode to 'git commit --cleanup=3D'
      commit: cope with scissors lines in commit message

Sebastian Schuberth (1):
      clone: simplify string handling in guess_dir_name()
