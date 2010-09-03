From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [GIT PULL] New ab/i18n series and builtin fixes
Date: Fri, 3 Sep 2010 18:22:44 +0000
Message-ID: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 20:23:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oraum-0003Np-7f
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab0ICSWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 14:22:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab0ICSWp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 14:22:45 -0400
Received: by fxm13 with SMTP id 13so1355920fxm.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Z1cDMQIa9zNPUNiFuSAn8mXNsYELRTyYvZrcCDfjHeQ=;
        b=YrjQb02+lDfP7VZIKnkLgBn1hYAFyA2Yg4Tl1h331xXTddb3i6ciHtm8FqidygmWBZ
         D+v7fwrnvvpG70Jkdiv9E3JtXzh1UbazkOjtvj3I3HGXRzHhbIyZPEMKfNeWlrTTBPcR
         q8BKEvIGmf5Napvp7bqkWFj4ihEjt0LC2R3cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Atul0qnaUXCEU4+2mI1L1GD9Bf0ppwHNB7lvEO4KOMmTIcnVUSLYB7TUMx7enNi1cq
         1PfOLe0DCS7Ut6RqR1xAA1QgpBB8cWAga2q+P1xwoCNMyKlSHsHcjudofA450Qvj2OVK
         E9ULgFAQMHHBTUI5sguRTVPDerpul0Yv/iRYM=
Received: by 10.223.104.199 with SMTP id q7mr218380fao.6.1283538164481; Fri,
 03 Sep 2010 11:22:44 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Fri, 3 Sep 2010 11:22:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155258>

This is a pull request for an updated ab/i18n and the builtin.h
changes. I can also send this to list on request, but it's 25 patches
for what are trivial merge changes and a doc patch.

I've rebased the ab/i18n series on top of master. Now it looks like
this:

    master
    \
     use-builtin-h-for-builtin-commands-v2
     \
      ab/i18n

The changes are:

use-builtin-h-for-builtin-commands-v2: (needed by the new ab/i18n
series, and a good idea in general)

 833c9cf builtin: use builtin.h for all builtin commands
 http://github.com/avar/git/commit/833c9cf

 git://github.com/avar/git.git use-builtin-h-for-builtin-commands-v2

  * I changed the "builtin: use builtin.h for all builtin commands"
    patch so that it adds builtin.h but only removes cache.h, not
    commit.h and notes.h.

ab/i18n: (new ab/i18n to replace the one in git.git)

 git://github.com/avar/git.git ab/i18n

 1c7584b gettext: Add po/README file documenting Git's gettext

This is new, a README file describing how to deal with the po/
directory. See http://github.com/avar/git/raw/ab/i18n/po/README

 aba2acf gettext tests: remove old sanity test under NO_GETTEXT
 340b167 gettext tests: test message re-encoding under C
 f072e35 po/pl.po: add Polish translation
 ea9736b po/is.po: add Icelandic translation
 a0dfa7e po/is.po: msgmerge and add Language: header
 6693d50 gettext tests: mark a test message as not needing translation
 9428b0a gettext tests: test re-encoding with a UTF-8 msgid under Shell
 b1d6c80 gettext tests: test message re-encoding under Shell
 e630ddd gettext tests: add detection for is_IS.ISO-8859-1 locale
 da615f4 gettext tests: update test/is.po to match t/t0200/test.c
 09c03ba gettext tests: test if $VERSION exists before using it
 56bed97 gettext.c: work around us not using setlocale(LC_CTYPE, "")
 c1c0d12 gettext: localize the main git-init message
 a0b47a5 gettext: make the simple parts of git-init localizable
 4a606ac builtin.h: Include gettext.h
 deb01cf Makefile: use variables and shorter lines for xgettext
 4ecebf5 Makefile: tell xgettext(1) that our source is in UTF-8
 3d9f454 Makefile: provide a --msgid-bugs-address to xgettext(1)
 29446ce Makefile: A variable for options used by xgettext(1) calls
 e25db7d tests: locate i18n lib&data correctly under --valgrind
 d3415a9 gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 3e25bb6 tests: rename test to work around GNU gettext bug

This is all the same.

 760724f Add infrastructure for translating Git with gettext

Changed perl/Makefile so it doesn't conflict with the version now in
master (conflict because of "perl/Makefile: Unset INSTALL_BASE when
making perl.mak").

END PULL REQUEST.

What I'm working on, which should not be pulled at this time:

ab/i18n-gettextize:
http://github.com/avar/git/compare/ab/i18n...ab/i18n-gettextize

  Updated version of the gettextize series rebased on master. No
  longer needs its own builtin.h patches (since ab/i18n itself now
  depends on it). I'm also fixing some minor issues raised on-list.

  I'm also going to add the aforementioned GETTEXT_POISON
  functionality to ab/i18n to make sure this series is OK.

ab/i18n-add-translations:
http://github.com/avar/git/compare/ab/i18n-gettextize...ab/i18n-add-translations

  Adds German and British English translations. More additions welcome.
