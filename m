From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Mon, 23 Mar 2009 23:14:48 -0400
Message-ID: <20090324031448.GA12829@coredump.intra.peff.net>
References: <20090323195304.GC26678@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 04:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llx7u-0000Ez-28
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 04:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbZCXDO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 23:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbZCXDO5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 23:14:57 -0400
Received: from peff.net ([208.65.91.99]:48931 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755513AbZCXDO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 23:14:57 -0400
Received: (qmail 26032 invoked by uid 107); 24 Mar 2009 03:15:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 23:15:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 23:14:48 -0400
Content-Disposition: inline
In-Reply-To: <20090323195304.GC26678@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114398>

On Mon, Mar 23, 2009 at 08:53:05PM +0100, Heiko Voigt wrote:

> The described issues are compiled from the tests by Michael Haggerty =
and me.
> Because it is not apparent that these can be fixed anytime soon at le=
ast warn
> unwary users not to rely on the inbuilt cvsimport to much.

I think this change is good in concept.

> +[[issues]]
> +ISSUES
> +------
> +Problems related to timestamps:
> +
> + * If timestamps of commits in the cvs repository are not stable eno=
ugh
> +   to be used for ordering commits
> + * If any files were ever "cvs import"ed more than once (e.g., impor=
t of
> +   more than one vendor release)
> + * If the timestamp order of different files cross the revision orde=
r
> +   within the commit matching time window

Reading this, I kept waiting for the "then" to your "if". I think the
implication is "your import will be incorrect". But it would be nice to
say _how_, even if it's something as simple as "changes may show up in
the wrong commit, the wrong branch, be omitted" or whatever. Just give =
a
general idea of what can happen.

Also, this renders somewhat poorly in the manpage version. I get:

<quote>
ISSUES
       Problems related to timestamps:


       =C2=B7   If timestamps of commits in the cvs repository are not =
stable
           enough to be used for ordering commits

       =C2=B7   If any files were ever "cvs import"ed more than once (e=
=2Eg., import
           of more than one vendor release)

       =C2=B7   If the timestamp order of different files cross the rev=
ision order
           within the commit matching time window
       Problems related to branches:


       =C2=B7   Branches on which no commits have been made are not imp=
orted
</quote>

Note the extra blank line between each heading and its list, and the
lack of a blank line between the end of the first list and the heading
of the second. Your source is very readable, so it really is just
asciidoc being silly, but I wonder if there is a way to work around
that.

-Peff
