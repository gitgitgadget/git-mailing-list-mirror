Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D53FAE12
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334078; cv=none; b=qyLI+WQim9Hah4VYjKKQiX2pHuD/92hXcsFDb21BwSg96RtjqxhwebiKhdSjqDTA8NhHHzqTb/iFtX/SCuT1F7IAK9lVSDOA8rcKxIVAsI1bXZO+a6afK0eWTJmzie/+xR+/1S9QUWGIZTditNDnb2dyVneARPJB4ArPlSiRlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334078; c=relaxed/simple;
	bh=ex+ALXIHxpvbVUN1o2LAzabe57g8M65Xn2GzWpNDC5c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q1UQkTLkDrVrIbQcfPUivEeg8SZSeNvQmc1I2HqI4hxDmjPkeAwpZus+CR2WpMazDFIS0cKYULzcMlqwANBUpK3UIvCZnb82GZ96o94WO26b6aWMUsHU235GYBVN1WOEsQ7EN2qcfEw2K7G0B1n+qct5tTuml96RKMyMP06eqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/RlvQ9+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/RlvQ9+"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a126b79512so1297100e87.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334069; x=1773938869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ex+ALXIHxpvbVUN1o2LAzabe57g8M65Xn2GzWpNDC5c=;
        b=T/RlvQ9+X/OzjQ+rJk/j22JZ+gr0QQw2ezqqYyrI887CTkNnhtXepbawdbZeCsgLgy
         YjNW4u+du7/YxwFcQWhkMzA5GEN2blT0rQjkIYgnmj26YIFKle2TDyPEipn+uSHssO2C
         8X+Iu15PmPnQOIEsqmpgzIFviMpxf+iQSSIRsIbDvy5c+N50eJPO8X1lYHHHQRYi/HkW
         YqaifDM1z/vmXzQm+DkfslPrnPJOqC+pMabi1KuBSbAMWC0JVus4+mkHsmOM9C+iT+Nq
         YER6Cr04ys0lFxeayXlS6OS7YLnD8z3SE7hlxicfXF9FBrRt2geRwbeEv4xEv9wX7J7Y
         vxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334069; x=1773938869;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex+ALXIHxpvbVUN1o2LAzabe57g8M65Xn2GzWpNDC5c=;
        b=trTUV8BFxPuyZDNJpyPy1Rv7RqeOz5baEqMkdeiZx+u9GfTuvqgMHKSdnJHNlzlr2W
         WsnjRcDfYUTZkfFk9LN1BXWB73tuCj3Th3QDfRjJd2Affjl4Q96HauHphKbNcrg96nrm
         N9qvpgvTfjXwoS9qyTIiehaIBdkpvxnoSuYd08lBF3il9A11lvgqYZBPiVFm78EhaZIZ
         BygUbYNWwNBcGoqaRF8pV7oSzwdvDp5YvS8sEmMeKiZwvrBp4lM7J/jdwG/Qtu5qsBBK
         N6gLtKv9HOrr5vWzyecWomQCRDR6qcBTab1FuyjtfbMsgRY4jU0mFUGZEBTN4K8Mrnd2
         7JYw==
X-Gm-Message-State: AOJu0YydDI2cBySO45PDBnJtTirVRJATuzB1lqPiRFYyYakCsXuK5ztE
	OWzh/EjNGoMNZKwjD314z/tH1Rvhw8FvgUA+LGSE9E1Hjvy5xKyr5hQjexKRqPWtbCE=
X-Gm-Gg: ATEYQzwTonQFKRFGC3IAECyXWmjbKq3TxqiRz5TXdvn1ngXHN9/XmsmAXsGDUrySKYU
	5yItM+dFkLNik2S+phYVkKu+uq1MCMltPjrF5KNRTVevQHnsEsLOfZaEsyf4PVRwvXUu422BOqU
	xQfC0eJAtlGPdCrlEujekG+TaxCUpGsj3MMu6w2P6s3fSQvwAwJsteAP2Shk03HPZLeWwFubT8S
	sTSv4yrkt7szAeFj+zr7CRUgsXTPGzz5tPwGjPV49PK5QUGsEqNpWyNnXp6uDzGUAyNG4yYDBS8
	Ugyld+2LQdXA5CRcXE+jNZ6VQqcRAjWDgw8stc785ltUgNl2vFS85hkTf/CEOsbLohbxZis9Koi
	z5EJ6hd+Mca1GREM2b2oWbkLF/5pLW3dzZ0AfAZn3Ke9YQi3feFsO9lbwn6w6bLZdf2ioaO+Lfv
	e6eklCi7oU0OJkHZRW0pjc2pzcQiwFSGJtbbaB2xU4l/mNEj5zliRYGYmmGueKkie7nRJXVK3i
