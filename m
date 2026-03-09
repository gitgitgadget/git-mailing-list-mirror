Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF137DEBF
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052373; cv=pass; b=m+OKaoRk5IVlNX4E05WTbNdRjkcVIfPWSbnOK0w0teELPp6UiVTFUD/s4j00McnTNmOU9g7V2Wg25p4HYmYYfohXPZOVu7EzLb39AegKEQ/JgZnikvOdkFf65KuVEyFURgltPCeCFkPOLwlg9yoXq8KN72DO/QY25SfMkPgo7v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052373; c=relaxed/simple;
	bh=QUxfpoVqve4OygHfilFzloeMiPvXI78XoHd0pzb/Tjw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE45m7coyo73/Yh7cXBIW80bbErODTxc9KqGo49QRRW6b875W+T+uOUK948j6ERoJVzleQNS0IAWMQfLnzea/TdDtEmq/Z7j9xmpNZ81/yFzdn2JjAFOZSvHZOjY3lJvPPFsWPYqDbemJ9nErLXId5QaAEmjvcq+K8DaEtJfaMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxQyVt0N; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxQyVt0N"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso4050186e0c.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 03:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052371; cv=none;
        d=google.com; s=arc-20240605;
        b=arjYQOQOjxBMUAJnVbcQQdFdXS0Ei8kag4k4snviNGAizceqPI4B+sAwHR7VADBlE3
         J19Kf26bSTAMd4AvpuzPiNJsag7GeKdXPyapV4NqWtHii4c/XY3Tzn4DWgawe2vmOjfX
         9mLNLKpOE4ubSS+cG1/dDQTTgmDA2KjpdfrtCDfdbG1yiPrGNZZB8mvna9ums3WNtCAL
         nsJuHFwpUs0TdpJO2h6t8SwMk91TuuTHSDsDCQGLmM2A0CDXiCGa4ePIuIAvpKGAdCAs
         S8WqfHSIvXJoVjVs/vQgGPcrisPNEgZoHkkt9iZNShsEDOSnAVVkwukZWnosHQ9xwNUo
         aQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DAJGDTA8OgN2dH5jWw73b2pAL0gwXkIqN8GVHZT1ZVk=;
        fh=36GvrYCWw5OkaeaSdsqipPhEw7Gn7pSb2MA75dK6swI=;
        b=ABy57Beuer+XPLv0fNha8ixrn8eowyLfGRGdEMDPG83kZly24KeaOBR/VWOQRQBLKb
         CIKmDbRBKpi8+eGSyuv4mu/6JexKjNA8e3wPgLBew0MQnDBVROXe/mYyXgko7AzSwfln
         RfqhmnLSgl79pd8YblcukhpiNMBL3Q9LzqcbouGvLx8H0hn16NYVupWI53Leqw0GXVFM
         L5i4zlR2JcDZgyAbp/RuIr3zmbIlb4nm2NRACPsr4M4HTNmqj0zVSOP1e9ffUCpojhIY
         QeiPMgP8PDt+3Tr2TxT5XSjoUN3QN7X1KI4tTxwAN3FAwnyTD5SfFeqIa2jBrhpWwtCb
         7emQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052371; x=1773657171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAJGDTA8OgN2dH5jWw73b2pAL0gwXkIqN8GVHZT1ZVk=;
        b=lxQyVt0NOFQZGy7mGj7M8Zf4NemaamDSz41aHwmJScjdnl4yRp/FuUHuNq5GHhll6S
         HV3Zrcy+6co+tHSr+/NSVVZT9IRz2Ie3UePOnq48Qc9T3CMSlPyBcCG+Hsl1JphnytNG
         +qTD5YbdzxF1Asfls7ImOIgxPNXJyda0ZyZr2tSdS71aexocaa4tJWMBvejh2h0azMIo
         R5IQ9l9LNEobJ1U88KdQExzvVAulX81pS00PjinDlvtgoJIIeMe/GyO1jrJXijXE8sku
         QidaxCcn7YtgHJF/0WJ2JIgRpVhuWJIAGK9arHXj4ZokICszNJhgSnR/JLVYXETVdQSS
         aGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052371; x=1773657171;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAJGDTA8OgN2dH5jWw73b2pAL0gwXkIqN8GVHZT1ZVk=;
        b=daAUHVpbsIKcL7EcE7dn48kFKRCMVqdqlEhe7xu2bfeJXGEAkvLSm4Vkz88MLL2lsK
         m/Atx3kuTJ9J39inWzU5P3rts1m842kIA8hzXw848prYlieo7vpkMlUmumRGFraTjeDo
         IfUe1cHxjavkrVn+uu3Cm8l9FNbRei0EJQN6Ang9Oov5c0Jv98uj85Lfro6ioavPZmhO
         /8oR/BSQeMIW1szlfYCHI274//pUkyp+vbOAJFE1dbtbJPepGyOrqxLZ0beZ9vvAzJQB
         ILe0DtWgkKYhVik2BUIOFDG4VSh5B3u9WvV7hptP44edyVHyQKQDe2cZauerCoEBfKPJ
         uMkg==
