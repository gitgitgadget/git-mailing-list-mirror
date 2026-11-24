Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795509714;
	b=OfzDq1gDF05l8qTVZEAnVWjsvcf5RMByf0MhhU5Z58Tva2YfQxJrwp1T7obmN6kQBJ9V
	 6ssN0Kr4j5xBKnfMm/TzrymkaGSZTDc2Vj9/BC92P8ch7QdfSo4WBiW759EoxhbOwP8t2
	 3asS9UDOwrjeUl966GcJsIIvgt6+JbQ4cud7ulKWy1vTF0eOjP/viArzy9Q4+Kw9qBrNC
	 vzmKDUdCOfLNmSlg3me1qqdp0toucm95//CmpvWYFMihldMweoFw68KKzOkDTcRsOBQZ0
	 2JNXC5daCX3jHEW2gtSW9jCvEES8495V2mt2LcTs+BiQfOFjOgQ0xAP3ElhKP/r2yBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qRMKABpOR2apgoAm/DsMMJQZ0CDehkJMK1ItbVxJBeo=;
	b=rgjhR+Qx3/fktgyywekaJoUJj7cyX4T7yLZQtchNIZmcTa94rwBqz/clRtSV8/DULYCy
	 7IjKOvwgbR8P6tdnvf80IINViJmL2n1f8OxSs5qXk8C1+WSXb4W/+PIkSIyg+u2Ha8ozt
	 jHvf2BGGclrw93ZtcsFS++SsDy+Iw5TRtZgvQQsbfHnghYM853OSa6ni/RQoXh991y4HL
	 fxmkDYuurd0XJOVmpg0zd5aHmkfi5AS2ztoXme2UX+ytg5OF2s/eGEbgR3rg2JlTstVu8
	 VoQnbflPM/HToNJQtkT+jUqZIq3tYSem8bztcDFBrYHcghe1V4++LD7WhanBfl5rpWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7yBaHeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61ED606A32C
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 08:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61ED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7yBaHeq
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b563e32936so722978c88.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 00:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795509713; cv=none;
        d=google.com; s=arc-20260327;
        b=REUzcdzs7QAt3HnDOK9QT43AiaSoYYLWOUBe8XTUoP7qm7sKRza/EnUiBwCiTRwJJ+
         MhO1/8EdhuldxW3CqaVIAV8Hb7hvk0m0XCLeqduHvH3lIwR1FMeDwt6jEo9i207dDHj+
         RfKE+vmgPbDx0CSpnofGIjs13fnRuYBcPQUhMxF9G9BoSRyF5GP/PjgCVaMWfWv2Se/U
         GmTneKO/lVfCbciHvaK5OeFmaAUwlSJXON5MvL0iXcH60kYZ4oVUbMegIj42UnSykCPT
         VvkHgiTi+7LuQlglr3HcpOU5rLc1jkD0u2xvH5eJJ0yWQi/oQjuxvb7Ll0q+8jiT+/ah
         adIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRMKABpOR2apgoAm/DsMMJQZ0CDehkJMK1ItbVxJBeo=;
        fh=M0bpdXiSTXdD+3QsRqpLy8Sf9mfMfWjg6PwNpY05g9c=;
        b=Ph46IPt9YR3yptR9MEQDo1P7kWGFPQwraZ7zxQE0c3BRyPV8siefsYmATlFu3DP/BB
         4neYYHL3ck5U/NS6OP4OZnWBlk/LU/i/QcRBim74qsC+aLtO1MhIXi8YzV06QO24casr
         U7sSUhfFhfwuAMH8BZxhKOQO6kEh7BUcV50RooET9ijIuQRoFvOGvdjgoSK5UDzfNg/5
         2GzmgQkOLWOhBMsW4FWo3JcNjuUFh7dOpQdu1Arf4M4OinCART0BOJjaQKjNL2qMyTsR
         0TV4GAB5ZQIHyfzi2xxL42dWir7UP4PFsWnAmfnZu8FtRmguNg7dqRrai1V7WoVPTe+j
         5HBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795509713; x=1796114513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRMKABpOR2apgoAm/DsMMJQZ0CDehkJMK1ItbVxJBeo=;
        b=D7yBaHeqJkxaz5yVfVwX6It+qiwakpa4dKvOU/N4h8gsdVkK3DXMrRTVwpe0WHm9vV
         heOPswU1OZnxrx3EhxEQgMVYWUzuxzYoDQ0g3JvvI+tgVG7Kq7wJOmFAtlV8HmIUJnuv
         K4pw3BpEirmRcWFo+zii755I4lT2MwEPradNI1BMWNACib31FprmFtBq3qPs7wVNTN0+
         cHempJpSXVksI5gVhBD/JOgo+/Hh9YvNO8PVHoZ4GjLhFknK7gtu3NWPjV55NW77oK5j
         bzpluk+QQ/fwiR5xl0Cr6tDmhaLkhRDTyjbraqEHvQuSWQkV1eDgr5hauIw077IAK+MJ
         V3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509713; x=1796114513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRMKABpOR2apgoAm/DsMMJQZ0CDehkJMK1ItbVxJBeo=;
        b=GqCU5YxIcPF2x3oZ3ceL/zgQJIUW8n54qssgZMQVp7R7QkuHxozdCQ/DMrveMu7fuu
         Odczd+5mkiWntAjp5Ynp94n6syInPw0MY/K85W/aFFy5NT4rqmiSeyKFqzh4xktNFrIC
         caq0HEeunzF/A/C4Ew82YI7nwmI1Q7xrn9kvoc/Qr41m3zTPWyCJoWwJ4EcTmsc00F1s
         sLgKhKRTuvwIzFAFnPSEDi99dpKOgITBkMEGZF3dbgNw233pLuaddWzzn+3bMEVtYfUG
         nJQUhF/9fSbpMzN2OjPIwy2jedAR2xMoCNNlvp7yZgxPhiMEwRvPO79qWOedBxty1JE5
         xDHw==