X-Received: by 2002:a05:651c:198d:b0:38a:6acb:eb1d with SMTP id 38308e7fff4ca-38a896a74e6mr24241fa.12.1773334068548;
        Thu, 12 Mar 2026 09:47:48 -0700 (PDT)
Received: from ?IPV6:2a02:2168:8772:9800:eb6d:4393:98f8:641a? ([2a02:2168:8772:9800:eb6d:4393:98f8:641a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e70d66sm11097121fa.40.2026.03.12.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:47:48 -0700 (PDT)
Message-ID: <57252c1e-69e6-4953-beb3-3cfd41cab857@gmail.com>
Date: Thu, 12 Mar 2026 19:47:47 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrey <butirsky@gmail.com>
Subject: Re: bash completion bug: "symbolic-ref" subcommand doesn't complete
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <c1e0c05b-c767-4fcc-859a-4da6b90c4497@gmail.com>
 <xmqqikb1ggri.fsf@gitster.g>
Content-Language: en-US
Autocrypt: addr=butirsky@gmail.com; keydata=
 xsFNBFpWP0sBEADdnQLkXcwaJnoXWO4o9vlWHsLqsbltZ1MEIewNV/7jfhQ6mBBW43O4wK0/
 kdICUpH3Tv2iGQtWszAxBotWhEjFii6naG5FK5nHtO/qbIhpRA0I3nHn0tNJRxIPbtM1rFHh
 xplEEPRqL04EG0C5iC69SdKPQdHCDEP+xFrBSmANQ7Zi2ipUG9ctHiWA85iatbK1Y1T/AhfS
 d0dOkKXxH7SWz1w8TiinhIGlHDtKdul8W/g2pUkSE0iW9j2Yipr4YRMSVJPMYiilWrC2ofth
 1gH8rUI5/a4ePatVBh2GZInpyUImjGbC3r7vzig/w7tdrq8dXQYramHHs4xpCQZ+kW45nkS6
 aNY1AWvwGKJBzVIyqflVenn/oElIvaviiR4txl+HfaIcSwRfVLIym2ywa1ZUGFfVF89U5kh8
 WSp++JDIAEflm3Yh+56H0L2th81mV2XzjEJhS87isDnQLvBYvW4GSwUTwgHbGvU6yuHGC81y
 d4bGdYKEJtPLjGpFMRAdin2YRHyKZbbcQknOJCOSOZW/H01H5aix1FqklZp+jwAvXRAT+dPR
 77sYVu21IDe/glcuTxHRvk7fgMnJt5+Gdv6nWEtg1r4NLAik1eWMKJnc7Ho52T9Zw/Fie/UX
 mQ4iZDJFmOmckxLLoRJnvGBmQJD+dHQLW9LHIM4aKwSqAIbZXwARAQABzSRBbmRyZXkgQnV0
 aXJza3kgPGJ1dGlyc2t5QGdtYWlsLmNvbT7CwYcEEwEIABoECwkIBwIVCAIWAQIZAQWCaXyn
 cAKeAQKbIwAhCRD8txru3lAhIhYhBJhAidEwFbzdZP55C/y3Gu7eUCEi3U4QALaYKHNoZMMA
 v9wz+lRTade6vgD7dLTfxvWK5Ahy+3N/RyMe4yH8Vg1t5gGAtTqIV6xB2sGC69f86LLSa9+H
 Wj+9FYGksqd2B9STVjSRC754hMwSObM8WPMFj6qoP8I/URgH5J6rRhPQuk9Ltc0Kb7ws4BTi
 gT1Ss4+aEizcwiahH2JjHrnYFHAM/IkCQEmxHZFrtlODCPpQvSw1iuL6hL3iwYFLZkkcNIDr
 FYnNKAF+0t28Upq0Opd12NpIvOtBaqJ1+QeP5FqpuuuDMW350pr/oieCUS3XfAEV8ilcABCJ
 kK5EpwkbNW5KdOuMYjchP1UfkdT5vz85YhhAW/MC9DpC8Ade3Jdo8c4dmvgrYduhHyJ7xLfS
 soJbD68mUcJ4aG0uiZR8XBrca2e99cG0QfDyVl5NqbYj289Arhs+26LMEBu3wECUqQSlXL7V
 A2iUShH3Tp06XOyMkbUv8gDIzD6vrhaKK+MkDjeTOHC8pZzFeh7n15e1V1vdiwsup+9Lcz/J
 J822sR0ivReRRM1jQKW8O6t+eZDOSw71WUdGU/ySQXkPQUcsy/20kXZ+8JXMZ/OSOhzp2wdw
 Fw9iokn/mYUXKLqae3MHp2s/FPV+AqyfEUFCXOePii8nI/GvG4VDA77V8dNi5LqPnDsULW2y
 Ym/vvid8aBO1HOtRjpGnPlWwzsFNBFpWP0sBEADxNpLRM8haulFf+d8g7SRS38t3AUBou1cS
 lym08+djQVUXCpNLPj0LSsV4zKzmyGs5rn4R0kin+EIjhJEVqfiPrE9FwCV5tk3r5kP4X+oK
 LHxworYy7E+nBtw7GHvXvLvtWyMGstC1dVhU3lLmIPfwwNpjvE6LSDS+xwZLZeeoIO07Png1
 KjYZ+T7FAdrClhhwypMFwM3kimBUifZdzSPwnxww6G97Vqm8hFP2Oxyh8AEWBTeya0ayfV+k
 BEdnSw+Uy7sRt0L8Pvs5bk3lm+Qi6NMzDGsT6ezvOVSAa5meDULmdjkett8lbRRE9IndSGhx
 CDXQDeRC4NLcHdWVDHir0tHvZZxCuD6FSlDXZtnYYL3PhWef9q3nTdpXzfKhNxUbFU/4AKAv
 UiNTvypvgsrbhHnGKWBX3/oNPSY5ISuGYe5BCgeBKBCc/5MFvPAT8/YOJbZUkHNiN3Y4xGQ0
 tNCcgxmffQPDt+F7XLDdfnvIlgDPI0yxr7tp07uW8QItp/ArTfknGzZNOT0T0HjiWojD8TqY
 YKQzsEh5Acszh5auNMOucGMV89TG4o8PMAgGlyQvUVix3TI9JWG8LYEooSFttkf8iE4/6Plm
 hlkr5I6lCyguRo2+o88+o6tt7Y/f3LDYcV4JtMhye/BSrhjv4xd26yYWpTmGf3avU5UsNcBf
 XwARAQABwsFlBBgBCAAPBQJpepOJAhsMBQkYi4yFAAoJEPy3Gu7eUCEifCQQAMEP1VOnkIEt
 jXQ6qgpuBvyPZkudJ7w38VHpL66cQn8ipQE6YEeE4bpQmw5x7TvyHiATEnI9cWK9dhiNMe8D
 QXrKuLIxEW6sEhhd/lpfMWCAERmvZw4rGW9KDjhr+O3i3we88VVl+5eWW+A7cwrcavSZtGhk
 Jdb9KeUFFplVO1MBcKnO6DST42S5oJ3xOyHXuXGZjbfKv7HL2leQ0mVOmBG/2pgz1YbCFE4F
 BtmMjP82dEAJYJChM9uvw+OaJDOc8HCSOT/OHJT7exl6XGBpwAzz+LRw5wybf5llafPFv42H
 W68z4rewUh5lFZFsQHcBYsaUmLKg4HaiVNQNSNhkCjTaS0Ns4Sw2muvwSwHT1EkWgEhOdAFc
 fRFHtu4LW6eZIQAcyzjt+9cnvCz5/FRpGzLVHFVhkHNi9qkdbnGNNz8B0nbAxYQJgQ5TWDsa
 uiVzj4EZrDZSbZHl9sjfFSer2bzCK9bfVLhM/fjOfoyLWJuZ5kgGJqfDyfPsCHoiqsJfamJ+
 PsWRKZFcB3U+mbaMzFUqKDCskpRE6+frm188LrSf55BLmL5XnIykO+l+zAH8u9/iy6NHSjEK
 0ft1PUXja1u52zJ4FNtW/PVbeYP2Thow1izzyA5L2b35FVfpz1wlQ2WHkJ3x4CpaET/6H/dY
 VVOdns/k4krQA8QXLlOOXh+F
In-Reply-To: <xmqqikb1ggri.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

You forgot to mention the main thing:

/usr/share/bash-completion/completions/git:

...
#   GIT_COMPLETION_SHOW_ALL_COMMANDS
#
#     When set to "1" suggest all commands, including plumbing commands
#     which are hidden by default (e.g. "cat-file" on "git ca<TAB>").

Thanks for the tip, though.


On 3/12/26 19:21, Junio C Hamano wrote:
> Isn't this working as intended?
>
> Our general principle is that the plumbing commands are not designed
> to be "typed" by end-user to use interactively, and cat-file,
> commit-tree, etc. are not completed to reduce cluttering
