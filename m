Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005835;
	b=fsyclF1wQo1GJdawz1qXqR9RRMkFn29my8SJDpl716WfP/RMgcqGoor5i8iegGcY0uwc
	 5zpOiocqMefDhGZKF0dIxIUHJPa0Yw+YCsrBySAd3GCFeeOI+HLXCUe0wNhZwcmkQtjrW
	 xKC39kHh4exbST6lF08/YoQ4z3PTwpl7LgjzcVcALGtyr+MqkNndfeg0/LVPYGQvJOir7
	 T+nbaGg1U++cfWAJ3wNS+LmGHTTydzVxKLIzjpW6jB2DqkiE10MlSTyeyG9GaqlJeLiwx
	 toq1D36qc0EDKQdqY2Y4XXNDusJZOxQ2kPuYCvkBURp/uS/g9vKwqcfzy0oQWdRCBPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005835;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UGAvxRltGWVcxnwWwzSCn0045Ww9P/is0hs8RiLWJU4=;
	b=YylmCV9UDIaSqyCwI0nS8rXPyMZ18Mkz90/JnSuR5Flt/7i80LTdWDSkt92FUobusdfK
	 pzka/uIc/xGYZpOh65UjpRuWsOVavgZzzADbCTQWYw/zuRMVHYQMtFCwuFR3xUD8mGPaV
	 8aOaVA70ygkxMWN6SR/+noefwpgnzutf2rb2Xc1M8seFQ5bmxjAtQIqOtmTACrgqMw3TM
	 ShEc+MgKbF3wR0uJf+OMF+/HgbeWQ+m19xh0+HF7dToTrL7Q3KpYRoHflOjoNSjlQLGbk
	 iEzyHXPoDSKh0MNlFQQ9elo1ijepNzM9H/q90QA2oJ3BW3qO/Cz0XngLK+k+shfzllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=cJYRCPgU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Jp7XznBw;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4E606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=cJYRCPgU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Jp7XznBw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4764A1D001C5
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:43:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 07:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795005833;
	 x=1795092233; bh=UGAvxRltGWVcxnwWwzSCn0045Ww9P/is0hs8RiLWJU4=; b=
	cJYRCPgUTuUGn8g/PPLfHhppKeTHqklYosGg6oxJxtW122qYctKu++fiurAnrmtC
	OnoTt6rbMxj6jrLKY5Z0duC8szQ56/ssiFpY/7YbTnWQ4ezQSJdRcQjgC2MvDi+y
	dvcc5fbV6YP1FZ4w78Q9XfbAPpd3bV+f85KaPFVYJLaubwbvZ+E1Ysv6wBD1O+08
	VdZbDIpivaBjB7MIyxtEkiDj0HzaIJGUUym9FHp+cu8ol6Q5HlipBRPnBFN3CN4f
	5DA3VN9SThUCKXDbEjOsnC8HA/yGXpvIwgINk0a980bk5+VMNYtPXshed9n0NSNU
	ZkjirQJARqpfs8UjxZZT3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795005833; x=
	1795092233; bh=UGAvxRltGWVcxnwWwzSCn0045Ww9P/is0hs8RiLWJU4=; b=J
	p7XznBwS9QESFtEmjU5u1kwYph0IzSdq6fGwvxvg7TYQORZBILrupRgsoNIbP9Ia
	YOTbYLrlsteRFaZgaGjkoevDEKjKl2/if1GwXNgWluvbFLP62jUmpt46fQ48Dnf5
	vLW3b8gJRhKVn+JZPn5gdipQL7SKtQeLJyZhwds/YccQ1P4S3t3R+yb71mC3/+fz
	O9+X8cyuNg03qZMK++RaryfNYT+FhG4+bLoG92wiKALrxePoWTa+nakBEhp2N6xt
	yhBmzqNj/zn1MRnXKBbbyrpsdJht6SGkxfCK+qKkyYPCBx0RhL1vlNKEJWkfv5RO
	DXa7jlOXy/k+a3kt4sBSg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795005833; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ktpyeX4P07wQ5hS//HohsoMy5WoA9NjVmd7FqTr8fD/OH3d
	nhPg1RXZfdkr1r9lx+Ik9nRF5kreVz1+PeDy08hJ9h9cTcvYKTpDwMxbVtro7tKE
	eRPyzfGTwD4eQOCdihcmTWj4lcdLL575Hw4YEbh/gbwePl/XfmWP9DLAoB0uSKpo
	D3s7VPeRTTP4dP7aSNNY6UvpvsuMhXAiqocWiCbBJ0eDOzxEukVWWxOqXrf9/oNB
	vwTj/WrSLCLqjNwafQsDTFCHiM8Hboi+pXkC4X8kLaRpHAQWl27DwmEuU12n2XwB
	sNi61hBVQZ8nDy0SU7XnJK1e9GEtG9TfR3D9TBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:icJboZ1GW9O4BPBSLDyIbIftwPItyc5lyH7Vm4q85iI=:KbuWSPeeXIwC/b7rPwpt0xbuPKZT4+C+oEXkgbkyFMU=;
