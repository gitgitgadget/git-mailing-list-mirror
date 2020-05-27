Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9646C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFC32088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CrfMFblV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgE0SXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 14:23:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:60629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387699AbgE0SXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 14:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590603789;
        bh=E/Q+Px0CZKkBkf/JjoClCaeuM9g0rBLUMS/c3RwmW2c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CrfMFblVeYzaD/3a2GqU3YZu5UpXCWkjoufL/rywuaNd5emgLBURtqLFA3MXfbYXY
         AAnZAyTxAuaHqamD4yEKcz55XBlg53Jiuq7Ye4g3Oo2aKcdRzgmDzUmmO5Cv1b7Pod
         vl6QLdFssIXzjPE/Td/0lmsFv4rPOfM/Fg2wKr0c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.52]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1ijaSo1sb9-00v5VH; Wed, 27
 May 2020 20:23:09 +0200
Date:   Wed, 27 May 2020 03:49:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Merlin_B=C3=BCge?= <toni@bluenox07.de>,
        git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
In-Reply-To: <20200527075648.GA4006373@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2005270348240.56@tvgsbejvaqbjf.bet>
References: <20200525221100.31d36d4d.toni@bluenox07.de> <20200527075648.GA4006373@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-626452366-1590544167=:56"
X-Provags-ID: V03:K1:ht+NkUSPCtlTopVL/1YBkXotKW5MyP0528nEu/6lcT2oGG4GEtc
 3ECBcI537UGoL5IeLdaorYllbdoaodwAb2Y0FkjqMsdoZGfu+z30ODCQUwHH+hXvra99G8S
 pzeN/SYtVBvGyVgfWCcHtnfUdsxI3lNw1EEY8oAJJE301kM504ZNZ8ENhFqtlLL0ULAzz5S
 JrYD3UrD4a6/dTny4jPYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Ynuj2F3jTg=:M0u6j/0gJlYemFf9+3s7JD
 E9mzdWkUPTjsJWitiKLx0I2cmlt5vzXNAKsqmpAT0/Y0Wpkx8OoRCEJivUF4j8rEPxLGgOije
 7C8wCoiGGA7/2fldy/54Bzx04odp3nrpFhiwyYTehTudxDjcN1fIQLcwWLLOgvD870FXokg8c
 V5OU96lmVM+NZqjVXjmKCiI9zCFNHFfPXhd5phxkKKKcwP41MH4qRFFKOxl4Z6FXTCrVkDaVb
 /KwnmQeP66feSAvWj4JJEaz4tXdo/UmBmqtQrocKxJZbsDlyhhOD8Xfps6dv51GTOduiE1lJ2
 vh80NtTC2dwhy3XP/D8K8Qp9wBmKNe+tlBg+ceR0LszH27dbpHpa8H1lPGdmMmUtj3MaKxSG7
 C/8MT3z0P07U9XO8KgmUVLJtd+3Vul5LuQZnGc8GdNI5FEOSqs0X5dYDbdTAcbNIjHfaruCyI
 34K8WvCspsz2Idc3hCkpBPGnt8k4cySZQtfaXHo5zxAaeHnZPHdO5/bwPj0BhtipYF8OzbEac
 QInR3VZBISNALRACa1x8eRmmXP2qDIW4+amOxc7FQ4VeGSXSc1lnh2yiDtgP7EOggCUq5VSkX
 Bdoq5wEKoewNJu+XPsOGk9AAGvXnpTxSEpE2LQUVd5UWRKjlftmu9M7DKuaLdP7gUcQ+nJhYz
 LmjndO753mn7fFQ0oqLS8JiZwIPcb/ufunyAzbOQ0HRl82SIWk3YrahaVN+Ja4UqjkS/cXnUw
 TH6q5uinbKl3FJReepHEELQXVTMXdQIRi+XoZfkYmEJflGgDyTsoeN8FPA1atRDKm6sKDgx+T
 DcObXao7+iFEpDlfs6E3zuGs5Ki/1FgprVfUy6h4dk8SxMJWYUEN5K3s0S3kB7dmvSbS8UHR5
 IICgzAO8YDuCyXT+ZeAN4OK8TwyDLXQmrKQIzLZKh9cVuzVlnR5WrY96HyoPQOwvh1q8HkN12
 GhVLUaYHXzfxpwUXZfYyxoTJPnn0hSqZ7/CrKV+iPikeyFyLWvJ6VtTmxOK12GMwvlQ4HD14i
 P3o3cr4KyAGHsFVg090gKG5JUORfg9TkznZlpElhaWj0rWq98RbDKceeBsMpaYsWv/51dabR9
 5NB5wT8lgFkxJ8iMeCzlWdks0R1HI83sXfcPYU3mLY/CgiMIEKdqBs6V1JyEkCDorbLk9xfAa
 NvK/frZ6VcZKSheApLikaVGFlsaw/12HzkUEEvjO2PC2NHdToo6EPd842X9/Nxv7PMoSzijMi
 NnNHF6PGG/kb6cB/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-626452366-1590544167=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff & Merlin,

