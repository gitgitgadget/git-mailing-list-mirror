Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B415665C
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769954488; cv=pass; b=ttPkB2Ujj2zFzH6Jw3W9yGy4cnWAnzG2l/7qlp4fike3iiQodhCXOzHX54IwgKyFiujGcmidiH54T1GEOjZdzUa2QglYekog5Vlpkmkf56hTn9HJvIlmOoL/kgL6ApgnpQfmP/6gv9RJMkMbgTuqowTyzkT6DmLKAM+CltMsEjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769954488; c=relaxed/simple;
	bh=WfX3chbKeAThoCmSG3Hg5NYhWwH5BPS6TJ3mhCI7ujs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hd1kZ6MGdOZMyuFkn3FCdSUFV8dBkpodVWCGk50z4bUfO6r9xGsbFJwLqcO7/t+yQL2eP8Vtv2t6BDso7zlpkR3cMUcWg4kyIVXSs/YYcDto/x5pCHE/WWgsCO/3ehgfNoW97PQ37JhqUKB41h4l8eUP55uOngujhlNYfDOHRL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=merH0C88; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="merH0C88"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b74f839bdfso3272500eec.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 06:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769954487; cv=none;
        d=google.com; s=arc-20240605;
        b=Uj+e2WU+R8REgGD5+cDx3Oy18lEcf5C7G5sbUmpKtMppb0+OyrYWcnwIv/1EYdqcyP
         UiuzdOvLVE8V2qiEjZV6zI24+0kE9zVPUIR7tTB/ZU4JtIUqDHQNAuFKz7YdLUrnceDn
         xSXxr3nR+mFhHHyy6M7fq7u/sFi0NJ+y7tLI58WgjowXpRWlpa+Xl4FFgoblLV1BnCpc
         /uaX1YRykpg4FnzY0xK4RGgJkKhWKFW1lJevKPufMl16ix8J1s/DXQptJpCfUyihwbWi
         wjZkDV9t7CytDyqtyFsW5N6qLxscc+kLJ/0DUvZ92GRrk0r0A37Hf7sespxDmRDcXkC3
         AtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WfX3chbKeAThoCmSG3Hg5NYhWwH5BPS6TJ3mhCI7ujs=;
        fh=xVMIxISUY/RdXpPx1mEUvTSih6h5WjicUO0jcPODdF4=;
        b=PFnEzQSAiqTSFlxlFYPyDrj+P9fLzygHfH7LqVxL8ZQ/9GcoE+DZDkZERqtYIy/4RO
         qrWH2UrOq7UhA498T8XMltC7swUQqP794+sBxIT+VIuY6FTwe+IDLMrZ4UoDWZqJHuEG
         Belt3cFiYIwk8mckQzDISiZaOMgnaNOrhWMqM9SlS+DFRqiO1Y6h/OZcjWnPtycR22wS
         OCxv2OKODiUaDLJYEkCfnDNDwTkcJ7UZVto9WJX62TQ0n8+B956BMC/kRTgw1YtOv1/b
         C6/Fgk52n6MIoSiqFDm91K667qtiQ1ipj+osvozKTLMQrLleM/S9HOxkEVbsZ0pqd3N8
         2hug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769954487; x=1770559287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WfX3chbKeAThoCmSG3Hg5NYhWwH5BPS6TJ3mhCI7ujs=;
        b=merH0C88awOCrhWOkwtRD9GD2vnhkcV5M0irEvF5hlz2e6Xy/mjcJAUCTIRbKxL49n
         pbPX7zmQmGb8WzaPsK9G6PoSoGc/nQpdZ16KCetMMyKnsAhinyXmwszCMUiz3e6L3OAt
         HCQQOU4KuwSn0xVAYi40O5lAXhEL2lehaOsXuEYpNX7wV1/4HslsMm1zr0IKQEr1ZOpU
         3B9j1EbNt8k3dbIokUaC89NiPOgsSWYiGAIuWj5nEEDw3Go55H41q9uCFD8KEZR4qwRV
         UyP5qHZ+4X0UZE5jFZrNCrYl4LvFk8hDuJIA/cjTtMbiJ2b2YTnQp50EqstFBbPSkNzU
         xLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769954487; x=1770559287;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfX3chbKeAThoCmSG3Hg5NYhWwH5BPS6TJ3mhCI7ujs=;
        b=jCDbYrfrtDOC4ivIDG41O5cJNWEoI1bJ0Pp3s6xXYzIYN47tM/3nd/5UqzGvWhUUM9
         Bs72BtqKSAAdaKW0UN5FDk2nPg/7C4p22+5EjvfOPRDdrGDQ2ylAHjmtmfLFTJUGjOMO
         WPRffZOenxZrULdBJkpXZmE0psNZOXzcVmAA+OFMvT3ENWQjR6QOqijelE0eRsAlrCDe
         jbmNdmUWjw8fSgy6xnoCQ/qz68oZnVxNjE1/aBVkfbCbqcbp9giul/ZiK4M6qPxpLxX9
         CFpYM/kzRuxrkTVVHX0/zGp21m04ok5LMaHpO8aYfA06SgbI7sg7t0Rh+zKlL0fD4j99
         p8dQ==
