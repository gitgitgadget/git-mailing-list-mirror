Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7B259CA2
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912032; cv=none; b=K0HTvbNL2ZgV1qcxNAcpGydUGAjqmr58Z40ut2bojgsjPuUKC30FYizMfz0V2G3BKusSKKgIIJwJyjnyBmERHm1G5z1CzhNyBWQspizeb6R97Shf+Se+1y0J3jbL3tQiZ2PpvWhPcQTSxDUtvX6XAmpQCVZiYsdyr3vON5XGu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912032; c=relaxed/simple;
	bh=rKsrM3wBMjX+vs906JXSoZQIX85j58xVyPkDhCFbRlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QLe037OuFRhmVvrSXUHy4dbcMh0/qpxZkRx3Y2fwxl0BUuAIXgyOUAM+9ksqlP8pUEfG02ZYiWslIr2NGa8CdjsIysCceBLAkrUTSn7/3EIQu6ysDkFlyWnO3pnNnuDmwwg9xsa8yAyXEN4UtoIA5Dmj26Urah4dhEOkSWwaQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=biw8GQa4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="biw8GQa4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742912028; x=1743516828;
	i=johannes.schindelin@gmx.de;
	bh=rKsrM3wBMjX+vs906JXSoZQIX85j58xVyPkDhCFbRlE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=biw8GQa4/T8FSG5HhwSUE3EeT+3XejrbWAT1HpI6X2AKzVQzZKS/ZBKFuaqKoiyx
	 xdJ+eb+YHoP5V5rVPwGbmepP1coEXKjv2NEUgErjbj1I5W0POu2XodH9ZYmVOtawK
	 4Ekcx+I758q1i8zqXGRiWDHYP3iSezAIYGpXYFLRdRhRBlWLUeSA06dfYL0Ae2Gi/
	 WMNkqBUHLoF/sOEfY09tLsadu63xi60LjqY7O58ujIdbN87vvMdAYqp9L61AATZDU
	 +/4IUuHtizEVuALK/xzZl94E4jGyCt7vvs1fvCdYTOpUD/CuO3u4Y3lln4FuVCI6S
	 ktfhGAqPjxqcJ/0Q+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1tZSaL4Bp8-00PGB4; Tue, 25
 Mar 2025 15:13:48 +0100
