From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http_init: accept separate URL parameter
Date: Thu, 13 Oct 2011 10:06:40 +0800
Message-ID: <CALUzUxp-Qe05+VF_EDg3+iHBeqWcEfcSVp3fyV_fQjAUaCVjOA@mail.gmail.com>
References: <4E95FDC8.5030009@drmicha.warpmail.net>
	<20111012214316.GA4393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 04:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REAh4-0000WC-R7
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 04:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab1JMCGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 22:06:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56263 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab1JMCGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 22:06:41 -0400
Received: by bkbzt4 with SMTP id zt4so785637bkb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=te3zc3NUZkQJwJs4KlMnv7HVeIJnJ+G1LO/rEP2p1Wo=;
        b=KdDi7NXhOoAc01oBTNOlyfbuD4GX+ALl0BcbX0itXYnfSt8HlgZX59J3w1IaJ6F1jO
         gSoPe1fFHxcQDlUat+bgM6nZ68b6A2RbqBCrHK2CuKKtKQdLkkN72kBc70Fmoza3yY0H
         FilUr44Jqg51jAuN2zCaOOII3YipJqt2jf1Uo=
Received: by 10.223.62.19 with SMTP id v19mr2624820fah.27.1318471600354; Wed,
 12 Oct 2011 19:06:40 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Wed, 12 Oct 2011 19:06:40 -0700 (PDT)
In-Reply-To: <20111012214316.GA4393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183433>

On Thu, Oct 13, 2011 at 5:43 AM, Jeff King <peff@peff.net> wrote:
> The http_init function takes a "struct remote". Part of its
> initialization procedure is to look at the remote's url and
> grab some auth-related parameters. However, using the url
> included in the remote is:
>
> =A0- wrong; the remote-curl helper may have a separate,
> =A0 =A0unrelated URL (e.g., from remote.*.pushurl). Looking at
> =A0 =A0the remote's configured url is incorrect.
>
> =A0- incomplete; http-fetch doesn't have a remote, so passes
> =A0 =A0NULL. So http_init never gets to see the URL we are
> =A0 =A0actually going to use.
>
> =A0- cumbersome; http-push has a similar problem to
> =A0 =A0http-fetch, but actually builds a fake remote just to
> =A0 =A0pass in the URL.
>
> Instead, let's just add a separate URL parameter to
> http_init, and all three callsites can pass in the
> appropriate information.
>
> Signed-off-by: Jeff King <peff@peff.net>

This is excellent.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
