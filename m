Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E54EDE990
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 08:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjINI34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjINI3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 04:29:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CBCD8
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694680174; x=1695284974; i=johannes.schindelin@gmx.de;
 bh=bgvX+Y7SD7db29/MADoNi4SawVCD3hGrnFzyCB8+lSo=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=K/0kaXiVbVqiiphR9lnPykCzSemhYx7spiaEfk4cXn+1zGmhypRo29fNQGwoy/Mv4130JYyyIwS
 B0UEDsApCmkWZNnHash5O50HbbjEOyVZxwUMCehveSYyLlbre3fEGhG6r7tWwi/KVlPIzQPLN8pey
 KrKRVlMJBl9rC0vrxjpSGtmtJ69UZurg5WIWZCCxD/ROqU10gtzwuSvDUXkznHAgLufL8RBi3kfJk
 RlAMos06Id3rDZupPeUVC0MTXt+/he2a++kFjvBCgyGgf/+/JF63yX/gc1xzQDIpF4bfPag+hG2kP
 fh/UbdMUCyq2Jz58n8vhPwyFlq6aS4oezBPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.197.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1rXZSp2cHR-00rGAE; Thu, 14
 Sep 2023 10:29:34 +0200
Date:   Thu, 14 Sep 2023 10:29:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/1] range-diff: treat notes like `log`
In-Reply-To: <xmqqzg1strgx.fsf@gitster.g>
Message-ID: <dd2958c5-58bf-86dd-b666-9033259a8e1a@gmx.de>
References: <cover.1693584310.git.code@khaugsbakk.name> <cover.1694383247.git.code@khaugsbakk.name> <a37dfb3748e23b4f5081bc9a3c80a5c546101f1d.1694383248.git.code@khaugsbakk.name> <xmqqzg1strgx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-242712657-1694680174=:751"
X-Provags-ID: V03:K1:UQjoE6lZO1m8uNon0rjTm8Jl79aQbN+kEzFb86dAkAmVOp83bQT
 qZYAYtMjZ+jCMONHhGGvWVxV2mQzYdR+9vu2v+cE4KOy8NkAbeaKl83/VqmKtKV01P7ZqP0
 DyVUBidroOBfnMcq6495AtqX0oakfa7nforliBrMlqJ0IPWek3qZYldrGAXhGVnwVxYw2o3
 kt8t8O981N7OpCoG2jJXA==
UI-OutboundReport: notjunk:1;M01:P0:DCPzuDFebjY=;nFaUj81gXis8/zUmzcykJALM2Yn
 eSkfg71m63a8evXF6zXSvrRGt7nA5o5w6J41aMHglqfpWhiVySMFPzWrNWLNgcmNelnJO1x4y
 nG1ce2sikn9XLdWA6WDeF+Fs6FgzSvnAYJNnKzAFYe2vVOdaICBDaBOZ3ccwHhweuwX6qwx7Y
 EjrLWaA4XzWPXSfqt8GvkMzRQuZ3A67d1EP/up9ZfadQMgH05mPs7Qls4aHyP0+6Ashcj5FUl
 fzp0AN0+j2CIt5AReFL5GSVJ7lLjADG7UDiBORzjTkqAyG9Uu1vvGDmQfXTdjhySGW8GhQyOe
 2V2sVaHFCmMEN80p8UMRtnsy4bHb6vLlBGzIVhoSa7303doRioIgXhjALPtmpC35KCxDAOnXs
 vgIOXN1AdFF8biu8bczoGacVuBaN4UR3uMa4uxsOyc1qYUdfc9EV/Iaqjr+8c3NKVb4dI2jkl
 eg516TzmNtGJRZhVcZ98D4HvNwpY96YfXM2u5YkUrxTlVWEQ67R7JiW0jfCI2lDyJRmI7sSg7
 iMDRtPvb2IpOKCh54t1KAVQW8QarU+x4rUx9EvUUr1cvZFbLPqZKku7JOQ5ADnd8w13d7xwFh
 st+PC3T7RS/8N7Rbbk9tY0aaUedyPW6VZMLRxjd6YCDIeSHW525+cbr+SIf0gn8T/NgjE/7sd
 7rAxTBm4m3ryu+8CgDJJTqMIZYLHCRd/GjqFH4OF3U0DRiB2wHButUZn3iaTeB2TdE1lM8F5R
 QlzO/+XhisZHwkQ2Ete//a3TW/qtbOmTNqLHY7zxyNPkMEj63FHo+ojU5oXO8xDO+fSSZ45in
 muDwrEYxgoPP7gKknITY2BkuE9hRrTXdBodEOyyaWKeio6jRNDVRkPJNEf8YgGwMm+9pvH8io
 0MwuIyegx1fwxZ3Oqt+xxIRcNLd+RV3fbqwXdB3V7v//SAmEzY9GrFG3awwAGyl5HRveG5QG2
 qS5NzQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-242712657-1694680174=:751
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 11 Sep 2023, Junio C Hamano wrote:

> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
> >> To fix this explicitly set the output format of the internally execut=
ed
> >> `git log` with `--pretty=3Dmedium`. Because that cancels `--notes`, a=
dd
> >> explicitly `--notes` at the end.
> >
> > =C2=A7 Authors
> >
> > =E2=80=A2 Fix by Johannes
> > =E2=80=A2 Tests by Kristoffer
> >
> > =E2=80=A0 1: See e.g. 66b2ed09c2 (Fix "log" family not to be too agres=
sive about
> >     showing notes, 2010-01-20).
> >
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
>
> OK, Dscho, does this round look acceptable to you?
>
> It feels UGLY to iterate over args _without_ actually parsing them,
> at least to me.  Such a non-parsing look breaks at least in two ways
> over time. (1) a mechanism may be introduced laster, similar to
> "--", that allows other_arg->v[] array to mark "here is where the
> dashed options end".  Now the existing loop keeps reading to the end
> and finds "--notes" that is not a dashed option but is part of the
> normal command line arguments in "other arg".  (2) Among the dashed
> options passed in the other_arg->v[], there may be an option that
> takes a string value, and a value that happens to be "--notes" is
> mistaken as asking for "notes" (iow "git log -G --notes" is looking
> for commits with changes that contain "double dash followed by en oh
> tee ee es").
>
> I think "git range-diff -G --notes" (or "-S --notes") shows that
> this new non-parsing loop is already broken.  It looks for a change
> that has "--notes" correctly, but at the same time, triggers that
> "ah, we have an explicit --notes so drop the implicit_notes_arg
> flag" logic.

Right, `-G --notes` is a good argument to rethink this.

A much more surgical way to address the issue at hand might be this
(Kristoffer, what do you think? It's missing documentation for the
newly-introduced `--show-notes-by-default` option, but you get the idea):

=2D- snipsnap --
diff --git a/range-diff.c b/range-diff.c
index fbb81a92cc0..56f6870ff91 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -41,20 +41,12 @@ static int read_patches(const char *range, struct stri=
ng_list *list,
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	struct strbuf buf =3D STRBUF_INIT, contents =3D STRBUF_INIT;
 	struct patch_util *util =3D NULL;
-	int i, implicit_notes_arg =3D 1, in_header =3D 1;
+	int in_header =3D 1;
 	char *line, *current_filename =3D NULL;
 	ssize_t len;
 	size_t size;
 	int ret =3D -1;

-	for (i =3D 0; other_arg && i < other_arg->nr; i++)
-		if (!strcmp(other_arg->v[i], "--notes") ||
-		    starts_with(other_arg->v[i], "--notes=3D") ||
-		    !strcmp(other_arg->v[i], "--no-notes")) {
-			implicit_notes_arg =3D 0;
-			break;
-		}
-
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=3Dno",
 		     "--no-prefix", "--submodule=3Dshort",
@@ -68,9 +60,8 @@ static int read_patches(const char *range, struct string=
_list *list,
 		     "--output-indicator-context=3D#",
 		     "--no-abbrev-commit",
 		     "--pretty=3Dmedium",
+		     "--show-notes-by-default",
 		     NULL);
-	if (implicit_notes_arg)
-		     strvec_push(&cp.args, "--notes");
 	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
diff --git a/revision.c b/revision.c
index 2f4c53ea207..49d385257ac 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2484,6 +2484,8 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 		revs->break_bar =3D xstrdup(optarg);
 		revs->track_linear =3D 1;
 		revs->track_first_time =3D 1;
+	} else if (!strcmp(arg, "--show-notes-by-default")) {
+		revs->show_notes_by_default =3D 1;
 	} else if (skip_prefix(arg, "--show-notes=3D", &optarg) ||
 		   skip_prefix(arg, "--notes=3D", &optarg)) {
 		if (starts_with(arg, "--show-notes=3D") &&
@@ -3054,6 +3056,11 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, struct s
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log =3D revs->expand_tabs_in_log_default;

+	if (!revs->show_notes_given && revs->show_notes_by_default) {
+		enable_default_display_notes(&revs->notes_opt, &revs->show_notes);
+		revs->show_notes_given =3D 1;
+	}
+
 	return left;
 }

diff --git a/revision.h b/revision.h
index 82ab400139d..50091bbd13f 100644
=2D-- a/revision.h
+++ b/revision.h
@@ -253,6 +253,7 @@ struct rev_info {
 			shown_dashes:1,
 			show_merge:1,
 			show_notes_given:1,
+			show_notes_by_default:1,
 			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,

--8323328-242712657-1694680174=:751--