On Wed, 27 May 2020, Jeff King wrote:

> On Mon, May 25, 2020 at 10:11:00PM +0200, Merlin B=C3=BCge wrote:
>
> > This works like expected, I end up with a 1:1 copy of the original
> > worktree, including empty files. However, if I include the -p option i=
n
> > the last step:
> >
> > 	git checkout -p master .
> >
> > ... I correctly get asked for any non-empty files/hunks if I want to
> > apply them - but not for empty ones. It would just display e.g.
> >
> > 	diff --git b/emptyfile a/emptyfile
> > 	new file mode 100644
> > 	index 0000000..e69de29
> >
> > and then skip over it, asking for the next non-empty hunk.
> >
> > Why does it skip over empty hunks?
>
> I think this case was just never anticipated, and it's a bug. The
> original patch-selection code was written for "add -p", and the
> fundamental unit it works on is a hunk. We hacked around that to handle
> deletions back in 24ab81ae4d (add-interactive: handle deletion of empty
> files, 2009-10-27). But "add -p" would never see a new file, since we
> only consider the set of tracked files in the index.
>
> However, when it was extended for "checkout -p", etc, we could see new
> files. I guess the right fix is something along these lines, extending
> the deletion concept to new files:
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index c4b75bcb7f..9c8844434e 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -768,7 +768,7 @@ sub parse_diff_header {
>  	for (my $i =3D 0; $i < @{$src->{TEXT}}; $i++) {
>  		my $dest =3D
>  		   $src->{TEXT}->[$i] =3D~ /^(old|new) mode (\d+)$/ ? $mode :
> -		   $src->{TEXT}->[$i] =3D~ /^deleted file/ ? $deletion :
> +		   $src->{TEXT}->[$i] =3D~ /^(deleted|new) file/ ? $deletion :
>  		   $head;
>  		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
>  		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
>
> which does do the right thing. But:
>
>   - all of this is in the process of being rewritten in C, so it should
>     probably go into add-interactive.c (it's not yet the default to use
>     the C version, but it probably will be soon).
>
>   - that still says "Apply deletion..." in the UI. We'd need to update
>     the messages to differentiate the two cases.

The C version (with "Apply addition"... in the UI) would look somewhat
like this:

=2D- snipsnap --
diff --git a/add-patch.c b/add-patch.c
index d8bfe379be4d..c0d8bf2df0c5 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -10,7 +10,7 @@
 #include "prompt.h"

 enum prompt_mode_type {
-	PROMPT_MODE_CHANGE =3D 0, PROMPT_DELETION, PROMPT_HUNK,
+	PROMPT_MODE_CHANGE =3D 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
 	PROMPT_MODE_MAX, /* must be last */
 };

@@ -33,6 +33,7 @@ static struct patch_mode patch_mode_add =3D {
 	.prompt_mode =3D {
 		N_("Stage mode change [y,n,q,a,d%s,?]? "),
 		N_("Stage deletion [y,n,q,a,d%s,?]? "),
+		N_("Stage addition [y,n,q,a,d%s,?]? "),
 		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -54,6 +55,7 @@ static struct patch_mode patch_mode_stash =3D {
 	.prompt_mode =3D {
 		N_("Stash mode change [y,n,q,a,d%s,?]? "),
 		N_("Stash deletion [y,n,q,a,d%s,?]? "),
+		N_("Stash addition [y,n,q,a,d%s,?]? "),
 		N_("Stash this hunk [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -77,6 +79,7 @@ static struct patch_mode patch_mode_reset_head =3D {
 	.prompt_mode =3D {
 		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
 		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
+		N_("Unstage addition [y,n,q,a,d%s,?]? "),
 		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -99,6 +102,7 @@ static struct patch_mode patch_mode_reset_nothead =3D {
 	.prompt_mode =3D {
 		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -121,6 +125,7 @@ static struct patch_mode patch_mode_checkout_index =3D=
 {
 	.prompt_mode =3D {
 		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -143,6 +148,7 @@ static struct patch_mode patch_mode_checkout_head =3D =
{
 	.prompt_mode =3D {
 		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -164,6 +170,7 @@ static struct patch_mode patch_mode_checkout_nothead =
=3D {
 	.prompt_mode =3D {
 		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -186,6 +193,7 @@ static struct patch_mode patch_mode_worktree_head =3D =
{
 	.prompt_mode =3D {
 		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -207,6 +215,7 @@ static struct patch_mode patch_mode_worktree_nothead =
=3D {
 	.prompt_mode =3D {
 		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
 		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint =3D N_("If the patch applies cleanly, the edited hunk "
@@ -248,7 +257,7 @@ struct add_p_state {
 		struct hunk head;
 		struct hunk *hunk;
 		size_t hunk_nr, hunk_alloc;
-		unsigned deleted:1, mode_change:1,binary:1;
+		unsigned deleted:1, added:1, mode_change:1,binary:1;
 	} *file_diff;
 	size_t file_diff_nr;

@@ -442,7 +451,7 @@ static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)
 	pend =3D p + plain->len;
 	while (p !=3D pend) {
 		char *eol =3D memchr(p, '\n', pend - p);
-		const char *deleted =3D NULL, *mode_change =3D NULL;
+		const char *deleted =3D NULL, *added =3D NULL, *mode_change =3D NULL;

 		if (!eol)
 			eol =3D pend;
@@ -465,7 +474,8 @@ static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)
 			; /* keep the rest of the file in a single "hunk" */
 		else if (starts_with(p, "@@ ") ||
 			 (hunk =3D=3D &file_diff->head &&
-			  skip_prefix(p, "deleted file", &deleted))) {
+			  (skip_prefix(p, "deleted file", &deleted) ||
+			   skip_prefix(p, "new file", &added)))) {
 			if (marker =3D=3D '-' || marker =3D=3D '+')
 				/*
 				 * Should not happen; previous hunk did not end
@@ -485,6 +495,8 @@ static int parse_diff(struct add_p_state *s, const str=
uct pathspec *ps)

 			if (deleted)
 				file_diff->deleted =3D 1;
+			else if (added)
+				file_diff->added =3D 1;
 			else if (parse_hunk_header(s, hunk) < 0)
 				return -1;

@@ -537,8 +549,10 @@ static int parse_diff(struct add_p_state *s, const st=
ruct pathspec *ps)
 			   starts_with(p, "Binary files "))
 			file_diff->binary =3D 1;

-		if (file_diff->deleted && file_diff->mode_change)
-			BUG("diff contains delete *and* a mode change?!?\n%.*s",
+		if (!!file_diff->deleted + !!file_diff->added +
+		    !!file_diff->mode_change > 1)
+			BUG("diff can only contain delete *or* add *or* a "
+			    "mode change?!?\n%.*s",
 			    (int)(eol - (plain->buf + file_diff->head.start)),
 			    plain->buf + file_diff->head.start);

@@ -1392,11 +1406,13 @@ static int patch_update_file(struct add_p_state *s=
,
 		if (hunk->splittable_into > 1)
 			strbuf_addstr(&s->buf, ",s");
 		if (hunk_index + 1 > file_diff->mode_change &&
-		    !file_diff->deleted)
+		    !file_diff->deleted && !file_diff->added)
 			strbuf_addstr(&s->buf, ",e");

 		if (file_diff->deleted)
 			prompt_mode_type =3D PROMPT_DELETION;
+		else if (file_diff->added)
+			prompt_mode_type =3D PROMPT_ADDITION;
 		else if (file_diff->mode_change && !hunk_index)
 			prompt_mode_type =3D PROMPT_MODE_CHANGE;
 		else

--8323328-626452366-1590544167=:56--
