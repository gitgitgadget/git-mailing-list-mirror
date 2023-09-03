Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999AC71153
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 12:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjICMSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjICMSR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 08:18:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A6116
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693743481; x=1694348281; i=johannes.schindelin@gmx.de;
 bh=hxcz4qkT8bULPsJuXCtq5RkYUoe2fjsnlDmuK9m3jCg=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=gkr+00Ffbp0JuihC7gs4f6QNzfkN6GZnGIL/pqNu1e5ZjDcTWlKTLzey5+KPjiCdo/Yssj3
 7UK7M6BSenJEUcUrmH7jHnh3KlFP5/ux0/pAsaZvzXSnaQyuwGrNy025roMYChckMmnp/PM+U
 vpvzXCKkIhTBzvRYxrDw9diRSCr7pPrPcbE935E1NkTpFekZ8tqIHdUUj6Tw1bwoNeKOwZCLA
 9C7T4Ok0MnyH1ePkM/d6kearBA0RMCf6MRne0sHUK0A+P6svjL8WUIQEUhd+Ws+XgQn4BD1sV
 SnRwl+wmxEjjMsbzCPt1C4eSNzUsHiKK0ZTY2Vtzzakt8JH3SSWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1q9VFH1V8Q-00YfNt; Sun, 03
 Sep 2023 14:18:01 +0200
Date:   Sun, 3 Sep 2023 14:17:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] range-diff: treat notes like `log`
In-Reply-To: <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name>
Message-ID: <94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de>
References: <cover.1686505920.git.code@khaugsbakk.name> <cover.1693584310.git.code@khaugsbakk.name> <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1308764035-1693743481=:134"
X-Provags-ID: V03:K1:AraBt+b8h4PWPtNoGWEqt1ddWNqxcsJ/FkMVcdzMGOueyUQJL4B
 BjaVY+Pglj7Cf3f22GSm63kDZ3aKANUpB1LpDGjP74mVKh3pDK4LbUdHr/lh7Tk/KlAMBty
 I4WLHa+LVJtBWwlRo+SWaQ6q8TnW3YowwZ67kmuy6Fl/7OIJ9Bine5Kj/wTRbFiSsNgG3uu
 xSJadRsMl/tOifwduy6dg==
UI-OutboundReport: notjunk:1;M01:P0:3d6QY/0Bsvs=;ssAJ7Ng7tdxJTTc1AXe5xXPcgyS
 UI7c1haEy3ZQn16gz2WUCGyT/vuMz+nkxqb06tryQrymkH6V54v8LVrGh9aNUJkpgPtyrOzQy
 I4td1NJtw0gk46JeR6eAlUaCEp2QupP4nN4t3yAQD+ttVvK3mikEnrZ1stniFoe5RJKpR9xNl
 O2UiQ1VhM2PBAZXAPldi8DAno9HCXNzhIojVCKRBHx3/0zTAyrKzV3zixLjZ+cQgjsAgA317l
 FQTxGG9RHabp8ol9yuRjbV/hyIFs0LuJo2QnvQXsUIEXayLeLsbRAWa/ZyFnwYRfMrZw1+G8A
 THevOkNd5s4w/vhOp1C432PMabULYcK+vs3Mu9Orzm6eQeD/n/rvILVuWIS52U6jXxAnrKUrU
 ubmyP7dB/ZIQq5jSbEHYWCkK9Fs0hIw7f+XgAIU8EeEZO147llj2h6/jZSIjtngmQmi33wsYK
 h/7TMSuIY3PE5u3thYXYKQwkHcuEaR6SHNc/KCWPR70ybu7BlVqUj6huWwT3z9yu7PyeUlH5+
 n2zV4KSbH16ZHoV1qrYT7wDHX45woMjb/kQ3GsJQEkIPMlxp4hQb/bHRr+xxp/dHv11jLneAi
 Er2uRi+o+sHlokrrzmum3kR1Vzngxt7BR8wgTAr3+Vjnp5zsO5fs/WySYj09g+cwmi+50Ff5U
 HawO6rk6Des2FnIf5NHRD7y6TPlBwbmfgAYQVH5qsL/Lj37epK/H8gx07mByUq0xEoOOXUx3R
 EVmyIw2bIa7AayzGlHtTdvgbFf9Gu9ANTlL7obynW+SYCxIxAxzpLVwZrfDI1OZ6LBqsEbc9W
 G9ePovCAIWDA8qTnX6k1n5wiw8OiCJTCLNb/EjfTu7E+93XZEu9bsyS2mRq5mzbLHJC7deo1z
 h7svsYT36/KNiR27CCKjq89msBLvcnd2dDbHohIDZn0jL/MjIg6Wxn9GZtC58owLC4PfJ+FwD
 e2Y6qIEqMnT4m3sehoY5NR4R3Zs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1308764035-1693743481=:134
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Fri, 1 Sep 2023, Kristoffer Haugsbakk wrote:

