Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181822222DC
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488884; cv=none; b=c0Ejczk1q5RwyNdCyGZJjWwEh49lajRLtaeYL6yKtuxitNkdyoUXAsH3s5a/riKNAiEwQvAjD0udRwugJh8bbcyjatXkRvLfGq6W4i20m5lUJ7UsHnwyq0WYY2qwALN5WezzjPDiIZP/gf6keLRKo0mSnhkTOF03DzPCIY9pYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488884; c=relaxed/simple;
	bh=7CXN+T9CuQZtzSyPcyG5oLxfXkeW7Iap4rrPDNvyejg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGq9cTqqHHJTEHaoBaqAX4fdHcaa3W4wxnvDzgyhxeScRhnag0O1nUFHrR9nsxkxDEx+ZY8kUKyZtxz6zR8gMdl9p5cfzHfr8trpSv0bSmBsK6Phg3r+ZtIUvxsrz+vZV7PrgIKdF5yjwM7uDdbDNIl6/1uNnO/KqBpoNkvw52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=pp9+t5Ml; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="pp9+t5Ml"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id vIxItzjQtbpaNvIxKtm41q; Thu, 20 Mar 2025 16:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742488878; bh=dvM/I9sBvJSlDfBxeGT7EVtZwm8ZNoHPZCVeBdjBB8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pp9+t5MlZ18lMkSIBzHkieLH9KNBGP86kNDtVfEGQY4qm8y+l4F64zKW1AMsZ/Npv
	 ysfFLW6G3WhEoZsXVFgLo2jgRO9Hd8C062fy6yP+L5UQlRBXpDD36xL5Ir3MaKMDK6
	 Yiigqxju2R1VyA2Xp6P6nJDYydL4tqYMp56lVgY7aztKrah8Yx8ty/LP7U8Zbj7T2r
	 WBPud9jSYue2ZP8FGB8PjaPMQ7sV5BhINi+wBN66f9HhXfUaf0sruXC5LTj6epQ8oE
	 Tq6MmEPmSWhW6nTkg7GOQ2iwJUuCKyPTsaEhJtvtisB0P3hK/jNIuJkFfCFowx1gLL
	 lKNdjcKlhGxsQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67dc452e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=L11zsU7EYvVELNu423AA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3267c1be-5749-4220-90d8-22aabb631823@ramsayjones.plus.com>
Date: Thu, 20 Mar 2025 16:41:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net> <xmqqr02wbtdn.fsf@gitster.g>
 <Z9rG3JVA5vSoYynt@pks.im>
 <74b2838e-1d7b-4ee0-a4a7-e3d21f4e6597@ramsayjones.plus.com>
 <Z9ulomq1tDrZRsmL@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z9ulomq1tDrZRsmL@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfODXtzUBlUrfhkAQnig5rTUP9UOfk8zM+C2b3DvyAk/dT2EEJ4jbFrAinRRPtG/DrxqrhFnAfRZLnTh+RPAEmu8JgqXNXCOyZ2ohbTA+4J9M6Nchuj8c
 AJsXUnex27eFgYbkKK+0GGQrLLCTriGX2BK6mRzPLw0iEz/ktZlgLVNyH6xbAXq3lCsqi/V8DzAAoo6MEAXjAN7olBH+7/EBXuw=



On 20/03/2025 05:20, Patrick Steinhardt wrote:
[snip]
>> That was my immediate thought also. :)
> 
> Okay. Will you pick it up in v2 of this patch series?

Heh, well, that was my immediate thought, but having thought
some more, and considering Brian's earlier email response, I
have thought again. ;)

Without a wholesale change to the logic (in order to make it
platform siloed), it is probably best to just set the Linux
default to 'getrandom'. (I can override in config.mak for my
tests, or just ignore that difference now I know :) ).

The issue is that each platform has a different priority order
for the 'backends' (even multiple orders depending on the
criteria, eg. availability, performance), so the current order
is probably fine on newer Linux systems. However, to cater to
older systems, it would be best to default to getrandom.

[Note cygwin and *BSD systems should prefer arc4random, on Linux
all of the three main options (arc4random, getrandom, getentropy)
are pretty much the same from a performance perspective, but
getrandom is much more 'available'].

So, yes, a v2 of the series, but a different final patch.

ATB,
Ramsay Jones

