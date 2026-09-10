Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB649BD75
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047785; cv=pass; b=LOspofOwoN8MzjlGXQ29OC/nciBy2fRFhZjFg7KP7AhVRXUjJLaYBXwiSDW/7CJaswcBDw5FAq/WWBVy4MwGnJoTR82knovvkmo5ZG9uLAaKzXK36qBk1ZoGv09YXZ41aoZdUXDrke9rNxkrxkBFbsa7hJrceRVu9WPynvi/UbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047785; c=relaxed/simple;
	bh=SmPDZb/Fzcy5ffwSNp7G/inugSy99rhx0ssJC+IHwic=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8nwYlzdKEkFK+D9Qdm6cnwZ+F/pqoXJRC0MhrlMMIOQW7ErIY3uN9aSYhKWOXWYr9qYAsmvc6N0XiXDjftH/DD7UeSaflCzwei1AZdgKqtDkQflzrru1F9mlACaWJbJ+p9K9EsgqPYqbPSEJSJKAgpwncif7fvcHe1jMD8HWYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN0dz3t2; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN0dz3t2"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98089686ee7so4081879241.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789047782; cv=none;
        d=google.com; s=arc-20260327;
        b=MuSo1gFgvpVkSvCLc2RhsXhymJhOuSNd1fjMD+LT1ksEvZqcQeqnL+8vMX7N+gsSqP
         ngfIejD3wvhmmeAeIHe3iQIkWkdRJpxYLUzS04UtnMNfQxGyyOQB9GFh+cSuV2/zE+Cz
         6ojYROakNklXA+LTX5F2qiUJeQJnJT2I2QLUS2ZWpO/52ZeKgPJmspfz+DXxUsoGa8ZE
         AI0XJ2aeN32oVR4bxkcftQ7+QJjEU1ZoaqSTMpnN5OWMwsu7Zt0c2k6ArHFQVLiI9Mfv
         PubOwtGVqLtSNtpudfOvmsxxsnFuJGIdJIfxP2zh+YC9IbCDwVAuptPzD2zkE8tXzk5j
         +TlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=rI0+3b8IUYos1Bcr8iUtl2xY6wAil820JiLzSCtDb1E=;
        fh=v/OOScdyXBuJJSpP6BDpOiPXCCd1tXSTp5+qT+6YdYs=;
        b=iCawZVo93ndAKaE7v43jXy019c9GZLQARvXvgo9WT+sAAk/OiwopOSATzhpspGw7l7
         +JkA7APHN0Fb4oNGZaxtCt46RXlQIw5C7HUgyMcaZjVNmuIahW6nkldbjX//C0U31jAx
         vUws9omtzW39gcr6DnRqvewvkgiV5Wc1bud2fLIf+IloNwawFlHr++X3Z16zxAFN4tk3
         /lbdU4D/sXso9BAsn0GHl413FrgvuQSqfxR1Pam1Hjn5ABo6/uZXzIC7PdaVlQuuipqP
         SYVHk/65OVojzHwbyfPKvRKKuCHHz8rtNuFsSPkSssN/Cn4ZxfDabCiGQQj/pZybHZhG
         GHMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789047782; x=1789652582; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rI0+3b8IUYos1Bcr8iUtl2xY6wAil820JiLzSCtDb1E=;
        b=LN0dz3t2LKxwkccL6TCFUuDaKhhpbdtz3ls/392GXnmaTjzUhDW0CLo2Ms/Jl7Dpj0
         MvPzFgBTKzJT4oRnWVm5cxo8a54XzF8jS0sHuZsCTaUc775nt46zLdKe9y33zxFe912x
         oufW732aGXvBt0tkyzLAvgJYE+qricQO69bFM9dW9N0TlVvhahfzk7aw3ols5EKvnLPl
         VjAuFxDKzH/OzQ8ol4TKWj+L1n1/oxZHjjFy1q31FIFGThCHQU7BP0Q7TBQFRH/LlE3F
         eDWFrRFcWKKxeKv3KzfEGya1hegtY/ZSNers/9CLIm2XccCMoTtpX/REKQzqjvLOAocJ
         e30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789047782; x=1789652582;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rI0+3b8IUYos1Bcr8iUtl2xY6wAil820JiLzSCtDb1E=;
        b=OZXZAz6RmoBcQ6tjli1m18zyaaHPoZ+RbNqrXcF3I3iiPaI9xvxj9BK8wwnCAhOjED
         gMjRW//uzRMSv9A7ahPcdO9C0TRXFlfG4bb5hIXIwmBoeB2suwxdOJNAP4n/GSUbHdT9
         KI0fYmC8vyPFbx+2BIox7Tn5/CiBLnZ6fpdHLMpO/2rGAfYNtmIwApuZ5DuFlb8HDg0L
         FYKfkXiZiUpiX2lUAaOLqlR2+X9YTxsMPXBB7P5kWIkgnlw1Q1WlXcOkbeWorX7hSR3S
         FnhcDaaOmez/1uwU3Gy2N1hv1OVaDWkk72JkxLefueSqcHGHR8k1Ktl7RNV6wtq6oowS
         LlYA==
