Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042723;
	b=1dVM/cw9/4+xsoTBlnUZhTl5j96JUEyqPphAt+twfunfYzpRjNTttu0fEiu+taJKgwoN
	 kL2bj7rDhviFgPx2W1USAnXDOx99VtHk3E6PQYkvUNX3/rr1wikw6Fz6csDSbvAkCP+Zs
	 aYs+diSgFiLHa6tK48UeHwNU0TVP17/C1pbmAuMZkaY+MdUhMav0w3khUZ1hXeJ5LCewI
	 LfnNLX74xHIYhOl0Gjw0qNPaWLQL3kDYhGlc/11n5UlNX1qw78uwjEOJfzwNJfVZg1Pbg
	 GvEiF9C3pKEoVICT8sSgb7ltV0Z5t8/svlkBkBq5+3MStHU9OGKFB87NqvDTxO5tlDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042723;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=LX0yuDxdVLZxWIO1hF3t++YlsngirPpToZOFC70LZbU=;
	b=s/u5CBp8XlahS++LNdlLeBegbw9GOvVfdMQ7+GIhWvxc6LtuEQY1Yly9jt3uNyiKqxgv
	 KxIXI/t2kvSwmJQ7ePcCAZVzYCHrPdlouZRuW9qIzabb8nBptG/Tc4d+9HX6RpOWlVfX+
	 OUxM9wN4ikuLChaiKONZ1TJ4rRH5w5MqthalXIAbp4eXWGKreVuu9wT7JEltiAUK/eMBx
	 N1fnleQ9KDz66Q9fzPGhh9U7vceV0WPnoZZpmEGWPpt+deXom9BYMreet+vx0NVPCmXzm
	 K0k45MzOP9q3AVFfUZ2hl15fxLzjuuSIuoYGfyTqzORcvbWEcwurLk29tkGwTFGHMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=OpghNYLM;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F305E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=OpghNYLM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793042719; x=1793647519; i=tboegi@web.de;
	bh=LX0yuDxdVLZxWIO1hF3t++YlsngirPpToZOFC70LZbU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OpghNYLMUUfNCMPx+4zX2meLaMd/8GY8+ZQnHGA23QQ62GRm5RMNSSLnvLxRmksF
	 uRePYNSXttfps/GwEA/ITOTC1pYtzg8lv+JfaKTv76pGepEARQ8pUO6HSs7LDIj1g
	 /ibAmFe0LLidd1WZ0DWYQB2RDLQxdbMO0nO3XhJCwoA+3T+34HaBs+soDWRJqDJzV
	 H6dikF4WZ+S98OQ5NwxAWZJqmAQ1KmYPg1aM7yRJl/spV7o1G8/06vQZbNW8dmscL
	 rjdKmO75u1EVPAHXcKqgw/BsIwzNL2zgA94lJJRtWPX6DxGZhmC+cjMye+1jLzkPq
	 a22G/HokdIDXaH5Ffw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0PR-1xQbn13ZmP-00CPRI; Mon, 26
 Oct 2026 20:25:18 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH/RFC 0/1] More cs/read-cache-conversion-size
Date: Mon, 26 Oct 2026 20:25:14 +0100
Message-ID: <20261026192514.15844-1-tboegi@web.de>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWDRAy44KYbRmaIVHdSJABi8CeYni88Sq0SttzCMURSZqr56N1w
 GC4f8EY/oaIa6Lb0KAHp9vdbSsmWHiNiMCpS/B5JP9bTCwszBHqTRJsgvAXAvkjXaym/KwF
 7MP190ijvt1FzqKKYfFqaHBZw9K6VbhlFxAlODZ7Wfe8+QGNyWHnDWNoNAL8cDRal24a0JL
 suEze8IBUkxWGbjMCJIUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fth+cPOf5J4=;S4XbsTDtSEwX7cHokikRcHNcwoV
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Add an addition on top off
cs/read-cache-conversion-size
It turns out that we can optimize even more here.


Torsten B=C3=B6gershausen (1):
  read-cache: optimize  file size change when conversion is active

 read-cache.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

=2D-=20
2.53.0.154.g7c02d39fc2

