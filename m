Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF3283FD4
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928805; cv=pass; b=TVGADUfCBX6XZvqkDvEDZxoTHUw9su8Qdf+8I/wiEruTZ9noXcCZ33kvJLEgQaN5RH2CiXi2VEfqPUvK2ZTGtDy+7fwk06XpCxYRJWrnnpHetmTgoqKWqEoC4K5h3jMZ3KTbfDRBWt4XLVW+oozxz8mSUnwT7fL5oBNXlEGwg8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928805; c=relaxed/simple;
	bh=pHxUgEQ3YOynPFm7s4oD+9N4Kxg1W5KisV01hJGs3Cs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p51kkNNypa45ORiYw0uKE2SlLkP2IBV43azDemuP61VzRHCLOiBYeTQcOfpp4gn68BVrWHlxCq9rQhH/cunDEvWBbHUKC+FkwZm00ip135ebkayw+9DccAhf/qbqhuubSdZCZluWYzeqVyfuF2yx6FqOU4tJG6nRhPZRz8SbhmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwZf0FBX; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwZf0FBX"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b8541a00dso153785e0c.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 07:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773928803; cv=none;
        d=google.com; s=arc-20240605;
        b=O7YOrQQofNw2HtxKX1cYB7MABQ/ovoxKMfJhy/4ZzP8tgRYoeOC7h2oW0OUImgYiBM
         wnjzzzm53CXf8fyWLTb2ONPlYKbzvsSetz/Usm5fht0SCQY7SH8SRg5ZYXo50SwAPXBD
         aIvHMv/7k+JlUSyDV5dfcGfF0NNyG966spM+Ru5Tf9utF4lIX3hFfA6cC93kvDtlq9Vn
         YFEzIyNxrWyr6K7Oumh0lu1TkaZLZuz6HNAa4BvUroIxxENAhFVBTb4oYKrN5x79ZV5X
         aF6agqDDoLR+ovzZB7idcC0wjhFlGCGpjA+WX+miV+U9h6AYs3WEBUWVgQRfsQq6gg2o
         ogrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pHxUgEQ3YOynPFm7s4oD+9N4Kxg1W5KisV01hJGs3Cs=;
        fh=7GGDYZEkku9sK9oKFzUJeF/sSsDIu8M2339i1Sft6/4=;
        b=Mpez/bA7DhYC03pSIqxO2u6bhAr0fJWnZzLdEDmIj6lY1NiLSjcj1wOS4dCZgulqJW
         /dyQzYluB1I2jQkUQ0fkI60ZG+Ygpmo8qIcTSl0EjEoJoypH1XccChaQr3n770jmmpdy
         puILzBFVGWGd6UEjPlTiHrLgoJ+66OhASfhpwrTqEIrpVlAlY2dVYCLaOpihXVbPEA+F
         /xRyMaIt5lpIMF8HUaeNt13o463CyJShAzwuU3iOSEWNxT7wXOQE4Avv3E2GsuvQGKKF
         jjyGVV3+y42B4ajTbVrUe9zn2tChzMGDIyqTz5tAxqDAc4Rl5dUjD+EDlTCv4Aplz2ua
         ZmOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773928803; x=1774533603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHxUgEQ3YOynPFm7s4oD+9N4Kxg1W5KisV01hJGs3Cs=;
        b=SwZf0FBXPGaYxZLA1gNfIBGM+DbEwxta8RwtXM7qI3mbNvfS/RngFV4OeaPWBxYEr+
         FkW8pFh/frfUW4aWcvh33i1IO6NVjQYWzBAlvIb0zPdoYNSw0n9UAa3cokolW3neBpu3
         0GBz71wNGx8LCN5SJCVlx5iIqM1Tsq3qjOk2Cq2KXid1yfHBtyeR3JGEnI1iY/w9qOCN
         Fcrdv2XQS+UnBSOIbm+gIFLeuByEDbQ/VwvJBcID/oiJJ4BGxe6MMOjl4AAXwAZha44n
         NQ0CdLps9XHasqQ/1ovWAXwCEGMnHz5u7OGepcDZ+Sym0TR3911JbZ8/emouNHlr0aEF
         Ogvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773928803; x=1774533603;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHxUgEQ3YOynPFm7s4oD+9N4Kxg1W5KisV01hJGs3Cs=;
        b=NaWK8BuDYjt8O9Re25tK1ANKll2loyQjgebovJlbXiZlsy+rKLAyG3J16iPa1xcEh/
         MKilT1xp/n1eR4QLSgSRXrezfnLsAdQmnC1C3M7gkOaRAB0esplVos8Nsd7qc1Fs4me5
         +3mxyv9BSv4Ztnss465YieJ93iJeCueJLZnNHJOYxQxj7kfqXRP8dV+ni3Z1F8P2GW95
         KdDKmrwRn0sFlB5MdkKhcIpcA7z1xJt6NWvyEsiyZPGB/XW68DXTFyLF3kAboqRN1NeL
         fZliHUSz1LYB8xTTjnD/YjyLd5vyM2U1YyoreZbHj2CpoBaHDL3gZx67quZA9PY9GVkR
         jZxg==
X-Forwarded-Encrypted: i=1; AJvYcCU1qgjfuCLMcwOVDwZCOUj8bhEYtZUczRawN9MmKX0M3khlVIf2+Rcf50fzwYsQHaqatcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNK5T1M0CM29KiG9iLpMitwMK7iUXt46FCSLOrGyQw6SPhIRw
	OUvishi2Age0BeeayWAH4Hgk4iJBFS4Cakp4CpVLtSHRQ+OLV/eNv7bYAZlmm+JowVRqHU6tAhP
	Zp2GD/k2mCQfifKxIj+7OqMSUhGkcLrI=
