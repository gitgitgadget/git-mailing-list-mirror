Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55B1A3BD6
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576488; cv=none; b=ijRDU8GUlKP7nW9ZICEeuvVSVIvDEMBteoJt7GMIkOAnWuoWsAB5ltCLmS+WMEA991ZVOPJiSdrSOSznVnQEPPdPHd8r4cOsEgPesu+uMxbrFfN5jw3D3zPwgSnhdAlaThMjKeacwpgIoyz2FlHHst0XairsU4YsalX90lFfGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576488; c=relaxed/simple;
	bh=x+vj5vMgaMg52Bi23A3MdJxYn+jt3DdyxpvSZSYgsRI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQPIhSEQ33QojPby7EfFQMHt/ShJEagVbVpZswcSum0IjTYripvNloJov7MPkuOYi8NESbuiGXlg61gHzFSVIzLPtiN6VN67hFqDjglodGS160+3V35NWmWvJJ/yFWVo2zfH9XXUinRGx/kftqt1e26hoS3AeOJagVrQjRM6azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47DJEWjX1729992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:14:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Edward Thomson'" <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>	<35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>	<xmqqv8048mx2.fsf@gitster.g>	<03d601daed95$d10a63c0$731f2b40$@nexbridge.com> <xmqqzfpg461i.fsf@gitster.g>
In-Reply-To: <xmqqzfpg461i.fsf@gitster.g>
Subject: RE: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
Date: Tue, 13 Aug 2024 15:14:27 -0400
Organization: Nexbridge Inc.
Message-ID: <03e701daedb5$083e1200$18ba3600$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQJKqFjGAnOgwnYCtG0nYQJDlPEmAhXkSKezEIBSgA==
Content-Language: en-ca

On Tuesday, August 13, 2024 2:44 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On Tuesday, August 13, 2024 11:26 AM, Junio C Hamano wrote:
>>>Patrick Steinhardt <ps@pks.im> writes:
>>>
>>>> Fix whitespace errors in the clar that make git-apply(1) unhappy.
>>>> This has been cherry-picked from the upstream pull request at [1].
>>>>
>>>> [1]: https://github.com/clar-test/clar/pull/97
>>>>
>>>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>>>> ---
>>>>  t/unit-tests/clar/clar/sandbox.h  | 5 ++---
>>>>  t/unit-tests/clar/generate.py     | 1 -
>>>>  t/unit-tests/clar/test/.gitignore | 1 -
>>>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>>
>>>A funny thing about this step is that the copy I carried for the past
>>>few days was an empty patch, because out of habit I use the
>>>"--whitespace=3Dfix" option while running "git am".  As that fixes =
the
>>>whitespace breakage this step addresses while applying the previous =
step, this
>one becomes empty.
>>>
>>>I'll requeue these patches with --whitespace=3Dwarn instead.
>>
>> Please forgive the third ask, but I really want to test the build =
early. Suggestions?
>
>Sorry, but I do not follow.  If you have "git am" and "git clone"
>working, and if you have enough C toolchain to build the rest of Git, =
wouldn't it be
>sufficient to also build this addition?  I think the 7 patches cleanly =
apply to any
>recent tip of 'master'.

I am confused. My bad. The unit test works fine with the custom clar off =
seen and next.

