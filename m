From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 12:16:40 +0200
Message-ID: <1187086600.12828.177.camel@chaos>
References: <1187080681.12828.174.camel@chaos>
	 <20070814093357.GA14010@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 12:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKtSJ-0000Pm-Er
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 12:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166AbXHNKQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 06:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758910AbXHNKQr
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 06:16:47 -0400
Received: from www.osadl.org ([213.239.205.134]:38115 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759150AbXHNKQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 06:16:45 -0400
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 1581265C3EA;
	Tue, 14 Aug 2007 12:16:40 +0200 (CEST)
In-Reply-To: <20070814093357.GA14010@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55823>

On Tue, 2007-08-14 at 11:33 +0200, Karl Hasselstr=C3=B6m wrote:
> On 2007-08-14 10:38:01 +0200, Thomas Gleixner wrote:
>=20
> > is there a built in way to handle the following situation:
> >
> > file A is renamed to B
> > file A is created again and new content is added.
> >
> > I found only two ways to do that, which both suck:
> >
> > 1)
> >       git-mv A B
> >       git-add A
> >       git commit
> >
> >       results in a copy A to B and lost history of B
>=20
> What exactly do you mean by "lost history of B"? You do know that git
> doesn't record renames? So you could just as well do

Err.

git-mv A B
git commit
edit B
git commit
git blame B <- shows the full history of A & B

IMHO that's why we have git-mv

	tglx
