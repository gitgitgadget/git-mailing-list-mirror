Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795281887;
	b=Xvlq+h2Vrw1Q9YylVW8Tn+gaJnCmhklt/BdlkV1Zs3wOZgmqqZBu2LJDbVnC9LFPPMJx
	 kSBy6d8HeNoz8gb/UZJpVdMu7vHfejzqm9ZImalhOLTy8bDLxBr1ABoMRSrJaRtxG+vuC
	 yt6CpgPbwF0+EjJCg+2pGan0fYAb570vYNpmRLpgyG5KYBxIcpa0OPqLIUvZ1CI6w73/B
	 WhKuMS/HaImVr9wyijRzWzN3ZoVGR0aWDGCWd22lxoQfOjEfn0yGSms6tKhZJNS6LZKAF
	 q6q1SiKQnXlQUtln/RcamtxrzmNHlB6EjUXIy5XHrYXrIzmsaoWEoV5gBPPLQvM0ENg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hzFmGMifhLboZh2kGopaxbIEeOjWFZQBzm1EOjBYPKE=;
	b=Lct5M6WvwigBNOF+MXyEcz0bZR6LU+zFH6xchp5o+6mZlDlXSCF3ivdCD12rm7WZy6y8
	 PjibFHwUI2yxOOozSu9QG2vYj6Yg5u8V5To1OeeMpaxke9Log3P004wXlYRVotIcsHwHG
	 wi64sb7lzjewFZ3qp8cwdfag2SBrd3KZJ5ntS1w5GjN5Ni6BRLTblUIGUiAaiFlFfuweM
	 g9+VX5N815lc8NtH2JW6CTUrB4yz1Ipt0hkrdR8YKRRMS4j57yBTsnEPEbQmh59b/yCg+
	 NsCjt/L8LMWgGBBeAYwyWBwwQ8fytMpX6YoVFp/h8XX4LtutCKHYdK9NyDNxzLMGvkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u7zT100/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AE606A33C
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405AE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7zT100/
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cddac941ed1so786656a12.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795281886; cv=none;
        d=google.com; s=arc-20260327;
        b=gcNaztbk/uHLEGkrlKY2fzyQiIiXqBsasOydfbGjzZOsB0idLdlAo8h6dctOtTHTAf
         xtehRXQ9oz7s/KB7auRpcRNHOxvtqIHDFnOuYtK8Uo54fXao3mgQ1t3P2kQGE7SOI77U
         XWowRTgaTnwZhGD+YuUHP2q+02uy0SmBmZqNOLjT4Dba9eE05UcoJ4NjlbI3UgOQqTjZ
         h7FF9iBwnNrRCtj0MttYYAXYwyPvPbJqg6Nyqn6R3uI2CJAIsQVLeIeNu6bff9dMf1nS
         2DCACAJv/A+Vr3RmQFZOO9sQce/GuJd21fiY/tQ9U3I0duisdkzMqVKadqamKCO/APq/
         q54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hzFmGMifhLboZh2kGopaxbIEeOjWFZQBzm1EOjBYPKE=;
        fh=kZvEvI/iErNiVh3Ry7k06uXBc2Epyg5sbSQt12mwY5E=;
        b=tCRRcBHdoPYjcTPao52HBx7G07NKmpnBI7xrIWTvvLu/c+o3+ed2FsY5efm1H9DFWc
         JladGEOpcue37VXMTKWD+5IAetqtB6BywWSPC1LYu7rgq1Qjh5PEETVMCnsLbfgGg9hS
         WzZ2HoFU4L1AD5NqXQwL350GIEyj9uuHdaFV4nn9MeOoq8Tflko3HyBwLqODz7YTRmSH
         njL9VasTC6telQCNvDzywUxvxzImzu5fwMJyAdlC2wWoql3TrNRqeqJYetbe5zhDdWwj
         vPPadAI7+NVxkCxn8+0ijwysHNW5rN9/hBC9PPjNHI6NqJyf+Wnv1BSoTNMcWsMjaa21
         T0OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281886; x=1795886686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hzFmGMifhLboZh2kGopaxbIEeOjWFZQBzm1EOjBYPKE=;
        b=u7zT100/FxXgis/fQioKFxEbZRRbwvJojcOPHMkMGVIpS1DuWviptQ3DA84P6UWvX/
         GHyP0jeZ0tTJfJW9G/mpbze9AxnrildNAz0HA+vgzflnGxbikd6AgOfdmqvG1GeelfqE
         ns5ef7RBfR6LBqqmgTbzjIWWPdkuoGvbS+DraIlNrA3XmLf7cj6HdDU6hXNhPE7yVwqo
         9UDQT4xbGM9I0zg0DCyDN3bxD90j2S2ymPnuxxL3vPoJAj+bgSGBQQSSQbWkh7dJC5yE
         x+Z+d8C0Pn2P26L3jfoAWfk/Al2tBCj9m13DmtFoRohLFDJsOykoN0eAv4geTuX2Pt6p
         cNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281886; x=1795886686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzFmGMifhLboZh2kGopaxbIEeOjWFZQBzm1EOjBYPKE=;
        b=RZne9iEd9cNz1t2hPpSPM2Qw1RDZ/qubCIqNicIe/vb3xMzm7nTrYho7B5dcgCwXv0
         TVeUeb35A6bXyjmfpNFmKytWqMf+S/57uv6MVkhOiyimBQzCqoMg9kn35jWZU14x62a8
         kEwpwO1hdfsvaCGdsKn0ORVUGRAM9n8LKs8at6rojd/e0zgia7ZC6yyf+hoFwCxX2pkr
         PlK6zeikcpyjEbzSg6LPsDkTu/q2LrBU5dqMlGJWRIULNLA8dbaJOwlquas12hI819du
         CAe25nf6ZEazL5p+wENX/h/hiUUjy3zx8bThW4biN0kQlbW6dxubqxIuO/Yaa/JXst+I
         gfew==
