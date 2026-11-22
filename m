Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378773;
	b=vCNn60OgnrCIGl6keUgayG1NOYwOvVIpm2Epobj1qBeR2n2QiMV6xR+45meDxYZMwvoN
	 M/61bCX2RKHR/75T2cVnVTKyzBFbeSkCA0YcyFLR2oED677MBAmmboGMe0/UKCuYZasvL
	 /llsgAq8rvENxNXba+y3AJRnPoiNGNb+l7ItSelNLOToiU8Zmo8h9KoIx2dZ0/jIRv71G
	 /iwc6nQC/9za85XPt6mJfKcCs6Wi0pqZC+DtxPfCDQu6oIpcrXaio3bs2ZXpPt7R6fg3b
	 vwtQ9GKgHkxie3LJ/kV9B9luuqYkCEmhMRab39Idvo3bQruZ5bfygfA5WRZcA2mclgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378773;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vb+Y2PlpTbTe0kN0YHlZH7j02rofazl4iZAcBML9n80=;
	b=30Ah5YkpOTBwyca51mae4hZHed284mSRcs4u57KB7+jlFHALTwD5n+kormJJYuL69WXU
	 1IHT82W+EdKf+YJnGGGsKryittQRptN4FzRF7xXbxNBCDJYGTxn1jSmpCCfztBgEhmAPh
	 QpUzch41RnBlj8D9OUPES0Bei2LlqhrhchYIv8ZsvnEncNKNQF6KQ6Wx8CQmX3rPk5yZ/
	 bJypF5y4Vi+i1xOmK/VoVBjPG2P/B2tb6vIEO7yslXTmXw5WSLjG/9Eao5ta4BZigzk5G
	 EW0xPAGUKDhld2gEkb9RGJyUM6HEvNu3lIQbYSvms2WnyWGpYei3cnFLw+W7OnSg/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MtuWBv4T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wo2qBBjk;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C877606A31A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 20:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C877606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MtuWBv4T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wo2qBBjk
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70CDB14002FC
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 15:19:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 22 Nov 2026 15:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795378771;
	 x=1795465171; bh=Vb+Y2PlpTbTe0kN0YHlZH7j02rofazl4iZAcBML9n80=; b=
	MtuWBv4TXyVqCJx1znpt4yY76NAnP1lBgmBTyJhU4B6eB6gV2DcXN4StTWJAe0/6
	d7TxTptdukCLRuFQJcevXFJRF7cPs7CJ6Y5MQTzen/QffhO5/LqAYjPiv6gIuq4W
	bU4NxGNECz0nrtY/RmHVwc22O0h9br0JQs6hxmTFTufcd4tBAt9Qw0S3zp5ixJG/
	DexxI/TgGlXQ7jtIxRY8TWsMsxW62su0fvo0RsdZAW63Dv2Oq/wvpYI1QKiFlPBr
	8TWurN0EYUDLklsEZ6vUQOC1jFGWCcmSdnr13M++gQiOKh/jH5eQssDTHsFyupbi
	NbOPeRHw2ATIndzsbmR7Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795378771; x=
	1795465171; bh=Vb+Y2PlpTbTe0kN0YHlZH7j02rofazl4iZAcBML9n80=; b=W
	o2qBBjkfLbyMuLr5WO5ZkWRJ4qZcf6mJlaRNPn51/kstyJ1gWBqOQUP27vBZDwce
	eW+JL8LZ1VS6EGKxuV2/AfVgKMGEkNSFgwrYd8BIuYFBS0vYoFDJLzbxRdw1crhI
	2qyeCJJpB2C9KmnPVu8nqwVKOW77uRutGSecmjhN1hSw5uZIM1TlZLt0V+uKTPwu
	MZh203xnM9m4Q/79FV3wcCZ4WVgguquiw38ZPv+9FRWHDvyijcK6vWb6nSM4jvK+
	u79aKIa4OQ/F/WZwFhm1ETCLKjbaZ3dyj2+fnv/uiz9V/pPH9glmbg81QmoUWW9J
	+n1/c5D+Kod3+ICij8+IA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795378771; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WSmbhCSPNzMvsC+ggBkpxcGUO4H87XafScUn1ILs8phAnsw
	l1ECyeBNDNtiG3WmHZG6JNJh2PKD7Oh5cTYAUNe2lYtSox720WivMJPehHI9UWVE
	Q4XDkIE53YMAeP07d6XeoKQMdvEOLT0jSGaMVER4rOwGs7/nYNv2ixe5j3oQjk97
	kOqyaotBQkR5K9r2xOK+xOYx1v1CcjIpQkJ81S1UlH2264AXqBYQjzj/r85QDrJd
	ztWVpFGpRqxPGJCnJPlvP6fidmY8pBbE14WHJUQjgHEQQHm6WWopVE4fIA5Jt35z
	wpLoD15AgDzyRvmrULz8iheEs6/+OzaxfPG+tpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:K7KGzRTBjGcQpKYGgiUS54KiV4NP7lD7y7fEQcHo5Ls=:X95/I30g/05ynB60crSjWFHvB3xeUnbIcHV/8Uh1IKU=;
X-ME-Sender: <xms:U04Da_Vh1faFRX1hrYZ_sUxCu8Kvga4Eq98Th-XJyEwGcED55HoSUQ>
    <xme:U04Da_DKikQSVCJrb5-i6Ivsd5GXUjOZg0uP5hcKaSHAl5rf0PyIEe5rlCWuIEAUr
    HiyHdE2hKnQY_F3eggC1dn_P2l7pJr188IgGF1jsvEquCYwhXN1IY8>
