Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4A175A74
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146767; cv=none; b=Vr0O2If4Gcex6zPcJAMZ+7KVLZRDDGj54bHesKXFLcNyeLpqDNJV7sICT5fybCeQg5Bi1nuzNqIIaqRvrbRYszDH8qqTsUTX+b591k6KAxktuonTzJApg8yeNQ6/dXBm26fXkk4ESM1Wm7Bd5Ov+rCixxHeFz7pKZtsxQoTUBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146767; c=relaxed/simple;
	bh=e+FYE/M8/nOju+qbRKEMX77zUR9ikTODOfq7zisMoTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsHlEFy+93eegmppkijKxmgLOZtKPZXTST/f6aZ3aQvHoeItwDoR7fn9DsKrZlGZ+kHqju0ncibc4dsS9da8bTwDD+FUi1V03wDPnX5LFEBXs0palGKT2DNjDYKFoshIML49UxfvuXVd2LXEz49nAwmehwDT+aUHKuczARL3CYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=e2X4lv1U; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eAKRplWo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="e2X4lv1U";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eAKRplWo"
DKIM-Signature: a=rsa-sha256; b=e2X4lv1UNqUsPHgq3ZjpxibdGcxAWAqy8LyKb7N77zqINfom8nPZYz3EllwEuF6d8tEgPmyttWZEndMO1GJsOHdfNwr4XAg6RXT34IqM6EAo72bKvlIs7E18y3SsbTOotWCiFHpa5pTJdXCasX+0VBIuWg6grnl35NVxCTfhMeO5zdCaSAic0R7IL25caT3m0ANBCG3RjHKbYWwM2/iccGszYvozHLLJJgLQbWCU3Dz3SREPAYsakb2V4hKSYI0zwlfj77aRiLU08zw7wQP+Fa67WAOsDfGS+Az2TMEogpMVlvRyAm/PWf8mjoP1e3z8ZlDYdM0BNmhNUfQ+fb/k5A==; s=purelymail1; d=malon.dev; v=1; bh=e+FYE/M8/nOju+qbRKEMX77zUR9ikTODOfq7zisMoTA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=eAKRplWoj2dqjcaA4yIUssbPA+QSP4obL5ZegetR+sTKt2GR4BE0zTG3vo9Dcuvm2+52VxP0tomOIck5+P9IPPf/JJcejgaHcQ1iLx6A/qV+yOKlbkDj+SX49Sy/LXdPX3vnBEO0JV8PSZrla7WVyMJEmF2gArfJ1ZepWp4wW5QiADmTRsjd5DgctSlQEDrwsZLmYIixuNhubFC93kuNkxspVegeUMuIshCkzWkuFn8Gkl7MD6JtUpcn1ddYokGyfgEhXER9AWVycFHwJTgYndw/aW0da0lcXP8i87dzRdUDyZHRqE/L8bNtE7ny6JSVRN/hG4x+eAccDwH+BD6dTQ==; s=purelymail1; d=purelymail.com; v=1; bh=e+FYE/M8/nOju+qbRKEMX77zUR9ikTODOfq7zisMoTA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 824274450;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 22 Jun 2026 16:45:50 +0000 (UTC)
Message-ID: <b5a9115a-c909-405f-b150-f956d866b1eb@malon.dev>
Date: Tue, 23 Jun 2026 00:45:46 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] environment: move ignore_case into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com,
 johannes.schindelin@gmx.de, stolee@gmail.com
References: <20260618114207.605211-1-cat@malon.dev>
 <20260619155152.642760-1-cat@malon.dev> <xmqqjyrr7ipf.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqjyrr7ipf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/22/26 04:16, Junio C Hamano wrote:
> As the compat/ layer is not meant as a general purpose POSIX
> emulation wrapper that is generally reusable to projects other than
> us, if we have a knob settable by end users to affect behaviours of
> lower layer in compat/, it is natural to make repo-settings
> available to them.

I see.

> What is the perceived problem you have in mind, and what are your
> proposed alternatives?

Actually, my reason for showing this question wasn=E2=80=99t because I thou=
ght=20
there were any architectural problem, but because I felt that for a file=20
in compat/win32, which is more on the _downstream_ side (is that=20
correct?), we need to exercise extra caution and confirm with its=20
maintainer whether the changes are appropriate. That=E2=80=99s why I CC'd=
=20
Johannes Schindelin on this.

Was that the right thing to do?

Regards, yuchen
