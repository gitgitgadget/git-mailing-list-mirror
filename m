Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63EE2EEE68
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558058; cv=pass; b=KNn95jmd8k50Bpbg9HjCJf9d+FH/InqoNqKGvgkcNt2RsdvAzzAIFcnTH3uZnRjaA0GHvFaOIeZ46pSg5qzXbA6dTKurSu/wLfDYVUk0fMToOARoH26QVZ210/6ZUSsqGSYfVNcIcEHyzWaTFNjqIwqAycmFYd4DopfHj5H1e+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558058; c=relaxed/simple;
	bh=rB5/pajrQKcEw5gcxcuZOPX3hPmqpO4BRnqUW/wRESE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWYkWB2pmtT4bcMRltoxeb5ripGYvXiw+MHHaLRYqtEVszbIudp27+gj6fJ2AjnucmeP1mUMax9ePpWJL3H5duanG6lusbrQHs1krFMCwGmAAUnsdVDl94tqy8BlXzyW0aq/dAWjyitMCSVpoVFvgzgP7jKuFqDqz0jB42qvXyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/LgiBAe; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/LgiBAe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a0a0b46cd9so322682eaf.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 14:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781558056; cv=none;
        d=google.com; s=arc-20240605;
        b=QRmajHkLwfiHLf69cfE1IxazZ7uM+G7w2R7L4iErZfAEhUIRjwCrqXUtRUDJbSYzYN
         A8u6eAZSve78k5jS8x93i0OM7q8oiPadzchsUcJF088TK2A6VoeyDC+HJmxq30bkqbKz
         4N+assGzOwWg7hoiv71eaeTsJOFzads2dDZ7DXs76gb+YWR7Af8KZBjlvibfd8+h57o8
         FD6ZLPkrWNFG0P8IlkR6GJSYUbRL3PLp1P3TmrQc3hq2n5jcEajgocI1fBNOeO7d5RDm
         pYMpJuRKfBlHtCIE12rrqJlsgg7QOTg4Z+7lvOlkp1PnrD8l0piwynnjwJ9r5Cj5um0f
         x95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rB5/pajrQKcEw5gcxcuZOPX3hPmqpO4BRnqUW/wRESE=;
        fh=vebmqH1zcf8Gsqh55HqWd7lDn0h0awZISzkq8SKHI1o=;
        b=SEaFaaZ5OBUlfJ7Xxjm46OC6piIzFm9qXnrE/oBL9VSxwNtWMrNLaaM3aEOiM6eA4I
         v0hTRG/LrZs8nfhF0JECRDAEngUP9R+n8dWBraFND1Y/NYMMC6kj80phXPc73U1H8+Va
         OotFcHz458kW4VYXwrJ8IYaquol8xIL+f/5mouHvBCyHwFdzq3UgQeK8nIeGuLsch/IG
         oS60FuxHvk5eyQAYxnvTdLTyt833nMeG7wFxiCMgcxgEAcb/NPRKa5vuRYOqrHeXXXvp
         917E2Bo1gMMV5VqANrqzprNS3XQXII+qH4uo7tvZrq2SC4SgaO9SFsDGldY4X0Zll55f
         6zSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781558056; x=1782162856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB5/pajrQKcEw5gcxcuZOPX3hPmqpO4BRnqUW/wRESE=;
        b=q/LgiBAe/154v4BexHqwIOnU+og7vM4BKIuDc4qjoF/pw4BNgqZljwTK2CUOx/kN+3
         l/aoLXgV/JY64NsxQ7hfw8seGxvH0TtUPzzWv2u4HSX4upAFoWKvxkiug5G1y2c5eoE3
         4h3CQiBdT/9iqXftdZFxN0BKWF+Eg2pVXJNmrXebcz7WWfA9kz//C7QsriBydsjOKdwL
         l25XAizk2dXYGiSyhyVWhlSRLBUxWx+LpiIQkp1oy9FuyJO8tLixkhWI2/rJRsiDJsIo
         cV6qginGrU0Dic/XZjww35P7pISSJi6js8+VZMf5chv8Dfs7dZRMpA0eRi55BsVh5Qud
         e+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781558056; x=1782162856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB5/pajrQKcEw5gcxcuZOPX3hPmqpO4BRnqUW/wRESE=;
        b=WDEKZ+cY0FM0FGMFal0VNeqAdifZ+j1kIRSxiKq2AAOKKnRqQBqKbedcjSFe34npiJ
         dEgT63ebYuK5pbSYDsnth6gs/JPHxeUNE+q4+w5xg6NGVuyFBMcg8Aj70wehvxI7XQ1u
         h29rZ+NH6r0R/J2JCGf461GyKQ+euPz8Gvd3GdFZoweC8jw46J+BCtOuDf1pUxpAjS2O
         Xadgma28YBddg24wwEfqg8QVU47yCeAp5dmeA99Z9KZcDYTdWjb/L6p9D47ec0KZ/z0O
         FL7PSyXZ1PaUQIk37CEdkYYsYcTsLjPmTwisAelLrPiLPXFs7oDo9kz6G8dfnANd/ymq
         9EJg==
