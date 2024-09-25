Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B6134BD
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278510; cv=none; b=WXnz3O+s7mDnc9JOFOw3E3dNIxL/0x9UPGjMGpyfQjIxb7NGCbQPHmsr1Hs7BZrj6j6hosNGUE9v+EbfO6Cp+PkXPriz13hmL5j1lY6oTsW9knRZ7VN07vdEUKsTgoh5AR/AYgKzRwJpCQS8G4C1UBlZH87znSI/+HTRYPmu/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278510; c=relaxed/simple;
	bh=GrrStAR3wimYYAC6aWlsiAxk/qMhdDejif5/xNSvbQE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUo/k4S0SBmUTlqA4v5J47fQOFrbg3zfyyDK9Ak5qxA1lbTKZsSyL2nTpZ2cl/InEvs53EusltSkUBoPKNFplBQ9Ev7PtxP/bvnT3dKkprQjhNtYwkaqO+PdUjLDXTd+uTtGoSM8uXH0B3MvnqdRKIaWie+lViTZjBwbMm1DHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net; spf=pass smtp.mailfrom=mad-scientist.net; dkim=policy (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b=vANCslum reason="signing key too small"; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="vANCslum"
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id tJlEs5rcYumtXtU1Ds377X; Wed, 25 Sep 2024 15:33:31 +0000
Received: from box5922.bluehost.com ([162.241.30.80])
	by cmsmtp with ESMTPS
	id tU1BssZwEjkEetU1CsPQ62; Wed, 25 Sep 2024 15:33:30 +0000
X-Authority-Analysis: v=2.4 cv=PeH5hDhd c=1 sm=1 tr=0 ts=66f42d4a
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=e_eVUG9BRDgA:10
 a=FuY0_K3rwPhGrrxOtU0A:9 a=QEXdDO2ut3YA:10 a=9XL2PSxQjqKr3s6xf5LH:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BcW6dOusXcvq8UpCmrU+SEdvgVz9HCSYKTUiS9xsm+Y=; b=vANCslum3Gd/Of+e56RI8fdjQI
	qD70GcAzo+Mx5dPIyI1EpyKtbLquACoq5jfQvvhvGJgw7GVnjkPFHmxebihQ3A4SjknOmCZgGpMH6
	wR0dlNna+Vo1xYOAaXPxVO2bs;
Received: from [160.231.28.5] (port=14290 helo=llin-psh13-dsa.dsone.3ds.com)
	by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <paul@mad-scientist.net>)
	id 1stU1B-003MSk-1Y
	for git@vger.kernel.org;
	Wed, 25 Sep 2024 09:33:29 -0600
Message-ID: <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
From: Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To: "git@vger.kernel.org" <git@vger.kernel.org>
Date: Wed, 25 Sep 2024 11:33:28 -0400
In-Reply-To: <xmqqwmj1t0hp.fsf@gitster.g>
References: 
	<GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	 <xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
	 <xmqqwmj1t0hp.fsf@gitster.g>
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
X-Source-IP: 160.231.28.5
X-Source-L: No
X-Exim-ID: 1stU1B-003MSk-1Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.28.5]:14290
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFq7QLJRSd/peLpVkASu6PphFa91pp+ISdJC8tU9r8lLyhf0MVePY4HGXfOrLCN3h8RUqmp8sblPoSA/Feqpva8aDxi7XW1B8lIt9Y5+J57IqfiPteQ9
 9pWNCQFynGyudtoQjy9FrvU4TPtUJfT6dG0VdzVGzJcbcCELIkoTtjoBI9ku6yRJKsUeNL4ZMQhENtSzzlwd5S5kzxDAcmn//5w=

On Tue, 2024-09-24 at 10:39 -0700, Junio C Hamano wrote:
> Our dependance of heavy use of GNU-ism in our Makefiles makes an
> argument that make is the common denominator a fairly weak one, so
> the single one that eventually we use does not have to be "make",
> but it has to be something available widely and easy to learn.

Regardless of what one might imagine :), I am not advocating GNU Make
as the perfect solution: it certainly has downsides and disadvantages.

But, it also has benefits that should not be ignored: for example, it's
highly portable and it consists of a single binary that can be copied
anywhere and run from anywhere with no other prerequisites or need for
any setup or privileges.  Also it's extremely flexible since it just
runs shell scripts.  That also makes portability much more "do it
yourself" than other tools of course.

Meson is portable, but that's because it's written in Python: that
means you have to have a Python interpreter already available
(currently Python 3.7 or better), and the ability to add new modules to
it.  Admittedly this is not a super-high bar in 2024, but it's a non-
trivial requirement if you're trying to start from scratch.

Things like cmake provide abstractions that can make building code
simple, but it can be surprisingly difficult to get them to perform
more advanced tricks like generating source files, linker map files,
etc.  It can be done, but it's... not always easy.  And it has some
weird behaviors (for example how cached variables are handled will
certainly confuse you at first).
