Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC43E1D04
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337006; cv=none; b=ChHuGrcPE0RyGUFzjQKuDNijEDBTLXYAKMh311KbqTnIiJsZuD2zG5Jg/wk4aLGu9P1LT4bww+vyyrAJO+k9jC8jb0xSdw6O/M1ttGORX7RB3ZViKLOv2sv03x/GjBnSR6KeLaFjxXnQgh2xWfrlqvL/i7iwH7sGZaahtsKogYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337006; c=relaxed/simple;
	bh=2kKz4ZjAh5BqPnAtEoCRBE/HpDzfel/1QwaebzruByY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EazrF+Jez34sw9uUgX6cc6LMSOc4mfGiNo/QYoLl1/NrisjhkSS5D8OKGuxPtq4gOB54M3hmiKu0hmCrhmhyDA4znYq5WY5OuBqpOVPt2KHxe6FXP+h4YPiY/qv/UJnsnDuv27TQZVP/d3ShV9M9pTUrxDSsK01EENCSa+7nOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=MW+pcgxb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HpBn2bUV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="MW+pcgxb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HpBn2bUV"
DKIM-Signature: a=rsa-sha256; b=MW+pcgxb7UXUFl7D4fhL7QpkyapLPsSHx4zGmlNgcfvnWTUnWUQzVu5Cg3dM1ZWkLAbkNKz1vcW+IFwHovOYS9md/QfEFkWb/HxItl9MJDZYbmBebdv8rlvyzrIVeRzSexvziQP+JX51k3MKu3MPwtwCEVpzv+a2aRxQUWSyWoBWViLa/Xwph8aSnEVStLJ9zdFcdDJzMAMSsyfQVtkwutAYmVANTRGiWCXbeb/sOdJEHtDWEpzNWb/2pqLrP/PzjIKEGbPgLDH4UNNnhBLXosjWj3u2/5osYQUDEUeChZzPYTZA9gya8dg86Oe7o5SPefiYRtS/wruoFRiYNfLxXw==; s=purelymail1; d=malon.dev; v=1; bh=2kKz4ZjAh5BqPnAtEoCRBE/HpDzfel/1QwaebzruByY=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=HpBn2bUVout4RQcD7h2nAiLCa+RIJrfs+Jl5VRCNJc2B98KCp42Fc45Tt8zQFwFH8Po424baIb1E2pEX2CyXEJNb+/ILFVZq/jTliQEMrL55eksUezykYeDljuNigpdgzGKvtcrYWGRJP/QSkodn/z8CCDrdZgDltIEF0m5kMC7GJM7cE4BM/oXuCSG3T4MitJuhO7glZ2TWgl70SspqPoqkHczUqxp0AFXVvujalu4/5WsTyKmO9A4ZLMCxWMTox/NJRth3w4fMvKcicLp0w4YEDeOtC1URgc0/fNfDWMSbvbdZT5kaE+MJvoncmqcqNPE1CIr5FtjaaHDPOX04ZQ==; s=purelymail1; d=purelymail.com; v=1; bh=2kKz4ZjAh5BqPnAtEoCRBE/HpDzfel/1QwaebzruByY=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1347260826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 01 Jun 2026 18:03:21 +0000 (UTC)
Message-ID: <8083b217-4a56-48ee-b34d-b4596d45e382@malon.dev>
Date: Tue, 2 Jun 2026 02:03:15 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] environment: move 'trust_executable_bit' into
 repo_config_values
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260530160520.77859-4-cat@malon.dev> <xmqq7bokebct.fsf@gitster.g>
 <e0d5b1af-b040-49e2-90f9-d8325682826b@malon.dev>
In-Reply-To: <e0d5b1af-b040-49e2-90f9-d8325682826b@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/1/26 18:10, Tian Yuchen wrote:

> That=E2=80=99s true: I had actually planned to start migrating has_symlin=
ks as=20
> soon as this series was approved. Since you think it would be better to=
=20
> merge them into a single series, I=E2=80=99ll go ahead and do that ;)
>=20

I=E2=80=99ve found that migrating has_symlinks seems to be quite a tricky=
=20
business. Some callers in certain files pass very few parameters, and=20
the call stack is quite deep, if I am correct. so I feel that adding a=20
repo for this purpose might be overkill. Perhaps it would be better to=20
focus on trust_executable_bit for now?

Regards, yuchen
