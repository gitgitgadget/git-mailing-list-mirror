Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B863CB570
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874011; cv=pass; b=UuNZEaxh9eDoy+vOzhjXru/4XxbBA/VUGoCHK7WAIkuJeR/xjVWdCFVDwdXIavqnQ2RONDnbLZRrKvYoZ6UQOuqwxLLSfadWOMwodSpBLhg4wtw+KNY75dNpbKePMU27Nb0qx33l5Y/0Da5g7tXcHL5jUpp3xgCBHc93m5yx+DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874011; c=relaxed/simple;
	bh=ns53vF0ApJv+TqMqmEUTsU2jdpc2vmbxJKWT1D2A2Yg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sX2+2IiU3/bJstw4KLywsX2aaGZxVolK9K7y73L2gHEDfIai/pqGX7IIHvhcC2IcAy/Ljh9JlHwYm3HEa8OBefFs15pKerfnBL1rTSC/X4NncqRH3dQO7MhhWu+k5p3AnJYae8PXTYDGA+wqP2UKaSKn3yjvgAydYsNI+XAbb/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY7f8L9u; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY7f8L9u"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so259994b3a.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 13:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785874009; cv=none;
        d=google.com; s=arc-20260327;
        b=KDFvVdXivl26yDxVhx/4y7un9WKqKFS8hTSe/mslsMVZMGLewSaDIJoXXTH/tt64KV
         uc1D6Me3I8MZHF3YTYIIyLSi36hZvvE6DzEYc7UpYASMH53E+z1j0uo7vOuQO0Oc4/kB
         0I8rQmfBayHRedUtDjJGfg6lQpR2QPdJEtGuzu9VPQYwXSh0GP4JdE3bo+hW2GZM+FAR
         F2m7bqejJQ48W4YybTk5Kmj3E6Nq7l6tPDa8eBMH4oYFXr/JC5CeyvV4wSjE7CkWXqt6
         M6Is6KWfnZE+ObMCdGUaCeXrQAA2tArY+rYDeWi/Cpm4Cd5jUueVOdm75NSxdIxAu5Xr
         Lr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ns53vF0ApJv+TqMqmEUTsU2jdpc2vmbxJKWT1D2A2Yg=;
        fh=n69HU0xdvyfaxYri5fBnlRQ1JNzOk5TqdDasfOy/Pzo=;
        b=OJ61Ftn/xXydXKzEYllqrWm1sX7ejlCAbBEUQMBVgGaGETj/vKHP4/WpcfzF6WSvDu
         wrW0FrP/N7pyiBojaLh/PdSPCAruIFq8/IEfZyoqp5wUJr5Ik/XwUyxXigpnBa6r917o
         8L39hsm8H5JKOMlh2gFPuF02xt0QtHEI7cRmjRLxivCcmf+dONeIpPxJZzW3I/etStE4
         BF/0bSSNgxERg2wZ2Y/hCtgTg2yFnYfxffBa88iBQenxBTSddF+BsEukenb/rNnyMtwV
         fwClkrAyg8Pk6aDOEzILBC7Zu9P8v5RopZYlEpESQfr7h7zh3nkn2UcQ5AIXi/RxbPfB
         R5gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874009; x=1786478809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ns53vF0ApJv+TqMqmEUTsU2jdpc2vmbxJKWT1D2A2Yg=;
        b=aY7f8L9uJPzJ6aF6OZ03z7PDxJOI6cM6U1lsggef/KnfVH0KvesGurNo4PfZqATkTk
         nqJ7cKlVOGh5UELoTQx9/R+TvElZld7s2xACgSSBRcm9A5EaQxHsKOl/ePktiF7jWWoA
         m8vS87llkdwqu/KNdvyJMncokwo4BBr53zK6TlfuGjPb/63iZY1SBTDznwGdLvxdmoVE
         Gte/Bny3kozUUBQ7cUsoxKWg83JbkArHwLZaj/pn8zHys1sa4A7g+XoTtrVmswl6XuQe
         wcEWrd9sukN1KOa+ILNKXJFS2qGILiCEJhyUN3gjtyNoxwf6i2ZeJwRXyf0I680o3Sm7
         bPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874009; x=1786478809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ns53vF0ApJv+TqMqmEUTsU2jdpc2vmbxJKWT1D2A2Yg=;
        b=j6oYEZx8Qe8wJX5E2nX+62xrK5bIhum92jKRbV+KmvBFWsKU/lddaHh0YaZcaSKbxw
         GAGoMLn6aOzTtpKY4CXIPfVh1ETnFVqGC9+XA6yTuz+CkILS7Ha8CUXQmh2JNrx1yz30
         n9fKzp2kJG4IdOPJ3Kp8R6Ut+FS8vED8kXwTBFwy56wZqvrTLlYvJTJ8EmhRBL6A/IdU
         pmMQAOKMsTzbJ15XHnL1ktObNL6bGxa8n5OsqkZY/0vN7ZofpczUXt0ajaX3Otdkk0yc
         SqP7YG/mfyNXasXRzxZKXnRTmP2WMgVBYqp08iC/9M/GvF5g7d+Jz9VMB76GwJ42e6mT
         F/WQ==
