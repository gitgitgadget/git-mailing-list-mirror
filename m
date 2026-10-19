Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444359;
	b=ssvWc7biqfYCzOZHoBGCDcp61l1TTvrSUc9ilihPiNPIQJqN1V76y47EitaZfUWlzojw
	 5sXdelYtlGFX2VBD9yDCC5v0Xk9680BSB8Z+y2zd/hLnEnF0iHF+llHulZF5oZgaiEndp
	 d220KiGFEALx8uRF3SKTORx9LunzaGS7BqGQgE6CrXMTjULQ+8lVHKcVI7oDN7TGa8q8h
	 ngsmInPb78UMRA/qx7fafs3iN/LJSj9QvFk90G0fuVz5HCfXGo+0YvyCOKaJOGA+B3i8q
	 v5aX7ZCzhEYSlVokPt43lJnkBLenrXLA9zasPplwAXH/C0StFRJrg0CpkLpjsSDWZmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444359;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d0zKNf8rH4CUabOFmleEZ7C6MY7IPs4rtXpkZymZn0o=;
	b=eWdvVE7ZY4Cth8WnGsPZhDGD45bBH5fzHjNC/QKbKB/Fvvlmf1CvJDMR+4GMTFtIqxku
	 jvyrYHEEDvmn1F3sU3oeZp2veO/g7Vlp/yKKL39Mjzk2p4OATi5eMiy2hHQBbcAoig716
	 xlt8y35/PwlO5k0t+6N/sVIkFdVu8w5wi0vg7c+3+3E6Kef+4hDazwhmWcHX98mgpJN3i
	 GkO6c+vy1TOhR2LHoK0A+HPm1JKHJULyLJOwmr8uY+mWJnAG1oON2ZV181xRDuybOTSOa
	 j2icbISjmHaZLtI/uiRAQhjishrJqawfmZm0ZGauCcHkRMVSZQGrm+MKb25fQguys8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A6KWtL+Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y3+3KiHL;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62E606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F62E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A6KWtL+Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y3+3KiHL
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA64CEC00CE
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:12:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 17:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792444357;
	 x=1792530757; bh=d0zKNf8rH4CUabOFmleEZ7C6MY7IPs4rtXpkZymZn0o=; b=
	A6KWtL+QE47N27DCyEjULahv0CTq4p2TkRIJhHqTpdB2vj46d17QS0jbu9kUZjOG
	CmJb1aUz1CI/Ai5ideYontn+tFyA5pMbBx1+3bUA1w9K6iD3M3eT93JM8ePB5hjZ
	Z+tgy0Um5NUSWe4bovn9GhZ07BxQf9fb27tCZJdjFqu9WSC1blWkKJxv5gyXjmai
	RXtPlqifzAvFdd2TtGPa4k1tuL4//Wx30QePjChfjVXLSBMiq8Zq5PFJ4YRjfcdr
	KOtl7JScTbrz5wpGoJVjaLomDYpwRFqKk+zeSq+2/xODcuXuSxhUFH6s4hM6enq1
	EZrt4wvrxv9E58IDbLG5LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792444357; x=
	1792530757; bh=d0zKNf8rH4CUabOFmleEZ7C6MY7IPs4rtXpkZymZn0o=; b=Y
	3+3KiHLOMY5x0kurdWEIDOTNVZOiVyWk4jknpC6C7mzPocpx+DTZf3s+2NP+Zc99
	tpvuWqJ6Wjo72IL4Y96zyshpf9FP0HFkPDrZsEJStydpddN5x5CW+GE9m+8Hncl3
	ick3iALfV8FiqvZG4lAKpsnCJlYVIzHIm+LsV6EpA5y40fLp7X1AadLXi13pCw/8
	Qdi+ScDj1vZI0lLxJFX7hgOx9e0e26D7bqQc3fWhZZxreFgYwXI1imJnqpFgA8OI
	9PEoNNw+0In7enrKaSbhXIFBDnGoUW8zIp7L1fNRaUzp5buQzACn3Qc8CEyp3v+s
	mK9VzkIoKzURkhv3SAyyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792444357; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:g1KLQnt9KvxqWmjjDuTswEy5sD+R/3IbYvag1tGKD7BNfHA
	B/ap4weUb4wZF91XlGOMF1ba1eij8cbC3rfeaoay1VO1P9DbVqLd9+jQk40ndffO
	NwCJ6LwmSMdCjsgqjqz76yLPOX0iPFiShk4gLAggNsEGdzRDO1gUjUky8tLGDMRf
	12XMzkzR6ci3hb0+QHZJYICiZZ2bJGwcj2c3pCfgMcUFIG2vZ8uWRqZZ3F8P9nex
	YVm44VbtsNXvr6i0QadcK8DWp3PrhcKVHtJBGQqf1+w9uaraOfqOPoIKO01kbiy1
	ldZmkVzjlAtjriTVkZJ4W4nfXXlKhpkSr0e8l9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:O2Uw9Nc91t1a+tGz2NzJZ3bkeRuL/dxJxa+HZ4z70GI=:7KZTpxLoUXA8xh5GMSaiozpQexsV3wX/wiHRMHCCvBg=;
