Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400893;
	b=dCRU48wmxPe7hpkHoo/V+gpoIEqY/LCtOSczeWZG9/06qzz0jtSseWLOQDDv+8u5UWQ0
	 FxLUIEvqYZMHNaObaril5AEzxFXmdNo3um9HgabUp71InlgbqnZAHcvOYgZZ/QHeOtDfY
	 K7aAL2K0YEevCisB9Ze1C56AiJGwitX8prml1o7j53JIMUclOj//Fm3m46z65l9tNplXs
	 avSxOSAy8eo0etd/iYdU3cnY0HbMa4Twvw+ChwTNnSZOJitDieSltMPB7r4bROdiPo3JG
	 x6tIdRlbQYcZ4qk3Q791FQBWuACrNGXnODvR4+ytKaNAeDqn9EmIVk4q05KK2LbOFPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400893;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=dlrFYR182a3OJxLQehSM2O2LqTZRaIrYuICynJjZHeI=;
	b=xmrYWImNNGQCxOtuQVQ+zGiGu1ahnyOprBASJBzlgoNx9c1xlbubVsGlKBMN/SSeF6HF
	 HcHTdlIIxQDSKT4ZuLdbuVnHrNby/3zKA/mVFQjUUU1o9A6jaUT4MOJX/7JI1NS6GNi7+
	 +r4Hp2DZ14aT7GKcVXhdmppFlPXJmaqK4BwDIu9Qm9BijpiyqaEA5kNlzkgE83MuvWY6f
	 Urr+5K0o4d1QV2xHg8c5NXzziVi1LTabYRPPRiZ4g5AxMNpMKle6nhOfRIM5LbkW9Ph75
	 YiFklSGEVPfXqcCYMXZHNM356CMkVaHzY4aPMQNTj/fxBRJPToKir/X/MQ8GtdiGOVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=iGAU5Yo3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4799606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4799606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=iGAU5Yo3
ARC-Seal: i=1; a=rsa-sha256; t=1794400886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pl49MK7wicR0sQShBYGWRqt5GV/CoMFS/xoqoxNWhfD8Ji7scEK4zFBr1GKdBc4uPF+wH1YPual/7dn0gydi7ro3y7ECX5ZseYOBHCwIK2nRGbhEXwE8c27h0tB+Y/Lqq0O7b5FGH0BinFc0BbbPPGlpE9bulIRqB2euZUg3x8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794400886; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dlrFYR182a3OJxLQehSM2O2LqTZRaIrYuICynJjZHeI=; 
	b=DVzGn82DH21KUmcrfbns34Mcj6/IZuETfhwT9tulx7LMI8IvPk30EUEdJgIAgGQ5WFbBYK7vDb2o4WHDd7NFA+Xe182hsswgwiXHDIrdmMoVcrESw2yrKxU1tvaEHBFxDemKLuVdGoc8Stvi+PgJwYgYOnp30+XNnfovt5R7SMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=iGAU5Yo3MHcTaNetwXhlKl1/LjYgd9tG7PFSbZ1qOoGhlNh3pY2OKcH6A7QJvAY6ITBKtmw64TWHkafP2yZLKIvNhj111AqqOuo3z4gHjHnEqdlUrIrroZ61inSQxXhM+dVT8JWSByklYVYKJq+ydFely6ntXeAEkYUDG58ezHg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=dlrFYR182a3OJxLQehSM2O2LqTZRaIrYuICynJjZHeI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794400885401121.81315640616162;
	Wed, 11 Nov 2026 04:41:25 -0800 (PST)
Date: Wed, 11 Nov 2026 12:41:21 +0000
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, gitster@pobox.com,
	szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <avRicTWUWuyOuUNP@collabora.com>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <cover.1794078554.git.vmiklos@collabora.com>
 <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>
 <avRG5r8DPrS23Nmk@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avRG5r8DPrS23Nmk@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.380.36
X-ZohoMailClient: External

Hi Patrick,

On Wed, Nov 11, 2026 at 11:43:50AM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > While the original patch and this series do improve correctness of
> > following a file through history, I wonder if the increased cost is
> > ultimately worth it in most scenarios. Maybe this could be something
> > opt-in with another flag instead of toggled on my default?
> 
> Yeah, by now I'm also leaning into this direction. The performance cost
> is definitely way too high for us, so we need a way to disable this new
> feature altogether at GitLab.

I have no problem with turning this from default to opt-in. I would be
happy to not revert, since a lot of effort went into this, and some see
this as a bug in git-log, not showing some history which is there.

> I don't have a strong sense on whether or not we should revert the whole
> series. I find the patches quite hard to review, but that may not be
> because we're fixing things incrementally and rather be because I myself
> am not familiar with this subsystem.
> 
> But in case we decide to not revert I'd like to see a toggle to disable
> this feature as a first step. As mentioned, this change has caused a
> rather big regression for GitLab, so we'd ideally have a way to disable
> this feature soon so that we can mitigate it.

Makes sense. To be honest, I'm not too happy about the complexity the
last patch in the series introduces -- but having performance that is
somewhat close to the old behavior seems to justify it.

> I don't want to make you (Miklos) responsible for delivering that of
> course, I just want us to align on a fast path forward. In case we don't
> revert we can help out and contribute such a default-disabled toggle.
> And if so, that would also give us more time to fix the issue properly.

Yes, aligning on what we want would be good. :-) I'm OK to replace the
last patch in the series with a patch that turns this off by default,
but then how to opt in, would be be fine to have a new config option for
this (similar to log.follow)? Would that do what you need or you want
something else?

Thanks,

Miklos
