Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211306;
	b=k6fe4GL3psAgyezCxjBayMMzXJrc8n3bmJ+fzntOT0aXDooooDw+zIvAuz74VslFDvmP
	 u3IqKWL07du5O0B/x91TscnSv+SO3/NpODV7kYrCx07jkB4lr1yMYtY57F3gKJ6ME6TjM
	 Ulu3gYtjosl4msiJRGbCmGQ2U4I4/FrjgE9EpEsrs4ANj3LYX+PEeuoziMi7pyTUR6xJN
	 JkWB3Cll9PuHjZJ8KF2Og1ff6AXDB9aavqqTxOX7e86xd+Dr7HdzYYEEOWyGb0LnuYAGv
	 2z1LWnPTIz9/sp+PtcKpAoSWHtY5vfNu3rG+lSCzT30P1L2Lj9kW9FtIDipSwoqrUvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211306;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=tIEwjLZw9ENqN6IG30ZnMnjrEaBr/hdb1q2GZ3N+4h4=;
	b=ne+cO5dgddvVP4fjnqp3iLbcxpEwyBduI3a0UhX4y0oumgWOJvKlTEgOxc8fEfxTQlh6
	 apKCWCGMnlY3pVoZCf/3P9xphy2UM3KSfCaiSTq5tw9jjUjGgxn0CFqswZeT/YFQLzbeC
	 v0qlrP0+5RLu5B4G5e0tQAQKdujFsrtztdDm5v9150pq4e9CA7yXRxweO3H4fPQQJu+6j
	 4Un3dGtspa9tzL2Eq93ZCsliSjmrWn/caSK8YG6qqyaRaAtPV0Wk8wNA3hzGbaGiozGgR
	 UaaTzGIgFxZRun1rNP15WNTpbvUKMeETbCRCVMby0cDZR1pMgkwpeb5e4iFSOX7RdOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=D7I43j+B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.122
Received: from sender5-pp-g122.zoho.com (sender5-pp-g122.zoho.com [165.173.182.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708D606A332
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4708D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=D7I43j+B
ARC-Seal: i=1; a=rsa-sha256; t=1794211298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PcqiEJDs+RdSoZWmoohamB2GTJr9FFb1z1aNy4m13Ewg31FB9DgmqWjX4nE9h7JBI26MRDMIGA3zR9Z5+OjDFyQyQpN8XGt/ad/Tzqy0K/RxeTG9sOblWe94gmvKMVq8rzoHxSTh2+sUks1RN79BP+itWiebEvvvbJeJ0f1Is0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211298; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tIEwjLZw9ENqN6IG30ZnMnjrEaBr/hdb1q2GZ3N+4h4=; 
	b=nythLgIKBjihpOmacRM1enYfxkpFIPWGT/TFaYLlWg3KjM1liFId/LbNCip2EKinKcf7nLjL313J1BQYSRDuE5bpjRMnvzJ9k5WqoH8PMe6+a72UT40P95k47gZ+HetuuP52DT0QWBz5lfTLKHphlQecvCbJJJveyRN2yDfkIfg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=D7I43j+BO0cGQCf0vKY6fbxQnxrOIKspwjqTw7npUF6EIucUIo1UKZy4UyQPorNP/+Jsss0AmaOKt6vy7i8Df/4uwvWidTubhAtv34Wb+pG0Scrgm+sUwSUcZg9aDupZTd5gPlqgStcLA6EFRY+g54HnaABi0sy9zxLprNGFbcQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=tIEwjLZw9ENqN6IG30ZnMnjrEaBr/hdb1q2GZ3N+4h4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211296808169.52526686680505;
	Mon, 9 Nov 2026 00:01:36 -0800 (PST)
Date: Mon, 9 Nov 2026 09:01:29 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] log: speed up --follow following renames for
 non-linear history
Message-ID: <avF92deaqNI1G4vw@collabora.com>
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
In-Reply-To: <au3gn7kUFYZWUinE@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

Hi Patrick,

On Fri, Nov 06, 2026 at 03:14:03PM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> please note that the expectation is that you answer to the review
> comments directly instead of only answering reviews via the cover letter
> of the next version. We want there to be discussions, and reviewers
> should not have to figure out by themselves whether you did or did not
> address specific concerns.

I see, I'll stick to that way from now on.

> Hmm, okay. But isn't it the case that your speedup patch introduces a
> regression where we now don't follow history in some specific cases
> anymore, and that regression was only introduced in the preceding
> commit? So it's a bit curious to have this be an extra commit.

I've squashed patch 6 into patch 5 in v5. This way 5/5 in v5 is a bit
larger, but no patch in the series fixes a regression from the same
series.

> > Interdiff against v3:
> 
> Instead of an interdiff, could you please send a range-diff next time?
> That makes it was easier to see which specific commits I need to have a
> look at again, and it also shows diffs to commit messages.

I did it that way in v5.

Thanks,

Miklos
