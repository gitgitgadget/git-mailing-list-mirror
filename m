Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06151AAE0A
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187921; cv=none; b=ZrLQodfgUT5LGeMmvfU3uOeQe2eeDgTRz9/iF9WTdyWvDKRz79DcaSX1LmauuxWyJlxi1fj6N7bePeJrGr9VmPlWuwFZDVnN7PaUV/sY1zWGKH1GywTZO/Kg0ORbLxVwIpgacFVAqRY0MJXW6dizbaTB38XVyqC1HrYhmkUJhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187921; c=relaxed/simple;
	bh=dUYTViqA8lVeV3CbVogKkRkHS2wYfMy66NTkuSk6FLI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJBww0wI6UkeM0moY/2+hd5ODjAeNgXzQ3l1waAJaWqn4MkiOqWUQoQ8sFJ/7TnJfJmj66AX4TM6KWd9z+vazGxcFaeTPjSPvUMaX7Gy6ZY7NU4NZUsAfclVuJWvg+WNsVovo6huQOgYxMFbg2koZfUERZd6OM43zWtt5Hghi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net; spf=pass smtp.mailfrom=mad-scientist.net; dkim=policy (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b=3ETjbKIi reason="signing key too small"; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="3ETjbKIi"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id so95sQ3oKnNFGt6TXs5xnJ; Tue, 24 Sep 2024 14:25:11 +0000
Received: from box5922.bluehost.com ([162.241.30.80])
	by cmsmtp with ESMTPS
	id t6TVscTBvO7Crt6TVslp0M; Tue, 24 Sep 2024 14:25:09 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66f2cbc6
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=e_eVUG9BRDgA:10
 a=99DtE2x6uJ2bEV9HKhYA:9 a=QEXdDO2ut3YA:10 a=9XL2PSxQjqKr3s6xf5LH:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7gKQRH18C/aDFDunofexFQKSgXQ2MvHoHeyovrfndos=; b=3ETjbKIiTiEqP+v+5py26s0g51
	xZ1sURwrYiWeYwKX4uceH/bzFDlmRQXdJXyQ7IxrgRKBS6xljdTj6Ed2nYNZg6Nvw097iqNbaYr5y
	6PRZ+2YIyyva+aFQuX0TfZyW1;
Received: from [160.231.220.149] (port=12025 helo=llin-psh13-dsa.dsone.3ds.com)
	by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <paul@mad-scientist.net>)
	id 1st6TV-000c3s-09
	for git@vger.kernel.org;
	Tue, 24 Sep 2024 08:25:09 -0600
Message-ID: <1e0074769f43f5a1f4938e74015b8903642d6b03.camel@mad-scientist.net>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
From: Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To: "git@vger.kernel.org" <git@vger.kernel.org>
Date: Tue, 24 Sep 2024 10:25:07 -0400
In-Reply-To: <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
References: 
	<GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	 <xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
	 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
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
X-Exim-ID: 1st6TV-000c3s-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.220.149]:12025
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEzhT1S1lFF46Ixis/tE8ojYfeO9ff1FOtmmXHfkwHY+IFfDw3LSxSwfuk5f+iV4VsNj9kkNZPM0Q2R28NjbsWHGrVeZdN/Hm9iog44J1G3JT3ueAcV5
 eWperSs/g5E+fd8l4wImtQZKUpjxD7CJqZaOTUXtoVd8Gvcct02fy/H9m1pdHgn2dg1U9GIK5uPc5L73e3tr9SV0YNGyz07n4CQ=

On Tue, 2024-09-24 at 09:59 -0400, Eli Schwartz wrote:
> Still I would prefer meson over autotools any day of the week. I'd
> also prefer autotools over cmake, mind you.

Just to point out that relying on ever-more-esoteric build tools is a
recipe for frustration for those of us who want to build from source.=20
Yes, I know meson is somewhat popular and definitely has a following,
but in the grand scheme of things it's still rare to find projects
requiring it, especially at the base level of software.  I build a lot
of software and I have never once had to install it, for example.

I maintain a minimalist set of tools and libraries that we compile
locally from source so we can control the full toolchain.  Every time a
package we want to add requires some new, different build tool it's a
massive annoyance.  As of today everything builds with either make or
cmake (mainly for Windows support).

On the other hand, now that all the systems we use have "good enough"
native versions of Git we have stopped building it in our environment.
So in that sense it no longer matters to me directly :).
