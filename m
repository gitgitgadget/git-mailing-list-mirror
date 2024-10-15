Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B31CB9FC
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009090; cv=none; b=HOieIxuQG3mt7MPrdukYPtiBMJzYxvmDIk89vn1Setfbzr8VCTham4IcGzgafWU5tulH9R05cwGDGkvBgnanbU+a/kBCzcnjHuCj5G+se6NkS+lAofmAaxpB5eX4BSSda9aJTkfqP2yF37tWjgyWlQSSCt4HJTIjnplsrI84Ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009090; c=relaxed/simple;
	bh=+9Hl/UPv49HgDEWJoc85eQtTeg7HT5aG387UN/zWsUA=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=MuL+Az6l+CWBGEQYmx7e0wflcQX/lzAjPFuMTzcSHCNIvoIETQ9LhfaLQUBJD9hFnTG2ZSyVCxQ0K8pOMLB/c+EBOFyi3qf+ezGXlXNTVVmQsg19QfKYb70Pw4UUzlpdNvZvLnPVDrB8Ra7e+yHr7TcjaQKL7KATFOlrIdNnNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IvFAMmxD; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IvFAMmxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=+9Hl/UPv49HgDEWJoc85eQtTeg7HT5aG387UN/zWsUA=;
 b=IvFAMmxDcGZDG/BrT0nKvHyxvjtHPReXdzy/+nPCLGrtQKOuoJnZFoX9/TYqFC1Dfj7fTIFS+z3M
   8TaWd+xji+805ZQhKrAoR9dom4LVHLWNiaG23AH52bOOLtOSgTg+ZwccTlZq0/EnsgKrWTWMgDVH
   nfvRyvekkqjvbKTZXb8zGpfzh2hVqfrsgWMBv7IXAx3L3c35mBxbFXo1oJESoFVcggCofc7bx3/j
   aU1x6dx1uR5wdQTNCvF21AA74s/g4uMeA05dgyo6GPY/9OKCAZGN2ZVNiuapbbl7CyKIbFiecfOr
   2mQIQNrqKpliTna7ccAXw5T3aTIbT39tV/eBoA==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLE00IH6NY1TF40@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 15 Oct 2024 16:18:01 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 18:17:26 +0200
Message-id: <D4WIJYJHI6MX.1GVDAHVOLKGO7@ferdinandy.com>
To: <phillip.wood@dunelm.org.uk>, "karthik nayak" <karthik.188@gmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com>
 <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
 <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
 <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
 <D4U6L3C2GHZG.2SN8P0C7ZH33M@ferdinandy.com>
 <CAOLa=ZRfku-J2HO8MOqu-dZspmCZDV1S56TD1X-zUy5=9+XSUQ@mail.gmail.com>
 <65dd8e08-d8b2-4abb-a141-002d8f0b0401@gmail.com>
In-reply-to: <65dd8e08-d8b2-4abb-a141-002d8f0b0401@gmail.com>
Reporting-Meta:
 AAHy/uc8uN8voQiyeo7613PurlkZsvS1VzZ5t+dLuoLcQXeqeyIO5hNN+SoUzfVl
 vTp/4LptntSiUZLiLDmHuC6L6ZNDUa5oygaVuyFlr5RHtr7rZb3UuGK9SAmypZah
 Kt+YZG2kgL6PY/mE69fH47D00UisXj6BpknP3HRJ2KP2Omz6HWni3iWChIyRW2Ib
 w5yNBl0sKD1doGLPWYhgzCeos2ALHU2RSMrDEa8x/ZGL3VkGe3dSdQtesJ/VYEoW
 6vp9jZd3YVHsOSUCAI3bWIlUxWR+LW6z5N2MGKyr3lClj0sEYGGcWU1bLapMnkv6
 Y/lskJn3zLzjplN3N5aSLzHmhpUipOTeOEz7jKw0LFXpYtbw1n5s+4kqAfyXeLY3
 Idh+cG1d0AksFNCyxh4+gH4URJjXn+J0GeSj6WE0Mz6DNcYXuW5nP2p/Qtwg/oFc
 /POXBPLJkA+mvB2kqDhS3JVWa+BW86ZNOvGZHAzYIQ38F+9EkntzkVox


On Tue Oct 15, 2024 at 16:10, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
> On 15/10/2024 08:51, karthik nayak wrote:
>> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>>> On Fri Oct 11, 2024 at 22:43, karthik nayak <karthik.188@gmail.com> wro=
te:
>>=20
>> I'm not sure I entirely agree with this sentiment. Consistency is a
>> great goal to target, but it shouldn't hinder changes that are
>> beneficial.
>
> Exactly - if we wait for an entire test file to be modernized before=20
> using our modern test idioms in it we'll be waiting forever. It is much=
=20
> better to introduce the use of things like ${SQ} that improve=20
> readability as we add new tests or modify existing ones.

Ok, I'll change the patch to use SQ. As I gather, it would be preferred if
_all_ the tests would use ${SQ}? If this patch series is finally resolved I=
 can
send a patch for this style change, shouldn't be too complicated.
