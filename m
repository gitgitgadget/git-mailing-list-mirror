Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221581474B3
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414083; cv=none; b=bnyOfNA4FG9piAzVCP9Bc3oCMhfOpg7+uAtF0r/8ThRS4102mtzPv70rihO6s/CIfMSWCO/KlFAu/TDCE0guA1aa+oEumLojbULXvwGQYJD+0KWttgHyKJ2weDewiwMUxf0FUUC6F4SnSFtrjsWZwUGUlFo8W43zolJiY7NFP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414083; c=relaxed/simple;
	bh=P723GLs0uPi4CwICjNYdsEHHhaUCbs+yuuX/f/GMldc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IAHA9oAvNfn82+Dev7SR2NWt350UC12NM1sQEsevUcgwo5hFS2cWksIk1YXfS8Dz9weTxqlCKwj+DRVboaAr2qSkS6np1pPgiyuFgDziykecH6+Q8jBvV4lfVtCmz+LsHVH9dGqtyVTFxa0sWa2iL38dMyQedqQZ55JxfmLXZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mytechnologyco.com; spf=pass smtp.mailfrom=mytechnologyco.com; dkim=pass (2048-bit key) header.d=mytechnologyco.com header.i=@mytechnologyco.com header.b=dby7dbVo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mytechnologyco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mytechnologyco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mytechnologyco.com header.i=@mytechnologyco.com header.b="dby7dbVo"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-81f91171316so1427350241.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mytechnologyco.com; s=google; t=1721414081; x=1722018881; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6PZTJ8+f2QktwtxXpm5fQeVDwk3UuImeCdRaBxXObgk=;
        b=dby7dbVo5qzzaSaa/fYL6Xh5gXeLB3CsyWrx/lRvVZXlc356aVWk6DRB6gI0cR+Nla
         IfWOYTgQpwxa1drAgNihFzUQEbgpR13XlNz1gsYJSczA65I4SsbIkblj/SoL23vYGb4F
         Tun340FHYy/bv4tEbaXiG7UsW5RC86Eyn7GSEdiB4G0PhmkrUdDtszahF6yMOOY17LLm
         TlwPV17pn2IAPO1GPVujf0n0g5iINb7R5W51YO2yBJs0Yjt9XbkABVPbOPobEJI0IEdD
         DgpRaI1MSru8vupyy0cGz0P9x19aXBsOKdqnsn/gXInwONGMAzP4CNpinBIjt8J1tHwN
         AxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414081; x=1722018881;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PZTJ8+f2QktwtxXpm5fQeVDwk3UuImeCdRaBxXObgk=;
        b=QiKlmj09fExIHWGhKBPe2EeL9sAVpOQj/fl8YPViY+ynth+vvXqdv8TZx09XBR4N3Q
         2akDemS+u6HAw7szVzCzJdkeP12m4Kv/zX1c+7KbRWD15wguhH+Tyhc36DnwBc+3e9Z5
         sTwJFMYNzD78RxFoZznGmBYd4EWxMjT7AIrWroh22n6jXStU5gXuMICzk8RcoSxnlmRJ
         sbN0KqtToD6m1OWx8LNVzMu0l1k2CqeZs33wfKahwxZq1G3Cj5jfAgPwSX2/L94lATlH
         C/NhKpVUz71oIgcvfBQxgp+z0vTWc9wiuJU0paHrojZ5KPIKRsrObueM7kpLu42CnDZn
         xhQQ==
X-Gm-Message-State: AOJu0YyvBpapavIDn3HRzzWdj3wttZxMRgLe+CCwgid+2m0C1JoxxMC6
	RHbmfdrWt+Vq5qnt6jRU4G1WM8UZW2wNsFyr3KWm14RKV9FAE/2ZMqqItnv8W2+cEL5VyifP9O7
	nlTx1LqHwGX61/kDE5xGnnRncGbziYIw28CMqTY0/lKaINOBUbYQ=
X-Google-Smtp-Source: AGHT+IF2z9fVI3dd19bGgqjHgUqYeYCMiF6QXLC+gtRPj7tWNlj5ML2/SZRl1ak2UvbUQo6ONKW+OB+vkF9LTiFmAwk=
X-Received: by 2002:a05:6102:150e:b0:48f:e729:f45b with SMTP id
 ada2fe7eead31-492842ada08mr716890137.8.1721414080764; Fri, 19 Jul 2024
 11:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roman Dvoskin <rdvoskin@mytechnologyco.com>
Date: Fri, 19 Jul 2024 14:34:29 -0400
Message-ID: <CAKexjB-+6VXE8YXrc1YaOVE6bKs05Ty4XHMSBPRHUcUrxpp31w@mail.gmail.com>
Subject: Bug report
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cbcb65061d9df2c3"

--000000000000cbcb65061d9df2c3
Content-Type: multipart/alternative; boundary="000000000000cbcb64061d9df2c1"

--000000000000cbcb64061d9df2c1
Content-Type: text/plain; charset="UTF-8"



--000000000000cbcb64061d9df2c1
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--000000000000cbcb64061d9df2c1--
--000000000000cbcb65061d9df2c3
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-07-19-1426.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-07-19-1426.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lyt1hmxe0>
X-Attachment-Id: f_lyt1hmxe0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkkgcmVuYW1lZCBhbiBleGlzdGluZyBicmFuY2ggdG8gYSBuZXcg
bmFtZQpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpX
aGVuIEkgZ2l0IHB1c2ggSSBleHBlY3RlZCB0aGUgbmV3IG5hbWUgdG8gYmUgdXNlZCB0byBtYXRj
aCB0aGUgcmVtb3RlIGJyYW5jaApXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZp
b3IpCkkgd2FzIHByb21wdGVkIHRvIHVzZSBnaXQgcHVzaCBIRUFEOjxvbGRfYnJhbmNoX25hbWU+
CldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1
YWxseSBoYXBwZW5lZD8KSSBleHBlY3RlZCBmb3IgdGhlIG5ldyBicmFuY2ggbmFtZSB0byBiZSB1
c2VkLCBhcyBpZiBpdCB3YXMgYWx3YXlzIHRoZSBicmFuY2ggbmFtZQpBbnl0aGluZyBlbHNlIHlv
dSB3YW50IHRvIGFkZDoKClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQg
YmVsb3cuCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4K
CgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjM5LjMgKEFwcGxlIEdp
dC0xNDYpCmNwdTogeDg2XzY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApz
aXplb2YtbG9uZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKZmVhdHVy
ZTogZnNtb25pdG9yLS1kYWVtb24KdW5hbWU6IERhcndpbiAyMy41LjAgRGFyd2luIEtlcm5lbCBW
ZXJzaW9uIDIzLjUuMDogV2VkIE1heSAgMSAyMDowOTo1MiBQRFQgMjAyNDsgcm9vdDp4bnUtMTAw
NjMuMTIxLjN+NS9SRUxFQVNFX1g4Nl82NCB4ODZfNjQKY29tcGlsZXIgaW5mbzogY2xhbmc6IDE1
LjAuMCAoY2xhbmctMTUwMC4zLjkuNCkKbGliYyBpbmZvOiBubyBsaWJjIGluZm9ybWF0aW9uIGF2
YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL3pzaAoK
CltFbmFibGVkIEhvb2tzXQpwcmUtY29tbWl0Cg==
--000000000000cbcb65061d9df2c3--
