From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 3 Jun 2005 07:31:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506030728120.1876@ppc970.osdl.org>
References: <20050602185046.GA3717@lsrfire.ath.cx>
 <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org> <429FEBD5.5040306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 16:28:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeD7a-0001io-8A
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 16:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFCO3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Jun 2005 10:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVFCO3K
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 10:29:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:47796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVFCO3A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 10:29:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53ESvjA028440
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 07:28:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53ESubw025875;
	Fri, 3 Jun 2005 07:28:56 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <429FEBD5.5040306@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, Rene Scharfe wrote:
>=20
> What version of tar do you use?=20

	torvalds@ppc970:~> tar --version
	tar (GNU tar) 1.13.25
	Copyright =A9 2001 Free Software Foundation, Inc.
	This program comes with NO WARRANTY, to the extent permitted by law.
	You may redistribute it under the terms of the GNU General Public Lice=
nse;
	see the file named COPYING for details.
	Written by John Gilmore and Jay Fenlason.

> Also, can you please send me the output
> the following?
>=20
>    cd t; sh t5000-tar-tree.sh; cd trash; tar tvf b.tar

I get

	?rw------- git/git          52 1969-12-31 16:00:00 pax_global_header u=
nknown file type `g'
	drwxr-xr-x git/git           0 2005-05-27 15:00:00 a/
	-rw-r--r-- git/git          18 2005-05-27 15:00:00 a/1.......10.......=
=2E20........30........40......481.......10........20........30........=
40........50
	?rw------- git/git         111 2005-05-27 15:00:00 37e07bc886b166ad252=
5f1cc7a2df9bda0e07a02.paxheader unknown file type `x'
	-rw-r--r-- git/git          18 2005-05-27 15:00:00 37e07bc886b166ad252=
5f1cc7a2df9bda0e07a02.data
	?rw------- git/git         112 2005-05-27 15:00:00 f72c8a14fa272506e5d=
e2d779cfe088769158b61.paxheader unknown file type `x'
	-rw-r--r-- git/git          18 2005-05-27 15:00:00 f72c8a14fa272506e5d=
e2d779cfe088769158b61.data
	?rw------- git/git         113 2005-05-27 15:00:00 b53ac87f1a63ea1a2ee=
c65cc8b5bed9130b8c114.paxheader unknown file type `x'
	-rw-r--r-- git/git          18 2005-05-27 15:00:00 b53ac87f1a63ea1a2ee=
c65cc8b5bed9130b8c114.data
	-rw-r--r-- git/git          16 2005-05-27 15:00:00 a/a
	drwxr-xr-x git/git           0 2005-05-27 15:00:00 a/bin/
	-rwxr-xr-x git/git      719924 2005-05-27 15:00:00 a/bin/sh
	tar: Unexpected EOF in archive
	tar: Error is not recoverable: exiting now

which doesn't tell me anything, except I assume it means that my tar=20
doesn't understand extended headers.

		Linus
