From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 13:06:30 -0700
Message-ID: <7v4ngcv35l.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
 <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
 <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
 <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
 <51435D49.6040005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 15 21:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGauB-00068Q-8W
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 21:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab3COUGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 16:06:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab3COUGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 16:06:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE7EB3B9;
	Fri, 15 Mar 2013 16:06:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mbt4X4JTjByv
	aWw/hP12I08srUU=; b=ZWfKivwsJtH3oVbt9C0CXTtDQHg4yWsAmztFHidSobcB
	pR6CQ4tE+kn5RGJ3+JTv2Z0rZuF6O1yxEtzNTczEYbjxfVkncNnRgsEk8uQjj8+K
	JBfeJaSS5Nvz5p1bimfJmEgLfDsquHTnlVoeiZ9g2zBFkFliAHj33O7EmMuj7YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bX4Yis
	0Iw+koR3hxRj3Dgz0j0zyO9bCDstxa/dBue0rGcuv8wxkl9tlKjJnSk5mMAt7x08
	6MPuLLe9mcbwjU2Yamq1b/md70lBPgHB/oOKBrz4ozGUXangW0SJSGxIG4GOSuI0
	+68NbrsW4T01NzifWJM2q1bowqahtYVd8SKt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44461B3B8;
	Fri, 15 Mar 2013 16:06:34 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73FC1B3B4; Fri, 15 Mar 2013
 16:06:33 -0400 (EDT)
In-Reply-To: <51435D49.6040005@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 15 Mar 2013 18:41:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5779A14-8DAB-11E2-941A-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218259>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks, I like that much better than mine
> (and expere is probably a word not yet invented)

OK, then how about redoing Duy's patch like this on top?

I've moved the timing collection from the caller to callee, and I
think the result is more readable.  The message looked easier to see
with a leading blank line, so I added one.

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Wed, 13 Mar 2013 19:59:16 +0700
Subject: [PATCH] status: advise to consider use of -u when read_directo=
ry takes too long

Introduce advice.statusUoption to suggest considering use of -u to
strike different trade-off when it took more than 2 seconds to
enumerate untracked/ignored files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  4 ++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 t/t7060-wtstatus.sh      |  1 +
 t/t7508-status.sh        |  1 +
 t/t7512-status-help.sh   |  1 +
 wt-status.c              | 21 +++++++++++++++++++++
 wt-status.h              |  1 +
 8 files changed, 32 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1de857..a16eda5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -163,6 +163,10 @@ advice.*::
 		state in the output of linkgit:git-status[1] and in
 		the template shown when writing commit messages in
 		linkgit:git-commit[1].
+	statusUoption::
+		Advise to consider using the `-u` option to linkgit:git-status[1]
+		when the command takes more than 2 seconds to enumerate untracked
+		files.
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/advice.c b/advice.c
index edfbd4a..015011f 100644
--- a/advice.c
+++ b/advice.c
@@ -5,6 +5,7 @@ int advice_push_non_ff_current =3D 1;
 int advice_push_non_ff_default =3D 1;
 int advice_push_non_ff_matching =3D 1;
 int advice_status_hints =3D 1;
+int advice_status_u_option =3D 1;
 int advice_commit_before_merge =3D 1;
 int advice_resolve_conflict =3D 1;
 int advice_implicit_identity =3D 1;
@@ -19,6 +20,7 @@ static struct {
 	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "statushints", &advice_status_hints },
+	{ "statusuoption", &advice_status_u_option },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
diff --git a/advice.h b/advice.h
index f3cdbbf..e3e665d 100644
--- a/advice.h
+++ b/advice.h
@@ -8,6 +8,7 @@ extern int advice_push_non_ff_current;
 extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
 extern int advice_status_hints;
+extern int advice_status_u_option;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index f4f38a5..52ef06b 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -5,6 +5,7 @@ test_description=3D'basic work tree status reporting'
 . ./test-lib.sh
=20
 test_expect_success setup '
+	git config --global advice.statusuoption false &&
 	test_commit A &&
 	test_commit B oneside added &&
 	git checkout A^0 &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e313ef1..15e063a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -8,6 +8,7 @@ test_description=3D'git status'
 . ./test-lib.sh
=20
 test_expect_success 'status -h in broken repository' '
+	git config --global advice.statusuoption false &&
 	mkdir broken &&
 	test_when_finished "rm -fr broken" &&
 	(
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index b3f6eb9..2d53e03 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -14,6 +14,7 @@ test_description=3D'git status advices'
 set_fake_editor
=20
 test_expect_success 'prepare for conflicts' '
+	git config --global advice.statusuoption false &&
 	test_commit init main.txt init &&
 	git branch conflicts &&
 	test_commit on_master main.txt on_master &&
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..6e75468 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -496,9 +496,14 @@ static void wt_status_collect_untracked(struct wt_=
status *s)
 {
 	int i;
 	struct dir_struct dir;
+	struct timeval t_begin;
=20
 	if (!s->show_untracked_files)
 		return;
+
+	if (advice_status_u_option)
+		gettimeofday(&t_begin, NULL);
+
 	memset(&dir, 0, sizeof(dir));
 	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=3D
@@ -528,6 +533,14 @@ static void wt_status_collect_untracked(struct wt_=
status *s)
 	}
=20
 	free(dir.entries);
+
+	if (advice_status_u_option) {
+		struct timeval t_end;
+		gettimeofday(&t_end, NULL);
+		s->untracked_in_ms =3D
+			(uint64_t)t_end.tv_sec * 1000 + t_end.tv_usec / 1000 -
+			((uint64_t)t_begin.tv_sec * 1000 + t_begin.tv_usec / 1000);
+	}
 }
=20
 void wt_status_collect(struct wt_status *s)
@@ -1011,6 +1024,14 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add")=
;
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f")=
;
+		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
+			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				 _("It took %.2f seconds to enumerate untracked files."),
+				 s->untracked_in_ms / 1000.0);
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				 _("Consider the -u option for a possible speed-up?"));
+		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%=
s"),
 			advice_status_hints
diff --git a/wt-status.h b/wt-status.h
index 236b41f..09420d0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -69,6 +69,7 @@ struct wt_status {
 	struct string_list change;
 	struct string_list untracked;
 	struct string_list ignored;
+	uint32_t untracked_in_ms;
 };
=20
 struct wt_status_state {
--=20
1.8.2-279-g744670c