X-Gm-Message-State: AOJu0YxfAXj7V1yGtewRpsdhMoVXo3j5OozRNxeWyyvhbJRIrD/oFVe2
	2NI1OVOHjbFYsa3oOkv1cNpvrzjYnikAVGRImJry0IIqb2yFgoc1uvhBgrirDN2T1dARgzGBsrq
	7duLWS1LwZMM6yYHrhNWd+zjGCcQ5zFnSzNuA
X-Gm-Gg: AZuq6aId7we41VRl9/M7Kskz4Czl+4tI1XFdRiZoAH4weSalwa8il51fKhPCQ2MVbvS
	SkrN0zZw4NYWZ7XDB/CBEoLwLxU0BxK1spApCdUrqOuojrQpSpXEYc+n8Ry5O9BRgzxx32HqobC
	wvGYQM6qnC27EWXL9A0OdCdYVt0rWP5WWEknKGCZFJWyRO2BD6UF5rIzwRogQ9ERmLG++5C0Yri
	vqa7OmMaM9a2w0hpxGg71CDXpBEiIi3w39v6dhKiyorpbtRlwbmHwkBwOf1OjH8qBM6ulL79+ww
	wtYA6fnZXXE/l7jfo0KXMqzXc3OzK8z8KedTgyHrTNZ+8CPgMT65N613iewVKA==
X-Received: by 2002:a05:7300:f108:b0:2b7:1dd3:585b with SMTP id
 5a478bee46e88-2b7b17a83bfmr5336727eec.7.1769954485433; Sun, 01 Feb 2026
 06:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Sun, 1 Feb 2026 19:31:13 +0530
X-Gm-Features: AZwV_QjUK1ylbpxviuWuGtBkxaFDo0CV28TcZTUnk-9jO34bp635SA5ffJ0_5Bw
Message-ID: <CAG7UgERzxKzaqAS1upF6G7NHneoDNbfQYkpyAsGRBGXtdmVOxA@mail.gmail.com>
Subject: Re: [Newcomer] [GSOC 2026] Introduction
To: soutrik das <valusoutrik@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Soutrik, welcome to the community!

Completing a small microproject before applying to GSoC is strongly
recommended, as it helps you get familiar with Git's codebase and
contribution workflow.

You can pick a task from the microprojects list here:
https://git.github.io/SoC-2025-Microprojects/
If you are unsure how to begin, searching the mailing list archives
for the microproject's keywords can be very helpful. You will find
similar patches and discussions to reference.

Also, these guides are useful before sending your first patch:
https://git.github.io/General-Microproject-Information/
https://git-scm.com/docs/MyFirstContribution

Best,
Deveshi
