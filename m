From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Thu, 3 Dec 2009 06:31:46 +0100
Message-ID: <20091203053146.GA23215@atjola.homenet>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
 <20091202192028.6117@nanako3.lavabit.com>
 <20091202190807.GB30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 06:31:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG4IG-0007An-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 06:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbZLCFbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2009 00:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZLCFbo
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 00:31:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:42363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955AbZLCFbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 00:31:44 -0500
Received: (qmail invoked by alias); 03 Dec 2009 05:31:49 -0000
Received: from i59F55C39.versanet.de (EHLO atjola.homenet) [89.245.92.57]
  by mail.gmx.net (mp059) with SMTP; 03 Dec 2009 06:31:49 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/tQVItqHXtFTNpsexnTUU9Ntt7c5Ml7LjBWiC3HR
	y02NJDJ23O1SyF
Content-Disposition: inline
In-Reply-To: <20091202190807.GB30778@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134436>

On 2009.12.02 14:08:07 -0500, Jeff King wrote:
> And for convenience of the user, you would want a way to avoid repeat=
ing
> the name of the "I want to check this out" branch. So either:
>=20
>   1. Add "--track foo" as a convenience wrapper for "-f foo -b foo".

Hm, we already have --track for "remote add", and that supports being
supplied multiple times, so I guess for clone, that should work too. Bu=
t
if track implies -b, having multiple --track seems rather weird. Which
branch head would be created? One for the first --track? Or the last
one? Or one for each? So I'd rather not make --track imply -b.

>   2. If no "-b" is given, the first "-f" is assumed as "-b". So "git
>      clone -f foo" becomes equivalent to David's --track.

Won't work if the first one is -f refs/heads/subst/*:refs/remotes/origi=
n/*

> And of course the name "-f" (for --fetch, if you were wondering) is o=
pen
> to suggestion.
>=20
> What do you think?

I'd prefer to see just --track for consistency with "remote add". That
could even learn to use globs, but allowing to specify the right side o=
f
the refspec seems wrong given the option name, so it would be more
limited than your -f option.

Bj=F6rn
