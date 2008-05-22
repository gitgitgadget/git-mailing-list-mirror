From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How can I figure out what commits relate to a given diff?
Date: Thu, 22 May 2008 17:48:59 +0200
Message-ID: <20080522154859.GM27724@genesis.frugalware.org>
References: <48358F7E.6030401@harris.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gyf8O/Ycz0PncjFg"
Cc: git@vger.kernel.org
To: "Steven A. Falco" <sfalco@harris.com>
X-From: git-owner@vger.kernel.org Thu May 22 17:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzD3b-0006O9-DH
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 17:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbYEVPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbYEVPtG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 11:49:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60419 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbYEVPtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 11:49:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2E6F1B24FB;
	Thu, 22 May 2008 17:49:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7430D4465E;
	Thu, 22 May 2008 17:35:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5AA941778001; Thu, 22 May 2008 17:48:59 +0200 (CEST)
Mail-Followup-To: "Steven A. Falco" <sfalco@harris.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <48358F7E.6030401@harris.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82635>


--gyf8O/Ycz0PncjFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2008 at 11:21:34AM -0400, "Steven A. Falco" <sfalco@harris.com> wrote:
> Is there a way to map a blob SHA1 to a commit?  In this example, I'd
> like to map 9ceadaa and ad31bc6 to their commits.  It seems easy to go
> the other way, seeing what is in a commit, but I've not been able to
> find a method for going "backwards" from a blob to a commit.

Something like:

for i in `git rev-list HEAD`
do
        git ls-tree -r $i|grep -q cb4e8ed && echo "$i contains cb4e8ed"
done

could do it for you.

I don't think there is a --contains for blobs, like git branch
--contains works for commits.

--gyf8O/Ycz0PncjFg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg1lesACgkQe81tAgORUJaFOQCgkMesfvzkrtcTGohlU1V98Mvm
ddkAn2v/Yl37jq+l4oStLhwGzkY6PTsU
=fUwh
-----END PGP SIGNATURE-----

--gyf8O/Ycz0PncjFg--