X-Gm-Message-State: AOJu0Yy6vAI4UBNd+QKX/JbNVdgR9j577WnesSJ0nkPOU5iY1WpT2RSC
	G7S2aagbsRRsGoZ2rxhMphY8/EVLtcyVDWLW9SSrfmPJkveguiCG+wdm4rshy8Nwa9attKnQiDh
	glFTpe7UG57r8Wyw8Aow3a/08i+lEXEevvQ==
X-Gm-Gg: Acq92OEYgjXxkNl0ukEGTO4jSzuxPPg/d6CeJDqPSTXMR9L0/wMPXM5dKyZz1wClFFC
	QPgYzpAheJifd4jUZmM9sG09TNZLlspHd91um5O1WTqOz1KVoBZaMyDr42UUxrZVxouPgs5GBXi
	fzjTU3kZmamXwm02vYsTTlQWrzNNvdTk4XM4s7bB9IYXnM3XSi6fDw858oR1j8I6D0oXQH1AwWK
	Vude4cdOiIguB/i2bprEPQp8AfRSVsGvZuma8lt6fQOFxSTsDoegvLMPkeObqAmjIG8ggf6LpjO
	4+va/S9yxb7lZq8emyPvObTDG2M029Bi2QTzM/nwhc3rspNcJUM=
X-Received: by 2002:a05:6820:806:b0:69e:89dd:175a with SMTP id
 006d021491bc7-69edc622308mr9368587eaf.20.1781558055801; Mon, 15 Jun 2026
 14:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com> <pull.2120.v4.git.1781463332.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463332.gitgitgadget@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 15 Jun 2026 14:14:03 -0700
X-Gm-Features: AVVi8Cez9bFQpjuncNqB00fs6CiFS81BY7RL-biUe6oTVh8P-QnZkWITiFeEoWY
Message-ID: <CAC2Qwm+P=fZOtpfMPeMiSXf3Afk6OLYpTP8Br78_PRA8WNL1Wg@mail.gmail.com>
Subject: Re: [PREVIEW v4 0/6] [RFC] diff: add diff.<driver>.process for
 external hunk providers
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:55=E2=80=AFAM Michael Montalbo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series adds diff.<driver>.process, a long-running subprocess protoco=
l
> that lets an external tool control which lines Git considers changed whil=
e
> Git handles all output formatting...

Now I'm realizing there are some diff flags that are not properly supported
yet with an external diff provider. Flags like -L and the stat-related
flags should probably behave like blame and consult the external diff
process. In general, there should be a more explicit and comprehensive
explanation for which flags interact with external diff processes and
which do not, included principled reasons for why that is the case.
