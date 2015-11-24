From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: deal with object name vs. pathname
 ambiguity in tree-filter
Date: Tue, 24 Nov 2015 18:38:13 -0500
Message-ID: <20151124233813.GC13872@sigill.intra.peff.net>
References: <1448281396-5049-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1NAA-0001Ip-SV
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbbKXXiQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 18:38:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:33567 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753504AbbKXXiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:38:15 -0500
Received: (qmail 30697 invoked by uid 102); 24 Nov 2015 23:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:38:15 -0600
Received: (qmail 20054 invoked by uid 107); 24 Nov 2015 23:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 18:38:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 18:38:13 -0500
Content-Disposition: inline
In-Reply-To: <1448281396-5049-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281652>

On Mon, Nov 23, 2015 at 01:23:16PM +0100, SZEDER G=C3=A1bor wrote:

> 'git filter-branch' fails complaining about an ambiguous argument, if
> a tree-filter renames a path and the new pathname happens to match an
> existing object name.
>=20
> After the tree-filter has been applied, 'git filter-branch' looks for
> changed paths by running:
>=20
>   git diff-index -r --name-only --ignore-submodules $commit
>=20
> which then, because of the lack of disambiguating double-dash, can't
> decide whether to treat '$commit' as revision or path and errors out.
>=20
> Add that disambiguating double-dash after 'git diff-index's revision
> argument to make sure that '$commit' is interpreted as a revision.

Thanks, looks obviously correct.

-Peff
