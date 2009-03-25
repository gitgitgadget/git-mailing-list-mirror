From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init-db: support --import to add all files and commit
	right after init
Date: Wed, 25 Mar 2009 00:19:35 -0400
Message-ID: <20090325041934.GA15524@coredump.intra.peff.net>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:21:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKcB-0005ch-GW
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZCYETq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 00:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZCYETq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:19:46 -0400
Received: from peff.net ([208.65.91.99]:45720 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbZCYETp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:19:45 -0400
Received: (qmail 2363 invoked by uid 107); 25 Mar 2009 04:19:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 00:19:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 00:19:35 -0400
Content-Disposition: inline
In-Reply-To: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114556>

On Wed, Mar 25, 2009 at 01:09:56PM +1100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is equivalent to "git init;git add .;git commit -q -m blah".
> I find myself doing that too many times, hence this shortcut.

I think I would find this handy. Shawn suggested an alias, but I think
this is perhaps "universal enough" to merit an actual command-line
option.

> +-m <message>::
> +--import=3D<message>::
> +
> +Commit everything to the newly initialized repository. This is equiv=
alent to:

Maybe this is being too lazy, but I think it would be useful to allow
just "--import" without a message to default to "Initial commit",
"initial import from `basename $PWD`", or something like that.

> +		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m")) {
> +			if (i+1 >=3D argc)
> +				die("--import requires an import message");
> +			import_message =3D argv[2];
> +			i++;
> +			argv++;
> +		}

I seem to recall that we were phasing out "--long-option <arg>" at some
point, and that all long-options should use "--long-option=3D". But may=
be
I am mis-remembering.

-Peff
