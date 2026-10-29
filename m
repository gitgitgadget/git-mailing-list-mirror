Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284544;
	b=uAe1s+SgLebjK+6JmgLnSBGTg2EQXNMvDZ6jIZJsvuJM95WcJtlZSLtvoi4P2obUbZet
	 ir47lpFJZZ1lM9tACVBNrm4uR3q3Q13bR5Wvd2NhcM7MRnQ09joMOMB7psD/l+IXWKTGF
	 7sz2XZb8iCa6VFHR5yeQsi1QUhf9ibXr7YtMGgB/xhGZu5hH6mSctCsmzLJdp5P72X6EA
	 oZhDVN52DhM/Wa2ATZGnx7z1XKp0DJqC0Ff74KpDxEEdx+zRANCXohx1DfhpZO8dkNLyv
	 k+0tzrwplGbqBU30z8AW8Knez+m0cpvb6HxY3RF8vXvr33xTB6k4J0w8iXzwCZy97Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284544;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jC/vTlB8e9IutayxRy9HmxeRNjsfWY2fPOGAqm612YA=;
	b=A75V1OxoAUvKVGhsZ3FJg3Yr7JP/15G+mrLA0PDiXQaprPsMKkQfSYhMJY4DUph+A6ah
	 YykBMf9iKGfX3hYHQEilFYxzQnYrg8Dq9jVbU2CmhqDH05wpdMAS5o88mPUrYHqPaD+fV
	 NNp4Eel14wK/Xw1gwRisA6PRZrEYVeRiL9I5u8IrGdiIkX88RwHk5UuW6shKwU5bZJMev
	 R4ar4+foN/RbLgdk7nyQOn4saBO6xSVeXSfVb09G/I0+nfqaX22WikCZMrnrswzMKR5rp
	 WxdY8gXRISa4Kxz9DYCcxxwS+BQwQsrf1qtBP7Ol9uH4P/31I0w7qDNmtW2+t1zcPrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y5vN9muX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qpHiuX1o;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7A606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y5vN9muX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qpHiuX1o
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E63391D000BC
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:35:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793284542; x=1793370942; bh=jC/vTlB8e9
	IutayxRy9HmxeRNjsfWY2fPOGAqm612YA=; b=Y5vN9muXyIonh4WZwl/Zk4L1Tq
	Tg33l73u7NCvcb1mFv7jpXqN3S+aZJ9VCV0arGz2AgWSIjkj6aTTHzkMAnTRZh46
	5zB2JlSxsunSXZ70e3vasQ5bkGEVpdj82UEBp6JPhWOybpuYfozFmQC+mX3ihQlt
	Dkknj+Sq+LlDijp2BxESzRiEfPcLQOqbbptag1Ok3aCC3ryFquOR66E02S+o9ZR/
	cgU2ppPDtzTVmNU+StVYGKU4Za3FSrZPXEsXSFXYBTk7Lki7l1Psji0yM9xVgOM6
	z7yfN8cXsiNDK9mLInAmzg+Doyh1jJ+7uSoX0RfbPtXJiBJdfumiJnC9T6pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793284542; x=1793370942; bh=jC/vTlB8e9IutayxRy9HmxeRNjsfWY2fPOG
	Aqm612YA=; b=qpHiuX1o+qW+41j+liv5uttJaczYz4r7jxguhLRMdtSPxeKAN9M
	wZiekIZcWycEXTGPIVwViWy9+9Txk+vYPjEzW8yTO9UHU1FToqV+HGlAZwUC4i6k
	1JQVSn0kdjMuqRatGrSO0i1AuqZdSAs3u0eEcKF+CTic1Alj65WATqPBUGv351J7
	C8HvctGTyf0G1ixMMebexptka3gHiTE6GghCQ3zsii2L/XzIjg4JVpnK0aE5U0Sj
	U5naN61iA+m6kNK+mWoEO16p0Cf8TVwq6EUssE9m9WrpqxEEkFGn8bvDZFGo9+OC
	SL9N5AwLUetKbgUNTPVgE9ARbk7/pjbqBtw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793284542; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RsmIIvKz2XILHmh8IM0BiG33QAFNw8fhPXhqCrz4a8ln2ag
	0BYZpDnqr8VYoOuv0q9Nhy2qAiIVjnVg8/Mh9caS6b/0SjjerEVSWaX3G2LvR+Na
	gEiTobS9jhOUBl5WmC0nLti5dW3MWxNhFONEI+g62FoRcVLvQ7frghF9q1A5zByG
	hQKBXLPBrxae7u2n88T55dZbYDhLhDJk3xuD8WdfH1FdXef9J+UrKfV/BGR675zL
	2IgHuJWYRDQbP7oJm39jjFc5cU1WmPHh2xKe6dcwl5Ydd8ydjNz5bMNjmo3irySn
	aja9pL3TGIXxoUrnteRhPfORY9Cl7vjf0/+Txzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Dzx3NZicf7Z6SxTyzqF/P7UyJC3vMlknXYy/pF7shM4=:U+vNrKArjwPCMBKcoSUh05ueA0Qy/q8cH8Pe/UU6ghw=;
