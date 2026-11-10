Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333469;
	b=qdlBr3tEv1DRQRKVKENJUX29zPE4i62N/4okhzYb/cn+yAOAW4xZAEMz9xllmVVSQQ9D
	 eir09IfSpTnoIOcUai2TQjDTDRlRip5ZEH4Tn8uWJGmp1oWh7Ysprj8rUuwroprwziZMQ
	 PXPdT5pI2BxBV/raHBV3tRvaiYjVaQ9seSm4xcyxfm1jVD9naye18BEX7x4Yd/rX3yxED
	 aBt1cprrqdBJXkvgNdKsS5R+i3penT9Rp6nmSHH//tv/o+Ta7vkDAXNQ2PdhCvEbxdt90
	 kYFcwh07GnU/r4J5FHoJDUJHCpP7ORi3Iv+Tj3b+qTlpV/lMeJ1iSWg+Nj0kHV92+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=icA5/fEwF52HBhBQrCkbUDY+LpdpqX2vVSeqAswzBqo=;
	b=jZ4IjyKHPvoTwrHhdUBroGOnRs3bY+l+piq9TiY+3mrtYddt+AVrDAlacFONFyAz8XfJ
	 8rLxo/NVoBtk7azfFnBOUZintC6pj2Za4u9/Qe6qlgfKLvHCD8o7xgI0OqLNlNrSmCBLT
	 HnnFzh+iErr+CCY8eZmKg/cRt/Z5kQ+Ocq+7Yj6yAM4TEprssTukYvP3X3uqvxQtYYFy5
	 yNcRah8ncKH34RYVyrjcrZBSbgWs6pO6qADU4vNPyOhIlk0nYG22Tjz8vv5qLiFNbo/5v
	 4FGHUQUdaKV9ANwiI4ArrrS0P0IaeAwIQfIgVtjvmWUQmcalWhr9KOwPRZmeEgTnIpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0UZpfpW;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D26606A219
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D26606A219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0UZpfpW
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37000e7234bso4272309eec.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333468; x=1794938268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icA5/fEwF52HBhBQrCkbUDY+LpdpqX2vVSeqAswzBqo=;
        b=E0UZpfpWypDxRIqMm4cV/9jwC6p0+kaT/coSkLjR9j6HSyXPxuaGwsCbMt+dQNUtoe
         Eq5h2s80L48t3IDr2xoocEQhuA9ObNmCWvcbtGdh9QxJ2ZJAMC2rXtsl7IJbF0p2NPsx
         HWu1/gFyQfM6/AbPeNEka6aKUCCkmaVkj5hJorfxV/01UKmtEQgBixdnlXphgeEev1V7
         WGFk6MeVbQvLQZSmsvuB5v0dijMrufqpBAD6zqH1V3mbvElcYTpLQPDuNFochr4BisOS
         Nk3mpfGs7cVtBqjCzswoen4au6R5yXoQNGkmi4bVUI9gGUzsNAO4V6H3daWyo/T+Y/jz
         PyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333468; x=1794938268;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icA5/fEwF52HBhBQrCkbUDY+LpdpqX2vVSeqAswzBqo=;
        b=w1umBqfjHwS/mT8MBmP/8NxdgnOKjLTmdDnMzh4IpvaBmQTBDHRVoVLKXcOKr0XJwj
         mRCSny8lnRwez6/IHWjdQqugDKlLE83Fs77JjT2fx7Uqqv3tjP2tRdth8jknUc3CfrSY
         +jrgkFVN91l/dCsRFcvrHmSQBIKi2rkyXmPMENztQbSRkwLcU+7m+PsnLH3dRX3aaVjp
         2LGYixir6i6sfzgQgBnz+aYNMWNJSTEYzkrw1VwWy43RGlUKA1wfbV8UtY/LVhzZ2nRk
         btG0j1GO1m8lURRoZB8YSeZQqxFjuxP68GSMUgCQZ9xWpQWa+bgmfZR0dzDKAgBQMSMw
         t//g==
X-Forwarded-Encrypted: i=1; AL+hErEn/pS8Rfb7p4PLNykhJGC4dbpr18K8IPKrefg+xiRc9x4e2y6KOU0lbMpMbeA+Ggt+II0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9scTnRcF3acvzHbRWgl3egB/JUVvwlYQN1ToZf2xb1U5jtkm0y
	Wtb0dnhBPfcrbBxMmVmvv2VqnwLfDz4z3ys+wGejxHBabrqCK/OyH9Kp
