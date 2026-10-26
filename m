Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007743;
	b=FdO/ezQhjcxQsWCEQQ/p4JOI7laGVnqwnogNdAPDsFoDr4GgjqrUoLssyUO4JvesLfgx
	 IXGgZhYq/O4rcKb0F8UHZ2M6M+OjMqTgWsIGR2ZTIhSkwe7Mcm3j9QKvBqWICwGgcCaBj
	 yG6CcNteJcUTMGVC6OOTk7odFMwXo3xTWgd/knI2F+wsxcXOn/jzG6JlGaIekDxhD+Tox
	 RX6eVOUX/U+m8zUsQ7fgiCrMcr98MQx+FhqvPoiTpe7OeYl3icUd+cheQ7sDbmR6twGYM
	 T3zFlBo80Kb3sN02ZfiVMO3h0vWxGNU9ZP+8JYKMjE8hvb1uptUxkshueYXrA3KIl1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007743;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aD9fVybXsb3KpmYL40G4y4th4MfotCPVSu9Ts/A9ePE=;
	b=YwuUycLJgwkCbWxQnaSW1viTNOqga4RWIDos8YqEyK58xrNPNHAwQMV+fCiD/ojwsJQ3
	 fM9l5mHY42QIiqBQ93ssXleFbvYbWYfY73XC1+ny323S4Oi0qsapiEBHhWn9rT5wTzT1d
	 g7aMMuFFaowEJ6eLox3+c9e6qRhaSMIleEFS+4+UfRItkb4r7N+mPuMIsu8tAJ0xOTDR5
	 bC5p5MocxHzOi1KkSD1XT940OgKqxfH7vNbDYG2spbJxT0wcMFI1XiEswk0/pZ2ZgpYWv
	 T1tL00vse2T8C4ZtN0HjwQVEMXJzm61JJyglw7u3fWRDbZuPs5lhCndkIepdHv1I9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=lSVMFrMV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=A319HsU9;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87560A3803
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A87560A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=lSVMFrMV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=A319HsU9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E4E21D00229
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:42:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 05:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793007742; x=1793094142; bh=aD9fVybXsb
	3KpmYL40G4y4th4MfotCPVSu9Ts/A9ePE=; b=lSVMFrMVKZJ/j5R2EQfGMqNa2k
	zUdMEP/RKbJ8GSmkRfgDdzq/vo5S0Xz2E9cmwXU1zUuN9IDymkQ9wqn88gWQukiS
	Jgp4Z3bg/1u6FFlxVR595PRFKrInqjYBQo6+CqS+YCgneiEP9KfQC4xobfoGOw0A
	644erFaMAV5Ippjg9tfykopsovSZ3KnDM2A1ZLbnI7HMb9sCOeA/G6wKKiHJ0QRl
	7JVT2sok+IqvvcQEFQ6SywnMra7asSc1Tv9Uhsx0FMsL44x0ya50NGutEDZaKf66
	3NtqxTLREeMPIQBfGXWzp/mLWnN3TlvMTCIYtAV6l+pOIaDUntC2JMRwxi9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793007742; x=1793094142; bh=aD9fVybXsb3KpmYL40G4y4th4MfotCPVSu9
	Ts/A9ePE=; b=A319HsU97hfSmHpF83gzDBzwQRLQ8aYt+r2MQMPzgejLazsSSQy
	t/YiftREB9C34ylxi2qvk4dOjxbxsfia4wjYk72PyO1ADcd2BsdIo028Wfz7loFm
	HBYdCAVbX8RKH9NZo1Y+5gaGLidaTP0XkORFZQUQdujLXEJrtDG/p3Y7NAkwqTBM
	gR/RHDwRUPBIqgzlM5efd9Ls3jD/YJuXYO2kQPhVn9Z9DU1HlAqFnZ3qK79BuHc0
	2SSMJtoKqQ5IxXBZPAW5x0WHn+s20u7iqKH6dNbM6M+Vs/i10iEobGmWoR9QwECl
	UW6NWfjXkvij/F2FG2O2BWmscnV/Te1mSgw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793007742; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ncjOp42SXzVKBjxtGAR5speTl1AsC1p9y+M68MYzpQ7fo/v
	PbMqo5OCs/9FBzVjv0RTMIgMBZY0HSFaoHkFRClSwn5eFPlA/Zj7rcHv52Hz0lIw
	F2H7jSy6k4WPiLfhcZTxAFR8n9UyopafSxtNJqyTYw6Iddn2Zos9N0x6c8CGbEHb
	t/djrB17kHMinigF6hgJxrKbr7CIuxsSG7lXAWikByZv998p3gOrql8pj7zsFJJ9
	FphSxr4rWY0mGyOCaLTi6LR5u3j8koSwjWwnK0nT8oobtyqZEG7X1JAMq0NLoJ80
	C3LKB19JHm0KglGtAaNkTris6C4xK7G5TrEFOww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hp1xKALkmbzps6QxtL+kbQ+NqoUn6H1CMFL9xuf1+Aw=:kBZwGoJ+11wv2PXXlH0ul3/3pNaLGhUNpENwJISvt0A=;
