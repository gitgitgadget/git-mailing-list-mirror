Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707000;
	b=ju9g8KCCqRJvuB5i3Ab4mtidDuiqApxKxRPVZDI9nCmghGa+63LUBURqv1NqKTaqhJMR
	 DGPTlGwi/5NR22ZQQcS2wfa+pbAitmOT3X/rMvQa8anu12ZxI3Tghoe6lnPWm2yeFQZXn
	 eQMEq8waHC/yZ3thoyuYSwQkP3qqtYQpyxsr7B+Zw6g6a8RZ+cV6rztS5QMQ9aHs3bbuI
	 XKZJ45exKha0WC9q5De+lJzFH89t9EbtigIW9xo+XigMXXgBRhvee+VG9mlZ3XwABsIRs
	 RT0yEZk8LcGWH4/KkYu3ikguicmeWiRkHorWd/IOZ65Njy7o9kxS1lYTjl+n02ASmWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707000;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=bmnOybfcb/+bp0mfg2S5wu4jjEjw4U35eszD8RICTe8=;
	b=c/X8CNQqeAEPNIJY88ehCXKtg8sDQnSEZPoa85uIqhvbqjIHGEpyEuhFA3BHoGD7NOf3
	 Y7Q37znY8xU7L8NO+kJC0NPpc4X2yOUX5NqHCa2r+ohp3m+C4EryWTpF1TR+pLylolRMl
	 4XqvSYnzlSxKQ2dvP+/r7Hu2uWfOMb+oygpE6AKTjbmxlHCwB0lVpIH4zhJbO3U+K9iOG
	 aMVTu/4yerFMoWFTohyC0pA+Sk0vEXWZXZx3s0UuCb6C7P/9cabc1XGV7F17sXhC0HCb5
	 wmX/yDNGxvtd72GSwRqtfM2+P7aFvtMtk5gKUZ1oAZUrZ8xVvdreIBc67hsiognm5aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2EfMtRnS;
	arc=none smtp.remote-ip=95.215.58.161
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7216606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7216606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=2EfMtRnS
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DcW7gHYDQEYo+YIdQMqmqUo5TXt/Ax+ISOownU4IsL8=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706998; v=1; x=1796311798;
 b=2EfMtRnS4ahPrMKGtq/tQ99d0aDs1jvJEW2V7NaAREVFyrzpULAV/f29S7QNWsgxKQzGGurR
 PtBfrZZcIE9k8zGONmLNToHc7PkeBcE/n5kb9babtrt62y6+fPXv649SK/dRt4vJkCoDjsr0Sj0
 yTrfMOQFwNAhdBG6TFQyZAmg=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e65280c0d9ef10d0;
	Thu, 26 Nov 2026 15:29:57 +0000
X-Mizu-Trace-ID: e65280c0d9ef10d0
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] packfile: some lifecycle improvements
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
Date: Thu, 26 Nov 2026 16:29:54 +0100
Message-ID: <87zeuvr4p9.fsf@dev.null.iotcl.com.invalid>
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

> Hi,
>
> this small patch series polishes our lifecycle handling of packfiles a
> bit. The original motivation of this patch series is really only the
> last patch, which fixes how we handle process-wide limitations. But I
> took the chance to also polish this subsystem a bit, as a lot of its
> parts feel rather dated nowadays.

I think at least the fstat() bug Junio pointed out[1] is worth
addressing.

[1]: <xmqqwlq1lwdp.fsf@gitster.g>

-- 
Laters,
Toon
