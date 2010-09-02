From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/25] [CONTINUED] gettextize all C mainporcelain common commands
Date: Thu,  2 Sep 2010 19:40:21 +0000
Message-ID: <1283456446-22577-1-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFej-0005Oq-C2
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab0IBTlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0IBTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:40:59 -0400
Received: by wwj40 with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YU3bujDYizb7EpO5hOiYhIpjnt5viCyPRMJ1ZOp+jsE=;
        b=CxUaADmrefKqEunZoQlGSgsH7SRAtDanCWHsfRCjHHtOtKVO0dzTBWsqBhLqoiUnND
         g1bbCFYBubq3qrvwpePTLkUXNxKfwgH6n5G2vuXzmGqnhIdKGEU+Uwx6VbUDnoCWmhKo
         +UtMhoCneu7Ckwi5tFMPXjPa1wJeWz3OSCtts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QW11r5q6Bg0Diz1e3STl/bTUqTG5FwObT6qJ10+8XmriMo0pDNA/O51mtEaiKyYrOC
         Cf2ok3p1R9qmzaY9W0l3FHR91XDgP6g2Ef3vc01z6zdhnw8dclLhaLj0e2fuTp9DFUqj
         24bth/swYLu3ssFr4gflApV0WgchDOhj2BAzE=
Received: by 10.227.156.143 with SMTP id x15mr157851wbw.39.1283456457650;
        Thu, 02 Sep 2010 12:40:57 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.40.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:40:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155161>

This series continues where "gettextize the first 4 C mainporcelain
common commands" left off and translates all the C mainporcelain
common commands (the only non-C ones left are bisect/pull/rebase).

With this Git is up to 482 translatable messages.

=46or reviewing all the patches that say "basic messages" were (mostly)
converted by an automated script and should be really
straightforward. Most of these are just plain die/error/printf calls
with a single message.

See further comments on individual patches below. Most comment only
apply to the patch immediately above them.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (25):
  gettextize: git-commit basic messages
  gettextize: git-commit formatting messages

The message you get in the editor with git add . && git-commit

  gettextize: git-commit advice messages

An example of N_() and _() usage.

  gettextize: git-diff basic messages
  gettextize: git-fetch basic messages
  gettextize: git-fetch formatting messages

The status output you get on "git fetch" where it's telling you what
changed.

  gettextize: git-grep basic messages
  gettextize: git-log basic messages

This is more than just git-log actually, e.g. git-show too.

  gettextize: git-format-patch --cover-letter message

I think this should be made translatable.

  gettextize: git-merge basic messages

This need careful review. In many cases git-merge is writing out to
some .git/* file and I *don't* want to translate that, but it could
use a second set of eyes to see if I missed something.

  gettextize: git-merge "In-index merge" message
  gettextize: git-merge "Merge made by %s." message
  gettextize: git-merge remaining cmd_merge messages

These I reviewed carefully and they should be trivial.

  gettextize: git-mv basic messages
  gettextize: git-mv "bad" messages
  gettextize: git-rm basic messages

ditto, these should all be fine.

  builtin: use builtin.h in git-reset

as before, this is not needed if "builtin: use builtin.h for all
builtin/ commands" is applied. But it's here for convenience. If the
previously submitted builtin.h patch is applied this can be dropped.

  gettextize: git-reset basic messages
  gettextize: git-reset reset_type_names messages

Another N_() and _() patch.

  gettextize: git-tag basic messages
  gettextize: git-tag tag_template message

Another N_() and _() patch.

  gettextize: git-push basic messages
  builtin: use builtin.h in git-status

This is *not* in my previously submitted "builtin: use builtin.h for
all builtin/ commands" patch.

  gettextize: git-status basic messages

An old resurrected patch ...

  gettextize: git-status shortstatus messages

=2E.. but wt-status changed since then, so this was needed too.

 builtin/commit.c |  156 +++++++++++++++++++++++++++-------------------=
--------
 builtin/diff.c   |   20 ++++----
 builtin/fetch.c  |   74 +++++++++++++-------------
 builtin/grep.c   |   34 ++++++------
 builtin/log.c    |   76 +++++++++++++-------------
 builtin/merge.c  |  136 +++++++++++++++++++++++-----------------------
 builtin/mv.c     |   32 ++++++------
 builtin/push.c   |   42 +++++++-------
 builtin/reset.c  |   44 ++++++++--------
 builtin/rm.c     |   22 ++++----
 builtin/tag.c    |   66 +++++++++++-----------
 wt-status.c      |  115 ++++++++++++++++++++--------------------
 12 files changed, 409 insertions(+), 408 deletions(-)

--=20
1.7.2.2.614.g1dc9