X-ME-Sender: <xms:fiDfamtYzOBi6rgkF6ljDfB3b6i2SH7jVGpuDz__mXwVayFJ5nEnGw>
    <xme:fiDfai6_50zBHG6jyX_mBATBAvFbp4ZmJkywxq1QzcD4kskpiCnhbDBL-B672Q9Al
    0rRKyRYuBz09U0YLpWha9d77HYMzQ2lfGiIy1jmjhI_3Z53_XhDcqo>
X-ME-Received: <xmr:fiDfavLCVUuGulOIBOs2KUi4fsgEcSqQH8tjA-8TynxTHiDhp51R_w>
X-ME-Proxy-Cause: dmFkZTGE4mRmZQm5og3Qg5YD2zgJ7LHRGSPprc9yKL/63GJqN9VVTGdvvjs/aa440tDpHz
    n99vKX33mY66EGQkqEvzT3iRd0kOSU9Z3+KR+ZqhE5D/NY6vEULguoiq+Sm+Mjb9IVZ/eQ
    epDWWPjcY18IJ0uH34h4VeaCh1gj0zntBxyW/Y2rFEZfb4RK16iS48AUGMRFI3/mLnOo3F
    +dxJo9J/ySo30eZl3a8FG6RanLH+5HOl3bdNhKhYaSa7H6d5xdWNLhy9A/YVwrnx1rK2b0
    BBOGFMoPLBGEmFCkGCl8V0WqkHBinHYOQnWZcNtMcefRRsygMcuj7vDLCIkQdAqSV+1DPv
    Js9mTptr4eCz7tuceEdUhkea/oNcdL3VbgBW2cf98/5MZ6IUTboN3FCaRZmMiyrkrhnLB/
    6lNBwvY8M9cAxRlYez0klUgcv5NyDV0t5BzZFWXhkrd+hPYxiURbr5+UxADggPJEdHawGT
    c68uFer4Wt5pqyj7RW9OdOEQsHuqsOFJFgKLkoqIbJ/2tkeSBRrIGNjywmtzoTdt4DaGe0
    TctIyRrplC4nR2IKHqcl9+4flqJejt5V+/EGPPuL7iSlezZQIQRX/Pk+s2r6mjBvcB8CA6
    RE7l86dQGOtakRiMqzootvJ+F1sqN64qY6nTKiUTpIs+SC9K0m+Ejk7fr8Kg
X-ME-Proxy: <xmx:fiDfaq7wi5zBUjicnLYVa7s6u0vAT4c6zCw-M-ZYJYnrG0pEB6lcrg>
    <xmx:fiDfaqxJm5At2NUG8wH-so-TcrlzpoHuez7L_MeJNdRNsYSaHAYRtw>
    <xmx:fiDfamZncDPXHjiqaV8Wb0K47yQtQj82z5AjHChfdnCsyNiEBvNhzg>
    <xmx:fiDfakS0nBcNDk7cpEEUk05Z07iKoKhso2zg7ha0CRfCAiZZhBAKHQ>
    <xmx:fiDfalVamzyCQfFq4ekINNJdOOWyw9DqvNHLR19Tb6naYRfEnWOqy0Uc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 05:42:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81e664f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 09:42:21 +0000 (UTC)
Date: Mon, 26 Oct 2026 10:42:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 3/4] imap-send: check git send-email copies like other
 messages
Message-ID: <at8gelQLS3vuidF4@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
 <213c4950e053441ad81a0d5f6569e7a2ea63e25c.1792652185.git.gitgitgadget@gmail.com>
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
In-Reply-To: <213c4950e053441ad81a0d5f6569e7a2ea63e25c.1792652185.git.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 06:56:24AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> The copy that git send-email --imap-sent-folder pipes to imap-send
> starts with a "From git-send-email" line. 04133f5bc4 (send-email: add
> ability to send a copy of sent emails to an IMAP folder, 2025-08-12)
> made imap-send count such a message when it has From and To headers,
> without looking for Date and Subject. Without that special case the
> copy would not be counted at all, because git send-email writes
> Subject before Date.
> 
> Now that the headers are accepted in any order, the special case is no
> longer needed. The copy carries the same headers git send-email sends
> over SMTP, which always include From, Subject and Date, so it passes
> the check for other messages. A To header is no longer required, the
> same as for any other message.

You argue from the perspective of git-send-email(1) generating the mbox.
But what if somebody writes an mbox via a different script that doesn't
write a Date or Subject line? Based on RFC 5322, the Date header is
mandatory, so I think it's safe to assume it always exists. But the
Subject header is only specified as "SHOULD exist".

Now we probably don't care about such edge cases, so tightening the
rules is likely going to be fine. But I don't think that's sufficiently
explained.

Patrick
