Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816443;
	b=IF9h83wQvn+wYQgzMvEAk1uvbarubxi7qORJG4s6HZ0Y3VptuBKroafN0TSpXuY1Plp5
	 qGoATH1IhpJ5KEGK/KcdGx8GYv6BOAZRyy6pQv4DHSj2EyOGo58rMKXWC8bv0G6mNeset
	 Hz11Y44PeH+0BvOaoOQFasWtBAFTB7XRbE/hVAVgvgt7hQx+2X1cHwoA7RPlH9IgsUx06
	 8I2HdkWdfzwSn0xSDTHEqr/BSF3oV/hGdid/mkHkOm+fNd4jvD4Gy7KZwztCNJgsrZ9yT
	 FJPJm3Rd2Ez7BaYr3K37oQ+KOvCbvrTwssDAPqNfqT/iDaSHFZfvtaeThwFOcr4Xe7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816443;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qqKbikOJlzW7F1yXuOSZmcSA1XSRNEpX6MmzKyT4YB8=;
	b=qfXldXkbG45V5GozVnsh6uPNo0K5KXFqjpJKlsxrD8pBFxjjHN59qsI6q5SFaoPXPzap
	 fzKdfFgA1tV6wrtht/CECszgJhk4W/MhxgSOqupfhGRwYIPFvonK4PzqsgVIYyGl8Vtl1
	 AFbgAkMk/qKFZUcnFygko1D7NSg1QG8B+V08ZnmPwYNxy33Sa3EwcWGQg3/enrdk7e9nh
	 bPf//bnaqnXkNRY8YN05jvVlF1RzuWyYErRNjvWqs42tfD/vZj2ejVtZwNb/f80CyOIYn
	 XriN3P541E20k6eM5P4OSyK0Dnl4SEuZItai/ZWD8DlrVSqJPwFXwWlvtof0Dv+nTig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=U1pvjmeP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gwy4LJ5j;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F5606A329
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861F5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=U1pvjmeP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gwy4LJ5j
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id CBB71EC1EAB
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:20:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 04 Nov 2026 13:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793816441;
	 x=1793902841; bh=qqKbikOJlzW7F1yXuOSZmcSA1XSRNEpX6MmzKyT4YB8=; b=
	U1pvjmePeMl0lerBEFDlD2m0MiOesv0n9daQ0FCS+e5InHQAsAgtvv5mXZPspefs
	jEG6yIQLUWE6DLqBSP6JJWRKF/7AXVWx/AVSUGRc0Vf23+vyOYDt1tHsrE2YdYYT
	IK086mrN14WzjLm6Uk7Mnt49e9784yeNczVM/7Gk4Q93MFeO62/fX8GWCesaLgiU
	FXP074fkU+kkGO72eDQ2NLR3M+MyEXlCyt9CHA6TIIqTu4tEV/dYIlinhBJE50BG
	MBQ7qOk0Q9Y9Tr4vq39Xk1wi7vlClXg3AK6Zc08zBR/3emtvjwMB9NWtNIE2fquO
	5gyssPbGl8ws1prG8p95Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793816441; x=
	1793902841; bh=qqKbikOJlzW7F1yXuOSZmcSA1XSRNEpX6MmzKyT4YB8=; b=g
	wy4LJ5j0f4xSyktl71m5Ka31umwMX/fMDWKO1iYVy6n86JOyti8umBlHWZD+VDHB
	vfYB3VsEexCUrNzOypYwxZpL44GdOdeMpeItO6s53rmZ5uKYqWcglyTnMzvs0fIw
	A3GfwJb+PqaYPaVkcb9JUrDj4FBS2XnMZSzjWU69seKkj/cD2RafeHM07TszzPB0
	BFLDBd2LyTo//zx5/v/b9qNqJEwHz1vegvfKClVNvHh8P6vBZb68qCEEVQkZ4D+c
	yE5CakjhC0T0g6Wq1+rhUdNjiur19XG2Jvi7FT3c9an6AATbM7zCl1WDHtkpGhZE
	gvYBnu9KWtgiWjDRCp2qQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793816441; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UIgOQnZrnagD/ulM8Z6cx82lpk9bJFHKgwd6wCJa0kQLuA6
	7HWUpRrSS0o5h2614Ur1pftAmZv2z1Vr9z8jCxhoo/VkvSCRWlPozI8JzgZoO/YE
	4PEZ1Nf4RGtIPb6GPqFQTaRGfTJ9WeHVhpe8zwXbljrcO5+5qp7AqgzR7nJsrKZW
	wJAIl+0OOazr8D+NZoML/j55uG0biaeCs0W3E2kVO2Lp8vaS+88Ps9J5UK3kN0XS
	QdYRxOTj1r4jpmguNXdGCqn7ECBxcIukFHcy/l/uw8JIwW15uqMqXMtFkDbLfeaf
	zj+e1H9J0zi6ErZTj2zaat2Yt0ck88JOvqztPWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:71ZgpXbh+xdf56uDp2XNy34mUxw29m82YujqRMmekbE=:sK1M+Da5uR2wClU6M84XTVDgr7SqJygbXplUPN5zgK0=;
X-ME-Sender: <xms:eXfraj2v0vGbc6mCXlmkm5Sja5YQLCDiVSG4RYQpkAzy_vjaMmLllA>
    <xme:eXfralys0qlRVFVCe3_ceiXXtFzLZy0N1pW72bB9x9UyZtK9Ua7EEBKCCnbCKI2RC
    KeiiKI-tXrvIl2swT8oyyl3mKsMMzoxsYHgreCza3-jLghLnJpvkg>
