Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202732;
	b=1fvKavEoY6fsrEz/UxxK9MclJRKwCBqlG6zwmYc1DKwlwRx84zWH3DKH+LYgvZLec71Z
	 Vbtan2nrgphWgD3pxxXvK13/NZN7xFs1YuPCpIf/7HhVB3QP9YuFtdufm6x3ZDYDvNdEj
	 8spMd1T4hkAl+M8Kxg7fBiYuAlXPgJ8U/AYz30Ctvv9lytb3dgmlzeIIZvfOEw2YTYCzz
	 AUvVBc6dnq6jL2lSfgMNmDDjMGT3WzvOGTc1sp15ouhcm8XUBp/v36vl/eV7QkEdLstEa
	 X2hvQq5JWmPlJ1toAgxOXFTL28YhCOqnMgUmguWhSOjiqHsJsYDmpSWhK3E8efRUtsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=kcKYmxuUNK2CWtTFFSv/IqBlZLSa+onbLl4PHC3t73g=;
	b=O7Rna7OZbRFixgZyjrxcaTeHQr5UaRQOVMysNve1RQSr9GO2gPTl6WlhVSBWA/6iaSNk
	 VDazq8W0hlID6ogol1MmzX47elTlAavaholDPNrrg12RbwHfz45VHtkJPhYxqP7el3Cu3
	 RarW99qOmYf7k8omixpxtkojCWr0k6Pfxlg6LZ4OF5Z/ttfSZWd4BPCA2Ogyd2/WOx0fp
	 cNrVv81Mfei0Z65p+/hOP6Gs3fbUi1AyFuaCSmgJmZHp9dMmYz69JxDN03kYqIau39Uk5
	 ElvuKmKwYCWnoEqm86hp1NiJ2cBJkk6IsrfYU0IzsoZsT3udiJfHYMHi0UG92fJjsHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ankupPeD;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B663606A6FB
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B663606A6FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ankupPeD
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490f38e9688so982795f8f.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202730; x=1795807530; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kcKYmxuUNK2CWtTFFSv/IqBlZLSa+onbLl4PHC3t73g=;
        b=ankupPeDYpO3WiqFSyvv0xbTdQw+ZMi18gtJWHtnN3kSGf5qFhGVgyHJsZO8erHAl+
         9fDuJJz5aNAyaHXZSiB4c6Oj0qX13kIxkLIbFTRYhSlEqiWjGj7wX/QgSvCVFl54VQNg
         TVVcR2IE2Xy1L5sei+BZ156AfIsGehUZyhYXIjWILwhboQIEziwHMvfjNPhHQpGtWWOK
         hIQJai8kL8xjWtrx2dE0By3agcb/98x4qKUkPS9BByWRPfcMH5uxCdsm/TcYo2GvBa/E
         4JI4RDvBcIlNf5s+93UyERQh/JuABK68Sl0CTSV0MmJHn7p0Am9A9v5tILFpZ5uwhhVQ
         LSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202730; x=1795807530;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcKYmxuUNK2CWtTFFSv/IqBlZLSa+onbLl4PHC3t73g=;
        b=q+HFD+RqyEWjYxKjqRkoAOTH4qW9j1+TmE7WW1oziH+TfJ1SjKMwNgSNi7efQyaYiB
         fk7e5zaukrJecBwC7QvdqUko97ikgzDS2uQWwGqo7VW2wbHN/fxgKW0e5iSj6DVqQKIP
         DLe3hSFlDKIxq2hryNa+Bg5OtGu3nzFcBQ+XM77Tvf77a6sl+XJW/PcMXiP4H+UnQAvG
         mM6mhnmFE1cuBO6zqnBmiVmbcoiZQkulbRJiCe2LqrRqicspXvJXxvWBD6YcpB2qDiJn
         AmJZxXzyoawfL7dnoUvd79j6vyVnb+cSfO/mzEnDIwC3abM8Fx2lqeHf5rN3bQFr+KLH
         HwFQ==
X-Forwarded-Encrypted: i=1; AL+hErEHLXB4ng/+Rk+piiXwMVGz3eawn+RyToPbwMQISU/rfDABFjv8/Y0ZHjtta4Q1eQL6O5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TqccB2h3NzK8iW3YJpgMu3aHTIlTvWawLztioFBncxCfZuCHk
	GzaDE6h4LZJNDhVa60v+ffoCWnw4gzlfHc3deFGkGmvDjAQbTsfV0JTs7RMvgnDI
