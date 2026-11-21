Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277594;
	b=KWp0eX04fANeuySEcdpSZLBsYpHt3/JsAXliX2KBug/IbCa6VB8loM6KZNUK5fXmjDKY
	 AB9iRlB7A7lFrXjJVeq9l4Ryx7wUWbKQBEnC9sdmZZhW4jpSALc1vLTuH+y/RtCDAEnUb
	 Tj8VoQ0QYnG3fMlh7KYpuyhDGMucEIRc0nTctVGYv2ro3I/4mITol/tkZgxNcRydu3O/a
	 coHhqCTnmsulprwvUGvc3zQpCnALD/v9HaT7nVEk6LSBENhHpSofekN6epT/wkJGStN0n
	 PjLBrvskECB4Xkn65ZDUycUKEDk8veYfoHk96W9Lree87RVsOjBg7mozRXuGyvgF9Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=LDYXaKLUSJAl6Cq43VeEvUcFj29sS+/D7ILBlHUhkr8=;
	b=2EPbINbjhJzpwv1vfdcXd9E/DuaQ07o/inU4VGjqyW0SKOBBWYFsfytKx0RxAZwweC5v
	 oVPZ3ukkgb8D5LZppx0WUdWydtbnPt5T/0MJyezCMtWMkH5t+bQzP2D+89SO1H84QG34B
	 dwU8tsD/ELhe4Xlwngt5TqcMyfZdwDTMgHvefdZgij4sDkLlkKtd06ABvt32LU9IHm1Ka
	 mobHIgTsTy7EgzUNC0tvQwTVTezrgdUqv1/5tFo6IlMJBjrFDbyJbqJD5/S5xOTo3p66n
	 /4uvrtxXOb4vZOkiyb/qWqPiZgKMaKopIWKLhnEDT79vAZN7aYSddT8LOw1MBI7oRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7+krNE3;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964A606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7964A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7+krNE3
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d05d51553so13192905e9.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795277593; x=1795882393; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LDYXaKLUSJAl6Cq43VeEvUcFj29sS+/D7ILBlHUhkr8=;
        b=A7+krNE3XdZXBHKscQ13fMIrTlKvVVLX1jIXBQzir3z9/nBgn+T0+IIfnFbkgQMxjm
         4sR8bBxhucZW4NUMwMiDGdljkzE1GQeeWfDh0iKZvHo4w7S+z7WwQ1tdr0RaUobQjS63
         3tJNeepBKxsUnRGlkogRaMnT3mZlhS4WHbwYxPi3eMs+vrb4OeEC3y3McpbEyouDYFze
         +44VM5nWsm40lTwabHSFx3plBr+oZt986OWmI8DE9oORjBihQesRbefq8Zh3uKzHK4//
         OfWnktoXiYr1ES/Ih9DqwfthaETqUL0ms6HNnWqvt1pjgw8BepgDz8C+YTXgPFgRbOY3
         lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795277593; x=1795882393;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDYXaKLUSJAl6Cq43VeEvUcFj29sS+/D7ILBlHUhkr8=;
        b=fC6D3jtX1IVV/ElxxO3gjHYp5CkJpLHOwXh5rFPfzilKklHI97GdI3Udf6GLQa5UhZ
         fIB163YHIyBmNBELqlVfCm9uCaom48x4NCTrltp4mJ9ssF54wMxaT6uHYMTppkcTSe55
         vP+sxiz+Oxzmj9dHEQuO9O69oQd+0pu5KvIBlvTs4vCzjCz5UngUKwtlJB+ubKLQC/IC
         h5JYlARftqDC1ewuXezUaA0YkTZdDU0Gk/cK9uw6oiIEkAVyAFdZtNlUwnpmXeRgVvTT
         63Vhi95YXhp/lYZxBaOOaTYlt5oR8l1fFdINBM3JBK8I3trAjXLNy22JdOrNwy8i02B/
         mknw==
X-Forwarded-Encrypted: i=1; AL+hErHxlpX6+TKcW04za2sUit5zMmhGND+UVR/ADN6i/e+H2WhQfetbOckxdrm2c9cuw+O7K80=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s/rMr+2pGnHwNrWOvO4a3EVJ1Kk9/b6J0Q7h3ZUMU7QCrQWwi
	nijnbYcvCrMXpjt3XJXzXgSeB/jx0Y86SbPzi81GX1KxP79mXiYlULm+Y/sZQbHn
