From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v13 4/8] bisect: introduce support for --no-checkout option.
Date: Tue, 2 Aug 2011 14:16:05 +0200
Message-ID: <CAP8UFD0kB+dS4cP=4MXKShhMw3-f_uKjtOmYKahNM0uQQkojsQ@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 14:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDtY-0008J4-VZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 14:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab1HBMQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 08:16:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43542 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1HBMQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 08:16:06 -0400
Received: by gyh3 with SMTP id 3so4006810gyh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n1dQ9DqpREhfA/k4lmStPS2r+qxD0r6mO+zeK7m1yOM=;
        b=M3C072Tf15wtSRZIGgRM6o53qKusWjILuT1ZGb0S5ShiZ+nsekFbV1kjH/gTnOOz08
         MvWlnhmJF6eI3sx129EffTA6FM+6eIPLJ4DBF6mS98774X5OAtntZSgSgMP9pwiZv7QZ
         IHXtizsVmiU6bCBoH5FyejYmLin00rl5AjqNo=
Received: by 10.236.185.132 with SMTP id u4mr4476077yhm.224.1312287365519;
 Tue, 02 Aug 2011 05:16:05 -0700 (PDT)
Received: by 10.147.35.16 with HTTP; Tue, 2 Aug 2011 05:16:05 -0700 (PDT)
In-Reply-To: <1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178463>

On Tue, Aug 2, 2011 at 1:29 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> If --no-checkout is specified, then the bisection process uses:

Yeah, but in this patch you are changing "git bisect--helper" by
adding the [--bisect-mode=3Dcheckout|update-ref] option. So it is
strange that you still talk about a --no-checkout option.

> =A0 =A0 =A0 =A0git update-ref --no-deref HEAD <trial>
>
> at each trial instead of:
>
> =A0 =A0 =A0 =A0git checkout <trial>

[...]

> =A0int cmd_bisect__helper(int argc, const char **argv, const char *pr=
efix)
> =A0{
> =A0 =A0 =A0 =A0int next_all =3D 0;
> + =A0 =A0 =A0 int no_checkout =3D 0;
> + =A0 =A0 =A0 char *bisect_mode=3DNULL;
> =A0 =A0 =A0 =A0struct option options[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_BOOLEAN(0, "next-all", &next_all,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"perform 'git =
bisect next'"),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPT_STRING(0, "bisect-mode", &bisect_mo=
de, "mode",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "the bisection =
mode either checkout or update-ref. defaults to checkout."),

Nit: I would say : "bisection mode: 'checkout' (default) or 'update-ref=
'"

Thanks,
Christian.
