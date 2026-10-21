Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792576878;
	b=b0F6lteeVjGp2YWwx8rkmZ4xnfEpZkXENoYTb0jt5ETx+X6ifCS7JMYo8Q8VG9eqSmNF
	 tCFXfqHx2+fLmLoJta/ZPn2K5ZQicYEgg9RxHpEnLPPYSLN9mcJ4NtdvRyyIl8g0/A5kn
	 zuGdixfBsWhTZSI9rc6NcPHbta8b7nmdjnW4IPl4KEXbkNrfgJonZMIwtJ+S133XHR4En
	 SHdE/kFivdbV5v7eL7PgG4bI5LUcaKpDOUVXPvJDaX5CfAjPVmkXIc/gO9IIXNlLIK62r
	 oxxEfcx/xQsEcO+pfF77gyln2IfFcGvalLc/u/P1owiYpqbSutTBtc1gdeH4o3fSp/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=EX+CwWtpIimr89qqnVR3syeBrGDcLICbRND16I9aC2g=;
	b=CS4BD8gzjOf4eeVJ3lubjZ1HyBS0te5IlL0dYAbsQcN8DkSfy4Ke7QVC7DlfuU+PaoZE
	 oxiwjjfraK1GiKx1pWiSKZh+hz/Phbq3jDa5ujr4xfLp3bYNKn3WI+nwpBZfcQEh7DF5j
	 xfb35jsmN/3NxT7vMgYqZMxXfG/mwJeW8Yw842KyVrMhoJmdL7/XVs7noMbGaM5PMxmyY
	 zNixL+dykzruci+3hw6eiiFdLmoN2vXfW3lga/gBsfZfiV+bTa1T2UW456LiClc0N5eZH
	 urEsVROdxvv08Z6YBXYhVeeNO7WMq9J8TTv8wSE0B3MQcab6x3kcAdGlk5/+H6Dawlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQB2qMHh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969E606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4969E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQB2qMHh
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso211220e0c.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792576877; cv=none;
        d=google.com; s=arc-20260327;
        b=JNljEY2VoSSuDWjRV7d2X+EwwwAV/S64ysDsJIuk0JaTS03dYtuAjHSYuhAyn+L7p9
         UNIWPIdmYOQWFd8vgmDXSlIDsa0iz3qM60fH5FHdh5bd6Bdn6AjxFGW9y2MGPNH85gtm
         XPAL76xVae9EJ6tRbVmh5kKH+dK683NdNlxuaPwWYucD08zo7zdA2Bpyyy1Aq1OzymaK
         l84n9j8VhJTSz/foEVRKIXmA/AnGL+DOgHIJJGgZW7qGc+t+vWqMzMXONWNZ+aWt7hIn
         fHOpt27WJSbDuPVoe8kg6/ZHduDLgzVbUfra/8JnfbfhrrIBORCRz2wdi2DHgoT2w/UJ
         ZDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EX+CwWtpIimr89qqnVR3syeBrGDcLICbRND16I9aC2g=;
        fh=4UlOiHsp42ppYngFVcbXqub69IkUttaqTnbrr2cd7YE=;
        b=V66XUqSoUIgcgN60quavBnKulvhp58RrZAxKw9CzrmhL+mwHWjzfVl2xUfcIBLwwnp
         gg7Y0WMFo4deARi1Cv6swO8FGIDL/RPM6I4DRrBc2b1fAjbrjD5vyIIlKdgBhqIl/YQ2
         sN7wFnOnRJdMrGYABcZwoMmnJPrC2bFGMI4STIJxO68GO6GkpgJWtMXF79Xb9emMEB7Y
         /5LUabdXubLaqYSUrZ5YuPlX/e9xaPm4St7q5unKltc6ecLCJvC5R5a0jo6u6AxWVIxb
         oYygjbAzoKnFRQafKqD178agsGaCsvSD833as3rVrMhDgn/SUgfZALEbU3+0Fm8eIZ5v
         mihA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576877; x=1793181677; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EX+CwWtpIimr89qqnVR3syeBrGDcLICbRND16I9aC2g=;
        b=GQB2qMHhHegTDamC+EK5aU8B2kNj91+CWNEaOvf28d79DZcq1CQMs4saZYxUOPgSiA
         g1smhTspcMxAXjuIaecBsnRqzcbsboED1zjomwqCJ2F6psn0tKYDKtGwsTI6w2hP2jh3
         0xf9IxolnvAclBlOrdYe1PPSAXI65Ot3quafppGIYaTM5lZwtMVKhn59YibRJq02yEg4
         6IkKKqYZZiI3pAPXQgdctG0VNUx1mnMwka0MLfnhueG9UPRHT5FBKbdzyN5+h+a9MYw+
         Ohg+og6rYnJ6WySjQB1j3D1RJjSfymKq/x7tGv/zydI3/oo0jmUDndXr7VWuQzoVhFkE
         Gisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576877; x=1793181677;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EX+CwWtpIimr89qqnVR3syeBrGDcLICbRND16I9aC2g=;
        b=fBXfMdqTYa7Z09BWTHHvtoqfaVqeXuCBrpqlBp5i22VLFM70t90PM03cl8na9YvMcp
         OrWbrcDPMVz9tGBYPgt6e+aPfmg7pQ/63UDAlgrZU43fHx1bWRk+TP42sNws8Umamkzt
         BQWPgWJ3EsInI94K7kWZ3AZZzsUdGg0ummf5O8ZN6q+zaN6DfFNYZSyrl8CRVv/97Pp3
         JYF/Z5rcz3unMJJCiVtIoRYvzSUGIP1d52IaBnX26TrvxIchvre0aIIzXaZp+NBIWhy8
         96WP43ZpzIm8LV2sQGR1XQpyY5F+p7g8N91VUO+lp+kAoqUUGqhhPMlRyDTe2ucdDo4N
         O+5w==
