Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7C1F4CA9
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314997; cv=none; b=YIIyj/evk7BzQeOl68ohv7l2J+ZUuWnTMsGm0IyON0Hn6Y1Geu9hg3fJzx6XzFYLqUB2RrwiXM974n9gCVZC+sniTUTH40FL3gpkNeFnmF9G1NO8TCXaTF9W6Ey9syqtM5wcfod4z7er8Dl98I7V34ZkS5PRGMtD5y8CpXTdth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314997; c=relaxed/simple;
	bh=/ScjRYfKBMa72gLyMJtJCge3hlpMidCihYkazLVqBvY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtVbZLYzrTkn72e8rkZRvuhZbhO5KySSldjjuZZffS3ONzwSe8JCRc/5R8ZUAOPigZ1qIfGZi7UY0lz/tAtrN7jkE0e+qHZLKPSH03eQcGl6PHMmM2pP5bH/GeiKPzJUyjvWNPS2EC5aFrv4L5vgyEAmRy1pm+YC21fwxpEaeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57RHG0Z2172525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 17:16:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, "'Elijah Newren'" <newren@gmail.com>,
        "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>	<03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>	<030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>	<4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>	<031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>	<CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>	<aK5mJI1NfVQDmDXN@nand.local>	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com> <xmqqsehc1ypi.fsf@gitster.g>
In-Reply-To: <xmqqsehc1ypi.fsf@gitster.g>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Wed, 27 Aug 2025 13:15:56 -0400
Organization: Nexbridge Inc.
Message-ID: <023c01dc1776$440a55a0$cc1f00e0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHKaANAdlFqcOHeZ+UNw9ZV5fNZlgJjoZaSAeK73o4BCSPnmQFMkRvcAya/ufMCJfQ+PgG6B6/IAQZp1PYBTQmMUbQaabmQ
X-Antivirus: Norton (VPS 250827-4, 8/27/2025), Outbound message
X-Antivirus-Status: Clean

On August 27, 2025 1:06 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>So my impression is that the main contention here is a concern that
>>>worsening the portability will make it harder to push out security
>>>fixes in either direction. But I don't think that's necessarily the
>>>case. Even if it is, I would again hope that the track record of the
>>>folks on the git-security list would suggest that we'd do the right
>>>thing and not abandon users on older platforms the moment Rust is =
introduced
>into the codebase.
>>
>> This is indeed my concern and hope, Taylor, as the maintainer for a
>> platform that is feeling abandoned. Please note that HPE NonStop is =
an
>> actively maintained and vendor supported commercial platform based on
>> x86_64 POSIX, just not a Linux/Windows machine.
>
>Thanks for a friendly conversation, but I would have to say that =
Taylor's "we know
>we end up having to support both, and we will do so" is way =
underestimates the
>cost to do so.  And I hope that an actively maintained and vendor =
supported
>commercial platform would bear the burden of the major part of that =
cost
>themselves, when it becomes necessary to do such a dual support.

If the platform provider had taken on git, that might be possible, but =
it is not
the case. This will come down to my small team to try to cope with this
situation - generally without any help from anyone else. I can do much,
but this will likely come down to my doing all of the work after hours
and on weekends with no other support, as has happened for the past
decade.

