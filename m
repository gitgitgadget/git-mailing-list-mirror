Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934002;
	b=bVx7xpeWz5aKeXBfVF2wkBF785/Dp9Md2Zk4/owTWw9lKMrebikxch9V5mqjpzraNCFZ
	 cxjoRmla8G2d/aWyL6QucQY4w3UUCktXG4jQAwz0f4e/ckyXdipkm1T1zQ8CZB8V+yVBz
	 N7qa69DIIlItQJ82HuLyOeytvB8ro/GBClQ7ieRCRbbx1ZHfInwdSDWRjs6qwWQ1f88cH
	 rW6Al2pcy2fRljJlxp3Pxfr+vB/4xNxphybMyObMKFPIeD261Nvyae22dZ48rqRlDsFpH
	 2+6MyNwWxLcPF7NixzpIAroyjatkXvVsnKzbMx4DvdcfY6Lgxpi+hpwe7dYFqMoOOaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934002;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=CHjwgen36jCoEP9PJfoSXKWPcZ5JWrINh8h/OIHBdes=;
	b=4DAsWZ8fcOMxV1oBlV405L691IJ1GLB5KC0Ke3oKbbQV5CWW5PbkV1JCXv9R3Eg1T5gP
	 n/SpNNYil9njY1CL3rSpP0wBlg6nD9uB0exWJMpLw6g8LYsxJ3j08smAJJznejdHv6vu3
	 1mx0CAJE9xw6O+wEPSYd6EBWq1U6CkSLlZclLc8PSfufxrEumx15L53wNTzUljAc23LpT
	 48NhyIQO3Nqcqt9TXmuZ4d/x0eCuIZQiMBM1y70lIzHKGmP+DLi73NkKLifrPcmr4L/IE
	 lIrZDxI/p4WKZiyRRVpxeIhM9lZ9c4EKeVhCHICQtsSCQknNaOwpMfRNhRLgSeGkvfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cN0RtPhc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.123
Received: from sender6-pp-g123.zoho.com (sender6-pp-g123.zoho.com [165.173.180.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAE606A335
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AAE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=cN0RtPhc
ARC-Seal: i=1; a=rsa-sha256; t=1794933996; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EnwHocl1aypTpFDlUtvQGQABuSX9YLJuF4teyujfPh/ohhfoIUAbjfks0dZjN9uTpJQy7UJkEGgnLclRLIZ9Tk5ntTwRk8eJ0syF6buEJ+fWQJp9OQEu7/YM3KLZLlBgxJKQHvhpVH8Y4KkqI+U8kjdX4fkDsbrqh4dWBTMQGMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794933996; h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=CHjwgen36jCoEP9PJfoSXKWPcZ5JWrINh8h/OIHBdes=; 
	b=c8FpStCmL6XStGMBxQwLsZX4MZSvBLadW75Uxtfh5yUT9yaZUMqtWJdRGCTXo+eZZ7hWG0OdU8aEk2uQoMPLZEyPhlfVtCjUyAf3avq5CpkW+B5U6oYhVggkA4m6EP0Uwmt39MiAln6sdfUqQM2WAIBd1GPKHlB/ScvAx/kwMUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=cN0RtPhcgkYlTPirRZ8StLsjCHG4nDG8Wdj4tBlg1IgR63JfV0xhT3u4/TX7ywTNJRf+gu70qv82W7cooN5zxKUOJWQEYaN4AHy+BvRZCTKlS3vsQ1vD5gW9908KnTSfAxwQNYcaxgQCkXKccXwTNiIXQh/Jf1ocKIF85RljDRU=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=CHjwgen36jCoEP9PJfoSXKWPcZ5JWrINh8h/OIHBdes=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794933994862839.0846333693389;
	Tue, 17 Nov 2026 08:46:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #06)
In-Reply-To: <xmqq5wxwolja.fsf@gitster.g>
References: <xmqq5wxwolja.fsf@gitster.g>
Date: Tue, 17 Nov 2026 18:46:31 +0200
Message-ID: <87a4n7jti0.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Mon, 16 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
<snip>
> [New Topics]
>
> * ar/ls-remote-show-object-format (2026-11-12) 1 commit
>  - ls-remote: add --show-object-format
>
>  'git ls-remote' has been taught a new '--show-object-format' option
>  to output the hash algorithm learned from the remote during the
>  handshake, helping to identify the object format of empty
>  repositories.
>
>  Will merge to 'next'?
>  cf. <ava7178U9hXzPy1Y@pks.im>
>  cf. <xmqqfqx5kjoq.fsf@gitster.g>
>  source: <20261112085205.452463-1-adrian.ratiu@collabora.com>

I think this is ready for next if nobody has objections.

Many thanks,
Adrian