Date: Tue, 25 Mar 2025 15:13:47 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid the comma operator
In-Reply-To: <Z-Kf9ovF8zAemgUP@pks.im>
Message-ID: <22fe76ff-7940-86bd-af50-c161e3d04864@gmx.de>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com> <Z-Kf9ovF8zAemgUP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gbf+SgAOIARXuHtX+P/V4bPB/OlNNWOQZ/QmYsgp8L3ixbglo1p
 5d4ezD/CuM/UxUu38FTDJ0vTu4Xm49DFzj+cKcHQ+LqH3wtrTteYZEJD0JXgQ6AeqMnpeq9
 9/csnfiLiYf9EGsZL5V148Y212PEgvTkCWKdphrELZsrEKfajYqRpUBWs3rW1ROhn6tvnvz
 9R1NdYamuc2J+tOFJbH/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vj5+84f6fzs=;IFXSat3Lme37VQNyLTGjyvrXccy
 qqmhauPpyg7xQJg+AV37oTCpCNsLQQdQRG8lh5dkNoEssXlOscmu6FZRB2t8Exwd+FXUL2nvD
 IZFAfI1cPCR4R6kF81WkS0ZqGXAYfBseY2huNZRA+9UXe2mAjixaW2c3RcQQmkGNly5UX+4d7
 ClvY8x//5/UbuQ9txsegLkwn6YTlhY2N8JNvdxIJHWrugppd8gx+gB9o8aj0rszgCr72AVzkY
 LqtQmhbPC+oWQ35+Kh5jUHP+/Dm/Z3rwb1obc5uCpIaFUZXNfZHzYIW8SnAzmx4wtr+khs7B7
 ZcHbnM2iumH8toN7JMyqvwVHonu98YKPoJsGLzWdp28uioacO6npZwDa+u+NwlGVKaQ4WfLIU
 V5Dxru60LqtOc20EgumjLgdzXGkXNym7RLbde84iUx7leduNx21zKbwU+oUCt/tVdXaCubdMe
 HIWIviDl4GI++KEyFc+fM0BgzIlHkjeHiQObYDZpXweO6LCpB3ic+4orJ8H3+YEk655qXlixM
 4b+4/3l04UjbHBgiXHVpZwC1obuZ0UIs5aDn70nxKQiteSmnPE0iGIdWMSWZSD1nxBP3dnXFF
 TxShUxa5xw4R3SNN/WCTAAMtVyetA3wD+13yWeuBbQ/eFpFFljEqwlMXB9bvxN2LcXW9orW9p
 7m3CWtHUOMD+SOS1CUdmVSnoFS1eMzU6k39bS01FSCrHnRIoA+2/l4wHsqz9uW1n9oyFH4Hu0
 WvTqMZ9e4SoNeQXrnALuovdgO/qKlWCGPG2u75+uT4CWxdWTubgWuy5E/405+XjqqReHqNfuT
 dNOCowAXPH4RaZqvm/aimCFVKTHmsXtN/dkFMxOZn5fnfRkuno76MWp/LuN1Yf6TDoeBOTOmt
 l5r10jQemehUgBMWZqgnPwJQAR2EpSKBQsaRF4x3QT20ipO+jVllzpXNt6SHo0RRz4o/tsENX
 9M4Wd2IV+8f5DsjHZm46fjIu7NeM23ekjLkb4ed/nMXhm2WzkvAwlPFhj0UG+E76fvVYyIG22
 xHrixkmE8jAB3G6NVbn/qs8/r/hsWdTqj5C/Ykttmg2hIxOkY6PBj7ZnIAdgxaS3of0RVkhl/
 nXtz2tl3zmFwDzm/lq6S3Go/FnkM/+1z1c58RsPgqc6c2/ErNuG8D5qXlVcuex14DvSDILn53
 Tct6s3kjZ1EKhSwe/MW4qru2E6Y7Qt0G3zTp37OtnuLI6fXS2UU45R/exSoBJskAV5Pl2pAJ4
 W7XHEt4bE/zVtI/iIKvLecNqAJc7/VmhFDMWbRg3Fste0I7/QGJ+u/b7LEVl5r7FzmtirhtXi
 76yURjDRESEpHFouZ6hdEr984A115B4FeM3fgWwVhhTGW+LOD7wrHj5wAIU7mGHbNs5IAW3vL
 OtUmBvHdVogzak5tOzHm58avZif4GfaFOQHPKdQWowDOE/1BVyDosAoejAlyA9TFzeLjNxvil
 BQibldpipNavva5dd7CQMExXYWXtOxi20hi3RQi5670dF3n8T
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 25 Mar 2025, Patrick Steinhardt wrote:

> On Tue, Mar 25, 2025 at 08:01:48AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > The comma operator
> > [https://en.cppreference.com/w/c/language/operator_other#Comma_operato=
r] is
> > rarely used in C anymore, and typically indicates a typo. Just like in=
 these
> > instances, where a semicolon was meant to be used, as there is no need=
 to
> > discard the first statement's result here.
>
> The changes look obviously good to me, thanks. The reftable library and
> backend also had several instances where the operator was used by
> accident, and I've gotten rid of those over time. They typically don't
> do any harm as the result is essentially the same, but sometimes they
> may cause issues. And at the very least they cause confusion.

Thank you for addressing these in the reftable library!

> It would be great if there was a compiler warning we could enable for
> cases where the operator likely isn't intentional. But I couldn't find
> any, unfortunately.

I was not actually planning on adding the CodeQL workflow to git/git,
seeing as its CI is already taking way too much CPU time for my liking.
But in `microsoft/git`, I am kind of required to, so we'll catch those
issues there.

Ciao,
Johannes