X-ME-Received: <xmr:eXfrattlIYuSNp98PPdVNAnzcc1G7S9jqjA7aaLOQW_hWk-v4cMSZoOhpYNUix1C8qj9Ng32r1VN0Ee2_BwQyghKIQ_9qSwMoqQM>
X-ME-Proxy-Cause: dmFkZTEzLUzfiEySNxnWKn6V+L55mDjA/pEjEdNmL9M4ib5/5Ci4RPMPxqbbmLBmZP8dxb
    xPXgERadXPo8FMPDC/7VIazbHh2fZNDzTuwpDUpDqgIyqSYqCDhNlgfnzkuE8j7mwh9z31
    mwJaiN98MnbUlXU+7HLC0qE/DWUcT9jklZTbAgDl76hx3DmKlZo17mwaDcf96yZ9tIRTP+
    kauV+xE6cwHm+4GDZNqz2Xznnynp2sOYpcM6Ni9zkzh9wpxg5ZOZvI4IMt+VfSfkd5zlCT
    BAajwQtqvyRj/F5EJO7cxyetlnDchks7lnLqpfNTmsan0/0cJhP9B8FlPebQpEf8657jXK
    n23uSNRluwmgimH+nowvS1XgAfMa94LkvXKLtD1RzZvJl+9OCI577hDe+1oZzTQuQsQjVV
    NR+6OwqDukjLeDxO+Q13GUP9Ibm1Kztf16s5rFvYTkuWfI/vIYUx5KAS8bZuml+9neb6h+
    6UutLs+1TQYloMbE9WiETDT0pgPIDoHsgv+YoG4URbeNZ3zjVZxWPK/D/mYxdIyjefOoXT
    nDD22rRMFJPgNw4rbMZte9Xt6gfCqnE4OvCjB/wsEctvaonIECZTfBUZWP51ELHkpKAebr
    9JcES4cJQYWDOJRT/vCY8oSYoT8YoqGFxRcU8bV0gqGhSxtgNchfyCxf5dEw
X-ME-Proxy: <xmx:eXfravyPjPJK84mp3fUW02UY4t1KSTYN8y3wmC77cTWf05ttM3LVkQ>
    <xmx:eXfraoCF-znknEKJCRscpa38iKdp3B_khxw7aS4_InhOQT7tMckI5w>
    <xmx:eXfralf2OEvvr4abOdKg-pXLa-iVZhImKJMINVxiumsY6BiqFQKCTg>
    <xmx:eXfraqmDz8xc7jd_fIuek9AWStrwN9tx6vXpIJsMLXPylaK0MgtsCA>
    <xmx:eXfrapxARrfzyah0T1Kfgd0nweSdfYbfSidUOrA48O8hhDblPbcteDLE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:20:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tuomas Ahola <taahol@utu.fi>,  Carlo Arenas <carenas@gmail.com>,
  git@vger.kernel.org,  Ed Maste <emaste@freebsd.org>
Subject: Re: Is anybody using .cirrus.yml?
In-Reply-To: <auskIPBRorDxDj6N@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Nov 2026 13:25:04 +0100")
References: <20261102204151.MA00I%taahol@utu.fi> <aumQMJLMeI4sfeNI@pks.im>
	<CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
	<20261104095752.2rs5_%taahol@utu.fi> <auskIPBRorDxDj6N@pks.im>
Date: Wed, 04 Nov 2026 10:20:39 -0800
Message-ID: <xmqqqzh01mrs.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 04, 2026 at 11:57:52AM +0200, Tuomas Ahola wrote:
>> Carlo Arenas <carenas@gmail.com> wrote:
>> 
>> > On Mon, Nov 2, 2026 at 11:41 PM Patrick Steinhardt <ps@pks.im> wrote:
>> > 
>> > > Anyway, if nobody runs it anymore we should remove it. But let's wait a
>> > > few days for Carlo to answer in case he still does have a usecase for
>> > > it before we send a patch to drop it.
>> > 
>> > Thanks, but there is no reason to keep that file around AFAIK.
>> > 
>> > Carlo
>> 
>> Thanks both.  May I have your acks please?
>
> I think it would help if you sent this as a separate patch. Otherwise,
> this patch here is going to be very hard to discover for anybody who
> isn't reading this thread.
>
>> -----8<-----
>> Subject: [PATCH] CI: delete defunct Cirrus CI configuration
>
> s/CI:/ci:/
>
>> Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
>> 2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.
>> 
>> However, with the shutdown of Cirrus CI on 2026-06-01, there
>> don't seem to be any drop-in solutions available to support our
>> usecase---while there exist tools in general to run Cirrus pipelines
>
> The three dashes are a bit funny, but okay.
>
>> locally, managing FreeBSD VMs doesn't appear to be covered.
>> 
>> That renders .cirrus.yml completely nonfunctional.  Delete it.
>> 
>> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
>
> Other than that this looks good to me. As said though, might make sense
> to send this via a separate thread so that it becomes disocverable.

Thanks.  Yes, after showing "how about doing it this way?" patch
late in a thread, starting a new and fresh topic with a polished
(hopefully final) version is very much appreciated.  I also should
make it a habit to do so.
