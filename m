Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564048;
	b=h17LxTbD8pawZqmmxhdV/FuXkJfHzsjT9sfZAiC00WLEo6eEKtEA5GfoI5L3dBRWUyG6
	 eKZmI0e1nhxIcnPJIp6LuCFknUxpzVGxVLhWtUvYPCDBWHz3Rt2lv5NCvMYtavfCfyvJF
	 1TN6ydeIhi6ICiDasnzJN3eZoFWXYFZUrFZxI09eXr08dcp75XTlbu3EYVi3hjACmyYoK
	 D8hd00tLDT8MNJws6F6f4JV7CS1Ip6+z9NoKPKPzf+VVFgy1/xDJg3JaIXKhPqKGPkDIK
	 WEqnt1vi7u4Im1bZYISh0Uw2VFLpGDNcP1o2ECsI1fS/17ZdxBcBylS2mWtqeZ/edmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564048;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LAKO/4Zl8w+Tqyi73DaNvhvV4KECCQpN2l8xkLaNZUs=;
	b=UHKkn4WpaXodRY+uCvC/ojR2HE/sbEY0dC2V0jA+PTNYQv/4+eu86s/xEXl3f9EUFcIi
	 koVXSja7/jZSGcgtkXPASDA33wD8tUGl9UneehkDv+CA7TwxFBXZhMSVmd95LWXHFJNjz
	 OAWqv5+7M4BUY8zl/Sb1Mn1KtX6VvWDb9Bn4venpAAsMukw3gJ7lBOwpyvgQNBntskze5
	 9DVH/urrsTzSkyPAmO8AqO9UjljXgEaw5QF/nJ8XHpq4PdV3iF/xOP2xev129TzImRQ4F
	 6HFBZbHJ0tp9XA5YDjyECw7pYIoCGFStj04ytoTlXFEVr/ZYdcVHXyJ36FXwgmixokw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gEZ2qXNz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eTEnQbPT;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99127606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99127606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gEZ2qXNz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eTEnQbPT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AF30BEC0948
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:47:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 18:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795564046; x=1795650446; bh=LAKO/4Zl8w
	+Tqyi73DaNvhvV4KECCQpN2l8xkLaNZUs=; b=gEZ2qXNzzcXPC0Q+XThp7wc9Ep
	HYJZsxWR0pqMtkJoJO7m6sggPsijj2ZF0kyFrqfi+dPSpF2aSpVOVRrNN0WfeDhk
	pvGyMCI5GGlQtvEPt82Ho01G84G6q9l21kJm2D8srxJJffNj5fGJlxer7/rGb+Oj
	U+C0F+pM/YRWzYcIP6Lv4JNStuFFl1IiwO3J4oXBJe6xrIcUhXUTqFT2h+7v9uDo
	+uPbRbboD19JpkPw0Msm6J6K8P5jtRjYEsUEdxQA+nfkjRP30Pm4gbakyi+hC6CO
	XURkF3kCKJ3Aeoa+zb374FvHQyaWr79k/XG4mYOrPVu/g75n0045uocRSABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795564046; x=1795650446; bh=LAKO/4Zl8w+Tqyi73DaNvhvV4KECCQpN2l8
	xkLaNZUs=; b=eTEnQbPT6/IkRK3w4WJCnc4kwVOF+qoOAmTkSFJ95P/s5VrmCEJ
	U8VcjWbNnyUFoO+u9CYSLoScRBKkiZ4hraZPXr3vhUkX3no+Bc7BTOpbt+AWb41U
	37SQuhLgQ5MW6TwgmDUEfr+H7vlOtLAIt7mquaj/RJ8EjyMTGsDUa1HUokSZDIUf
	YfpnwJL/tCSrvbdhiID1HF1N1hE+9dOcvj000quZYtcCnesxnadf71SpmUlYXTgR
	/87uDpQkZrgbQ2QCuUdCWT8xu7/HF5tdiuLJk+5tY2Y7MblJvw0CPG7wMjvGIzwm
	p87JWg6VLt1iGdmcU07r46xem2br77yXsQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795564046; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KvIT5l7reVwDZVMSlUJ+qtpSpJhoSgTdOKO1EbwUIOgRoMk
	PE6+K/qAhGDzYe64OpgmFu/elYwyNdUu/+xEvZQh7CBRr8VQNcdVr11Y4yIUA90X
	Nk7djG4pjpQoaOKKZuSOIUyPNz/sMiXZuFLVKt8nicI66EgvzzdohBtH0nMkuPNJ
	wYpS8UUPHUKKEIx5+9gp2fquGWLU+w2xa1e5FkMewInUoQBVHKXYj/3qWb+LRK3f
	P6ro/L7w0KhkVjQGQvTdEB/j/S2WfV5RRP+SdTeBX3uPsP+zpb5qOknDsZEX8Vpo
	7EQ5vkq83GDmoP6JxzG/oCtkuDrfBQQIcjDH00g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wcxz/pnJZAcXrPLpKcFqSuKNeOs/ww5Hgiz0594/3Ig=:C4Of3lztNgwNgWsM8fPPk5/AREWjsjEA8QULsygk9Dc=;