X-Gm-Gg: AZFdTZdIWPN7lfGzlpirg5m7EaQ8zJ4HejGRonZDDD1AxxXryNIZxyks/FNUQZBGw9Z
	BwLOfy449ysLwSiuVZDw+9BqWZk5/oFONbZ1pEG/Piqd38+T+BeOCNDTh5TcCPGldJhra1iIUoH
	qJS4X4IKFQ288nyMesZtPwg+bDaZ5JObOO7I2L69NF2lTVwxY1Mx/x09Xc6wgzCVvkosj6tvRB9
	9hwBTrXIG4B5tZI9MPHx8JoHcwiacapvUaRUwMAu6a/rPAgmb7KZ7HNDTOXS1aG+6kZ/mA6hpxP
	nd+XdphvvFLQc3KMwF6ajtQSYzbYRdNLWhAIpxBAi6fvFBd8HbYSmh8wQ7fTFR+lLTCfWVbdXgI
	QqHVXzghlBPKyam5JpDVlxWWc62vlvoNbPy6vpzk9bFZkLiSd+W/nbW7ClW2Au5NgFTQabXjORD
	g7i5kzXgBsIhZErqudh80yiCDnSf3QZSwPgpC49JtCZqb3cOmLYTcb97sd8kEmy1T4Xq7AF2Qne
	hUNHSpZ3w6rQITv3o4kKxXILPw35v86/22hwc+XPYNxnphQztCkNRJ+5E3eyYWdGaiRCxpjt6Iw
	q1SYkVYmEMSJouwuhDwyx3AMkSeknoAR/0mgzC0Dk5Sw6K8XpzzzpawwkKrsepK7LvIDQKBIxvq
	M+Dc=
X-Received: by 2002:a05:600c:c09b:b0:4bb:665f:7e52 with SMTP id 5b1f17b1804b1-4bb8880995dmr106637715e9.10.1795277592696;
        Sat, 21 Nov 2026 08:13:12 -0800 (PST)
Received: from smtpclient.apple ([87.68.137.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm146802255e9.0.2026.11.21.08.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2026 08:13:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.300.60\))
Subject: Re: [PATCH] lazyload: fix typo in comment
From: Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <97cb053a-07a2-c840-c8c6-d1455b282580@gmx.de>
Date: Sat, 21 Nov 2026 18:13:00 +0200
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08E0332F-86DE-4501-8566-895E6ECEEDA5@gmail.com>
References: <pull.2497.git.git.1795275842564.gitgitgadget@gmail.com>
 <97cb053a-07a2-c840-c8c6-d1455b282580@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3901.300.60)

Thank you!

> On 21 Nov 2026, at 18:04, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Ophir,
>=20
> On Sat, 21 Nov 2026, Ophir Bleicher via GitGitGadget wrote:
>=20
>> From: Ophir Bleicher <ophirble@gmail.com>
>>=20
>> Fix a typo on line 11 of compat/win32/lazyload.h, inside a comment.
>> That comment shows an example of function usage, without a closing
>> parentheses:
>>=20
>> return error("Could not find CreateHardLinkW() function";
>>=20
>> There isn't any closing ')'.
>=20
> Yes, this was incorrect, and your fix is much appreciated.
>=20
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> Thank you,
> Johannes
>=20
>>=20
>> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
>> ---
>>    lazyload: fix typo in comment
>>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-2497%2FOphirBleich=
er%2Ffix-typo-lazyload-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-2497/OphirBleicher/fix-typo-lazyload-v1
>> Pull-Request: https://github.com/git/git/pull/2497
>>=20
>> compat/win32/lazyload.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
>> index f2bb96c89c..d348a89f9b 100644
>> --- a/compat/win32/lazyload.h
>> +++ b/compat/win32/lazyload.h
>> @@ -8,7 +8,7 @@
>>  *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>>  *
>>  *   if (!INIT_PROC_ADDR(CreateHardLinkW))
>> - *           return error("Could not find CreateHardLinkW() =
function";
>> + *           return error("Could not find CreateHardLinkW() =
function");
>>  *
>>  *   if (!CreateHardLinkW(source, target, NULL))
>>  *           return error("could not create hardlink from %S to %S",
>>=20
>> base-commit: f7de81456940dd6f3274e461149bba12965de609
>> --=20
>> gitgitgadget
>>=20
>>=20