X-ME-Sender: <xms:iZ39anN9n1f7QT25l8DbFhWc-hbA3aaOgpttuBoGcdrKEr1hLhKU8Q>
    <xme:iZ39ao980Fy9agCMzFKFXLis5-9Eopl5mYKEW7rjfh9_u6d8KFY1ACom1rqbR2dkk
    OM9DlTWL-_80Zc_kE7UTRuxp73kenSPzrdoeYCERn7dewiy2Hwe0Uv8>
X-ME-Received: <xmr:iZ39arSQaxgH6D8vLNgFGjVxmC_8NgINY5a0v7rBCiqZFOwdHwAhIuUKEx1WknFRbxSPvvHQHzz7rH1Z9fPISIVqm4LIwWkUE9kCu43gBHpFBgnaqg>
X-ME-Proxy-Cause: dmFkZTF+VzIKq6smqFA0Bc2gLPQi7VjysB0E4AH/KZU8tuqRRWkJ5fiZn8w2sCxDd0x2wN
    3hqO3F23iquJbcmPB5R1pNOrgnO9e8hGPa5REtkz70qlT845wSGbVsjTzxOxhbmlkcFum0
    zKEFsmUwrqTmKoPLZaj8jVP7T7f0EWkNnUXFCBG8wEvxVuiAfyn8NHfcUymGS4VCHx4Jk4
    WDipBJW/U/Qf9p1TQp4Y06HLjab0p4qZUFe8AgQnAE9F+LmiHSZ9M/yI/AoXATL+/vaY2K
    PnxZRJMxCZDVd1bXS1kcUQKGWgaBYSrqxgbzw0i28l02a4Tx1XhDYRuXzo7SV2y+hU1xlR
    z5WAw3X0z2TSTvihoTjwCiLrX9yWzykIF6XqfedRpM/Fv1s/D1aaygXyfBWV+7Sm4MO0Po
    nmXEhX9DHYlsA+igJpqBUV/KOoWD90f+bYA0jIV1JspXEUAwCcuA/25pJW431p6qO2Qwf1
    0R2qi7BdtnA38+mBahOrhNwxbsCyS701AKpZcRDdhe6VNxYFJtZhuzTkhiTj01lXw9+bsO
    pW1Z243q3C1iQllWhT0EfnXczHdy5f8LeqXJHtICsFvndO2x19fU3LcziNsrVQz751qEqx
    Fv5/GzQZf2iXku9mPIpcs3gNxlqZO0jMe07LuUhyp0PnrBYuOGdGYKp0zsGw
X-ME-Proxy: <xmx:iZ39aqli3mCkYeRCU10nMLO_vaiJ5QV4BITl-lpFlo_4p9_FQ7iL9A>
    <xmx:iZ39arQNYTqMerpDsiNgL5eXkYbdp-JxBWE76k85Sk_Erqh3FMLHUA>
    <xmx:iZ39aoPbKBY8FEaSA9NnbbjQvO0erM-bNFzlYvK2Sc_gmvbHJjet3w>
    <xmx:iZ39akU8TKM39GdroxsRouuWIcURHu6kop3xc23G6AGrS64PwAY6Qg>
    <xmx:iZ39auwfs-1nP1htUlMNNDhAbskg1YwZBQXayy0tbiO0jLbMgKE4nHob>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:43:53 -0500 (EST)
Message-ID: <09bcad81-4bbf-4849-a3a4-a409f5ee5434@jvns.ca>
Date: Wed, 18 Nov 2026 07:43:52 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This tutorial is a bit of a long read, so here are some of my own notes 
on the branch after a week away from it. Also let me know if I can do 
anything else to help review this one! My current funding ends Nov. 30, 
though I'll see this one through without funding if needed.

1. It was a bit tougher to get test readers for this one even though so 
many people said they were interested in learning about branches and 
collaboration, and I'm not sure why. Almost everyone who completed it 
said that it took less than an hour. Maybe a table of contents would 
help folks understand the overall structure to see what they're getting 
into?

2. This document is doing a pretty tricky dance where we're introducing 
some example Git workflows for collaboration without explaining remotes 
or upstreams, because the tutorial is already quite long, but  
ultimately the reason many people use Git is to collaborate and it feels 
silly to not talk about collaboration at all. I believe we gave at least 
a basic explanation of everything that is actually used in the example 
Git workflows but this will definitely leave some people with questions 
about how remotes work. We don't have a great place to point people to 
learn more about remotes. In the future it might make sense to write 
another guide on remotes and upstreams (maybe `git help remotes`?).

3. One of the test readers commented that they were confused by `git 
switch` because they're familiar with `git checkout`. At first I didn't 
get it (if someone already knows about `git checkout`, why do they even 
need to read this tutorial?), but actually some of the test readers had 
been using Git for quite a long time (even 10+ years) but were still 
interested in a basic tutorial on branches because they still weren't 
clear on the basics of how branches work. So it might be better to also 
mention `git checkout`.

4. Only using `git log --graph` for the branch diagrams is tough and a 
lot of people hard a hard time understanding the ASCII art diagrams. I 
didn't see a better option because other ASCII diagrams are not really 
that much better IMO (you still have to explain them, and they don't 
have the benefit of being a tool you can actually use to explore your 
repo). And we don't have prior art for using SVGs in the HTML docs.

- Julia

