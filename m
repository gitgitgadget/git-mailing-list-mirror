Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DF396B70
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346954; cv=pass; b=LwWPEf6Ar4e2sR6evr7COlz8okv4n9N+j1OZwa3zSyzveo8MuAwvYOPm9iQTe01Sg9174PM8nZJtTWoEaGsafG51d80LJXdfB3rWFzt7gCWSU+essBJQfArvpod56kTO1D+uH5IAzVN7HcCuMpsQqUBqRvIpgTIlGVjuMOdJMTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346954; c=relaxed/simple;
	bh=oOH1fnLjr5XEdKE77y1Cln89ZuQkcWigZ2x7f2Z3B7o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4G70rWTySUgl44YO+2uo0soCrH5/jCyq1PClbNgQHyO29lLLF618zOU1yjqisisQpDb2Izs31/10gEanF72tC+NVQs69M5eA9G9TcGmkhUQ1/N5tGX7lZQ6FP/Axew0fHXAu4QtCwUt4rwAGR6pRFd25UETOpBBHRlbr6897DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVBFMQRb; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVBFMQRb"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so784496e0c.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788346951; cv=none;
        d=google.com; s=arc-20260327;
        b=FCaCL+/neawY23ttqdQsVKALA+mMSNPSGM5Cege5HXLHhyi/+gEfjPGJmTfomp19F5
         K2pmk2Y8RePjnaMSS/NSH5lEAGdXDUCgOSfot4XL0Z8jVQN23XeRMQKNeEC7EZAkLJ/c
         al7s+znNqHGqWHTjuGxdYg4Hk3PcOb2ZrocqwcqdvoUxBniK6wxF4xJJfP8oPPpyZ8Tv
         Nh2ayukRwOp0W+u5vCl/SmdVW2TACGpU0r0EqsnHUaMiQHcRH2adM1SW6hE+b3pBOcoB
         KTmjJ/h/rXORMPbCYTKH4NfMLzQB2YtXYay/tbfSi328Xk9Dlz2B5XGkQNcsom2QGZKk
         EjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vtT7Ene+JKVac9LDFCsnyZKppro5ybtdCK6DTH6OYk4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=s5jfTQnVPdWTJ8Jaf4tpkt0I61RAoq8GG6Uo2Mf8xt/IozL44xpWnW6KW6jr/aLEMh
         Cex3b/8jC5V3QfM/pta0ILlrEDcgnhxtD9DC4aufvESuRjwcqvnNvBnBBbtzmROZz0uH
         EF0VPdS1WinupmQUmYnDXEtl5V8sgzUcIfaRhkTvC0EIYVfGRwd5tTwhDkCFvqi5SdOK
         2tn5zo7a7Dd5sWtobeY8uqzrgBxwf3VRP33FTjo1qTfnYZ67Sgjq2zvhcGKfTMURJSkg
         BfZTr8tedsuqDdkgrBbnXerGOQ+53H4Ooz7jF+yxsw2RlVBaUCn23Bl2FvvjrY+q4IY9
         r8mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788346951; x=1788951751; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtT7Ene+JKVac9LDFCsnyZKppro5ybtdCK6DTH6OYk4=;
        b=XVBFMQRbVV7zlOxFnmA47S41/MVdKYKH94IJXYae8e2H1COOHZ/KOhsnfcA1sHSUVE
         VuDKn6ww+OL7idv0e0zsuvcy3/IqoIZ5GOfiqAWhQL6yTFofICXlPGmOLDxHu+FTffIO
         p4d+u0k5PXHtJJEztIRHOPiHNeAXKi/5ivi+HboLFCJZIFoT3xdRa7HHxUv1796UUlpM
         6OF4+rluKVgoRcvkj/tM3mag0WMKWEGYGRSliU4UibyJcVe/hctnfWFJ24VgBamce6ce
         RWd8Lho6UBKhEMhejJprBNRVm811wm6XdKKbFpCPZZZxG6sQP68Ls61vPIjaAaOKLpAm
         dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346951; x=1788951751;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtT7Ene+JKVac9LDFCsnyZKppro5ybtdCK6DTH6OYk4=;
        b=qyTUy00At77A6PK9r5pEe53c+pgdEv8fJAzoUk75DecdKaO3cbhdY7doMsAphDXxPJ
         7EJTD94ikLLPNlIXeutwzKL9YvuJFn1lnLDhtukuL8bO1ELRLHehhg59EIyaqpdE+Xlr
         uKfeEkRGAWS4bR42mzri+xpIMbmZpc+qmvsSi+aTjzztJYDMhNyIaAbK+Z9g1wXPO/RK
         fphcLYVcaSQr/gdcBg3X1CXBkDWn95jbdHWCiCnPFi1IlU4c4qfossLE09Y+X2taOUr6
         SqAPhXt947pDQhxEQCZyIbdksHYuYbSPQg72Bj7PZ7e1wr/Xa+3KKArEcswXaTaJa0Bt
         CkzQ==
X-Gm-Message-State: AFuF++knT5sr7D5nmF0+GDm2qStWolsG+hSqzvq6ceO17PIxgFFI5NjI
	FKh5YaVw7CCFlPRZ/9wSdpkJzN5zrqpA93gQ4/VOPmzFIRT+5vCzbfSoO7m/kK9+4YNXD/F1Fu2
	9LaD5cBrwxXg3Kh/5PAUbFeVbON/3IibUZ8NV