X-ME-Sender: <xms:xYfWaryiObBksgRIQUvjmLZSeB1xRS3kMXg1p2tm2nEfVAB1Of9cmA>
    <xme:xYfWam9zgNWYsOet_3RZH60m9l9nByZi3zhljnabIEUP5PWV65H1pENjCKqXNwfOw
    TEiZCXKGv_mvG8iMS4c97OrnAgiKEG6-4GnAdAicSHfeViQlcRUZw>
X-ME-Received: <xmr:xYfWavI6fkQB12ThoJiJ8mpJMI_fgkyYDAspnKLqdeqKa85JhQibbVsvgEvhTUmZo0if7a3wazdn9viyHJHTk1a2pJdv3x99ddWq>
X-ME-Proxy-Cause: dmFkZTGEo/CvwBgkwFupmuqBIQ9s50Y3EhC62hbihB5tSwV/gwXtIwiyHpNg9d2q/L/6i6
    ML1WnqsYtqEZ8A9s7Q+BV6PapffKo2lD4acChr5CZhrXi5G0bel2UK9L5GZI32S1mrXg4i
    EzSw/mfIi6M2tEFSlkwYE31nWjCJE16fmWbAWQ82XfMKZCc+ikB4jHazveeYyviBChKQKh
    Eny+b8P74mwKZnfMg0SZocHJfB40aiFpLy9a2+zEcPj9YsBqeSLz2vxcRIyNmAEIuUmckn
    A+mJO3aC9RoPVKSYIZ2qrZc5Df7mE4jeRJJ8CDerNyXt+On+40E7APTm3WeFRU0FdI9Ncd
    7TMV/KQNOdWcxWZiFxJ/XDcTTayxqODUmhMIllCMc2geAbjJ/ZP2QaJTGplw0HC1/khacz
    cabDZ/4xOIpYZFHJ4l0Krf43ZKAED/bXYaDU6r/M2kb0N1HGo6o6uuajfO6mP+o2LOkANM
    gCdgvbzAVOqDZ8m2XzB9TY/SJtPe9qHRu/pAum0M7oFcAY4fEyklXXOw+TN8tbw11fxGnR
    KgTHUOEzliORfv0x5BBvk82QRGwXryfM0OCps0a2Jn1BMgHpp9nN3ug2r/Cm4VpsXFnXqo
    EdhZ6bIJEqylz9TAr56c1kL7PlxG27cVycDbGOopUjH+GpcIsbu+Zl20oaaw
X-ME-Proxy: <xmx:xYfWasf0ualB1ODIxHXkUPNWeivU799KeC7D_fNOntdudvoZ4BTw-Q>
    <xmx:xYfWau_RAfZ9DQ4xBJq-iBm4OHIGIoTDK44CMDjmx-A3San6M24RDA>
    <xmx:xYfWapo757ofw2y11xbZzx1ShaTZbniBibpPUMHS37mfD-FVNxEfqQ>
    <xmx:xYfWajAzAeDXtOYVJkQAMqk6m5wPzkLO_2tu5XXBT6WARmbPUzBxMg>
    <xmx:xYfWatWWPAsrs3eDNqHb3vxRI8LasBxcmUCWtWembnouxPZgOLfvZJUA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:12:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kerylefondji7@gmail.com,  git@vger.kernel.org,
  christiancouder@gmail.com,  siddharthasthana31@gmail.com
Subject: Re: [PATCH] archive-zip: refactor 'path too long' error message to
 use Q_()
In-Reply-To: <96187a3b-411c-42bd-8979-fb45006daa34@gmail.com> (Phillip Wood's
	message of "Mon, 19 Oct 2026 14:58:10 +0100")
References: <20261019084427.1879-1-kerylefondji7@gmail.com>
	<96187a3b-411c-42bd-8979-fb45006daa34@gmail.com>
Date: Mon, 19 Oct 2026 14:12:35 -0700
Message-ID: <xmqqmrs92y4c.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Keryle
>
> On 19/10/2026 09:44, kerylefondji7@gmail.com wrote:
>> From: Keryle Fondji <kerylefondji7@gmail.com>
>> 
>> The error message used "chars" even when pathlen was 1.
>
> Looking at the code below, pathlen has to be longer than 0xffff to 
> trigger this message. However there can be more than one form of the 
> plural string though. The gettext manual has the following example of 
> the Polish translation of "file" for different numbers of files [1]
>
> 	1 plik
> 	2,3,4 pliki
> 	5-21 plików
> 	22-24 pliki
> 	25-31 plików
>
> so using Q_() is correct, but we should explain that it is to 
> accommodate different plural forms, rather than because pathlen can be 1.

Good.

>> Replace _() with Q_() to handle both singular and plural forms
>> correctly depending on the value of pathlen.

This is written better.

>> Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
>> ---
>>   archive-zip.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/archive-zip.c b/archive-zip.c
>> index 6f73ca6d58..e4f8ef5a36 100644
>> --- a/archive-zip.c
>> +++ b/archive-zip.c
>> @@ -328,7 +328,7 @@ static int write_zip_entry(struct archiver_args *args,
>>   	}
>>   
>>   	if (pathlen > 0xffff) {
>> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
>> +		return error(Q_("path too long (%d char, SHA1: %s): %s", "path too long (%d chars, SHA1: %s): %s", pathlen),
>>   				(int)pathlen, oid_to_hex(oid), path);

This is overly long and must be line-wrapped.


>>   	}
>>   