X-Gm-Message-State: AFq9FYKaD+D6vbFUnKTOhfxTioAH60Zm3esifAeX7i36yGE99Yo0hELs
	DEYfBqx4okgSn/KCvPFjQtdpod67tAvpoeRoCNWgwKlQmY/+csXa9BoaXL6REXBvQBNo27xf9dU
	IAByIyI8T9jKDnsz342/n4kcFUqHHHsbMjg==
X-Gm-Gg: AYBFou29hy7ehovzsCgNeMth9wc5IfVTxyb9CisDCLVXi3MMKf1gdwWBwfoZaNVpH0V
	D85N7HkoDtagGBJoEFh6+SyGnKEfVY8P/ocLUTj9vvTfrqXdw4/L3ZjsAEh7ygIKC2SQfjsW6NG
	MEZPM6G1JRFodE22SuAGqBRe/dq1+Id0M8yKkKjOgXvkr1/JOn5t/gogqw1HaBAdlYJzPavfbDr
	R9wsGoUPqovTUngPbqwTsJ+T/AqSlgvy5Xt81n83vY1NWEzT00j5GCMdowPrx1ukt76FCR1im85
	94kOk6hUELaXczEokb6xk87HFqTsvwYDm7DPasoN+PVV4zGmQ0O6CGp8f5N+YVIj8uY+9CR7F84
	kK3q4GFxRH2v1tuopNsihi2PEQOLNjhpYUNG8uVFVXlkFzcI59/GGYRBgjNyw7gkSZ64/HpA5/Y
	uYelNhdI0nlw1focGhrAUstq9ZO1HP
X-Received: by 2002:a05:6122:3129:b0:5ce:76cf:fb2e with SMTP id
 71dfb90a1353d-5eaebe307c4mr562769e0c.16.1792576877076; Wed, 21 Oct 2026
 03:01:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:01:15 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:01:15 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <athd_dTKZYOv01UZ@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
 <atftdOihoUHTdvfu@denethor> <athd_dTKZYOv01UZ@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 06:01:15 -0400
