Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211375;
	b=HrZaaSkUc+iYZOzOekuVwaDS/a/42VRLTy2/T1U3Sney93nPHpmBfiGvoxV92VCB++Tm
	 B/qAXmGrtcNvgvMNF7MYy1YzKhGvyBHo3lUtzQi4Mldt/vD2DHgmg27fAJqRKXSaIfM0G
	 5BZ9JBEEYuZoUI+RUkaZQ7PtEy0uNuP+OfembdoolHLNJcWI2kSmcbo5IOzTjE9ZitxQA
	 KPkhhauuJNtGBGEzSXDHowGPkV70niKOinSLEFxsDyYKrzVbdLmHo5zLuIQWaDBixXRn7
	 y+3m+x+ejzLnPo7J7+FMt2CbwOSnr7lzvWIIVPbKMldrsGyAJeO+RBzBU7iIZwYWW8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211375;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=CoVh8zCoOvW4QQjWFWdMPXXpCrebYkVZEHzFBS7+HGY=;
	b=1o/csXKRHYOUGil+60zrRLTttVaFnTWvF7MfnUoDxpFjyOUApZtBijdlsGW2pUzibsih
	 tTfyL2CEWQOlFXHZuXSEFjtBT8WFTkPI4zCgZCMkUmyeAygnYnbpEcfHHVgIBazIPuFp2
	 3IGAK4c6TByO6uB1Wic0icbDGndu/pZvLNNqH+WjiSxcMnTVwSnqqPR346WHJMeXriKH+
	 G0uydIUB8g4pCCpVHJnzZk4DboUK8DPpHMK/y+lyvLvbzR05oFHQMiHKmnxjMYwOFnn/L
	 IL4MbVLQ/7o+Ulb6Zx6BRsLotwKUBW+cHohdw8JXV2rNCijdcLbCba4S5DEosRiPL9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Fm2m8Vo2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.123
Received: from sender6-pp-g123.zoho.com (sender6-pp-g123.zoho.com [165.173.180.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F98606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 08:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Fm2m8Vo2
ARC-Seal: i=1; a=rsa-sha256; t=1794211367; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lveHLaG6AWxO9lBWfpVK4795pazRGKPulD0OkTCzhXH0H226h3R3YTK7MciwixrqQ9PfVE8QH46HiyWB93RbfzLSHJ+YdaXnQsSC5mTZY2hc3M6v6oM1O5HmY2wNlLc+bqf0hfG0PmyHmiiOJg55dm1AvgY8BPaT+edByvEBmBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794211367; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CoVh8zCoOvW4QQjWFWdMPXXpCrebYkVZEHzFBS7+HGY=; 
	b=YkrvckJUmCW7doL4qQnv+UxkPxgWa2dZO929XZuRiEJljSu4NEsLY/6lSgG2LHfj6141IqGNuGC5GmdE1OA8HbkEQGLi+HBSA3nwxeQfDECXabx/QjC/M+lA/azf1/iehSG4490SMMKL742P5QDUa0/S97uO9oRo0Su+x2L1ekE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Fm2m8Vo275Gyx0Z4eKkljpa6aaxxZTsC4/rRFvGTBzs12DPF1MVT8MO1hlqgTKLzIKNwnfFfLlpwqum4Gy/SkfT9ny/uoZ4ZzsY/HslZV5CsaizFDuK2tSwFESKaYQWRtOZrfSCUZ81OZwuIziWrzS0TidOKb8uAhf7dGaBzfDs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=CoVh8zCoOvW4QQjWFWdMPXXpCrebYkVZEHzFBS7+HGY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794211365609297.20251466952186;
	Mon, 9 Nov 2026 00:02:45 -0800 (PST)
Date: Mon, 9 Nov 2026 09:02:39 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 5/6] log: speed up --follow following renames for
 non-linear history
Message-ID: <avF-HwjximDD54P_@collabora.com>
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
In-Reply-To: <au3gswJZzhutGlpR@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.182.33
X-ZohoMailClient: External

Hi Patrick,

On Fri, Nov 06, 2026 at 03:14:11PM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> With unrelated histories this would return no bases at all, and hence
> we'd always return 0 in such a case. But 304812ed33d (log: improve
> --follow following renames for non-linear history, 2026-06-22)
> explicitly mentioned the use case of sub-tree merges of unrelated
> histories, so isn't this a regression?

You're right. The existing '--follow finds the pre-merge commit through
a subtree merge' test didn't catch this, because there no parent has the
path unchanged, so follow_needs_renames() is not called.

When there is no merge base, follow_needs_renames() now returns 1, so
renames are followed as before.

I've added a new '--follow finds the history of a copied file through a
subtree merge' test to 1/5 in v5 for such a case, and 5/5 now passes it.

Thanks,

Miklos
