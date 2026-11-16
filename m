Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815056;
	b=4aJDc/74txMzHkJ+1qr0tL/0ygHsQmPfGn3QRWP34MKKB6nqt/lYvxnPKlFWQvOjS+wN
	 9YoHZ4n3Rq5gnuyBGJbH0qk42loAnHDzZ4Uq6lJbSUAp/G3/MNtICwMJXe+3SVwak9cWj
	 YoqC/kCjuOnS2Z57+XKacoouPE+8xEi+dXp35lKHFwzN2kWjYwIoSoRVlyzM4xkt8H8NA
	 Tcpquhye/y/q9SMjC3zsjx7JV2Zi3BCS6mcLUcp+Hf/QnBhgpe8Zi89P6aj1lXZc3l2RV
	 f32jdiDvJYq19GWZcIsYPZ710mz6PilZClTql7L8NRTIpYS7Rhom4DXWMKLGdGjE1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815056;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GBWZNQsiZykfn8IDITdj9NEsBXOuqqajUG+DVz1RgIg=;
	b=4te9EP5Fubw870g61Q50SH3/xVOvonSarzWdB7cYT88j56BiA5ZICKVg0vq6jOy5SGx2
	 Npr6y0cKLOx0jGwzKJZTNkRDixZj1Zja6uV0/8rYM58UMG7Al9XL9QCsZS7+/Hh/qzOgT
	 luwGczf/qDHby6/DUlK9ORhZDBkQy8zraZps9qodlwofYCHT7byH2i8EJ79u4uBHA2GfC
	 AmqchgFg6qXFWK8ETfdXZ0DK3KV4XRSnWpXYRGcbW6Nn40zJ56Go5KjVCkjrfW3ne2ygy
	 13erBXRJRzPvg/F7Q0/avVgoFlP5jcbNFn5dCNGj0SNMWRuZCRwkpQo4Zvx/JecNiHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pkCwzPGJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TM59JR9a;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA606A332
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECAA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=pkCwzPGJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TM59JR9a
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 302351D000C9
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:44:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 02:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794815054; x=1794901454; bh=GBWZNQsiZy
	kfn8IDITdj9NEsBXOuqqajUG+DVz1RgIg=; b=pkCwzPGJxFv5cwu8Qt6TX65iIN
	Zovuc+tz3icRadBA7g6P1bjb7VExPgwM4PkzSHB/8YrpGm/LEvAiLF6Ux0MT3FUo
	qxTlhyxxk6P0d+5/LMt2qvNQ+Pemx2g2omy0mXCzL1LS2vpsPmXPYcwIF1a/oHgy
	4UBZErMFnbC/vzRHIMye73F8tdd1XpjFdSYpzFVOtVL9Wr+tFFBxuh71QsFate45
	/gp1A4NHtxD5WlTZVLd7KxUzAlegAKcRuLLyfkSUDKc6S6RtLrppKZlsHCfeKgs4
	lutgnp6nMaEv6EH1rJbWw3yoVPl4jq5bius9aAuw90jISQU3q/Elw6P0rRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794815054; x=1794901454; bh=GBWZNQsiZykfn8IDITdj9NEsBXOuqqajUG+
	DVz1RgIg=; b=TM59JR9ac0Gq+mSYxJ5EnC8A+Ug5t8RhcVrzeLmWEstNrkXSoWb
	XDrJHOpAOGMdM+oC+NMNCNtg+6YSRv/POfb4y1Io4ToGPjz7VtH+oZbRkOhvf2Wr
	PtFXIMPc20Y9EunkeJ4BJbr2eVDlqfE/OQIaFhkbcMUI6HsX1qGzQlEKy55rUJPP
	Q/59By3zAhto1DJ+G9TqmbeLAVY/4VnB/Rk/2CRdd984ft1PMszVxWdaym7dYe4r
	RVe9exeFRxgkUV7FMT+myo+Jhy+lMKtjDmhSSz5MhMFano18f8GXIO+t6A0MKmCT
	iG4/s6WNUOSNnVba1qI8sBdEaub3aIGXq2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794815054; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:YxVfjbW9sojZ+Gu5Vw8Ij7o0WPhbgCOUOk+Tlm6d+w3KNwO
	5EXUmxs1b3CJkXSi8C+TFC8l9TBxYk6foJ6rDIwKJylYHlv95kzJWZkUqZ/JxW4V
	ZymalFIblNq94Rq8NxnLIUC48cTQiitFui6Ydi82QAF6IxzMpbhSX9CQCzwZ6bvF
	Qlexe0vokO6AsxxsZ4v4MVPLRzB1An2l+kas1ErSbDT/XtUqdj0hZ33UbXzvvagn
	Ze8/2XpOPuldcB0eOAzUm4ED2AbHWsRZOXy7hgz2xhH1zBtp/FsUW+vcFwLudbdh
	5LFsu6q7+xGyWAzFSoYgEIZEBPZ0kCCix49U09w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RSdl1qhnbRcCe72hOPG8eO++5X3wtRgwfqbUfcFa7vA=:Ojx3Bznb3k1W5Clfqmcm+3jKMnLTR9A42ymsY9dNdCs=;
