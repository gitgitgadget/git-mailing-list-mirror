From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 00:34:18 -0400
Message-ID: <20091019043418.GD7170@coredump.intra.peff.net>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
 <20091019000900.GV6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 06:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzjx1-0006Sj-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 06:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbZJSEeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 00:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZJSEeR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 00:34:17 -0400
Received: from peff.net ([208.65.91.99]:44212 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbZJSEeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 00:34:16 -0400
Received: (qmail 14375 invoked by uid 107); 19 Oct 2009 04:37:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 00:37:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 00:34:18 -0400
Content-Disposition: inline
In-Reply-To: <20091019000900.GV6115@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130648>

On Mon, Oct 19, 2009 at 02:09:00AM +0200, Miklos Vajna wrote:

> Add a quick overview about what is OK and what is not to cover all
> cases.
>=20
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> Signed-off-by: Jeff King <peff@peff.net>

Please be careful with sign-offs. While your patch text is an adaptatio=
n
of what I said, and while it is true that I personally would never say
anything on the list that was not free for use in git, I did not in fac=
t
do such a sign-off, which is what that line is supposed to be
documenting.

In this case, I think you probably just wanted to say "text from Jeff
King" or even "From: Jeff King <peff@peff.net>".

That being said,

  Signed-off-by: Jeff King <peff@peff.net>

:)

I still have a few comments, though.

> +The intent of this option is to pick and choose lines of the diff to
> +apply, or even to munge the lines. So it is safe to:
> ++
> +* remove lines with a "+" (don't stage the addition)
> +* munge any lines with a "+" (stage modified contents)

Do we want to use "munge" here? Maybe something a little more specific
like "modify the content of" is more appropriate for documentation.

> +* add lines with a "+" (stage an addition)
> +* convert lines with a " " to "-" (stage removal)
> +* convert lines with a "-" to " " (don't stage removal)

Is " " going to render in an obvious-to-read way? I checked the html
version and the manpage version in my terminal, and they looked OK, but
I would not be surprised if somebody has a font setup that makes it a
little hard to read.

> ++
> +It is a bad idea to:
> ++

Annoyingly, this renders for me as:

           =C2=B7   convert lines with a "-" to " " (don=E2=80=99t stag=
e removal)

               It is a bad idea to:

           =C2=B7   delete "-" lines

(the spacing of which will hopefully not be destroyed in transit). In
other words, the "+" list continuation makes the "it is a bad idea" tex=
t
part of the "good idea" list, instead of continuing the definition of
the "-e" option. I think we can fix it with an open block marker. I'll
see what I can do.

-Peff