X-ME-Sender: <xms:vlnjahJ5wfTgeTEZLIIENiN2LblakCfA2RDm0kUH20qZXlxUTfXJMA>
    <xme:vlnjakJ57aT0IALGUqk9NMd3MRY7BD7np0bUfPf0ccivNRhOICar0obrnmzRXJdm0
    nLYx__z-z6FWtNTqaE-LqhiYSS6FsI6c-O0Tr4W_v2eyyZXimAny0Y>
X-ME-Received: <xmr:vlnjauv6zwbVnruoEWHsp5UQ3f2myor_PeVucpvJW1bVyMQeA0b7R5vGB0B4gmyzpnX_kGl-VkMbOeC28q4u-qtIW8OGgVVaBwVw>
X-ME-Proxy-Cause: dmFkZTFf4I5sVbzCaqXIw4/asFvRynW6vFvU3tLjgxp/2y3yyPxn5IsbmpiXqnnBXGzrR6
    I9K9SDTTHb5ywaCciYFkZidJeZR1PbiypsIx/qWiinXd6QUWIA4xCWuvUHHXvKkBESC9R+
    PDKk7mb1gMadYe+PObQ1rcDgitxe0fp2aL/hcSwZoSQj+Z3lA8K6nMFlyZ2ynqIiD2PWnx
    m+5o6OuFIjtUugF6MT49lcU4mGLdv40n5H4mmAfu5gJDqgIEW6geHpYHTlmLhy2dSqQC4j
    OvA69aQ9fc2u8Mzjs9URBuQDW0rsfeYP6C5ldhZUF3CR0L4HizwwlOb7Klr8+RSmtr9pte
    Ndwcul/ze8Xoit2QwIChCwBy8wrMAZ2kY3Uof6D/l/ZwNL+brqrKPqJhd4ePw/us8G11/z
    7Pn5FoWk3Ok8OfJyGfVEbo/reHtJjPVZW8Pt68YSu+dWe57xAx98Lx0t3m9IPh+Ap5Dy25
    pcxhOFdJG6q255SPx5LO52EU85AfiYBotdtdrCiQeCUcdmmfULvUVX0FzdUd/+HL/VLvz3
    /IdbbbqN5Xi0N3siBVYMTHNqjkXpoQ6It3LeiK1M0PKigAKd5KOr1CCq0p9QK8mL8tOqfA
    qo0Y3pM1LQoiREU9lGTisoN7NY+ISR84GZzHr5lpttahhICGcsSWt3D8LdfA
X-ME-Proxy: <xmx:vlnjahQGwbX5ro30enAaMh5-YbTrsE_yHW_NCS5zIsxWknQGLHzWKw>
    <xmx:vlnjakPEVm71MvQj8q4vofYTY_owYkEgBlQ0Vr52dZYksOmb-uOcyQ>
    <xmx:vlnjamYQoEVi_IJ6-2xA_Zot7vMWQhAsnB8MUgflZIiF4mSkL6Al9A>
    <xmx:vlnjauyy1Y11ieTW_uNObhxMaSZpb9HVLK_obXQIzCHyhHZaZ-mI1Q>
    <xmx:vlnjauPUVkMSDBh5XOv46kh73_rH_k9gJD7Mqarx2NcDztPPB7ORUY3z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 10:35:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: What's cooking in git.git (Oct 2026, #09)
In-Reply-To: <20261029102756.35612-1-iwiedler@gitlab.com> (Igor Wiedler's
	message of "Thu, 29 Oct 2026 11:27:55 +0100")
References: <xmqqy0blwbyt.fsf@gitster.g>
	<20261029102756.35612-1-iwiedler@gitlab.com>
Date: Thu, 29 Oct 2026 07:35:40 -0700
Message-ID: <xmqqbj8c60cj.fsf@gitster.g>
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

Igor Wiedler <iwiedler@gitlab.com> writes:

> On Sun, Oct 25, 2026 at 05:18:50PM -0700, Junio C Hamano wrote:
>> * iw/connected-deepen-fetch-no-alternate-refs (2026-10-19) 2 commits
>>  - odb: ignore refs of shallow and grafted alternates
>>  - connected: negate alternate refs in deepening fetches too
>>
>>  The post-fetch connectivity check in 'git fetch' has been corrected
>>  to avoid passing alternate refs as positive revisions during a
>>  deepening fetch, plugging a severe performance bug.
>>
>>  Expecting a reroll.
>>  cf. <20261020075536.49286-1-iwiedler@gitlab.com>
>>  cf. <ats6VLXUqKwKZzIY@pks.im>
>
> There have been no code changes since v3 was reviewed. Do you want a
> reroll to fix the threading of the patches under the cover letter, or
> is there something else I missed?

Ah, the above reference to message 49286-1 from you was for the
previous round v2 that promised a v3, which was where the
"Expecting" came from.  I should have dropped the reference and
updated the status when receiving v3.

Let me reevaluate.  I expect I would end up marking the topic ready
for 'next' and report back later today.

Thanks.