X-ME-Sender: <xms:TrT6amxuK_AKLUxcHmxDYWF7z45rSj3urlcHCoNqbkZW_8CvmI3txQ>
    <xme:TrT6apsDFW1r1LpMhmzNYLT7Ytm3Qo5aUnYGmt1dZ0-rVFwbo84uoNcG5TV_WKSM3
    5wvtnTO07Ahu2eVy9DZycO3IxcKa5U3ajnnESiHFdnaSsOmk1z6ZEo>
X-ME-Received: <xmr:TrT6alvTkUS88m0AEV4i-eZv0N4fE4U1_e3cSsQtFQFGPboiXMCI_r5x40Iwd0Q-hBqjaac>
X-ME-Proxy-Cause: dmFkZTESrcTSV3q5m3+HTFb5EN5sJI9Af52bpo0X+fo7P6rYEnrV+j9IjZJezujDykT/Ua
    FyotTJ+aWOGCqVRJICp3Q0PBL6Ql+Is6tX01si9AAup4GtF5SRrOvL56Eq4RzR8lbT6Ar2
    0q9ksIApSgD8uVfrZOweT4feg8mVR6pBg6Gh8NeGLY6nVYsP7VFdt+s5kTXcJcxyKc6PaF
    GeDBx3uE0Up/7JcRz/KWJPQO23PJ+M13gaGa52qGK9fH0WxYI20w2gP99smv0f9Y2opw8j
    DcGWV0tqDyY0FMECmlYZZxRGksXdDBYiI9sEi0UBFlX3bR9xcGEf8TTZlpxHKHHfC1hkF8
    pl1O39wCtnHSMY80CVPuU+fI5r3Sh3gh4xofuqIz+OwBjR31MA7o3QEops8/9H9GdUb5Qx
    rS7xc/jpINrP1HF2/NUyKZzb5VQd0GUqtB+wiQnb0JWxCs3pn3UGiCtbBuQ6Kq0h0Win7J
    a7zd2kXxBiMlsiqt/eRxA/hiDNI3nsg0pCoQjZ802D+QyvNHKz3xGGDtvVqwwzTq0BeZA/
    hd7aOLLtaHKtjZlIxw+wlfzYJxL+3xVrh/IQaUcPQOjF34UmgfKh3NQg5ifKJvNWkkXulC
    p8S3uAj9hx44s+PtKXQWzrAaLde+FHIph8FNw27l2EUETEinWozLFVSd5rFA
X-ME-Proxy: <xmx:TrT6amNDqeBSjh5vJBt03jmZ7ylss_v9QbKxpcCvgJ6CXRBMp-I0Kw>
    <xmx:TrT6ar0eQh7dg1Uy32OZLyyPE4PXgwFs3Ld8jxgJH8vsgVhfYuJgNA>
    <xmx:TrT6aqNlkpAi_DTWEifE9S5_vT_T4zebTpZaAca-WiN1-2fxHhaqZQ>
    <xmx:TrT6aj3CvI9_JsQl8i7tFy6PyCsn3wg4-4sQEdnYSUWe91d4-6Sq6Q>
    <xmx:TrT6apJdCgmIuvZp-T8e0jOH1tKeZ4TRh_73dY5MsIbt0YXpfBYJZnTL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:44:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0668000a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:44:12 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:44:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 2/4] imap-send: accept messages with Subject before
 Date
Message-ID: <avq0R5zx0PgSN-Oa@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
 <fa90c64a5cab1964988a84b61f4b7af0d9e8b4ad.1793521297.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa90c64a5cab1964988a84b61f4b7af0d9e8b4ad.1793521297.git.gitgitgadget@gmail.com>

On Sun, Nov 01, 2026 at 08:21:35AM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/imap-send.c b/imap-send.c
> index 7e74c37a72..391bd8b96a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1457,6 +1457,22 @@ static void wrap_in_html(struct strbuf *msg)
>  	*msg = buf;
>  }
>  
> +static bool has_required_headers(const char *line)
> +{
> +	bool from = false, date = false, subject = false;
> +
> +	while ((line = strchr(line, '\n')) &&
> +	       *++line != '\n' && !starts_with(line, "\r\n")) {

Okay, this now detects "\r\n" and "\n". But I think that the behaviour
here is quite subtle with how we increment `*++line` and how that
impacts the subsequent `starts_with()`.

Would this be easier to understand if we had something like this:

	while ((line = strchr(line, '\n')) &&
	       !starts_with(line, "\n\n") &&
	       !starts_with(line, "\n\r\n")) {
		line++;
		...
	}

Other than that I'm happy with this version, thanks!

Patrick
