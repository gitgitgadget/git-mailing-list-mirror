Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391B175A8C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891430; cv=pass; b=UCCQGegroOzR6Dtde65pSpcQNOVIQrhTV4HTs2ZN//4eQT/N2jepezMYJQEGiBGq8Hg618chJXqem6F99YSVVh6jOtCCrMMQGEyqU+H7o5DE8jQBM5CUozTNTfYjqP3eLKkmUBxY8dkxWf7L+Jgo3rAJ7emIZ3sM04EPqa8b2uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891430; c=relaxed/simple;
	bh=o1AvPP7SlXB6MSlw28C4Tp53r+8r0BDS2TunFNWzRyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glV+2V6JdfNC8Q13axCiFktOPpZ1yGwUGSLV1x610r6e0nbkGWid8ElRHUMr9/d4WxGF8Q7/1CnIOmMNg+9CGqV5S5rtUFvwkMK37/Wv3sSgOg5XYwaPC4NUia4czsRXomxt65Vlas5cjoS3Z4jIU8NuoQILbB2vAhP667IIbWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWz9TCS/; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWz9TCS/"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67c641dfaceso1561777eaf.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774891428; cv=none;
        d=google.com; s=arc-20240605;
        b=VAehwkCh9nUjIoefufm8/doQYOhHCEe1Tc10GF5htNdbSVFeg2fQpdRj301Xsi/hIi
         9RWNGGRqjhPGOt0GOBCGXTXj+u0MkvSnsPhtnLIQInlXe/d8Ej+WMOQFrSpi5r5F/c/q
         +6p8QtA7VggAcQaJlS7oZLDJT39QYzH+BFJYUAxBS6yCPHGZ3JyrIWLMBk+sFjwYMcdS
         uibkryQN3TcbEMn/yYJ1IeFvWRFzk39ErAXjtNefIjN02rIuzHwIl7vq46LoklAMTXj9
         yGndSRKmbp9IgoPznXQN080DItHyEXpYIN/C7nv0Y3hNOzUAq51G/gfCrHsL5ydXIDgd
         4Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=exQDOlKV0mIhW3F5FP1r1JyHYykTwG9rxWmYQURvwsI=;
        fh=IIMSDl8m3r9qmOEjxMqGKJQdDcJ09HYr5Uo5UM/vzh8=;
        b=cdN3s5mY4q7OpasRVPfa+RXUDW1M0l2DNzBFhyRYlPCLQUmHA4FEg8kqEWZnc10LeT
         uSHO/dUYTLCJ1v9B8Zco2PL1Q3TXw5e2Q7J/GOCkXlrdf1MpHlWBrqqGIVGFnpJPlbxY
         U+yEY09qmO4ZXod1ab1dDjSqkjjodR1usTsy/u2FNkKpINHs/3kXYGW7vwHtQYqXHy7m
         CfSwqgU9J6jGpaQDOp+AdwE36LHavmx9J5b73aAyzJERl2vUpOcAhip7WV7Iy510IGFd
         IK6lWGKGQj5hb/IC3a+gr/HFxRePRfpDi1cgvD4cVvcd6kCKGVGvc0cfp2X4jC5IIJVe
         LbeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891428; x=1775496228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exQDOlKV0mIhW3F5FP1r1JyHYykTwG9rxWmYQURvwsI=;
        b=kWz9TCS/NnM5yUkvHm0MKhgYOssDQWIOb1Hk7OZfD6XJxLKoTrnYqBzlJ9HTM6YQws
         kvjG6ex/qu9LQwpW1SSzUouNeNL1yHHLS18913pmEAx1p98KDcvXNM1LADgv1LLkpkSo
         oWULtvXdBycspBOAm/h8gG7LkIgOwbPk61zCt0m8hRdF2yMuYEUNLYgYbpn9QMWiAAx+
         jQ+gb3IcmWosc+J6sumyttjY9R/lx5AcaZV/w4n9WxLkos0pH+KEYaZY2SNyOnYR4c3/
         guCHRpNoajHF1jKZ+O0T2CAhodYJBpg9qCUSGR6qQZMom+oKwTGWTpInDSWdTRpT6EuH
         vn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891428; x=1775496228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=exQDOlKV0mIhW3F5FP1r1JyHYykTwG9rxWmYQURvwsI=;
        b=BuMJgdzV5JvafKkIj2OlZi/HTxROqfcacBAkBB3s/Zlub9ZTu7DTe812zY8frsX6HU
         R7CZETftkh03urUf2dp2T3NcYHPutLpqambLDY5UF/AKUUDcLXzEBjoz+hKkbEaU7MUe
         PQxbD80YaWSIn8uxbXJrhDd+T8TlAN7NW3+BI+5uqU3ctNUlOp30tBOvYEO5Yhvd4wAS
         Y5/QxcgcxFnM+jpoIgrNoHNrzsBXUDEBk4HZMZp2b/cKxFuwmEvqjwPs4fFPV1GWvSb2
         1a21VkE8R/8wRtBh3RGOEfkyvd12XvXAXZDvPBHqu0mA4bNt6ZwNdcOrJfei5/Uw31yq
         DhyA==
X-Gm-Message-State: AOJu0Yz7n4Fc4dzgX9v9gyE1NO1pIS0DKelyWhfkbyCOPO87pZ2/VNfF
	h7n17qlHzMJA5+Q0280jQeikmAR0S8ao3Ar0DLY/we9/9m9qeJ9JKhArT7FzFTj5fa2BguGG4TV
	cu9gPVG0f4Olco5AHyEIxZJrGyAOoL/g=
X-Gm-Gg: ATEYQzz9CfgHfHWLJaq4b2a75noxmWM+qjGH/HHvKWw4ZJ0jed3sYaJiICAnDZ5U2Gc
	y0ts1lAvgvO/WfPy7cCYAzbj4KHW9qWt+oNKemkrMEZiERnqF/XzSNf936joXYcHVZBiWfH+UnM
	EU2TQtkc/2TNtnI8Usxx3OvAb4eXsN/5G+S4srYEzeKleMXzGwQTwgA+Tl8El7lFpSU0wGgu3D9
	hfcQout2N+0ftOk8tEyO5kGQdhMFeWJd7OaMTgfgkxSqg0uwsOF0dDDmYELxJBnvCQfF47dzJQb
	xuB9
X-Received: by 2002:a05:6820:c002:b0:67e:1a8d:cc3b with SMTP id
 006d021491bc7-67e1a8dcd53mr4265617eaf.6.1774891428556; Mon, 30 Mar 2026
 10:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com> <da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774890003.git.gitgitgadget@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 30 Mar 2026 11:23:36 -0600
X-Gm-Features: AQROBzDnLtTkpmyU93UJCB07pHhzHmCY6TQQUE_zfbiAEPSAIHX3Z-XD2md3lQ4
Message-ID: <CAH=ZcbA661Ho2ttq0VjFf4R4k8ZKg4yf=8rJPa+Nu+PWA_+wkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] xdiff/xdl_cleanup_records: delete local recs pointer
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Jeff King <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:00=E2=80=AFAM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
I forgot to update the cover letter. It would have said:

Changes in v4:
  * Change SIZE_MAX to PTRDIFF_MAX.
