From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/3] ab/i18n: README and GETTEXT_POISON support
Date: Fri,  3 Sep 2010 23:24:53 +0000
Message-ID: <1283556296-7365-1-git-send-email-avarab@gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 01:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrfdV-0004xM-RU
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 01:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab0ICXZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 19:25:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54452 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0ICXZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 19:25:11 -0400
Received: by wwj40 with SMTP id 40so3265439wwj.1
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rQD7+cxI7WvT9G0skK14SDHr1HPUAZSpUUE8AtKgXiI=;
        b=Ys3/Ivj67GkhKb3Puqrspn8vHyFDAFha78rZ/TqH92T27ncrL2gYPMip0SxUB6LbEh
         EQa9czwQ1vm7bv18guf3+K0SGtxBtHXlSid9nmEC+Xev/UIhanCrFvBkxvxY1oGeAPAB
         uTRuYqnWUUhInu/FLR5lBbxri5FstPChZRvmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JDWzuywBczk2I2/Yp/++tYSdWf7jOGuyeTaIaSVTKf3aXXVPJ0QuWvFYvyi4AEAP4S
         lNYL3Cd9kWL0pNiHMouJrYPH4caPTjNo/cnCpn7KcFE3H0RsGkWMcDh2TgMB3RDveLuC
         SW2N46vhJeEmwWZamNpHcAc8IN9rsvgvCQVv0=
Received: by 10.227.128.13 with SMTP id i13mr411972wbs.31.1283556309919;
        Fri, 03 Sep 2010 16:25:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2047451wbb.2.2010.09.03.16.25.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 16:25:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.336.g704fc
In-Reply-To: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155283>

On Fri, Sep 3, 2010 at 18:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> This is a pull request for an updated ab/i18n and the builtin.h
> changes. I can also send this to list on request, but it's 25 patches
> for what are trivial merge changes and a doc patch.
>
> I've rebased the ab/i18n series on top of master. Now it looks like
> this:
>
>    master
>    \
>     use-builtin-h-for-builtin-commands-v2
>     \
>      ab/i18n
>
> The changes are:
>
> [....]
>
>  1c7584b gettext: Add po/README file documenting Git's gettext
>
> This is new, a README file describing how to deal with the po/
> directory. See http://github.com/avar/git/raw/ab/i18n/po/README

Here's the README patch at the tip of the new ab/i18n (for reference,
because it wasn't on-list before), and the GETTEXT_POISON support I
promised to implement.

The poison support allows us to me much more sure that this gettext
stuff is actually working as intended. For one it turned up a bug in
the gettextization in builtin/fetch.c (I'll elaborate in a
soon-to-follow series).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  gettext: Add po/README file documenting Git's gettext
  gettext: Add GETTEXT_POISON=3DYesPlease Makefile parameter
  gettext: add NO_GETTEXT_POISON prerequisite to tests

 Makefile                      |    9 ++++
 gettext.h                     |    4 ++
 po/README                     |   68 ++++++++++++++++++++++++++++
 t/lib-gettext.sh              |   10 +++-
 t/lib-httpd.sh                |    2 +-
 t/t0001-init.sh               |    2 +-
 t/t1200-tutorial.sh           |    4 +-
 t/t2200-add-update.sh         |    2 +-
 t/t2204-add-ignored.sh        |    8 ++--
 t/t3030-merge-recursive.sh    |    2 +-
 t/t3200-branch.sh             |    2 +-
 t/t3203-branch-output.sh      |    2 +-
 t/t3700-add.sh                |    4 +-
 t/t4001-diff-rename.sh        |    4 +-
 t/t4014-format-patch.sh       |    2 +-
 t/t5541-http-push.sh          |    2 +-
 t/t5601-clone.sh              |    2 +-
 t/t6040-tracking-info.sh      |    2 +-
 t/t6200-fmt-merge-msg.sh      |   28 ++++++------
 t/t7004-tag.sh                |    6 ++-
 t/t7060-wtstatus.sh           |    2 +-
 t/t7102-reset.sh              |    2 +-
 t/t7110-reset-merge.sh        |    6 +-
 t/t7201-co.sh                 |   10 ++--
 t/t7500-commit.sh             |    9 +++-
 t/t7501-commit.sh             |   16 +++++--
 t/t7502-commit.sh             |   46 ++++++++++----------
 t/t7506-status-submodule.sh   |   28 ++++++------
 t/t7508-status.sh             |   98 ++++++++++++++++++++-------------=
-------
 t/t7600-merge.sh              |    2 +-
 t/t7602-merge-octopus-many.sh |    6 +-
 t/t7811-grep-open.sh          |    2 +-
 t/test-lib.sh                 |    1 +
 33 files changed, 247 insertions(+), 146 deletions(-)
 create mode 100644 po/README

--=20
1.7.2.2.336.g704fc
