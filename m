Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343B18EFDE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943073; cv=none; b=dt/+G8aM1s9VJ0jLRE1Sv9H+AZCnSQP+XloV9Q1/v8MyL7d881pJqPdyWf2lyFxoXGFFw7uPmAtSec8bueISEjIxY6PvZTgia8bPeIlP+L7J02RqlAfZfvS6+vuAlx4yT16BjClNjxgRr8hr5ooG47k7/anmPfQ7emDYrstAICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943073; c=relaxed/simple;
	bh=8nksHaeLpB4jQnhC5+6twME80FVfVqSFhuU614dG3rM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bN3L/PXceHns+Wj6FTpoleIMKnrAn+OOtQ5Wz/9ChWQRa+vCOVAUYIl6+Uiv/LZaFEmayL4hgKu8Wo0D9XxAwjEZt7scORD47rbU9nd5Dz5XzBQyHlLhMUqss92ON2HPn/QgWrA1A2qbKBGnPdWPavCdIFJJB6RtniU67h7dxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OchRKkK1; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OchRKkK1"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5146e6531c8so1459227e0c.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943071; x=1732547871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8nksHaeLpB4jQnhC5+6twME80FVfVqSFhuU614dG3rM=;
        b=OchRKkK1m+StA0+veE0yokJiwcH+btgmgfOmN0dq95sf1h397RH2h9QY94VGgCc8bS
         AT0F76tAz4rQ+5Wu7Lfb7vvXmo0bXViXd5B8dETk6iAwwGV4d/K6JXCeG5QJpA5CDsK8
         enI6dkd+Pr7K+9BI67XSva01dJqSqIryEJ+MJcMMVDXcPiybPCSLleeuzZHeG9Ev2yQK
         2VmRSFm0u+oys0mkv/NDSLrwRbpHflLwl8Bvf399T3M1HlYLk5RXIh8SSYAcL/Rywcj0
         +Ut/O/i8Sz+/ftbOpcFQ+z9W4/2OiO6VpKVRPzgxfQfhaGFx8bWhtOr3yLUg+unwGYmP
         1szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943071; x=1732547871;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nksHaeLpB4jQnhC5+6twME80FVfVqSFhuU614dG3rM=;
        b=wgowKYMdo1sOOp/hHQm6+VzkM02f1me8z8xW9varDnRgffvsmw4mM0X7y/vZXidVjO
         wVfVRSPW3lPcON2b6D4+PkftZAxjuU0jxAuELkba2f2euJnkp7rKHF3f/Ak42MB8xrBW
         9euHQbL5yxmcO9TTFrLX4gZQOVpua96EDsy8v+YZlTj8/rLq9d69JGP9f5SuIAeAf7YE
         D0MH+qCk/PhsxDNt8KY1c76JC18fq2kQHKrCbCfaig9IO1lFfp3MqUtkc8n5JXb/RKIB
         UG+hNBjM46uAPKDbUmajNwdHcJY45Lyn8myGT/xThJp1ucfSeWZS2ClWWbYnpo3lAl6l
         5gwA==
X-Gm-Message-State: AOJu0Yynh4uVfI4khWvlrwcLFFv/YXBG0KcfHqWeIwsbObLM2JbAUmlp
	IyupgejhLuBzVS170Ris+OgAvOklyIoLchG2zZtjyrMnjO4lCDUFPMLfvUTqn4FnzfxE/+xgFDA
	f2LkUjejHbGxpZwrxoId8vn8bkak=
X-Google-Smtp-Source: AGHT+IF2SGJGf+2nGnu0ywNmqLP3ma/G7Z2Qy4u1WO3d8kqa5iKdoQQfVK8V/HYo+zsrp+6npaV/+glQzRah1H8oKyA=
X-Received: by 2002:a05:6122:3bc5:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-514781ae15dmr11669417e0c.8.1731943069573; Mon, 18 Nov 2024
 07:17:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 09:17:48 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZzfTvGvyn7pMe3nA@tapette.crustytoothpaste.net>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
 <ZzfTvGvyn7pMe3nA@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 09:17:48 -0600
Message-ID: <CAOLa=ZS_b0HQg-2AaDvbsZrzujyKAs0Spe1irDw9QugWyzNw0w@mail.gmail.com>
Subject: Re: [PATCH 2/8] midx-write: add repository field to `write_midx_context`
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000006f29420627316b9b"

--0000000000006f29420627316b9b
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-11-15 at 13:42:15, Karthik Nayak wrote:
>> The struct `write_midx_context` is used to pass context for creating
>> MIDX files. Adding the repository field here ensures that most functions
>> within `midx-write.c` have access to the field and can use that instead
>> of the global `repository` variable. This involves passing the
>> `repository` field to `write_midx_internal`. To do this, we add
>> `the_repository` usage to two non-static functions, which we'll remove
>> in upcoming commits.
>>
>> With this, modify the static functions in `midx-write.c` to not use
>> global variables. This means, either we use existing alternatives (like
>> `repository` struct), or we pass down required fields from other
>> functions.
>>
>> Signed-off-by: default avatarKarthik Nayak <karthik.188@gmail.com>
>
> It looks like the sign-off here may have gotten corrupted.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

Indeed, will fix. Thanks!

--0000000000006f29420627316b9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a99dac8e9143326c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1dwc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFIvQy8wUWZraXZSeUYycC9IajhCbW5UVDJreU9DVgpFQlNjTkE2WnZM
cVlBM1Z2RVcxNTdpME1LM0Uyb3pOd3dzQ2JUeWs1Z2VFYVlRNmVveTRFNTNKbnJaT3hXRHovCmdW
dCt3RTJKNWFwNTd1YTQvdjZUVHpxNWFnT1huekpwQkdKL1pFVkJ3RGRSMW5EeDkzVHRCVzExdGY2
MDRTYjgKSzN5dGxkNzhUdUdzcUVURGN4NWVaeU9lckV2ODByR0ovdkdxdWsyRzBLQ0ZZdUhiamhM
UkhFcUV2S2p2cFcrTgo4aWZWU0k5aDdscWZRdllKMm10RFBORHk3eXcrelI0NzB1dlhrak9uMVVK
OHlqSTNoREdQZ1NpSGltbmYwaVVTClZWaUJuclpoZVI5TU1SWUFTeTQ5c1d0eHVVaFpKM3M2aUdv
T2Vta3hoZEI3Z0s2NDNJRndpNzdTZ2oyeVNEazIKOHRvbmJ5Wis4ZTh6N2FEY1NWREwzVU9qMjhu
R25adXd2ejZGK3NSVkxxaDB4eU1OQjRzTys0MmtuejZIVlJJdwpleFJFalp1bUdiRkt3UFZibzZ0
YTVNemlQbjZPM1VscTRyUHdUdzgrbnNMRUQ0TWVNbGhaNlo2dHlmNzNweTQwCi9ncDRpaHNscGtz
Q1BGUTlEVzhaUjlHWlJHNDlTTkQ0bVJzUDVNVT0KPWU0N0UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006f29420627316b9b--