X-Gm-Message-State: AFuF++nDKNZg9p2Tk1JP/DvE3Q6Fx8aiiF4pj1NE0+U6om2y+scJH81m
	B+HAG1h0df645Ne7cSIJSCYO2IyqpFnJ9ObKRIOhaf4mjFzpqxv5UM3HRsdqHsdT8XaN073gy+f
	mgxTMiwGSvAVN+EUFC9bPy6IIkjADfTUzzQ==
X-Gm-Gg: AYBFou3EkyHOvzMYHEy4dMa8tbcLfYD+en2HrWb0x/hgwCb+vK86cNDOItfgvbuDhXK
	Cg0yHigH3ieEL4G0lPAVArYzJ/LMTcYQvgAxgryOGT1xBEKQZaJSU7/7HTURUZ2bUFD7rSwstDI
	LdKH8v8ZYbdvP9dlNDpk3kkG83Dvsda/+zEVGsilBsjeMe5sF07b+f8AHh2Qj3yyfKHVQq2DTcE
	9632tSwG/5n+1rpLG3npxiLT7WazRL/vqnzlXLlxcrQlhtNFCxN+CNYuxHzZiqjV0WqmLyyQebg
	5MWDnuHZzS57YYgi3xmdEvgjh71VAqOYhNHZWlc4VMci86lNEPN+agoyjPj3s6RcxZVs3KEqHt+
	6E16Ra7zmUvWEkPYXE0PZF/JwwmIEhAhc7PaRjRzmVSFC
X-Received: by 2002:a05:6102:8498:20b0:78a:750d:16e8 with SMTP id
 ada2fe7eead31-78a750d459dmr1083958137.10.1789047782206; Thu, 10 Sep 2026
 06:43:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 06:43:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 06:43:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh5jys5mx.fsf@gitster.g>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com> <aqF0mbWgYU5rMR-f@pks.im>
 <xmqqh5jys5mx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 06:43:01 -0700
X-Gm-Features: AcwNN1XSUDmNCnQ4LeHvMkWgT_GgXO-5Eu0HFnUD9qNbp7Mqn5218-4S-8Wte5Q
Message-ID: <CAOLa=ZSJOgqiH5wJA7KZ2qPsfyBv21NB6mAwJVX_ZQ7VtWhoAg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, kristofferhaugsbakk@fastmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008b964c065b212515"

--0000000000008b964c065b212515
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Wed, Sep 09, 2026 at 04:51:35PM +0200, Karthik Nayak wrote:
>>> Changes in v9:
>>> - Fix a bug where we were causing a BUG() when no report was requested.
>>>   It is perfectly valid for clients to skip the report and we shouldn't
>>>   fail when they do so. Thanks Junio!
>>
>> It's curious that nothing has failed because of this. Are we lacking
>> tests here?
>
> The "send-pack" client we have will ask for report if the server
> side advertises report-status or report-status-v2 capabilities, and
> there is no way to disable it nor there is no practical need to give
> a way to do so, so unless we are willing to write a custom client,
> or a configuration to disable server capability advertisement, such
> a test is a bit impractical to write.

Yeah, this is kinda the conclusion I came to. I wanted to add in a test
but couldn't see a simple way, so I omitted it.

--0000000000008b964c065b212515
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38d4e7b7517910cd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaXMrTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEpaQy85cFc3bE55VzRzWHdiUm90dDBjeFR3ZHhIQgpqQUhHK2RsdHFB
WTdOYmc2RUtJb1g4cWdLTFJvUWt2Yjl1S253VXB2eWNaZ1FpZ3FSeDNNSWNPWnlEMVNxZVIvClFI
ZjR0aHBPR2VpZksxMzFTVFhMT1MxcjJLQVUrTUlHMlhia3BjOEc0NG1lMnpZYWQ5dk1zY0V0dTlT
Q3VpREwKZ2R1NHlQWmNFdTVQOWRDcXRTVENhUmVhcXQ1bndLRnVObzJBOSt1VHpEb2ZqYjNORU9K
aW03anN6akViOGFVaAptMjd1Z3lvV1RjRkVPOWVXdmIzQkhETHl0cjNlNHExNVFubmZCOUlMU0U3
NHZuOThQRTZhRnllcEREVHNEZ0d6Cmt5eHRpWWNuZlB3L1VPdzJSZVdWUWZEVDFjRENIdlFuajBn
M3lHOWc4V0p5Qk1nUFNUcVlWTUoxSnNiVEtqYkYKK285NFN5ckxsY09yNFphVmJ2MGRuM3RuSnds
amN4bFNYMVRFZFpHNXJOL1pKd1ozVUkrVmRjdktYQzV4dVcraApXY3JpUEZLbWkxQnFOR245M0w2
WUpFTjhxS1JhY2t6R2lZYVRObjRYMkoxRTN0QUVudDJsVlFIMzhwQzhBQS9ICmRiRTVkRE9ZSW0z
UEx0RFVQVHUrRFlwRmV5OEREN0k4QXIvTWcvbz0KPUpGSFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b964c065b212515--