X-ME-Sender: <xms:DiIGa6rXesSuglAnVPFvQmNH9uRDOAekNAuAreOXWrrwLCE_R5aVMQ>
    <xme:DiIGawGHmvRqyFa4cHKrTorkeeqV7ffGMtmk8L4HdxbiEBETqp32t1b5yuU8Q_t7r
    IAfkQeXuVpiD3AJWF7YQ_R6NmadBADKYpzKUnzopnvWouXhPNTa2g>
X-ME-Received: <xmr:DiIGa8lpgIJXI8gO6sv8lvoWwmy8pw5K5CvVdN9_bC-g5A9E5b1cO3ebKsGnbvsLSYifiqZUP6xH1LcYoGxCo9fCgX8miIxFYxaZiUw>
X-ME-Proxy-Cause: dmFkZTERvPNkyf0xMbSXBiZW/QMFz7lDguqVQPxownrWqtbw6zZNc6PjcpyE6dM7z4tFuM
    jBlKZOji/IuGxroXDlwz2XdKlwLf524iF8uvlrQVi5UOKNpC7smSWOnMaoWGTAXp6h/oQM
    aOe2IILRapa99/0Zqgh4YL4zep17mQSKIux9nDlrnOv0qQvJ26uOWZsy7+gCF+nZoHxJYl
    bCPq7Kt14va5SzS3vMBwLuzlnKRB3KYGjp52rTn7e5EJPEHj/xWwxJrvLsxEu7BYGKA1p8
    zQPZ/96t1IQoKEDvA8zpsjZSPHf/VWl0pvPgEFoOv5Le8EhnFtlpl9rocQr79I30lrqIl2
    /qq/3pUNbnmD+gGaht7S7kMeYdBDzvCsdpctY251lRCRjeFGgM1S4OCxhXGf7i3aM3Awk/
    2pvaHs/cK4y9WOfiGxXFbODpbJz4GqjMUBOWW/ryEXuZzFo4mz2gERdKMKqYH6LwWSj3BO
    /+bztvZt811lWL1kED2S0g2O4mw/kYsItlvUgvJ+/G6ahHApDBEsWFGayZdlEdi6A8a+Oh
    JapFW8ETyyWFYn07i69X5AJpE66WvQXdVNiRSdQfukTYj0iHKar6cKJ5AdLgG0HwQrHu/B
    zPJ5A/9DA+lcuHxqNBBh5mpvBLbE6DXDaNYodkyk3Pt5HcXBIJf5n8kun3FA
X-ME-Proxy: <xmx:DiIGazkkzqtpsJfWLNqDTPKh4o4SOSEdnUSyUuO7iYOAveCbb66y0g>
    <xmx:DiIGa9sdPpjyVUYT6ODJTbzKhOTqx0eCT0aJ04cd6_S7s2R2Fcznsg>
    <xmx:DiIGa2n5uhto78YwgxvsnesM8OPbekbgT82AzNHTQT41prk14g-C5w>
    <xmx:DiIGa4uRTzPdYtJYkt67geJR9dc8a2mu8qCdyEt-_G6-rEfuGRzBrw>
    <xmx:DiIGa4OJkr4WBy9K3oXCGldmNrnpnJbYl_pvL_NUfBM8hKhxoKGI13fu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 18:47:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] packfile: rename lifecycle functions
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-2-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:29 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-2-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 15:47:25 -0800
Message-ID: <xmqqfqwphjw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Patrick Steinhardt <ps@pks.im> writes:

> Ideally we'd modernize all of that, but that would lead to a huge amount
> of churn. Instead, let's improve the subsystem one step at a time and
> rename lifecycle-related functions to match modern best practices.

Scoping the rename to lifecycle functions makes this much easier to
review, and add_packed_git() to packfile_from_idx() is especially
welcome because the function never actually added the pack to a store.
All callers of the seven renamed symbols across the repository look
consistently updated with behavior preserved.

> @@ -217,32 +217,33 @@ int for_each_object_in_pack(struct packed_git *p,
>  #define PACKDIR_FILE_GARBAGE 4
>  extern void (*report_garbage)(unsigned seen_bits, const char *path);
>  
> +uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
> +
> +struct object_database;

The forward declaration for struct object_database moved here was
already unused in packfile.h, since odb.h is included at the top of the
header and no prototype here takes that type.  Moving it around can
probably be skipped, or it could be dropped separately.

Other than that, the step is done very nicely.

Thanks.