> Currently, `range-diff` shows the default notes if no notes-related
> arguments are given. This is also how `log` behaves. But unlike
> `range-diff`, `log` does *not* show the default notes if
> `--notes=3D<custom>` are given. In other words, this:
>
>     git log --notes=3Dcustom
>
> is equivalent to this:
>
>     git log --no-notes --notes=3Dcustom
>
> While:
>
>     git range-diff --notes=3Dcustom
>
> acts like this:
>
>     git log --notes --notes-custom
>
> This can=E2=80=99t be how the user expects `range-diff` to behave given =
that the
> man page for `range diff` under `--[no-]notes[=3D<ref>]` says:
>
> > This flag is passed to the git log program (see git-log(1)) that
> > generates the patches.
>
> This behavior also affects `format-patch` since it uses `range-diff` for
> the cover letter. Unlike `log`, though, `format-patch` is not supposed
> to show the default notes if no notes-related arguments are given.[1]
> But this promise is broken when the range-diff happens to have something
> to say about the changes to the default notes, since that will be shown
> in the cover letter.

Very well explained.

The root cause for this is 8cf51561d1e (range-diff: fix a crash in parsing
git-log output, 2020-04-15) which added the `--notes` argument in
`read_patches()`' call. The commit message explains why this is needed:
the (necessary) `--pretty=3Dmedium` would turn off the notes, therefore
`--notes` had to be added to reinstate the original behavior (except, as
you pointed out, in the case `--notes=3D<ref>` was specified).

> Remedy this by co-opting the `--standard-notes` option which has been
> deprecated since ab18b2c0df[2] and which is currently only documented in
> `pretty-options`.

This sounds a bit less desirable, though, than passing the `--notes`
argument only as needed. This patch (on top of `notes-range-diff` in your
fork) lets the new test still pass while leaving `--standard-notes`
deprecated:

=2D- snipsnap --
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-optio=
ns.txt
index 8c982609c99..dc685be363a 100644
=2D-- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -88,6 +88,7 @@ being displayed. Examples: "--notes=3Dfoo" will show onl=
y notes from
 	from "refs/notes/bar".

 --show-notes[=3D<ref>]::
+--[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
 endif::git-rev-list[]
diff --git a/range-diff.c b/range-diff.c
index f070e4a4ceb..fbb81a92cc0 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -41,12 +41,20 @@ static int read_patches(const char *range, struct stri=
ng_list *list,
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	struct strbuf buf =3D STRBUF_INIT, contents =3D STRBUF_INIT;
 	struct patch_util *util =3D NULL;
-	int in_header =3D 1;
+	int i, implicit_notes_arg =3D 1, in_header =3D 1;
 	char *line, *current_filename =3D NULL;
 	ssize_t len;
 	size_t size;
 	int ret =3D -1;

+	for (i =3D 0; other_arg && i < other_arg->nr; i++)
+		if (!strcmp(other_arg->v[i], "--notes") ||
+		    starts_with(other_arg->v[i], "--notes=3D") ||
+		    !strcmp(other_arg->v[i], "--no-notes")) {
+			implicit_notes_arg =3D 0;
+			break;
+		}
+
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=3Dno",
 		     "--no-prefix", "--submodule=3Dshort",
@@ -60,8 +68,9 @@ static int read_patches(const char *range, struct string=
_list *list,
 		     "--output-indicator-context=3D#",
 		     "--no-abbrev-commit",
 		     "--pretty=3Dmedium",
-		     "--standard-notes",
 		     NULL);
+	if (implicit_notes_arg)
+		     strvec_push(&cp.args, "--notes");
 	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
diff --git a/revision.c b/revision.c
index 44a04004a70..2f4c53ea207 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2495,13 +2495,9 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 		disable_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given =3D 1;
 	} else if (!strcmp(arg, "--standard-notes")) {
-		disable_display_notes(&revs->notes_opt, &revs->show_notes);
-		revs->show_notes_given =3D 0;
-		enable_default_display_notes(&revs->notes_opt,
-					     &revs->show_notes);
-		revs->notes_opt.use_default_notes =3D -1;
+		revs->show_notes_given =3D 1;
+		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
-		/* Deprecated */
 		revs->notes_opt.use_default_notes =3D 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header =3D 1;

--8323328-1308764035-1693743481=:134--