X-Gm-Message-State: APuU4Z95mMwHFzhUj0XsMZXGd9TRBXwDrXORUG7u8d+XY05HdyLmXow2
	ES1MHmR2reH1wv2drwfbJpGe3aiNptSfp4Jg800MLS8SIqEzC8bSju6wIkEsTzWixHz8uNjoQ9o
	zo5hy7AfQ+tIpxAYhjFFbLMGThgU+kW4=
X-Gm-Gg: AZFdTZf+UYguagdrKCtYpc+xIVjry10LOQYauIHJEMlaB/JHE+Qm6LTft8CBGsoHsGq
	yBijhRgqEB+kyygk6+Kl08HLSSzzYmtlm2BBcrV0LI5Y1olkUMQpfFWV6GeGW1DS6Nwrug2HInP
	2Wg9N3nxBVUtlTbjIy1sQpUEOal9AJK/KVBayO17B6b30iNEX7qobbn8B8GB5C1VwnYCwxT/1C4
	8udz+8g7jRgY2BcbxO4CcVkpXSNKo+iJ31lFlPSWFCHBnxNcw8RgHHHFRokR7SmPTHOn4qj9Qu5
	1P7DP5bC3k4SWtxHWojN9ZmJKhoO9ZNBiVJUHXeDp5NZzvbgbj56ZxqkJJqG6uoeCce8hr6Jzfg
	WqUQ1vp8d93aaYWQOfHL1ioGHnb2N1SGSpZ+P5jwluKyw3/ZmE8DjDtuHU6+HPZES+CDUMD381P
	/sMAUBeTG+VYaPVIv5fb5oVf74SfDtmTbcW0fwu+IFnqYdWkNW9+rixSNDU9gwQeb6
X-Received: by 2002:a05:6a20:9e95:b0:3e8:b7fd:6273 with SMTP id
 adf61e73a8af0-4014c7587femr6422108637.25.1795281886498; Sat, 21 Nov 2026
 09:24:46 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2499.git.git.1795279151447.gitgitgadget@gmail.com>
In-Reply-To: <pull.2499.git.git.1795279151447.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 21 Nov 2026 12:24:35 -0500
X-Gm-Features: Aa3M54o5hVZXW8RzrOV3-lAvW4_P8inKGQ68kXfaJP032YQcLMAktWGkJujRavY
Message-ID: <CALnO6CAqmkigFKUYcpkmfg6zKGpqfRTAXsxdH20fEA54wuVH2w@mail.gmail.com>
Subject: Re: [PATCH] github: fix typo in main workflow file
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 11:39=E2=80=AFAM Ophir Bleicher via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ophir Bleicher <ophirble@gmail.com>
>
> Fix a typo in line 10 of .github/workflows/main.yml:
>
> Older runs are canceled when a new revision is pushed.
>
> The typo is 'canceled' instead of 'cancelled'.

This is typically a regional variation (e.g., American vs. British
English), so personally I wouldn't bother.
