From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 1/2] config: add '--names-only' option to list only
 variable names
Date: Mon, 10 Aug 2015 09:41:24 -0400
Message-ID: <20150810134124.GA6763@sigill.intra.peff.net>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
 <1439199967-9655-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOnKY-00055T-0x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 15:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbbHJNla convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 09:41:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:42990 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751946AbbHJNl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 09:41:29 -0400
Received: (qmail 12341 invoked by uid 102); 10 Aug 2015 13:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:41:29 -0500
Received: (qmail 5464 invoked by uid 107); 10 Aug 2015 13:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 09:41:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 09:41:24 -0400
Content-Disposition: inline
In-Reply-To: <1439199967-9655-2-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275618>

On Mon, Aug 10, 2015 at 11:46:06AM +0200, SZEDER G=C3=A1bor wrote:

> 'git config' can only show values or name-value pairs, so if a shell
> script needs the names of set config variables it has to run 'git con=
fig
> --list' or '--get-regexp' and parse the output to separate config
> variable names from their values.  However, such a parsing can't cope
> with multi-line values.  Though 'git config' can produce null-termina=
ted
> output for newline-safe parsing, that's of no use in such a case, bec=
ase
> shells can't cope with null characters.
>=20
> Even our own bash completion script suffers from these issues.
>=20
> Help the completion script, and shell scripts in general, by introduc=
ing
> the '--names-only' option to modify the output of '--list' and
> '--get-regexp' to list only the names of config variables, so they do=
n't
> have to perform error-prone post processing to separate variable name=
s
> from their values anymore.

Nice. The whole thing looks very neatly done. I have only one minor nit=
:
the option "--names-only" is _almost_ the same as the "--name-only" dif=
f
option which is somewhat similar. Obviously they do different things an=
d
do not need to match, but I wonder if it would create less annoyance to
just give them the same name.

-Peff
