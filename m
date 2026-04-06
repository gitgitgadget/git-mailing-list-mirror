Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215738F225
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496971; cv=none; b=tiwlOGvD4H32Vu9QQhMNELrktQG4z0ZXMHKSS45kdVwB+SAuSuMpSGNCNa2wWDS0qHAwXs/GjQSrNRaytynkEGMPgViA3o1AUxXgOrzD9RoHSDGjk7YztZuzuzlWW6lBjiREBzdib5d6DYkwn5I7zLNmWnxq3zR3lWtMtFYavi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496971; c=relaxed/simple;
	bh=OdsUsPzzXy/ZR2A6HbQDbIm/XRv+KW6H3B4a7DXMkgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3yaFh85Xxl4weqz26pYzqDP8WNo/ZTpPF3YRmdUdRzWgHLEYqdDV6P/hHxfRJ7oSjbDNlvjzkei4dqro0FfavUdHTBCPjpemMTSp3/AKPKTDm8PLEGo2wr0qtlCiaUoZ9BJzQ3sT+9RUtbP4lqs8ebort0gr+rb+pa1KWSNY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=MReA6Vs5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=t1A8e3KQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="MReA6Vs5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="t1A8e3KQ"
DKIM-Signature: a=rsa-sha256; b=MReA6Vs5W+HK1P/qICYz5uI40Kg4tHxOcM0T3RUPHWF9ZKKz/mgetwib6n7ZyBe5UL/FEbiBL95HOk5vNVTZu/bXGgjlP47CDvHiqnOFoTxXxLQzfbmYXrvP4DYgqvamqZgV4ClXnPA48T304RozHerlv4/z4vy7ZfU7q4Ujp55Nsyqd6O0XXs4K/ehXOgXqxrd4eQohQiHWrwx76W6MNpUTCsDhNLEATL/fMyKLYrZSLguLNCimR+oiEtxKviMwgvStcT7i4fiuV5wY4X7J+MmClRbDM6wfbY81d0M0X3vAq8abON2O6OKfc7kFEu3o6SNBfXkvZYzdC+TjJeUanQ==; s=purelymail2; d=malon.dev; v=1; bh=OdsUsPzzXy/ZR2A6HbQDbIm/XRv+KW6H3B4a7DXMkgM=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=t1A8e3KQ8jsPRmDeLMWlKv0Y0K6boqFvVNGT4YAlJW+FDgmuKCleejtoHWsnV3dukGfK8NM/w45Sq6ZYowuT0QLjOU+91Hv/0r24v8z9VaVG5+hvkK+XkkiFy3PFGo6X+4xFyA6wTnIjBia4fyVSlq9P/EYDn7ErboBh3F/vZC+SswtAhjWkKkLau1cymXP5pt9FSz8v6Bi/dkNZyLKAnw0Fjh9J8CPKHb7aAxzXfSScmXYFDmRCWW8Q07k22/GWsPCqe3uEY3gUuOAdR/hJtBLaTcW4/ADfeiJuPBmdmbwPojHyyEyT10a8baGBebiP7Bvs2NpmwAkoEyWPw21m7Q==; s=purelymail2; d=purelymail.com; v=1; bh=OdsUsPzzXy/ZR2A6HbQDbIm/XRv+KW6H3B4a7DXMkgM=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 658461399;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Apr 2026 17:36:06 +0000 (UTC)
Message-ID: <9639df15-8498-4dd0-8ea1-6ebaf4533476@malon.dev>
Date: Tue, 7 Apr 2026 01:36:02 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] t2000: modernize overall structure and path checks
To: Karthik Nayak <karthik.188@gmail.com>,
 Zakariyah Ali <zakariyahali100@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20260327234019.95591-1-zakariyahali100@gmail.com>
 <20260405011135.125912-1-zakariyahali100@gmail.com>
 <CAOLa=ZTuk-33xz4RQJDv-nyK-MqFzLWHM7zdmBBGnXjYiJBsSQ@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CAOLa=ZTuk-33xz4RQJDv-nyK-MqFzLWHM7zdmBBGnXjYiJBsSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/6/26 06:04, Karthik Nayak wrote:
>=20
> Shouldn't all the tests above (since 'mkdir path2') be a single test
> block? First we setup the data, validate the data, the previous test
> runs 'git-checkout-index' and finally here we're verifying the endstate
> here. I think this should all fit into one test block.

That makes sense. I didn=E2=80=99t mention this earlier because I hadn=E2=
=80=99t noticed=20
that the patch title had changed from 't2000: modernise path checks with=20
test_path_is_* helpers' to 't2000: modernise overall structure'. If this=20
is a overall refactor, then it would be worth revising this outdated=20
test structure as well ;)

>=20
> Thanks,
> Karthik
>=20
>>   test_done
>> --
>> 2.43.0

Regards, Yuchen
