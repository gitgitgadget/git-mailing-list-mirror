From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: simplify '--option=value' parsing
Date: Fri, 22 Apr 2016 14:37:03 -0400
Message-ID: <20160422183703.GA7595@sigill.intra.peff.net>
References: <1461339503-6854-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:37:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfxm-0003Nf-So
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbcDVShy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 14:37:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:54313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751172AbcDVShy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:37:54 -0400
Received: (qmail 18196 invoked by uid 102); 22 Apr 2016 18:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:37:05 -0400
Received: (qmail 8945 invoked by uid 107); 22 Apr 2016 18:37:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:37:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 14:37:03 -0400
Content-Disposition: inline
In-Reply-To: <1461339503-6854-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292240>

On Fri, Apr 22, 2016 at 05:38:23PM +0200, SZEDER G=C3=A1bor wrote:

> To get the 'value' from '--option=3Dvalue', test-lib.sh parses said
> option running 'expr' with a regexp.  This involves a subshell, an
> external process, and a lot of non-alphanumeric characters in the
> regexp.
>=20
> Use a much simpler shell parameter expansion instead to do the same.

Looks OK to me. I doubt the extra process is a killer (we only parse
options once per script), but the result is definitely more readable,
IMHO.

=46or some reason I had always assumed that complicated pattern matchin=
g
with "#" was non-POSIX, but I checked and it is definitely in there.

> ---
>  t/test-lib.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I count 5 cases in my copy of test-lib.sh. I think you are missing
"--run".

-Peff
