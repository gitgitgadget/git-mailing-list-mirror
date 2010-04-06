From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Tue, 6 Apr 2010 01:43:56 -0400
Message-ID: <20100406054356.GD3901@coredump.intra.peff.net>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
 <20100405055139.GA28730@coredump.intra.peff.net>
 <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 07:44:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1aI-0008N9-LN
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 07:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab0DFFoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 01:44:16 -0400
Received: from peff.net ([208.65.91.99]:37039 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0DFFoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 01:44:15 -0400
Received: (qmail 3206 invoked by uid 107); 6 Apr 2010 05:44:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 01:44:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 01:43:56 -0400
Content-Disposition: inline
In-Reply-To: <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144099>

On Mon, Apr 05, 2010 at 12:50:11PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Thanks for looking at the importer, that'll be very useful when fixin=
g
> it. But FWIW that `find` invocation isn't a bug. Perl doesn't have a =
"
> " input field separator so "my @files =3D `find . -type f`" does the
> right thing, unlike in the shell.

He calls `find $dir -type f`, without a quotemeta on $dir, which perl
will pass to the shell to interpret (and is actually a security issue i=
f
I can convince you to try importing my svn repository with directory ';
rm -rf /;').

> I'm sorry that I brought snerp-vortex into this at all. It wasn't the
> main motivation behind this patch, just the straw that broke the
> camel's back.

I don't in particular have a problem with --allow-empty-message for
casual use. Why anybody would want to use it when they could type the
much shorter -mnone, I don't know. But it is long enough that people
will have to think about using it, which means the people who do so wil=
l
probably really want it.

-Peff
