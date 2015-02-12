From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Thu, 12 Feb 2015 19:18:07 +0000
Message-ID: <20150212191807.GA30062@dcvr.yhbt.net>
References: <CABNxngNDwf_Cy77OzvMg__kCNoTz5y1a2KKG1vobYjE_m_aLkQ@mail.gmail.com>
 <20150129233429.GA7162@dcvr.yhbt.net>
 <CABNxngPErFiTzUNK6P90Ug5fVtJSYD9XrGrQzK8+mt2u4g=Xyg@mail.gmail.com>
 <20150130002247.GA22519@dcvr.yhbt.net>
 <CABNxngMVsaSLmzf0ZsaXZqXhD+hOaRmz-uuSzm0ALDFhKjnrXA@mail.gmail.com>
 <20150130013017.GA10713@dcvr.yhbt.net>
 <CAK6Z60cGnvPP0ctnyV4tHfMmBGYRidEJzkAG+J2h9BunmtOAsQ@mail.gmail.com>
 <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>,
	git@vger.kernel.org, Minty <mintywalker@gmail.com>,
	Mike <ipso@snappymail.ca>, Junio C Hamano <gitster@pobox.com>
To: Valery Yundin <yuvalery@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzHC-0005Ak-NR
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbbBLTSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 14:18:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41424 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbbBLTSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:18:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA35C633842;
	Thu, 12 Feb 2015 19:18:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABNxngNH20O52QHSivQLvRFSW2hqnVTYuBv0CWn1L53cL+XoGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263752>

Valery Yundin <yuvalery@gmail.com> wrote:
> On 31 January 2015 at 13:51, Nico Schl=C3=B6mer <nico.schloemer@gmail=
=2Ecom> wrote:
> > I tried the patch and I still get
> > ```
> > [...]
> > r100 =3D e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git=
-svn)
> > Unexpected result returned from git cat-file at
> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 335.
> > Failed to read object 619f9d1d857fb287d06a70c9dac6b8b534d0de6a at
> > /home/nschloe/share/perl/5.18.2/Git/SVN/Fetcher.pm line 336, <GEN16=
>
> > line 757.
> >
> > error closing pipe: Bad file descriptor at
> > /home/nschloe/libexec/git-core/git-svn line 0.
> > error closing pipe: Bad file descriptor at
> > /home/nschloe/libexec/git-core/git-svn line 0.
> > ```
> > when
> > ```
> > git svn clone https://geuz.org/svn/gmsh/trunk
>=20
> It seems that the same commit dfa72fdb96 is responsible for the error
> in "git svn clone https://geuz.org/svn/gmsh/trunk". But unlike in my
> case, the patch doesn't fix it.

(top-posting corrected)

Odd, I managed to clone that without issues, but I couldn't reproduce
this problem with or without the tempfile clearing patch applied.

   git svn clone --username gmsh https://geuz.org/svn/gmsh/trunk

Anybody else?
