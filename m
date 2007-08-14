From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 16:19:43 +0200
Message-ID: <1187101183.12828.191.camel@chaos>
References: <1187080681.12828.174.camel@chaos>
	 <20070814093357.GA14010@diana.vm.bytemark.co.uk>
	 <1187086600.12828.177.camel@chaos>
	 <20070814105056.GA14536@diana.vm.bytemark.co.uk>
	 <1187089619.12828.183.camel@chaos>
	 <20070814111828.GA15399@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKxFQ-0004Gm-AJ
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbXHNOTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 10:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756254AbXHNOTq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:19:46 -0400
Received: from www.osadl.org ([213.239.205.134]:57158 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756250AbXHNOTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:19:45 -0400
Received: from [127.0.0.1] (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id B3B9665C3EA;
	Tue, 14 Aug 2007 16:19:43 +0200 (CEST)
In-Reply-To: <20070814111828.GA15399@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55834>

On Tue, 2007-08-14 at 13:18 +0200, Karl Hasselstr=C3=B6m wrote:
> On 2007-08-14 13:06:59 +0200, Thomas Gleixner wrote:
>=20
> > On Tue, 2007-08-14 at 12:50 +0200, Karl Hasselstr=C3=B6m wrote:
> >
> > > The result is exactly the same. git-mv is just a convenience.
> >
> > Fair enough, but it still does not solve my initial problem of
> > keeping the history of B (former A) intact, while creating a new A
> > which is necessary to compile the tree, simply because I can not
> > change #include <A> to #include <B> for various reasons.
>=20
> Have you tried running blame with -C, or -C -C? That will make it try
> harder to identify lines originating from other files.

Does not help. Strange enough it results in

# git blame include/B

b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  1) #ifnd=
ef _A_H_
b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  2) #defi=
ne _A_H_
b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  3)=20
b4062b16 include/A (Joe Hacker      2007-08-14 10:52:28 +0200  4) #defi=
ne TEST_1 1
f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  5) #defi=
ne TEST_2 2
f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  6)=20
f098c4ad include/B (Thomas Gleixner 2007-08-14 16:01:05 +0200  7) #endi=
f

	tglx