X-ME-Received: <xmr:U04Da4wQKkuqGuucVC1kki4QvGYaAC8yQCwAdzEZZAmz3d7fW4edzpNmsjs7QCG7XRf00T9xwr028X5NeWuQ0qz9Yf2v6FGEO74KZcA>
X-ME-Proxy-Cause: dmFkZTF40bVWoij9TJKj4X3hSEiWFQFXTgmlDN/2m3dpP6E58Ko5EPpQJBvB/oA+fpMcti
    65KmmxVjFv4ziLrTYF3JJLxFwMf+G2/XkDFbZbIAr4cjJ2/nadWBIW+xtrxtG6FjX0Tb9a
    3jJyKxhCmehzRLt0lIiknvGW7zFWi2X5fGupJQ/dHhklvDCgXYLknBLZgG//cYZfBg1djU
    y5EKJQa3rVSIaHt6Hp35K+VUdCmoPo5EyuGSWVpBJbXzlb9y3Fq6VS7MIaZ6MTnZJBWdwi
    9efHHsYIalD8HvBvArUkudgIQMxbrG91Xxq848hfsUZ7QBrE/wCnuAODrSfKkCZ3ZzH5LF
    8rp4JjXeDPThtEBnUluPMkjdG372jYTfBb2ppGvZ66o/DFfYrii2FanX7gXC4z2yxiiMHj
    /3Qi58fq7Aw0dCX4hB+Bo1sUT2hcaVg5QSAX/bpxvYmqUUAWjrUoW8f0hP/vka55Lgr1Wd
    pohgaROKA74Eac0U6F7AyaEWOLVny0oZqXFddBuDVhcT5JHgnc3ZXSUroZROV1KCdlBlPy
    zoFR+UzfjCu6bD3PceDewB8LqiLEq9/KF7OKBzv363lvCC9ggh9D/x0B2Pmd8QuURd2a8d
    WmhtkDbtxhrgdC0MmU6hFbgTBBPqR/TQO59Z1QDTX9jN49jW3HY3nGZX2Bbw
X-ME-Proxy: <xmx:U04Da0BXoV1azvqahmmL3tVKgHb3oBlsOwgyaoajIO9g4LcPh9Twnw>
    <xmx:U04Da9YhdyvcOLiEXo93n22KQAL_G7WrPLydp1gMshJAW9yxU0LuHQ>
    <xmx:U04Da0gt-VkNITiHlY9JR4USdbsk7eN7JKv9Xh-alhUEgh5BZeE9RQ>
    <xmx:U04Da34B-snMsS8i1pIMnAIQLXmy40Q-oNxPIVkCveIE49Ef_KuqSA>
    <xmx:U04DazCBGaO-LvaXkm49pIVm5-f8lJEW-rWBwcBGMlo3jLVuQJSUJ0lJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 15:19:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: update-index: Format options correctly
In-Reply-To: <20261122152538.107580-1-omri.sarig13@gmail.com> (Omri Sarig's
	message of "Sun, 22 Nov 2026 16:25:37 +0100")
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
Date: Sun, 22 Nov 2026 12:19:29 -0800
Message-ID: <xmqqfqwsk4a6.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Omri Sarig <omri.sarig13@gmail.com> writes:

> Subject: Re: [PATCH] doc: update-index: Format options correctly

I'd downcase "Format" -> "format".

> The update-index man page had references to several options, which were

I take "had reference to" to mean "talked about" here.

No, I am not suggesting "talked about" is better.  "has references
to" (or "refers to") is perfectly fine once it is written in the
present tense, as the early part of a proposed log message is
supposed to give an observation of the current state.

> missing the relevant markers, causing them to be formatted as text
> instead of as references.

But then "as text instead of as references" somewhat misses the
mark.  These parts of text still refer to option names.

They should be typeset in `monospaced`, which is the convention in
our manual pages.  And that is the issue you are addressing.

These changes do not make things worse, but I'd prefer not to see
too many low-risk & low-value patches that address overly narrow
issues.  If we compare the resulting text after this patch, e.g.,

> diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
> index 9bea9fab9a..9b956216d2 100644
> --- a/Documentation/git-update-index.adoc
> +++ b/Documentation/git-update-index.adoc
> @@ -57,21 +57,21 @@ OPTIONS
>  	updates are needed by checking stat() information.
>  
>  -q::
> -        Quiet.  If --refresh finds that the index needs an update, the
> +        Quiet.  If `--refresh` finds that the index needs an update, the
>          default behavior is to error out.  This option makes
>  	'git update-index' continue anyway.

with another manual page that has these mark-up corrected in
Jean-Noël Avila's series from early this year, e.g., what e9a99ef2da
(doc: convert git-format-patch synopsis and options to new style,
2026-07-23) did:

 Prepare each non-merge commit with its "patch" in
 one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
-for use with 'git am'.
+for use with `git am`.
 ...
--<n>::
-       Prepare patches from the topmost <n> commits.
+`-<n>`::
+       Prepare patches from the topmost _<n>_ commits.
 
you would notice that while we typeset `--refresh` in monospace now
(which is a good thing to do), we should also update the enumeration
header "-q::" to "`-q`::", and also "'git update-index'" in single
quotes to use the same `backquote`.

Also the way these changes are described in Jean-Noël's log messages
is quite good.  You would want to imitate these messages.

Thanks.
