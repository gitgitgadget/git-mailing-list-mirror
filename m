From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 13:55:50 -0500
Message-ID: <43CE8F36.3090100@michonline.com>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com> <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A7D521B9F523FA424BB8F19"
Cc: Petr Baudis <pasky@suse.cz>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:56:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzITd-00030H-I9
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWARS4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWARS4I
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:56:08 -0500
Received: from mail.autoweb.net ([198.172.237.26]:44188 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1030351AbWARS4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 13:56:07 -0500
Received: from 10-37-1-127.reverse.internal.autoweb.net ([10.37.1.127])
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EzITM-0003dA-QO; Wed, 18 Jan 2006 13:55:58 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14857>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A7D521B9F523FA424BB8F19
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Wed, 18 Jan 2006, Ryan Anderson wrote:
> 
>>Assuming both repositories are clean, no extraneous files, and without
>>testing, of course:
>>
>>In r1:
>>	mkdir r1
>>	# move everything into the subdirectory called r1.
>>	git mv $(ls -a | grep -v -e ^.git$ -e ^r1$) r1/
>>	git commit -a "Restructure directory"
>>
>>In r2:
>>	mkdir r2
>>	# move all files into r2/
>>	git mv $(ls -a | grep -v -e ^.git$ -e ^r2$) r2/
>>	git commit -a "Restructure directory"
>>
>>	git fetch ../r1/
>>	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
>>	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
>>	git-update-cache --add -- $(GIT_INDEX_FILE=.git/tmp-index git-ls-files)
>>	cp .git/FETCH_HEAD .git/MERGE_HEAD
>>	git commit
>>
>>No history rewritten,
> 
> 
> Right.
> 
> 
>>merging with the old repositories should, at least theoretically, work, 
>>etc.
> 
> 
> No. This - and the history rewriting - both have a fundamental problem: it 
> becomes totally impossible to merge back any changes of the subprojects, 
> at least automatically. The renaming just ends up making pretty much any 
> merge a manual affair (git can _help_, but it's going to be a matter of 
> luck if it works or not - and it usually won't work very well, because 
> you'll probably end up having files that have the same name in the new and 
> the old repo, and eventually you'll just have tons of confusion).

What I meant was that an old repository can continue to be developed in,
and, in theory, the recursive merge should be able to merge those
changes into this new, joined, repository.



--------------enig2A7D521B9F523FA424BB8F19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzo85fhVDhkBuUKURAm1cAKDYpLhGO4ydfg7FcNL6eazQCXLNLQCfWFes
4NloTMCKBhRwURFlRuMG3BQ=
=S5LF
-----END PGP SIGNATURE-----

--------------enig2A7D521B9F523FA424BB8F19--
