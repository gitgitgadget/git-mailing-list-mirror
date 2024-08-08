Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2213AA31
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112526; cv=none; b=N4bcaVdx6hdYQwyX26j1P21rR5hT26VgT3oTEw9Jutea/nnR3KKZn5Ckoc6xHT59r/alvZ2H+M76EGbaKGOcBgYUcZzBVXXrxBU33lfcmzgp34nyZu0TM3tCUaT9cn2e9LNKVSVt1ZKWgteiINM7yoeUoXMuf8FSedNH4ajt+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112526; c=relaxed/simple;
	bh=W/G3BUP+YOciQXD1GXmJPUvX44eIFXBjFWQcb0ZkvU8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOZLpVqBrAVP/7i9oxeKuiMYG2KJmnqMyVnAZtEV6PHv7NTkfDWW62/jF4OxIxcoJLFJtIjYzZMDdHBuhHx6euQR73nqsqoL5b+n25ozhqqM147/9l8+D/OUvxm8hgO1fO47Okh/nW4s4SduHk4zX5HGU50zW5Wy78No0xgItPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHsY7e8z; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHsY7e8z"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c661e75ff6so491509eaf.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723112524; x=1723717324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/G3BUP+YOciQXD1GXmJPUvX44eIFXBjFWQcb0ZkvU8=;
        b=hHsY7e8z0ybuBUE2ko77bmpQWJp/VLGYS5VaNoYBph5x4w9LqgEsgs7f3liHzeAVQz
         roRjxwaT0vUmuVP2p1IyrXDG8xievHq2N6t2rLWAxTnV1cfKI3mujubWbx4ykQWKycxv
         OiitGnJQ/uP9dveAyLyccTQ76UFyIaP1I9C6DzxZblb6R8325QJn9xC2RKkiaTsUuBwi
         3l39NJxe3HAB3L786+SpYpXQqmvbNR3LT4iQPma9my/Sdrv3eYDTkmsQTQlOdndpBk4k
         FEZFDYnZA/hIv3MMgN3w2Vnn14PVnt/fhalHTi+ywk2B/TncdzYNEGJPHc4JH/mPVJlm
         170w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112524; x=1723717324;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/G3BUP+YOciQXD1GXmJPUvX44eIFXBjFWQcb0ZkvU8=;
        b=E0ZWO0yf8i3KiPT4g8AXTay27YoAUj8j7OGair3bfcdEIVh0Nbm8bMtK9znW5CuoTr
         onJ0a/1qrjCWv185ZmeaT+ZrSo9TG0lpwabXTsY5oPp8CkzXs9jTTq9RcIqYlvliUL2J
         B8b+uCnlSkPcOfPcoeD49h/bN1ZwyZ6L6+q7UdklwFAsVGmEW+7lZxA9bBGaOmhuo2LW
         5RHNA5oLCFJhEG1O1e5ps4GMipxW1BN+C6U8KU+acaszpL3RILoq9aW4mXJOXOlSDudu
         BQHgPziJeDDD1zwBmDfZLqdV5ddTNt8FfwsG7n2L0EcRiNiQ0IaoGAINSzFvmcufgsVF
         18og==
X-Forwarded-Encrypted: i=1; AJvYcCX8v5OYZkPBhPtstvnxeqfkTw1z/tRhKgoss0WyIZWtUCeS9luc4bRv8A6rUmu1LUzXQp0MjPrmpId0LtRJ62sTofoG
X-Gm-Message-State: AOJu0Yz6cGGnlXVTYIpkRnEp/ZjaV7aFfTgKVimYht1aZ4oHVoa9/REz
	tuM/sF1tQBbfoGl/f8gGwhGpxc566/J213VGgcszhY3+BNxKkFfkhYz3vP1yajEej7zeXa2jkdA
	5PNCPu/Uto9fKet8TG9t0JZYx3Quuwg==
X-Google-Smtp-Source: AGHT+IGLz13RUmMNXBdr7WXyIjIKnI61ayj0LUd39Ng2jmUuAjn6EyXsMEXwUU4TA5pAdLJGC6bKXsnMVrYE9mIUJXU=
X-Received: by 2002:a05:6820:310a:b0:5d8:ebe:23fb with SMTP id
 006d021491bc7-5d855c0c285mr1520976eaf.7.1723112523962; Thu, 08 Aug 2024
 03:22:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 06:22:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZrNtjeV5_gyZXBgB@ArchLinux.localdomain>
References: <ZrEBKjzbyxtMdCCx@ArchLinux> <ZrEB16WGGc28dxu2@ArchLinux>
 <ZrHRpnpGkH19godh@tanuki> <xmqqsevhy6e7.fsf@gitster.g> <ZrMMaubE_V7wUZ3H@tanuki>
 <ZrNtjeV5_gyZXBgB@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 06:22:02 -0400
Message-ID: <CAOLa=ZTjVgVk_OodC+L+MC014vHbh6jztKNHyQjcXwKzmkqhbg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
To: shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e63788061f2965d0"

--000000000000e63788061f2965d0
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

>> If so, then the only two I had were some spurious newlines. I'm not sure
>> whether these really would be worth rerolling the whole patch series.
>>
>
> Karthik has given some reviews. I guess I need to reroll because there
> is one typo error in commit message. It's important to make this fixed.
>
>> Patrick

I would say, my nits by themselves don't require a re-roll, but if
you're re-rolling, it'd be nice to resolve them too :)

--000000000000e63788061f2965d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3935b8f2359be98d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMG5Fa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXZoREFDVTVzWlpKVEVVWjNQUFBHMXlkVFo3ZmRVWgpYZGl6N1ZTb0R0
RHVyTlEya0lZRVhSK0tFMElkbWRyUm1ZV0JuSXAwK3ZleS9hNERwWHk4TG1mUzMvUHZpbHNHCnBm
U2FWT3BEVkNGRCttcXFQaUhRRkJEUUU0QlFWWXNQeHdhVXNoU08yWUhodVU4bEkyMHhLa0hSSHpB
djJINkQKREFoWmZqNGFucVVtWnJ1WlJHN1NVaGZNako4R3ZueU16bTVsd3FiUm5tMEFKN0JZYWdL
dkt2RVhJVmlaYlI3TQpTa1ZCejg5Nm1RMzRxaVd5OXJMRUtqMzJJdnRkUXNUdUtITUFBZlkxUG8y
eCtOQ0FobFNoQlB4Z25BUnhPYnEwCnhVbS9raCtiM0U0bUoySzNmUGo4ZU9Iblh3WWNsQ0JXTThD
VjRHQnU1QXpXT0tDZ2Q3ZzBXN3hnbzh0ck5naEgKcWlvR25uQ29jRUMvYXB0ZTVTcm8wSGV3N2xD
Uy9BemVrcVc2ZHVFMXFJUjc4SzNYd2tCV2dtKzZPRVhZLyt0YQpPT1o4RFpTQU1oWThtVy91MHc5
ZVVkVGE0N1c1MjRJUFNJbmtDZjJIajJyL0tybEtoQVgvcE5uVWIvVTIxZGhuCi9maE9iM0pyNUs1
MHg1ekxTb0tRYTA4NHV1SFYydTdGRDlmL3QzWT0KPWZhZjgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e63788061f2965d0--