X-Gm-Message-State: AOJu0YzZddtEkrYUNFHybxOyG//aZNNzkfDazoW2hW4S3bE9TiPDDhmR
	0rO9G3G+bKM0h1KtJXdBg4V2gHIov6JXs+TZZWsrUcoFv/l4xskn7fF0eauPDHUdRFtZwlzmb3h
	65/clZZ77ltyC59r5wV3ah+A4MpSXJ/Kucg==
X-Gm-Gg: AR+sD11DE390FpoY3/71mojKwe6DUZg4A24cyHbTNFw9pGGhbUwoXok2vDNRfIw3vaM
	yeJ9J/LFpfC3lmpWiR28nV56+xa7Mg4LDvqT4uUJPnYCVgVpEguv3f08wFtEyeY//04wt/tf2b3
	Bti2GEpg87+hrL6ifemORwqwwN+MqfGUVaBtWBcYJLcFFT6Tl3XTyI4Cy3gGNGTTIlLUvlLSc1x
	oFiH37y0/+lwJq7/2F2V7VkNscOZmxXDZpgh3/mCDnD6Giig7VKepIGy/ko8En29DPkZjQuV8h0
	0+YB4YeoufNI3/A7rD5ezpLSgIXb4wF/Og15JKveiqcD/DGwBLP9AvtHOZySA90fiaX2b7ggih1
	TYffsCV34+gaY+uE87G0CmSfjWZRxjVRWPAl0xYc0RVw7Z6EwrdMLlMBF/EEhc9Lflgmx3c0SR1
	VEBtqMMUDFA29/xy/T3+5MijsNePsipw==
X-Received: by 2002:a05:6a20:e347:b0:3c3:9ed1:2549 with SMTP id
 adf61e73a8af0-3cb85fa02e6mr1206520637.41.1785874009345; Tue, 04 Aug 2026
 13:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 4 Aug 2026 16:06:38 -0400
X-Gm-Features: AUfX_mxLW9xzjYxeS4J6PC4jFmwNKqGFJ7CFq6JVDk2gAAtQ3Gx7UsU7UzcCYzQ
Message-ID: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
Subject: git-replay/git-history lose notes
To: Git <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I don't think this has been reported or discussed yet, though my
apologies if my search skills just didn't find it.

It looks like git-replay and git-history will drop notes (or rather,
not carry them over) when rewriting history. I've seen this both with
"git replay --onto=3D=E2=80=A6 =E2=80=A6" and "git history fixup" recently,=
 though I
suspect it affects all the modes.

Fortunately when I check range-diffs before pushing out new versions,
I notice notes have disappeared and can "git notes copy @{1}" or
similar for a note at the tip. Recovery for the intermediate commits
is a little more=E2=80=A6 involved=E2=80=A6 as I'm sure you can imagine.

Are notes out of scope for replay and history, or is this just a
"nobody's gotten around to it yet"?

--=20
D. Ben Knoble
