Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C9332C925
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552843; cv=none; b=UClztwbM2uA9EDOx5sU/U0bh0edFMMTGIN1JID1SQ9gNqV6+ycgGcP3ah1rHd9Cui4Fn2uc/SMc+X1NScor+T0NIf9my8693lBxvKUCh3h5HC/TP/OcLwx+Y9R4IhGU4c74uqgDTNf1tzSouygtXMmp6GvbHBA7dp5D9xKVEmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552843; c=relaxed/simple;
	bh=e7gcs1DN4SporflFdcUGF4xr9ST5pZiJqpG6fMc9vlY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JsgncDzV3RPyEyqa/HUedzvFK7hbzToEoIxpHA5+Y7V+YtO20cWHLoPduUD7cpb+8O9941c6mzWvvPqsvUnxKuBgqRhcZFh6DztHfRdXGuh7Ok5stcfEshCV3zwqI9HqocFdBahRTZLW+ygoiBAPp1kmxHPeXJjvfTkQqvUfQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MztB+zA1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MztB+zA1"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b785801c93so4601216eec.0
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769552841; x=1770157641; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7gcs1DN4SporflFdcUGF4xr9ST5pZiJqpG6fMc9vlY=;
        b=MztB+zA1Kk4eB+w8iPjr+6eoB8TE66UY0s1fUEacDqw+3jkHUKvVB22u1o9BHrrNKN
         OEi4tZY7Cp4a7dRhl3KMOg8wwvN44mG21P8R3ZAQfNjhdZ/4jQU8KN2LdwSn0ISaOxhE
         VSJdBT4Be7wN6KUIEPIJ5tjvMIPfBFpb8heUUHJemjoByNDYe0JqyZscLjzG35eJweI8
         NybCmHfIWoP4VYdvsyReDg45BvXR+2LL0uv/+DnGpIx3bs/j1cZtIugwZgLN05xPBdyR
         C+KCs/eNzkJmISULyQvjiar2vkh0yHZ2dRPfqIUITfvYa5HzcsGOUeu4U5tMJOCgjv0V
         hDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769552841; x=1770157641;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7gcs1DN4SporflFdcUGF4xr9ST5pZiJqpG6fMc9vlY=;
        b=aeSvV+KNwybgNuPNX9waDcmD6yyrJFvcP06voXF47g8dvNmk+fuilcnXcLymA/9yte
         Dd35AmJtyzeeK0CYyvXLv5bkwVLIg8ukq0U4bH8Q9TjNm29m8cFzAO8uIG4biWY0HQwA
         oPzqc8FKUAv8q/H4mJrJod8vni/Bw/CJFj0Kzff0V85KNP7KfWKui641roc7Qs0ttcfy
         OZxIlP6NA4Ci+xKK0zW1Luv+qkdNxz2E62JM9r+UxR/W9ct8fKHUuZBPOiBWtq7NCrKP
         2x4Bpc68V+pskq3TWEupNzA5nnoj6eekBB0YFTtlwCNmQDEKuMcl7IfjYbAUOaHL8Kr7
         s2jw==
X-Gm-Message-State: AOJu0YytemIfkh5SW/HbVYYMp0rWJEIxjkQHXL+atFFlR/RS7TSyMn/E
	0wezrsOZaVUauPlidTaVaX/8wjHeRdgwLdHkCxLPDLD6BWLHBOCA1z/k
X-Gm-Gg: AZuq6aL7u/1wkxc5MC688kNtHI2ss7ORr6EXt8BZA4H9emUayO+QgbzLUVCXa3wWYpk
	7ihX2Qw4EkRg9mUf6U538K3k0Jc+kuPOEWK9RBikRao1/TF09Su8VdZnN0OiivL3IJsj4KVSr+D
	11KJcI1hi0B6Fr+QZBEQXuD6V1VuqK3g8DCsAxCjJRM0H891FXSLhhUXSdAz1PE0igD62Ny62vq
	upVBUbX2wqWA6jPTm1IVFD4pyKB4DGGy6EIPdPc7GGlmACLcOjsR9cMAVrkAszNCtEyjKNJTRLn
	3E/wwikZuDhjQcfcInLpYcKHOrUJZzOjz/IHgTs+AZSk9DntgjHq+wyyk9vgMVMSYidGmNexzOs
	qnpdiVYB9f3jxdi/YDG5+vkS/PgWp4mZ3/n5dd1fAZZoIeYfupvkvDFWopz6njxvZxJ1gzpHUto
	5R+sMlvuyDD0+NrAQ10hWWEdwkcKiluCkXvjS+y1qg3Rk5pkiW
X-Received: by 2002:a05:7300:a188:b0:2a4:3594:d540 with SMTP id 5a478bee46e88-2b78d90178cmr2171438eec.13.1769552840924;
        Tue, 27 Jan 2026 14:27:20 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:32:8042:d8f4:8907:edd4:c45c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16ef40asm99313eec.13.2026.01.27.14.27.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 14:27:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v5 2/2] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aXhiIQXBvMhzkFy9@pks.im>
Date: Tue, 27 Jan 2026 19:27:05 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F857412A-6B47-4DE0-85BC-D8AC2E54669F@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-3-lucasseikioshiro@gmail.com> <aXhiIQXBvMhzkFy9@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


>>=20
>> +`info --keys [--format=3D(lines|nul) | -z]`::
>> + List all the available keys, one per line. The output format can be =
chosen
>> + through the flag `--format`. The following formats are supported:
>> ++
>> +`lines`:::
>> + output the keys one per line. This is the default.
>> +
>> +`nul`:::
>> + similar to `lines`, but using a _NUL_ character after each value.
>=20
> Shouldn' these sentences start with an upper-case character? I see =
that
> we don't do it either for the existing docs, but it reads a bit weird =
to
> me.

Ok, I'll fix it.

Btw, I'm collecting those nitpicks about the existing code and I'll send
a patch series fixing them after finishing this :-)

