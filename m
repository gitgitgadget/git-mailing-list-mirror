From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 11:30:40 -0400
Message-ID: <20070416153040.GG27533@thunk.org>
References: <E1HdQDl-0005ia-Bn@candygram.thunk.org> <8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTAM-00015K-27
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030757AbXDPPat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Apr 2007 11:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbXDPPat
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:30:49 -0400
Received: from thunk.org ([69.25.196.29]:49149 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030757AbXDPPat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 11:30:49 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdTGc-00082i-Td; Mon, 16 Apr 2007 11:37:23 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdTA8-0001UZ-5D; Mon, 16 Apr 2007 11:30:40 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44651>

On Mon, Apr 16, 2007 at 03:13:25PM +0200, Santi B=E9jar wrote:
> On 4/16/07, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> >When I push a kernel repository to master.kernel.org, where the
> >repository only has at most a dozen changes on top of 2.6.21-rc7, I
> >noticed that it tried to push a *lot* of objects over ssh.  As in:
>=20
> This is because git only trusts the the commits in $GIT_DIR/refs.
> Since commit v1.5.1-107-ge3c6f24 (in next) git-fetch first checks if
> we have all the objects that we are going to fetch available locally.
> This could be added for the push. But for now you could add a branch
> in your repo in master.kernel.org to track linus' master branch.

Thanks for the explanation! =20

So if I add a symlink from .git/refs/heads/kludge to
<linus'-tree-on-master>/.git/refs/heads/master this should work as a
workaround now, right?

						- Ted