X-Gm-Message-State: APuU4Z++dido34meHqTeGPD/sNjtXQ3iQfVsxy9og5/Ip19XDc5XbSTt
	ICbYMH46k409vEff/BeqtBXdL3qcSERjo76HdkABW5dudWZH+zGMF4MQ/Cxl9dLgbnxltdNxuY7
	W5AJCW4/9VKGdYcoH5sc2t94m62win54=
X-Gm-Gg: AZFdTZe3LpHGVL5CIenGUEsQC+pvGlO3r5Smx2xYUMRccwwbIgjzHbi7WeBIpKkzCwA
	L1WwJ9aD54a4aoV3GilmiLOOnGyAEBQf8fECx7cqki/pBQ6kwPbQ+BrljKjpdMhs6XDl/JrEqhb
	bwFfKnV0M/cBcGfRk6eNPnzpCyVyjdk7rjEIhqUGVyy5pv4/Jk3yz0aXm+rXBEQjIePUjIpvtLW
	CHPZNjoEtlokn/vF66nsaTjoliYySciTcJQS/mn2B3HH2ly4fmknKp4p0SbmoKHhhzah8opxJ9e
	eXCxQA9vbACYX26CySQTAe93yyyQd3e7blh/H32ThNzUpxJd14DuAKhMmloAsTbqQkwqk0ZRFFB
	jdGUjf6yToOjwlQb53gn8M4UQ4VAU85Z14WVlfHkbUmbB1/+9/76YNEY6m0Re6DyA37m5J+wbA8
	hL+AIlrasIYZGVcJOzoZaMbLoNKa1NPJOySqS+J+WCm+nzyP+snSZRuzM35Ooqr6mHYMrL+RqIB
	wFLEl6Hf8RJw/gzXrawnwSn
X-Received: by 2002:a05:7022:f8c:b0:1b3:a89c:c456 with SMTP id
 a92af1059eb24-1b55689eab5mr17606671c88.6.1795509712911; Tue, 24 Nov 2026
 00:41:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com> <20261103155038.87456-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261103155038.87456-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Nov 2026 09:41:41 +0100
X-Gm-Features: Aa3M54pNa-FYCMOOgl_ryj0HWmSWLqs_Pr96dS68q6WgWTFWgtDf2kPiuy7PJSU
Message-ID: <CAP8UFD31EuSF10wkSAqZxswKVvTG_m-VesbHSXZT_Df-FrqV5w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] negotiator/default: stop using the_repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:50=E2=80=AFPM Okhuomon Ajayi <okhuomonajayi54@gmai=
l.com> wrote:
>
> The default negotiator uses the_repository to parse commits,
> clear marks, and walk refs. fetch_negotiator_init() already
> has the repository but does not pass it down.
>
> Give default_negotiator_init() a repository parameter, store
> it on the negotiation state, and use it for those calls.
> clear_marks() receives the repository through its callback
> data. Drop USE_THE_REPOSITORY_VARIABLE.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v1:
> - Put the repository first in default_negotiator_init(), as
>   Christian suggested.
> - Pass ns to mark_common() in have_sent().

Sorry for the delay in the review.

This version 2 looks good to me.

Thanks!