X-Gm-Message-State: AOJu0Yw6R0dVN12oKDIv/TuXHZO4weXucvRmq0YDEq8kil8b6l2DWdPT
	2h/jEsoKwdNT/tLV1P8hkLBAOzjzQCtrHKJaeMzO7hjzlrArKWBGEC0gvybygTrLkftf1b23IKt
	f6iLGwEqNZCrcuikA7f4M0wMRDlzH75hyvlBv
X-Gm-Gg: ATEYQzxSJbSqR1dvth0Cj8xZdFY7KX7BMp0/WlAkW37LGprVbEbMmDYiGhohBkfbvLT
	GrVPLq4h9CpL8hAsKQs80CzCNDmJtfcWChfk4yz4Zq3U38sExYAyg7bPIMyOWv1ggB1wsLX+xPO
	8yw9P4I7Ohmf1pskBoTljaAJQXH6miZe4pYPQ4DSW0aLiM3vdidqwoICor6r+mNz/aG+JSryx3R
	Ox58KrvGDZuq/V19jY6nc2wvRTiSmfXn45uOS1rxRLysbvQAPUwDWcfupAoFfo6g96aOdHUFecq
	rOm5PGJnQw12PdJCIU6EzQN/ToqMeaLwNcmUe+JXj27A/WBLK2/9
X-Received: by 2002:a05:6102:44c5:20b0:5ff:f9d9:ce73 with SMTP id
 ada2fe7eead31-5fff9d9cf35mr2027204137.5.1773052371470; Mon, 09 Mar 2026
 03:32:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 03:32:50 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 03:32:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjh0y4i1.fsf@gitster.g>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com> <xmqqbjh0y4i1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Mar 2026 03:32:50 -0700
X-Gm-Features: AaiRm53EQnr5PRenANt2A6k4jIrF-6XFuO3R8UEdY3jc6aRsRhY07DjQf1YJBHo
Message-ID: <CAOLa=ZR1nfGC499-mKvK2xrfzAvrC6nvpu=XNj0yfC7JpMT08Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] wt-status: reduce reliance on global state
To: Junio C Hamano <gitster@pobox.com>, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000c58ec9064c94ec82"

--000000000000c58ec9064c94ec82
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
>> Changes in v5:
>>  - Added the usage of struct repository *r in addition to adding it as a parameter to the functions,
>>     in patch 1/3 instead of doing that in 2/3.
>
> We haven't seen any reviews on the latest round, but the previous
> iterations all had good discussions.  Is everybody find this round
> satisfactory?  If so, let me mark the topic for 'next'.
>
> Thanks.

I'm happy with the current version. Makes sense to move it to 'next'.

Thanks

--000000000000c58ec9064c94ec82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c72376199a952c00_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tdW9kRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDR4Qy85SzJ4TzcrbkZyTm51VVZ4aW5yU0c4L2JyQQpHNFBydXQyeERv
M2xVWEsveXRwSGJRcW93VEtiVlp4WEFMQjliZUFGajN6VXlSSUo2eUdCNW94NVNjMnp3NHI2CnpH
WnVSak1zSDJ1SS9zaFVRQkxCS1hmYnY3OEFQK0J0RmxsQXZGS1o5cWt3MVRSMC9CVzVzVWFjMFRj
MlhMdFkKclNHRjByZzR4SnJBM2tlZGZnbERJNEM1S2xkRjBTeXBxWWJVSzhZcEJLU1lhY1RoZWpo
RFZkZHV3OWNwdzNFYQpmRE1sa1g3TnNTV2Z0VzBySU9HNjVBRnlrbEZUaEtjMFBqeSthZnl0N3dK
L0M1THdzR1NFQnNGSk5EN3NnV1ZXCmdPcnVYWEp1aXhVWmFOSFhRa05sS01LZmVCWmsreWx4SVJO
RkduaDNxZnp5UytsZnEwMUgrb0pFNVF6TXNNTkgKRXlJaTJkT0RiV0FNK25Qd2JIaG4vcElJd1Mv
U3BwTEo0cDRiZzY1eTB5eEhmUmxIVHAvNzhFZVd1TGJrQ2ZhaApmQkpPUmpKd0g1NHczbTdpdzJ2
aXlZc2VZck9OQjR3eVlJcWswNUw5WTZObW9yVDc0ekFCQklCZXVwQU5QQzlhCjBjQXVFSTNZQlZZ
WklJcXplZUxHQVAwZXRwdW5lSlluMUFBemJUVT0KPUdNeHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c58ec9064c94ec82--
