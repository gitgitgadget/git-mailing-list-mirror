Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32E522A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379846; cv=none; b=ZuaWgNil4mRKmhkrqyRAO9iZiywqqMJdjsI2v5ZIdBlk8ehrxbOUx8riJVu3TP2VjQ3tg39OUpE37W5HDqtCI/ufrKqNhkzouOqLXdYQnCoy2VEtIhvVbJSTNrxQDxzG0xjJz0hBsn/IJTaSbBpnk9cXit5eF2UygbuDNuZxa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379846; c=relaxed/simple;
	bh=HLONUmF58GyLN9BI1bnViDll7IxeiCde24pWewWct60=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXPgF7FsXQWrjJqQr9Y3scUdxzpzLJBrjIZxHEuFo7O9OVg5Qf0I7IBeYpK86J3zy3mZN8SrK6DdIRbBKk6MN2ugx1y4NhAUn95mfz1b7FJm6zH85S3QdtyLrpc7iwGl3w4sogZEP0nDZprMdooGwzJCJqUdaAbtvs3IFtBvrP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net; spf=pass smtp.mailfrom=mad-scientist.net; dkim=policy (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b=VArtwLR1 reason="signing key too small"; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="VArtwLR1"
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id tgyLstHB4iA19tuNesEY0E; Thu, 26 Sep 2024 19:42:26 +0000
Received: from box5922.bluehost.com ([162.241.30.80])
	by cmsmtp with ESMTPS
	id tuNdstgzZWdNZtuNdskphz; Thu, 26 Sep 2024 19:42:25 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=66f5b921
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=e_eVUG9BRDgA:10
 a=IyqtRJjmI1ZsupcrM6sA:9 a=QEXdDO2ut3YA:10 a=9XL2PSxQjqKr3s6xf5LH:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aiIWqm9tHavgLGkJ2+J+QNyO03yeBHA4WRSQb+Y0mzY=; b=VArtwLR1MXBYnj2QZOyqQWGI34
	1oOWXeldAj/IU+V+JC8eRHVrSU0X4WBBy3AhzRheibO18swDsRVoMDE6dV9216AoqVCoixbunbZ4u
	k81jjkFA7WhKATQ2CV09noIc2;
Received: from [160.231.220.149] (port=46811 helo=llin-psh13-dsa.dsone.3ds.com)
	by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <paul@mad-scientist.net>)
	id 1stuNd-002W4i-0Y
	for git@vger.kernel.org;
	Thu, 26 Sep 2024 13:42:25 -0600
Message-ID: <10debb75cf7d29bc7fb907feae544769f2f2e3be.camel@mad-scientist.net>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
From: Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To: "git@vger.kernel.org" <git@vger.kernel.org>
Date: Thu, 26 Sep 2024 15:42:24 -0400
In-Reply-To: <6e3ac135-8357-4d2d-a49b-de7f1ab4da95@gmail.com>
References: 
	<GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	 <xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
	 <xmqqwmj1t0hp.fsf@gitster.g>
	 <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>
	 <6e3ac135-8357-4d2d-a49b-de7f1ab4da95@gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.220.149
X-Source-L: No
X-Exim-ID: 1stuNd-002W4i-0Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.220.149]:46811
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBoACT8kCrowkNUDayJlcNGzHi7hUmDBgky76hpirmC0bOPtENB1dsweTNnWqhT7kkRwwuUEF5g3YgxH1Iw9eibgf1+Fg553L1U8Yt2NqPHQPvgfNAT9
 Kjl4/3ktjq7Ak+n/1opon4c8AB7rkUysfJ5Ev7MLggfLmCfuyuGg3xpP44ghh0K/Bdj3LTLvMmC8EC2d2CZWLml+THAHnt4VShI=

On Wed, 2024-09-25 at 21:35 -0400, Eli Schwartz wrote:
> On 9/25/24 11:33 AM, Paul Smith wrote:
> > On Tue, 2024-09-24 at 10:39 -0700, Junio C Hamano wrote:
> > > Our dependance of heavy use of GNU-ism in our Makefiles makes an
> > > argument that make is the common denominator a fairly weak one,
> > > so
> > > the single one that eventually we use does not have to be "make",
> > > but it has to be something available widely and easy to learn.
> >=20
> > Regardless of what one might imagine :), I am not advocating GNU
> > Make as the perfect solution: it certainly has downsides and
> > disadvantages.
>=20
> :)
>=20
> I've read your article about why people should use autoconf!
>=20
> (By the way: I had a bit of a... chuckle, when I read in your
> previous email that as the GNU maintainer of Make, you build lots of
> projects with Make or CMake, but not with GNU autoconf / automake. I
> assume that was just bad wording?)

This is actually part of my $DAYJOB, not as the maintainer of GNU Make.
It's not even part of my job there, but I like to have modern tools and
I hate to mandate certain distributions and distro releases for
everyone, so I build a complete toolchain including its own sysroot
that everyone checks out from a Git repo to build our product.

At my $DAYJOB we use CMake, actually, so I'm also very familiar with
it.

But when I said "make" previously I meant to encompass autoconf
projects.  You're right, it's not really precise to compare make to
cmake since cmake build makefiles as well.  It's more accurate to
compare it to autoconf.

So, I should have said "autoconf and cmake" :)

However there are also projects that use raw makefiles and no build
generator tools.


I certainly didn't mean to imply that requiring Python is a show-
stopper for Git.  There are lots of options depending on needs.  But it
can't be argued that it's not more work for the builder than using GNU
Make.

Maybe this is will be deemed not worth worrying about given the
alternatives, and I wouldn't argue with that.  I just raise it so it
can be given consideration before a decision is made to (for example)
drop support for makefiles.
