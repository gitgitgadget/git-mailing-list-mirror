From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.4
Date: Tue, 16 Jun 2015 15:15:09 -0700
Message-ID: <xmqqa8vz5mhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Jun 17 00:15:27 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Z4z8h-0003ZU-0n
	for glk-linux-kernel-3@plane.gmane.org; Wed, 17 Jun 2015 00:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbbFPWPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 16 Jun 2015 18:15:19 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37106 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbFPWPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jun 2015 18:15:12 -0400
Received: by igbsb11 with SMTP id sb11so24603181igb.0;
        Tue, 16 Jun 2015 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=kY5P88x/Zg2YJqYQU6m+hD0WYSBRx8jwVdzOedklB5M=;
        b=Sq0KRmqZVLC3FfYLtyzWaSjgsq/vlPFivbPusIdIeoCUlGx3ZeMhW9ru/yI93ZvJra
         xntCUOvrRA0Lu3FT8ZTL20ij8VvN7w/R0lHwUV2GTYzkXFM1/ayteWTn+0X9PJJZ52aS
         WVP65xJlSAFvUMP25eIRoe1IoAXJapJI+fdNMMp496JKd7ELAk2NwKWp0j7l9F5uDwME
         f34Qyk+P7u8pFgoGMsPdVsj70HMXDU3soEYejzeAAhWR5ftW12iGZ0egRjhh3wpSIqME
         sZ1ipULpcpGrLWS9D9pA7P29frOwGMP1YZuiHjmjS6yy2HLr+AVaMBkKCLHUiwuIWBxi
         FHxA==
X-Received: by 10.43.151.83 with SMTP id kr19mr5360318icc.3.1434492911495;
        Tue, 16 Jun 2015 15:15:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id pg5sm1942927igb.4.2015.06.16.15.15.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 15:15:10 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271802>

The latest maintenance release Git v2.4.4 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.4'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.3
------------------

 * l10n updates for German.

 * An earlier leakfix to bitmap testing code was incomplete.

 * "git clean pathspec..." tried to lstat(2) and complain even for
   paths outside the given pathspec.

 * Communication between the HTTP server and http_backend process can
   lead to a dead-lock when relaying a large ref negotiation request.
   Diagnose the situation better, and mitigate it by reading such a
   request first into core (to a reasonable limit).

 * The clean/smudge interface did not work well when filtering an
   empty contents (failed and then passed the empty input through).
   It can be argued that a filter that produces anything but empty for
   an empty input is nonsense, but if the user wants to do strange
   things, then why not?

 * Make "git stash something --help" error out, so that users can
   safely say "git stash drop --help".

 * Clarify that "log --raw" and "log --format=3Draw" are unrelated
   concepts.

 * Catch a programmer mistake to feed a pointer not an array to
   ARRAY_SIZE() macro, by using a couple of GCC extensions.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.3 are as follows:

Alex Henrie (1):
      blame, log: format usage strings similarly to those in documentat=
ion

David Turner (1):
      clean: only lstat files in pathspec

Elia Pinto (1):
      git-compat-util.h: implement a different ARRAY_SIZE macro for for=
 safely deriving the size of array

Jeff King (8):
      http-backend: fix die recursion with custom handler
      t5551: factor out tag creation
      stash: complain about unknown flags
      stash: recognize "--help" for subcommands
      test_bitmap_walk: free bitmap with bitmap_free
      http-backend: spool ref negotiation requests to buffer
      clone: use OPT_STRING_LIST for --reference
      clone: reorder --dissociate and --reference options

Jim Hill (1):
      sha1_file: pass empty buffer to index empty file

Junio C Hamano (1):
      Git 2.4.4

Matthieu Moy (2):
      Documentation/log: clarify what --raw means
      Documentation/log: clarify sha1 non-abbreviation in log --raw

Michael Coleman (1):
      Documentation/git-commit: grammofix

Michael J Gruber (3):
      l10n: de.po: grammar fix
      l10n: de.po: punctuation fixes
      l10n: de.po: translation fix for fall-back to 3way merge

Phillip Sz (1):
      l10n: de.po: change error message from "sagen" to "Meinten Sie"

Ren=C3=A9 Scharfe (3):
      use file_exists() to check if a file exists in the worktree
      clean: remove unused variable buf
      dir: remove unused variable sb

Stefan Beller (2):
      submodule doc: reorder introductory paragraphs
      glossary: add "remote", "submodule", "superproject"