X-Gm-Gg: AYBFou1iQG+xnUQxqEEdlR/nDy8qQ+cPd4b9Xa/Fq867nS+psCxv04XqDKAkMkG+aZ9
	QwDWOsoBroA6Uf8ukN1XWr1YzJf4uk/3Arsshw4xLebV3n0AW8SPLJdyy0/4VbWzjorTgjJ3ASi
	MvukNdIfbDLJG4T9dIjvz4a1zG60ELifx7x7GeIcEg4RcUbqVAeoWxaUqojyh7Ft6JPf1x3zCdS
	vFDIoDVpQBFvQnA0wy4mHTRpzGBc/GMLi6+7iSeiLnYuZ+HnC1Q1ThCmCwqyN3iLxWpUtp7UQHM
	DgEcFZA105RzIyEJ3m1lOH9MrwzY7Lk5LDZp7uaysxcraC/Ui0UbuThX8VytbbpUh2NIXxH+aHJ
	/kBKz86TjzplExiOfwKbO+liEsnnbdknBL0cWtOLeJwRTpMMjAKf9NMB4MoEDzWaL7eJdg1eU+H
	niw4s/JKmQKFNJgLZ1eJZaZWra4UVYrPFpqXahSLwNOTCuoZSCsrb2QNuHSR5KH+lhsvXzhCKz1
	yDkYDMiQvPbPbQrvEnfOK/aBLD4udAabThICM0Mk1jMfrdHowA0pahmaCcrTFQISdw9F/Sfb9ho
	LF7gEE54j2MFXVtP5UDz64pSmSpV+ZcOJq/1qDgDIILOa7la0gY84oMcP2ME3DeMyqQsyUd+ElS
	viCjKQZ0mdTA0HeXmg5LjzuBQnoMqXw==
X-Received: by 2002:a05:693c:8004:b0:36c:a321:9fbc with SMTP id 5a478bee46e88-3768395f0e5mr77377eec.1.1794333467992;
        Tue, 10 Nov 2026 09:57:47 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:37cf:603a:4d43:6b5d:dfdc? ([2406:7400:12b:37cf:603a:4d43:6b5d:dfdc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm9772882eec.26.2026.11.10.09.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:57:47 -0800 (PST)
Message-ID: <590c5765-fc4e-44da-9326-b8242caa80ae@gmail.com>
Date: Tue, 10 Nov 2026 23:27:43 +0530
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
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com> <xmqq8q38yz5i.fsf@gitster.g>
 <4c7c44df-4eca-4abf-a825-1bb3b16015c2@gmail.com> <xmqqmrrgtz6i.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqmrrgtz6i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 22:13, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>>> Personally, I somehow find that the original "unless we positively
>>> declare success, default to 'ret = -1', and if we may have detected
>>> more specific error, return it back, and reset ret to 0 when we see
>>> a success" easier to follow, but that may be subjective preference.
>>
>> +1. I too have a slight preference for the old flow of having ret = -1
>> and resetting it when there's no error. It may not be worth a re-roll,
>> though.
> 
> Note that my comment you quoted was made with a misunderstanding
> of the patch and misses one important point, which is that
> read_index_pack_report() used to overwrite "ret" even when it
> succeeded, but the new code uses a separate variable to avoid
> clobbering "ret" when the call succeeds.
> 
> In other words, the original failed to honor the "have ret = -1
> and reset to 0 only after seeing everything go well" pattern,
> either, and Justin's patch is a definite improvement.

It is an improvement indeed. No arguments about it. I was just wondering 
if his change could also include a change like this on top:

diff --git a/object-file.c b/object-file.c
index e04ce0bc11..c52004014f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1429,7 +1429,7 @@ static int odb_transaction_files_write_pack(struct 
odb_transaction *base,
  	struct pack_header hdr;
  	const char *hdr_err;
  	int err_fd = opts->err_fd;
-	int ret;
+	int ret = -1;

  	hdr_err = parse_pack_header(&hdr, pack_fd);
  	if (hdr_err) {
@@ -1498,13 +1498,11 @@ static int 
odb_transaction_files_write_pack(struct odb_transaction *base,

  		if (finish_command(&child)) {
  			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			ret = -1;
  			goto out;
  		}

  		if (report_err) {
  			strbuf_addstr(err_msg, "index-pack failed to report pack name");
-			ret = -1;
  			goto out;
  		}


But, I would agree that this is a digression.

-- 
Sivaraam