X-Gm-Gg: AZFdTZcn2QFnRspDE/RB3b7ZlJ67TqO8+h3HHKiBz8gE9MWHf+iHByzHsvRSa/EEsCn
	XlkgtjY+o7x2UxZRLXNDdQSMxiw0048QjK0LA+TR+nAMfxiMAZaHltBG2V1nhcyFAcodZ2vj6xK
	YOo6clWKPVkjpuKC/MZMuCjW0KVE6u3Kml9VhU0G0XDoLfOWsfZA9J1yBUt+LIVv5Z7b8VCu6Vo
	04/zb1PbUWTqFBsRMxpxCXub9iDk/bzlfJB8s2kpv9Ydc89EsCOWtnV9Hsip9pTzJjwc0RnEN5B
	HWIKPtbHBaBgxx94lrVuD8r2Y6S4tVcTCUceVaCp+BdMAZuT3eFQG6yh/J1nR5s4daAmNV85kTX
	Q1JhnXLpCkJZtKSe9BO38nX5+dCjQlmufg98qF8XEVaHqqrHIyQ77uFDnmwOdvS9qFWM4uMQFn1
	rOtBOTck0Gl0r2e64/YuP/K3GaruqAFFqOmX+b5BFODeFlw5FGXl9jkx0z7wkiNF+NkGBZMnX4W
	ih5Qcaz+Kh/ZsPjVOPeyrjU96X2NbZt9xRA+JKSMg9wTNdj6vQs5UjyD+c4SpHOdMowLg7srRBa
	1V9KuUPwlHtY4NsY83FTvtH0oXWS20nmrzoebB6LRedl6/n52dTA948xOI92vKZQMnBJk3vLVZA
	VSA==
X-Received: by 2002:a05:6000:188a:b0:4a4:da59:aa60 with SMTP id ffacd0b85a97d-4abab4f5aaamr8947423f8f.3.1795202729523;
        Fri, 20 Nov 2026 11:25:29 -0800 (PST)
Received: from smtpclient.apple ([87.68.137.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9abf15sm6858955f8f.43.2026.11.20.11.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:25:29 -0800 (PST)
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
Subject: Re: [PATCH v2] doc: fix AsciiDoc syntax
From: Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <xmqqtslbpbpa.fsf@gitster.g>
Date: Fri, 20 Nov 2026 21:25:16 +0200
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <072A2362-2FCF-4DC0-8460-86B63498226E@gmail.com>
References: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
 <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
 <xmqqtslbpbpa.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3901.300.60)

OK, thank you!

> On 20 Nov 2026, at 21:03, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Ophir Bleicher <ophirble@gmail.com>
>>=20
>> The Documentation/MyFirstContribution.adoc file accidentally used
>> Markdown syntax for a link:
>>=20
>> [here](https://gitgitgadget.github.io/#...)
>>=20
>> Fixed it to use AsciiDoc:
>>=20
>> https://gitgitgadget.github.io/#...[here]
>>=20
>> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
>> ---
>=20
> The exact same tense and mood suggestion applies to this commit
> message, too.  "uses" and "Fix".  I can locally tweak them while
> queuing, so no need to resend if you are OK with it.
>=20
>>    doc: fix AsciiDoc syntax
>>=20
>>    Difference from v1:
>>=20
>>     * Change link text
>>=20
>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-2496%2FOphirBleich=
er%2Fpatch-3-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-2496/OphirBleicher/patch-3-v2
>> Pull-Request: https://github.com/git/git/pull/2496
>>=20
>> Range-diff vs v1:
>>=20
>> 1:  748ac69283 ! 1:  cf26060e59 doc: fix AsciiDoc syntax
>>     @@ Documentation/MyFirstContribution.adoc: either with the "New =
pull request" butto
>>=20
>>       The differences between using `gitgitgadget/git` and `git/git` =
as your base can
>>      -be found =
[here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgit=
gadgets-git-fork-or-on-gits-github-mirror)
>>     -+be found =
https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets=
-git-fork-or-on-gits-github-mirror[here]
>>     ++be found =
https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets=
-git-fork-or-on-gits-github-mirror[on GitGitGadget's official =
documentation.]
>>=20
>>       Review the PR's title and description, as they're used by =
GitGitGadget
>>       respectively as the subject and body of the cover letter for =
your change. Refer
>>=20
>>=20
>> Documentation/MyFirstContribution.adoc | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/MyFirstContribution.adoc =
b/Documentation/MyFirstContribution.adoc
>> index c58253fd54..73dab5f7c9 100644
>> --- a/Documentation/MyFirstContribution.adoc
>> +++ b/Documentation/MyFirstContribution.adoc
>> @@ -931,7 +931,7 @@ either with the "New pull request" button or the =
convenient "Compare & pull
>> request" button that may appear with the name of your newly pushed =
branch.
>>=20
>> The differences between using `gitgitgadget/git` and `git/git` as =
your base can
>> -be found =
[here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgit=
gadgets-git-fork-or-on-gits-github-mirror)
>> +be found =
https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets=
-git-fork-or-on-gits-github-mirror[on GitGitGadget's official =
documentation.]
>>=20
>> Review the PR's title and description, as they're used by =
GitGitGadget
>> respectively as the subject and body of the cover letter for your =
change. Refer
>>=20
>> base-commit: f7de81456940dd6f3274e461149bba12965de609


