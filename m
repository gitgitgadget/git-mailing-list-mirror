From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/15] [REDO CONTINUE] Add gettext support to Git
Date: Mon,  6 Sep 2010 12:21:29 +0000
Message-ID: <1283775704-29440-1-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsaiG-0000Dp-Uv
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab0IFMWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:03 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:50377 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFMWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:02 -0400
Received: by wwj40 with SMTP id 40so2310943wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=E4hLwRHEGBNG7EI8pGufoAbJW38iVGMMEf+awYnHXCQ=;
        b=rrmVm3nmacsJrNjgjClvYKCiLJscNNl03f8KZ7LM3LJ7b+PxJvIr5Q4twgeWZwoPoJ
         nsMUg0YYoMu+gtLHlO7AvmmRtJdHUfggOzAOpBk6LEqWiXVx/B0ojThm78P4kg6K+OQC
         zQFArdsmMgJ1vZf3cpAhFRmq85jsxjGoOALu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FF4oBBaEgaINBEI6JllUxQ5jz0M2sYiAw1u3rrERaAMyRpxbrWPMw4rA2gIReHirjg
         aHYJSOC6K4VDYYkwHaxFnaYV0/yOiFenfsunoS5aPUgiD/AQCL6W0bBAzqkg0Ictwi5m
         4DsGF/yYcjp5wLB+Z1azZk1I5GgZv3f50olb4=
Received: by 10.216.85.133 with SMTP id u5mr3712766wee.82.1283775720562;
        Mon, 06 Sep 2010 05:22:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.21.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:21:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155551>

On Sat, Sep 4, 2010 at 22:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> The previous nested pull requests were a mess, and I needed to fix
> some bugs. So here's a total re-do of the ab/i18n series. Everything
> that's already in pu from ab/i18n can be ejected in favor of this.
>
> Most of these 63 patches have been seen here before. So I'll only be
> sending the stuff that's changed or interesting along with this
> series. To get the full thing go to:
>
>    git://github.com/avar/git.git ab/i18n-all
>    http://github.com/avar/git/compare/master...ab/i18n-all
>    http://github.com/avar/git/compare/master...ab/i18n-all.patch
>
> The last of which is a patch file suitable for git-am(1).
>
> Since last time I've rebased this on the new upstream master branch,
> which now has my ab/test-2 series.

Here's more work on top of my existing 63 patch series, bringing it to
78 patches in total.

With this all of the 'mainporcelain common' *and* 'mainporcelain' in
command-list.txt has been made translatable, aside from these
shellscripts:
   =20
    git-am                                  mainporcelain
    git-bisect                              mainporcelain common
    git-pull                                mainporcelain common
    git-rebase                              mainporcelain common
    git-stash                               mainporcelain
    git-submodule                           mainporcelain

Jan Kr=C3=BCger was doing some work on the git-add--interactive helper =
and
those, and I was getting comfortable with doing only C, so I've left
those for now.

This time around the changes to tests to add the NO_GETTEXT_POISON
prerequisite are part of the *.c patches themselves. This should make
it easier to review the series, since you can see what tests need to
be skipped for each patch.

This series goes on top of ab/i18n-all and can be pulled from my
GitHub branch:

    git://github.com/avar/git.git ab/i18n-all-continue
    http://github.com/avar/git/compare/ab/i18n-all...ab/i18n-all-contin=
ue
    http://github.com/avar/git/compare/ab/i18n-all...ab/i18n-all-contin=
ue.patch

And to see the whole thing from master:

    http://github.com/avar/git/compare/master...ab/i18n-all-continue
    http://github.com/avar/git/compare/master...ab/i18n-all-continue.pa=
tch

Note that this doesn't include Ramkumar Ramachandra's patch to add
Hindi. You'll have to get that from the archive separately.
   =20

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (15):
  gettextize: git-archive basic messages
  gettextize: git-bundle basic messages
  gettextize: git-clean basic messages
  gettextize: git-clean clean.requireForce messages
  gettextize: git-describe basic messages
  gettextize: git-gc basic messages
  gettextize: git-gc "Auto packing the repository" message
  gettextize: git-notes basic commands
  gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
  gettextize: git-notes "Refusing to %s notes in %s" message
  gettextize: git-revert basic messages
  gettextize: git-revert mark the "me" variable for translation
  gettextize: git-revert messages using the "me" variable
  gettextize: git-revert split up "could not revert/apply" message
  gettextize: git-shortlog basic messages

 builtin/archive.c                |   14 ++--
 builtin/bundle.c                 |    6 +-
 builtin/clean.c                  |   28 +++++----
 builtin/describe.c               |   36 +++++-----
 builtin/gc.c                     |   24 ++++----
 builtin/notes.c                  |  132 +++++++++++++++++++-----------=
-------
 builtin/revert.c                 |   65 ++++++++++---------
 builtin/shortlog.c               |    8 +-
 t/t3501-revert-cherry-pick.sh    |    2 +-
 t/t3507-cherry-pick-conflict.sh  |    2 +-
 t/t6120-describe.sh              |    2 +-
 t/t7012-skip-worktree-writing.sh |    4 +-
 t/t7300-clean.sh                 |    6 +-
 13 files changed, 170 insertions(+), 159 deletions(-)

--=20
1.7.2.3.313.gcd15