X-Gm-Gg: AYBFou2Bh76dqrnBLbxZqreYgMg1/Xf5YxwaDEZ2L2zB1Qap6K/XEkyXG0r8EMvWKlr
	28ZvgHI1MOTSczVyxjY8qjtX9z1O26m6EzGPhjj2XQo0G6yLHqARJJd18OVGms4eu8hcX+fgqJe
	HGieWFBurztk7hH2iS8HDITTapJXsW+0bnPc32w4BAbb3evRNWD5JALLerFQbl2qthGu3aG5eTv
	vk5Vv03F/pzFug4yOSqj+rxk++arzKVNE+9a/p9aXnFJXGcYEdYjn5vSypREPtkyn8q2kfz6Rmr
	T/TasMMv+fnlqAEHv6qLLA5KuS+yGiIPL9egkNHx++i7fyh9XcyQPxftMyZhB27dyyLgk2HZClY
	3nbRCow7tIcWS5t1niUIRRxvvdoiChSOlEeA=
X-Received: by 2002:a05:6122:3113:b0:5c6:599d:8730 with SMTP id
 71dfb90a1353d-5c7d279060dmr1654766e0c.3.1788346951438; Wed, 02 Sep 2026
 04:02:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:02:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:02:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqik4olfk3.fsf@gitster.g>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-7-gitster@pobox.com> <CAOLa=ZTHGAfRZJKjrB=u-AxiUWgL2p_5HijdfJmCN_wJCE8BqA@mail.gmail.com>
 <xmqqik4olfk3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Sep 2026 04:02:30 -0700
X-Gm-Features: AcwNN1VyAoeSqHkEsDjrkq_Q8vYorCuZCfCOUtQ8bSc8bdajkeK21B7mJdAX6gw
Message-ID: <CAOLa=ZSG4T7G4Y-k_V79JrMSUeYngMViTTDb7N0qSox3kXA-5w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] checkout: restructure switch, restore, and
 checkout entrypoints
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c6c0e7065a7df87e"

--000000000000c6c0e7065a7df87e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> cmd_switch(), cmd_restore(), and cmd_checkout() pass their options
>>> to checkout_main(), which parses options and configuration,
>>> validates and dispatches to checkout_branch() or checkout_paths().
>>>
>>> Now that option initialization, validation, and branch setup have been
>>> split into dedicated helper functions, restructure cmd_switch(),
>>> cmd_restore(), and cmd_checkout() to invoke these helpers directly and
>>> dispatch to checkout_branch() or checkout_paths().
>>>
>>> In cmd_restore(), handle the --staged default from_treeish = "HEAD" and
>>> resolve opts.from_treeish into new_branch_info and opts.source_tree.
>>>
>>> This allows us to remove checkout_main() and enum checkout_command
>>> as they are no longer needed.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>  builtin/checkout.c | 297 +++++++++++++++++++++++----------------------
>>>  1 file changed, 149 insertions(+), 148 deletions(-)
>>>
>>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>>> index 2edaca5539..b18515ac7f 100644
>>> --- a/builtin/checkout.c
>>> +++ b/builtin/checkout.c
>>> @@ -1341,12 +1341,6 @@ static void setup_new_branch_info_and_source_tree(
>>>  }
>>>
>>>
>>> -enum checkout_command {
>>> -	CHECKOUT_CHECKOUT = 1,
>>> -	CHECKOUT_SWITCH = 2,
>>> -	CHECKOUT_RESTORE = 3,
>>> -};
>>> -
>>
>> Okay so this is how the first commit fits in. Now it makes sense.
>
> Yes.  The point of the series was to get rid of the monolithic
> checkout_main() that everybody goes through.  And the enum is
> primarily for that monolith to decide which code path the original
> request  is about.
>
> In the step that gets rid of the monolith, the enum no longer
> becomes needed, even though an error message with advice to tell
> which options are mutually incompatible may need to know the exact
> name of the option.  That makes [1/8] more reasonable than passing
> enums around.

Yeah. It makes sense, in isolation [1/8] looked odd, but together it
fits.

--000000000000c6c0e7065a7df87e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9fc083b5222e681d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWUFrTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNU9lQy85K2hoN3U5ZkZWL2V4SFJMRERzMlhwakVRagpMeENBa25kdWQv
K0lzL2tSenphSXlVMmFZNFN5L0dHZlVaUUFaMU8yUzlObkJSUUxmWG1PVmkzNmxlYm5iMzlCCjl0
eWZlMWxVMTBWd0UwaGxtNmpJd3I1OXRvNThrWk51QUYva1NjaTR3RkJESm9DdmRtRFArRW9SY2Ev
L1E1djYKR0RTMkl1Q3Q1aTNCdzJiMGdDWFlpbU54UVQ5cG1GTEF3elgySHZqQUorRHYwS0RjR0N2
R3M4TFhtQ2pGSHdKMwpKTjJXVHkraGZlUDBJQnZRcjd1NU9rSnI0NGJzcTdEcGRyVWJ2RUh6QUd6
SEM0eTNiQTQwYVd2TzZoOEdYUnBuCnZ2dmE1SlpGMUJNMS85dkFzWVJPenJhK0RSeWRDemplR0hr
VWxPQ21yb09NQ1YwVlh5bkRyb3BEaEFUUTMrN08KY2w1ZUxtMlA2ZVpwTWNzcG9rQVJUWld4UE9w
aFF6VTlyeGtaVWM0UzFNUHM1UDJhSnhLakNaOFo3Q3ZUZmJxUgo3Z2RQNTJScFpYWDE5emQ0eXd3
N0JLUkFQUGdwMWVhazZySU42Uyt3M1pPVXBNcnZPdE5CaW51SURHS2puUFkrClZZYlVxMW5VcU9z
SW1hUFFkSHdvek1lUjE0SmpjVEpkYlB4dzJnST0KPUdZK3gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c6c0e7065a7df87e--
