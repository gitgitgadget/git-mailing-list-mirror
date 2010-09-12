From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] Command names should not be translated.
Date: Sun, 12 Sep 2010 22:51:54 +0000
Message-ID: <AANLkTinN_fDAVVuT1ygCe7gMpHqAhL4GGjrZ98igbbP3@mail.gmail.com>
References: <20100912202105.DA51D2FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Sep 13 00:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuvPD-0003ly-LV
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0ILWvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 18:51:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53392 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0ILWvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 18:51:55 -0400
Received: by iwn5 with SMTP id 5so4498915iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vJc7tN6Udkxpv97DrEEaAtsQzMM+S04w2W6h0ucWTqU=;
        b=OkzP7vtHlfxphTSwp47HISfapj3VNMLuHya9P0fXjMMumb8xwob/7pzB8oCWZpoUSu
         OpUuMyggU+f8XeWLlr4PQeyYClV1NUnNk8msSRteFa0trWPHTYocgf94mUXQZXdZ1nh7
         qeS5WNlw8PetPjx2f+UcSMpk9zZDA7Hu/Qs/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=reZhFZngBx36s8vCgV7SAo95MG5KjvHPtp1/GCbQ4CndyyrwHB8t1Ho0ACm+jP8u7w
         37OkSrVbsplvvQ30mxWjsJM27iAj176nuBqfzVyenpNY7iH8KhLhQ8t10FijbTQ7Kvpf
         FcqxpCrGdNHloY5AR4P57/NT6Dt3owbG2Movw=
Received: by 10.231.192.80 with SMTP id dp16mr5102461ibb.39.1284331914341;
 Sun, 12 Sep 2010 15:51:54 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 12 Sep 2010 15:51:54 -0700 (PDT)
In-Reply-To: <20100912202105.DA51D2FC00@perkele>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156063>

On Sun, Sep 12, 2010 at 20:09, Peter Krefting <peter@softwolves.pp.se> =
wrote:

=46irst off, thanks for contributing to this.

> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("list"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("list");
> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("add"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("add");
> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("copy"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("copy");
> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("show"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("show");
> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("remove"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("remove");
> - =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check(N_("prune"));
> + =C2=A0 =C2=A0 =C2=A0 t =3D init_notes_check("prune");

I disagree with all those. These don't end up being used in a context l=
ike:

    die("git-%s: error ...", command);

But:

    die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
        _(subcommand), t->ref);

I.e. here the git notes command name should be translated as a verb in
the native language (or not, that's up to the translator). E.g. I'd
translate that as:

    add: Neita a=C3=B0 b=C3=A6ta vi=C3=B0
    copy: Neita a=C3=B0 afrita

etc. into Icelandic. Other languages will probably also want to
translate that.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0prune_notes(t, (verbose ? NOTES_PRUNE_VERB=
OSE : 0) |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(show_only ? N=
OTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
> diff --git a/wt-status.c b/wt-status.c
> index f6946e1..7d4719f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -663,9 +663,9 @@ void wt_status_print(struct wt_status *s)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wt_status_prin=
t_submodule_summary(s, 1); =C2=A0/* unstaged */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->show_untracked_files) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wt_status_print_ot=
her(s, &s->untracked, _("Untracked"), _("add"));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wt_status_print_ot=
her(s, &s->untracked, _("Untracked"), "add");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s->show_ig=
nored_files)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f")=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (s->commitable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(s->fp,=
 _("# Untracked files not listed%s\n"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0advice_status_hints

These however are good, because here it gets used as:

    color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to
include in what will be committed)"), how);

I.e. this is purely a hardcoded command name.
