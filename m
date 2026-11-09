Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.234.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233680;
	b=wM91bSVNsDC/Ad/GTazsmuVPflOiscWAeeB7e9fNZK9mKnfMhGlH7xjX4xSIydp1MihS
	 O+FKRriCP2kbR6TbM09/uJfpRVEhhw4pDmxxHETFQ9VzOowM9zmcRXJxYN44AdDntbsSx
	 PeTbVO+OcEBS6V+HYfzT38F2lW8Ci0K6nqXzotS1BYPKCAA3dhDbqeOKJnAFfPy4rfRs3
	 Qkt73jSuanEPU+3QOv2pxpeBwm7d0NGpV8sMdbc3BPLWlWF3QBh/ar2XsUfkgfShCAXz7
	 XZRiOVUePWPLypA/uqPwNiUDgsSCutKigKFwCbqKJnOhywrES3muw5DRGYglgNSV1Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233680;
	h=DMARC-Filter:X-Virus-Scanned:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=VYTkX4EvKC9lyFxxgc2ru3mxQ9ECzELWmBr9xwL7lVc=;
	b=IFof9DXpecWXnfZ1Zn9p7fjCwenpq3UY+CnkMOOrBqcg9ESIAhgM9FlBdKQUqvZuhTDF
	 Dxws3f9nZ10Czy7SrQ/qzyfB3Ydqt/AM5JeP9zIRof8r1PLqst5XSEiz2VPLAmbOfoEO2
	 9wpTKms9s5m9F0EK9Pc4ne2GhPA69Jw+ROZLQHvHprhoppfYwy3QV17o9gHOErvpcFJe0
	 CRG9w0lVMmx7SjAyOC1u9jvoVXL1SweqHt0OSNcHI9k+IwOhYpMhY5ah7F9JceETSwWoW
	 +02rzymbctP5rOod68qwNcGB8AytWkMorw+3eHPbp5p0H/eykJ2QtGoUjosxNdIuFeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs-ware.de;
	spf=pass smtp.mailfrom=cs-ware.de;
	dkim=pass header.d=cs-ware.de header.i=@cs-ware.de header.a=rsa-sha256 header.s=mail2026 header.b=g+WidvLj;
	arc=none smtp.remote-ip=213.239.234.118
Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB1606A332
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AB1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs-ware.de header.i=@cs-ware.de header.a=rsa-sha256 header.s=mail2026 header.b=g+WidvLj
X-Virus-Scanned: Debian amavis at srv1.79p.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2026; t=1794233668;
	bh=QFZVO3ywRJqZJEhVLNA+832ZNcpORhW9oUDmzFCw3io=;
	h=Date:To:From:Subject:From;
	b=g+WidvLjb92UdPzjqMe3y4ny68HemRozfCSpCe1Q6G8tmeGXQNRCOGFKu5cMCGlZA
	 4qlH04p49Ekoc4sej6f6o3ae5c64XVujKIySAG0LoPzx6QDCbkZVlSBFgyLVuDK9R1
	 yjuK0MJkKAVAKkVLHdEsAmZX4+wtD0aPv6JLavHqgB3haL2wEtpTfkaMqRTVTsAqRl
	 Rn7YF6janD3ASvvoUKokdYo5FxnYbIbyuIN96ZGvLiWnMGaJhwqt1sDZAJ6VUPnQh7
	 +TEuj7cAUXwBr75ze3V2+G/qW8e7sGVWIjhA/b/LHkpw7XydLmCn0BJirULMrR/Jda
	 EC8hFLHl2UJcg==
Received: from [IPV6:2001:9e8:2be1:1200:30ce:ab2:f448:c572] (unknown [IPv6:2001:9e8:2be1:1200:30ce:ab2:f448:c572])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id D082B600119
	for <git@vger.kernel.org>; Mon, 09 Nov 2026 15:14:28 +0100 (CET)
Message-ID: <9c54aa5a-f359-4db8-a9fd-d86c48b73ff0@cs-ware.de>
Date: Mon, 9 Nov 2026 15:14:27 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
From: Sven Strickroth <email@cs-ware.de>
Subject: zlib 1.4 compatible?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

zlib 1.4 was released recently to fix security issues, however, at the 
same time it introduces potentially breaking changes (cf. 
<https://github.com/madler/zlib/releases/tag/v1.4>) such as:

 > Raw deflate that completes exactly at the end of the output buffer 
now returns Z_STREAM_END instead of Z_OK, as documented.

Does this affect glib?

Best,
  Sven
