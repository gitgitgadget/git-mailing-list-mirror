From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 12:40:24 +0300
Message-ID: <20070308124024.d20e29c9.vsu@altlinux.ru>
References: <20070308041618.GA29744@spearce.org>
	<81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
	<20070308083317.GB30289@spearce.org>
	<7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
	<20070308091313.GC30289@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__8_Mar_2007_12_40_24_+0300_klXvXWLTBVJSE4M0"
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPF7x-0006B6-QQ
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbXCHJlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbXCHJlb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:41:31 -0500
Received: from master.altlinux.org ([62.118.250.235]:4264 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449AbXCHJla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:41:30 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id EBB64E34CC; Thu,  8 Mar 2007 12:41:28 +0300 (MSK)
In-Reply-To: <20070308091313.GC30289@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41725>

--Signature=_Thu__8_Mar_2007_12_40_24_+0300_klXvXWLTBVJSE4M0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 8 Mar 2007 04:13:13 -0500 Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
[...]
> > But this is only true if you want to make it really nice.  I
> > personally feel that nobody would scream if pushing 1300 refs at
> > once (4K pages and MAX_ARG_PAGES at 32 would give 128K for
> > **argv and its strings, and one ref's worth of data is two
> > 40-digit hex plus refname, roughly 100-byte per ref) is not
> > supported and always failed.
>
> Agree completely.  I'm not too worried about it.  1300 ref push is
> just not going to really occur in practice; that is just insane.
> 30 refs, maybe.

It is not completely insane - e.g., the current klibc repository
already contains 338 tags.  Being unable to use "git push --tags" to
an initially empty repository does not look good.

So could you please switch to passing refs through stdin while we
still can do it without breaking public interfaces?

--Signature=_Thu__8_Mar_2007_12_40_24_+0300_klXvXWLTBVJSE4M0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFF79oLW82GfkQfsqIRAkPoAJsG84rOUndtUyjXBSd9dq6rOhMuHgCePfLI
Bj032jrYII737dH2XAyffSU=
=wli1
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Mar_2007_12_40_24_+0300_klXvXWLTBVJSE4M0--