X-Gm-Gg: ATEYQzxOdVHrdsOseGKTlrthWMpxzYNhxxzsoDWQg1z4KJ78ZE5C9KCnlGAB6BSbXYP
	XJJoOfKLy5PeXLLQ/UlUvHlEpcUEVJ0mtE+RqWCQclNoQ/TMAluEHtNkf4uaXJetqmAz8Px5BH8
	2/KceaBrtd21tmZoVMmNwRgA+0bpulV9UGYzEM0wkWDRWMH90Wtf+m/zzTEvSuK0rVoxkZKTNIs
	ns3c3DI06iHNomZcXUCjb84kw0o/GOG45m608Boe9MkIG/nxHsWVc9hFXjkL04yfNf2WWBxNeyL
	/rwQ5mgqjpk1ci6jO1IUizUHzlj/0kejj28X++2xTg==
X-Received: by 2002:a05:6102:50a6:b0:5ff:d192:ff2c with SMTP id
 ada2fe7eead31-6027d3b24f6mr3120173137.34.1773928803182; Thu, 19 Mar 2026
 07:00:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Mar 2026 07:00:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Mar 2026 07:00:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2242.git.git.1773766519857.gitgitgadget@gmail.com>
References: <pull.2242.git.git.1773766519857.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Mar 2026 07:00:01 -0700
X-Gm-Features: AaiRm529LWEra8adG5K6jxzqsaApTiBZx3jHFDhebisa20Hgd8uI8h2q_2Up200
Message-ID: <CAOLa=ZTx1JnxtpPiz-Cegj7eMEGZmGL8s-RJQmTWv7W4H-3UoQ@mail.gmail.com>
Subject: Re: [PATCH] repo: add paths.git_dir repo info key
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Jayesh Daga <jayeshdaga99@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002bde15064d60fc98"

--0000000000002bde15064d60fc98
Content-Type: text/plain; charset="UTF-8"

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: jayesh0104 <jayeshdaga99@gmail.com>
>
> Introduce a new repo info key `paths.git_dir` to expose the
> repository's gitdir path, equivalent to `git rev-parse --git-dir`.
>
> This improves consistency and allows tools to retrieve the gitdir
> path without invoking external commands.
>
> The implementation adds support in repo.c and integrates it into
> the repo info reporting mechanism. Documentation is updated to
> describe the new key, and tests are added to verify that the value
> matches the output of `git rev-parse --git-dir`.
>

Hello Jayesh,

Seeing from the people CC'd I'm assuming that you're interested in
applying for the GSoC.

As such, we encourage GSoC contributors to work on micro-projects as
listed on our GSoC website and also to read the guidelines we've laid
out [1] [2].

I would also mention that we do not recommend getting started on a
project, unless you're selected.

Now specifically for this project, there is still no decision made about
using relative paths vs absolute paths, I've highlighted this in one of
the candidates proposals [3]. I would suggest getting involved in that
discussion and coming to a conclusion before starting work on it.

[1]: https://git.github.io/General-Microproject-Information/
[2]: https://git.github.io/General-Application-Information/
[3]: https://lore.kernel.org/git/CAOLa=ZTtNSZ904v0-SN16jAis7gK4=MVj1g_5CGdbmaBopeZkg@mail.gmail.com/#t


Regards,
Karthik

[snip]

--0000000000002bde15064d60fc98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4e962334d499ac41_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOEFWOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2hEREFDTUdPa2w1SFFmRDVSZHUxUDM4aVJXVk9zSwpFejZjeGNlUE5p
TUsrZGN6WlZDenZ0RC82MGhlK0lxTlhEWS9mcTlYWStGaHN0VFM0OUZ4Vk9oeGNkNyt5N25VCk9S
NlRFY29lejUzQXJGaytYblRFa2VyOTQ2RzhiMXM0bWZaZzQ4ZDJWVUZCOTBCUUZHNjZGZDdwZE40
alp4a2YKTkpMenVNQ0Z5TGI3eTlVUVlnakNiUzVwUHlaYnVzcGQ2bUN0eTg4NVhiZWR2VnFvTzNI
NVJMOU9ycVdTVUwxbQphT0pXcHFkakVtVXo5SVBxTmlzdkNRNmk3MlBDOUpTczlkVC93NnlHaCth
TjlUSGNwenZMeWl0ZFV5eldHSHQzCnhhbVJlRHVXU0t6ZmlSMkhDUEliQWo3cmsvNVN2WmxGTEI2
bGhFc2tUbURwenlFRTBrQ05sNThmZFpnb2c5QVAKdzFva00vQ0MzbkRQWTVkeHFqT0MzTFEySlIr
QzNyNzNLSUF2ZTNHd3pGOGZvRWVJUVY5VUc3ZEZIVVlSZUFOTQp1TE1DUy80WFNSYWZycllEQjdW
b0RwRzlSM0YxV0RESFo0RGFwUGdYYUV5dWRLZTVFMzVRS1JXS1dkNTdPQUFhCkpZQ2daU3E4aVQr
Ry9zdWNERkE5N1NkSnZXVnlIR1dkKzNiU2JOZz0KPWd6Y0QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002bde15064d60fc98--
