From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git gc --prune consumes *lots* of memory with repos cloned
	with --reference
Date: Thu, 12 Feb 2009 19:59:25 +0100
Message-ID: <20090212185925.GC20552@atjola.homenet>
References: <cccedfc60902121032y17180739r2a049197323d3588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:01:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXgo1-00028X-7M
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 20:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbZBLS7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 13:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758282AbZBLS7d
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 13:59:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:35099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758238AbZBLS7c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 13:59:32 -0500
Received: (qmail invoked by alias); 12 Feb 2009 18:59:28 -0000
Received: from i577B878B.versanet.de (EHLO atjola.local) [87.123.135.139]
  by mail.gmx.net (mp052) with SMTP; 12 Feb 2009 19:59:28 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+uv+xCrzKuI2J54Rl/DOTgBDDxY6BQlFx1Y5QiT1
	gjfYeopweO8sl3
Content-Disposition: inline
In-Reply-To: <cccedfc60902121032y17180739r2a049197323d3588@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109637>

On 2009.02.12 12:32:13 -0600, Jon Nelson wrote:
> The situation:
>=20
> I cloned linux-2.6
> Then I cloned netdev-2.6 with --reference $PWD/linux-2.6
> Then I cloned net-2.6 with --reference $PWD/netdev-2.6
>=20
> The problem:
>=20
> git gc --prune on netdev-2.6 takes WAY more memory than git gc --prun=
e
> on linux-2.6
> git gc --prune on net-2.6 takes WAY WAY more memory. 1.5G and countin=
g.
>=20
> Why does git gc --prune take 1.5G? (git pack-objects is the actual
> memory-hungry process)

Probably an older git version? There was a bug that caused a memory lea=
k
with unreachable objects being forced to be loose objects. That was
fixed in 1.6.0.3

Bj=F6rn
