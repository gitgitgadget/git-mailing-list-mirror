From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 22:44:35 +0100
Message-ID: <CACBZZX5Seh__OmAxGZUcSE6wwxyWa6HYTo_5m=y8SKnE4LoB=A@mail.gmail.com>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org> <4EF2D436.3080303@viscovery.net>
 <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 22:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdqRj-0000NZ-RE
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 22:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab1LVVo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Dec 2011 16:44:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58324 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab1LVVo6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 16:44:58 -0500
Received: by eaad14 with SMTP id d14so2320851eaa.19
        for <git@vger.kernel.org>; Thu, 22 Dec 2011 13:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ObSqsDW+HyQ0k8V+/8j/09IB3kCbcnCmP7ox91zsb6k=;
        b=MtQHWpK8Yu9jHCQrlOQVWfKWEnkHeCfvu3gTokW+AlIeJHcvP74P2pwvHDogln/Fxe
         GjWKpHxyRNsaCRfjp7OYMyGS4+Cw5Rcld4HYr7bcOIyoTB/TxMVRXQtQoLUATwydVKeG
         UXBCTQ8kH1HChuhBGfox97hgBbYgT+xdKWxdQ=
Received: by 10.204.145.86 with SMTP id c22mr3512665bkv.61.1324590297207; Thu,
 22 Dec 2011 13:44:57 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Thu, 22 Dec 2011 13:44:35 -0800 (PST)
In-Reply-To: <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187617>

On Thu, Dec 22, 2011 at 08:38, Junio C Hamano <gitster@pobox.com> wrote=
:

[Re-formatted for clarity]

> - =C2=A0 =C2=A0 =C2=A0 vreportf("hint: ", advice, params);
> + =C2=A0 =C2=A0 =C2=A0 vreportf("hint", advice, params);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreportf("fatal: "=
, err, params);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreportf("fatal", =
err, params);
> - =C2=A0 =C2=A0 =C2=A0 vwritef(child_err, "fatal: ", err, params);
> + =C2=A0 =C2=A0 =C2=A0 vwritef(child_err, "fatal", err, params);
> - =C2=A0 =C2=A0 =C2=A0 vreportf("usage: ", err, params);
> + =C2=A0 =C2=A0 =C2=A0 vreportf("usage", err, params);
> - =C2=A0 =C2=A0 =C2=A0 vreportf("fatal: ", err, params);
> + =C2=A0 =C2=A0 =C2=A0 vreportf("fatal", err, params);
> - =C2=A0 =C2=A0 =C2=A0 vreportf("error: ", err, params);
> + =C2=A0 =C2=A0 =C2=A0 vreportf("error", err, params);
> - =C2=A0 =C2=A0 =C2=A0 vreportf("warning: ", warn, params);
> + =C2=A0 =C2=A0 =C2=A0 vreportf("warning", warn, params);

If we do it like this these would have to have something like:

    vreportf(N_("warning"), warn, params);

=46ollowed by...:

> + =C2=A0 =C2=A0 =C2=A0 strbuf_vaddf(&buf, fmt, params);
> + =C2=A0 =C2=A0 =C2=A0 for (cp =3D buf.buf; *cp; cp =3D np) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 np =3D strchrnul(c=
p, '\n');
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TRANSLATOR=
S: the format is designed so that in RTL
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* languages =
you could reorder and put the "prefix" at
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the end in=
stead of the beginning of a line if you
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* wanted to.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addf(&line,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 _("%s: %.*s\n"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 prefix,

Changing this to _(prefix).

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (int)(np - cp), cp);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emit(&line, cb_dat=
a);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_reset(&line=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*np)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 np++;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
> + =C2=A0 =C2=A0 =C2=A0 strbuf_release(&line);

But ideally to make things clear to the translators it's better to
give them something like this to translate:

    error: %s
    message

Instead of just, as two separate things:

    error
    message

Because:

 1. We might use "error", "warning", "usage" etc. somewhere else, and
    unless we start using the msgctxt feature of gettext we can't
    distinguish between these.

 2. If you present them as two separate things the translator is
    likely to get the case wrong (e.g. translate "error" in the
    nominative case instead of say accusative).

But it's not a big deal, the patch looks good to me as-is with those
N_() and _() changes. Just something to keep in mind.

We can always fixed issues like the one I'm raising later as they crop =
up.