X-Gm-Features: AclHuK_h9Y6ofhAZ6LRSxRyF41urkzqvLczPO7CCpCK62WGEeUQgKm1MYJ42GXI
Message-ID: <CAOLa=ZQ_sgz9e4JFWj61HNnKXx+pTvTYhENbbtRu+ATUbXxS9g@mail.gmail.com>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling tags
To: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
Content-Type: multipart/mixed; boundary="000000000000fdcac3065e56d36d"

--000000000000fdcac3065e56d36d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 20, 2026 at 06:05:22PM -0500, Justin Tobler wrote:
>> On 26/10/15 11:24PM, Karthik Nayak wrote:
> [snip]
>> > Fix this by committing the previous batched update and initiating a new
>> > one for backfilling tags. Use a separate error variable for tracking the
>> > reference updates: One, it ensures that errors from the regular ref
>> > updates don't cause a total failure. Two, if starting the transaction
>> > for backfilling tags fails, only those updates are not made to disk. The
>> > initial error is now printed straight away to clear the buffer for
>> > further errors.
>>
>> Naively, I think it would be nice if it were possible supplement the
>> backfill fetch "haves" with the non-committed references in the pending
>> transaction directly. That would avoid having to commit the references
>> in the middle and probably also fix it for atomic fetches too, but I'm
>> uncertain if that would be a simple or reasonable thing to do.
>
> Hmm, I think that's a sensible idea. We should know about the ref
> updates we have already scheduled into the transaction, so in theory we
> could use their new object IDs in the negotiation. If that's possible it
> would definitely be a much better fix.
>
>> Committing the intermediate state here does in part fix the issue, so it
>> may be a good first step regardless.
>
> Well, if the above suggestions works we'd want to revert this step here,
> so we'd first have to go back a step again.
>
> If the above is infeasible then that's fine. But if it is feasible
> without too much effort I'd go for it directly.
>
> Patrick

I'm a bit wary of going down ad we'd be exposing un-committed references
which could fail as 'haves' to the server. This doesn't seem to be
conceptually correct as we now expect GC to not clear the objects needed
by relying on the .keep lock instead of durable references.

But seems like we have negotiation_include_tips in the transport
structure which seems like the right fit?

--000000000000fdcac3065e56d36d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 879a0681bab1c00a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWWpXa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2VRQy8wU1VBS3hOa1VIOW03TjRCZGhoWit1dnI5Qwp6Tk9ETHR4b3BY
bnhkeXA3UXBRSVJSYktIUkNJc3BsNVpyZ21CbTJVWVNveVp0eUZwVTRvSVphbk41MGhSY2FsClZC
c1pMSHRoNTZpa0NFYmNZMnJ3WnZqQXdhWTZybmp5Uy9oeUJ2dUtueTBDVVlNcGRXcm1xUURHMnBW
TUw1aDMKYXZkK2pVSnM3RzJqV25QaWw2Q1MrNXFEMTlPelcxUUxvc0c5M2xDWlNVbGRuMndIZk4x
WUQ2SWlWNTFpc0R6SApOZTRTdWY0RjJld3gzN3NtS1lCMGI3b000aWVkMmNWOUFOZHlqVDdVdUQ5
cTFIeXFmWWdlaWdNR3M1MTkzMUJJCjBoUFlCRUNKaWpDWWFKWS83amY3SW42bys4aHlreWwwZ1Y3
SlZZYW1EUUhPbHd2QjQrdVlyYVRWUFZGbG9HVmEKVDNXbXQ1bVM5cEtJZVhTNEJ3VkJyb2ZmL2lI
dElRN1VSdmkyWHk5RnJjcHhRbVZaclpneGpLOEpiYmV4c1kwaQpuR0NweWF6VXBCSW9vK1pHWG5j
RityYzZIV2RSU2N1dnQ2blFhM1h2b25NQllIK1VFOE9JeVVjRThiTFhEcmhYCmx2alMzalBqUnN4
MUh0ZEdieW1NMHRtaFMyWkk0ek9iYUhILzBQcz0KPUFyUUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fdcac3065e56d36d--
