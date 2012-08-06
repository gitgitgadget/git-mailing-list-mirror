From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: do not mention .git/refs/* directories
Date: Mon, 06 Aug 2012 14:04:06 -0700
Message-ID: <7vk3xbybp5.fsf_-_@alter.siamese.dyndns.org>
References: <CAHtLG6TDDmvtt1cc3_mGG9hZtSVp-ecNXzCQrPj6-e4DU6HMGA@mail.gmail.com>
 <CAHtLG6SQ3DeexriXRtV4ys7x12iKQtq7OCrZdC+A8SSH6Tokow@mail.gmail.com>
 <7vvch6t5in.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 23:05:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyUUf-0003kZ-V7
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904Ab2HFVE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 17:04:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756837Ab2HFVEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 17:04:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE23B766C;
	Mon,  6 Aug 2012 17:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TZHLliNbOQ45
	ki7v2wuqto+GfG0=; b=p0f8XUpUgQt/YPfh+u/TZkkMejYFeWzmEuUzKp+RyIb1
	0LN6HApMSftWS4uUpiQ/2IYi2EtMoX1jDFqtuYeQdBSEMJjN3QIeZsHwBUwvyMy9
	YDBiRvt1Xabo7dlbwlgRXRDyN5FkZIGCXt95jbRqyrCEV5/S/V7a2nLVBlXT0C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WbiFrn
	fT28HBgwnGYyTRS1uD0u5WUYNl8b5ugkqPnG2kE8kVePc/b/LJ5Ceje+azr542jE
	LwGftkP5XWHH5ls+P75ecAtIjuB1ggONvEd1kSaNVuMtCHe0GNevn1BNtM9i8/Gc
	pd0E4CtM64pBX3hgqPJ0VFE3fHOmaDemZgwl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB54E766B;
	Mon,  6 Aug 2012 17:04:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0AB3766A; Mon,  6 Aug 2012
 17:04:07 -0400 (EDT)
In-Reply-To: <7vvch6t5in.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 29 Jul 2012 18:13:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43251B54-E00A-11E1-8190-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202987>

It is an implementation detail that a new tag is created by adding a
file in the .git/refs/tags directory.  The only thing the user needs
to know is that a "git tag" creates a ref in the refs/tags namespace,
and without "-f", it does not overwrite an existing tag.

Inspired by a report from =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.c=
om>; I think I
caught all the existing mention in Documentation/ directory in the
tip of 1.7.9.X maintenance track, but we may have added new ones
since then.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-describe.txt      |  4 ++--
 Documentation/git-filter-branch.txt |  3 ++-
 Documentation/git-fsck.txt          |  4 ++--
 Documentation/git-lost-found.txt    |  3 ++-
 Documentation/git-pack-refs.txt     | 19 +++++++++++++++----
 Documentation/git-replace.txt       |  5 ++---
 Documentation/git-tag.txt           |  5 ++---
 7 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
index 039cce2..72d6bb6 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -36,12 +36,12 @@ OPTIONS
=20
 --all::
 	Instead of using only the annotated tags, use any ref
-	found in `.git/refs/`.  This option enables matching
+	found in `refs/` namespace.  This option enables matching
 	any known branch, remote-tracking branch, or lightweight tag.
=20
 --tags::
 	Instead of using only the annotated tags, use any tag
-	found in `.git/refs/tags`.  This option enables matching
+	found in `refs/tags` namespace.  This option enables matching
 	a lightweight (non-annotated) tag.
=20
 --contains::
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index 0f2f117..924a38c 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -32,7 +32,8 @@ changes, which would normally have no effect.  Nevert=
heless, this may be
 useful in the future for compensating for some git bugs or such,
 therefore such a usage is permitted.
=20
-*NOTE*: This command honors `.git/info/grafts` and `.git/refs/replace/=
`.
+*NOTE*: This command honors `.git/info/grafts` file and refs in
+the `refs/replace/` namespace.
 If you have any grafts or replacement refs defined, running this comma=
nd
 will make them permanent.
=20
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 6c47395..df9ea8d 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -23,8 +23,8 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, 'git fsck' defaults to using the
-index file, all SHA1 references in .git/refs/*, and all reflogs (unles=
s
---no-reflogs is given) as heads.
+index file, all SHA1 references in `refs` namespace, and all reflogs
+(unless --no-reflogs is given) as heads.
=20
 --unreachable::
 	Print out objects that exist but that aren't reachable from any
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-=
found.txt
index c406a11..d549328 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -48,7 +48,8 @@ $ gitk $(cd .git/lost-found/commit && echo ??*)
 ------------
=20
 After making sure you know which the object is the tag you are looking
-for, you can reconnect it to your regular .git/refs hierarchy.
+for, you can reconnect it to your regular `refs` hierarchy by using
+the `update-ref` command.
=20
 ------------
 $ git cat-file -t 1ef2b196
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-r=
efs.txt
index a3c6677..7664bd1 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
=20
 Traditionally, tips of branches and tags (collectively known as
-'refs') were stored one file per ref under `$GIT_DIR/refs`
+'refs') were stored one file per ref in a (sub)directory
+under `$GIT_DIR/refs`
 directory.  While many branch tips tend to be updated often,
 most tags and some branch tips are never updated.  When a
 repository has hundreds or thousands of tags, this
@@ -22,13 +23,14 @@ one-file-per-ref format both wastes storage and hur=
ts
 performance.
=20
 This command is used to solve the storage and performance
-problem by stashing the refs in a single file,
+problem by storing the refs in a single file,
 `$GIT_DIR/packed-refs`.  When a ref is missing from the
-traditional `$GIT_DIR/refs` hierarchy, it is looked up in this
+traditional `$GIT_DIR/refs` directory hierarchy, it is looked
+up in this
 file and used if found.
=20
 Subsequent updates to branches always create new files under
-`$GIT_DIR/refs` hierarchy.
+`$GIT_DIR/refs` directory hierarchy.
=20
 A recommended practice to deal with a repository with too many
 refs is to pack its refs with `--all --prune` once, and
@@ -57,6 +59,15 @@ a repository with many branches of historical intere=
sts.
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
=20
+
+BUGS
+----
+
+Older documentation written before the packed-refs mechanism was
+introduced may still say things like ".git/refs/heads/<branch> file
+exists" when it means "branch <branch> exists".
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.=
txt
index 17df525..51131d0 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -14,14 +14,13 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Adds a 'replace' reference in `.git/refs/replace/`
+Adds a 'replace' reference in `refs/replace/` namespace.
=20
 The name of the 'replace' reference is the SHA1 of the object that is
 replaced. The content of the 'replace' reference is the SHA1 of the
 replacement object.
=20
-Unless `-f` is given, the 'replace' reference must not yet exist in
-`.git/refs/replace/` directory.
+Unless `-f` is given, the 'replace' reference must not yet exist.
=20
 Replacement references will be used by default by all git commands
 except those doing reachability traversal (prune, pack transfer and
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 53ff5f6..f7abf0b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -18,11 +18,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
=20
-Add a tag reference in `.git/refs/tags/`, unless `-d/-l/-v` is given
+Add a tag reference in `refs/tags/`, unless `-d/-l/-v` is given
 to delete, list or verify tags.
=20
-Unless `-f` is given, the tag to be created must not yet exist in the
-`.git/refs/tags/` directory.
+Unless `-f` is given, the named tag must not yet exist.
=20
 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
--=20
1.7.12.rc1.78.g77644ce
