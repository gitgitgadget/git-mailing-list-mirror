Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6524677B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603903; cv=none; b=MibDuUTbQnRvqKvv5+kbLB5t70XHdvsiLJmFjkEWpN5tMnd5OOFFMVwSjiQh4GaUNDqCB2ROPmF3tXYsEGmgKe/wgoUs6uGK0N1nJE73dVJqbW+O8CJsyeX5lq41D0wICz2jwkn80scO3MQZXmICy9oNNl/oRZVHwTkiIWoaSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603903; c=relaxed/simple;
	bh=u+XzKYXw+PdKBew7AUfb1GcyIy3n6BSH866BM9G8a3k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgVfhBZsNpEjJNr4Zqu7CyeDYz4/jnKeZElRLHk+sSyQQGvxqVA3XEOKF4bC29pdxRDu6zjOlpHejp9Wh8eSNXWJHwhnRDBB14kObg2AZowAfGnbprkKG/UJ8TSeQvdKc3VYKARWRAauDgvhPOMYNBspku9YTAJO6JsZJd/SDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 56FINKPT1889348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 18:23:20 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
Cc: <git@vger.kernel.org>, "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Brian M . Carlson'" <sandals@crustytoothpaste.net>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk> <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
In-Reply-To: <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com>
Subject: RE: [PATCH v2 0/3] C99: declare bool experiment a success
Date: Tue, 15 Jul 2025 14:23:14 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dbf5b5$8b316f00$a1944d00$@nexbridge.com>
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
Thread-Index: AQD93G+NRU9hmfxmcUUkwFIcalH0KgJP6r0GAx6rUCm1xD0e0A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250715-2, 7/15/2025), Outbound message
X-Antivirus-Status: Clean

On July 15, 2025 1:19 PM Elijah Newren wrote:
>On Tue, Jul 15, 2025 at 6:53=E2=80=AFAM Phillip Wood =
<phillip.wood123@gmail.com>
>wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> We've had a test balloon for C99's bool type since 8277dbe987
>> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
>> 2023-12-16). As it has been over 18 months since this was added and
>> there have been no complaints let's declare it a success and convert
>> the return type our other string predicates to match.
>>
>> Thank you to everyone who commented on V1, the only change here is to
>> fix the typos in the commit message for patch 2.
>>
>> Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
>> Published-As:
>> =
https://github.com/phillipwood/git/releases/tag/pw%2Fuse-c99-bool%2Fv2
>> View-Changes-At:
>> https://github.com/phillipwood/git/compare/a30f80fde...669687147
>> Fetch-It-Via: git fetch https://github.com/phillipwood/git
>> pw/use-c99-bool/v2
>>
>>
>> Phillip Wood (3):
>>   CodingGuildlines: allow the use of bool
>>   git-compat-util: convert string predicates to return bool
>>   strbuf: convert predicates to return bool
>>
>>  Documentation/CodingGuidelines |  3 +++
>>  git-compat-util.h              | 12 ++++++------
>>  strbuf.c                       | 28 ++++++++++++++--------------
>>  strbuf.h                       | 12 ++++++------
>>  4 files changed, 29 insertions(+), 26 deletions(-)
>>
>> Range-diff against v1:
>> 1:  352f80c49b7 =3D 1:  352f80c49b7 CodingGuildlines: allow the use =
of
>> bool
>> 2:  a0f9182aa20 ! 2:  0b2402e11cc git-compat-util: convert string =
predicates to
>return bool
>>     @@ Commit message
>>          git-compat-util: convert string predicates to return bool
>>
>>          Since 8277dbe987 (git-compat-util: convert =
skip_{prefix,suffix}{,_mem}
>>     -    to bool, 2023-12-16) a number of our sting predicates have =
been
>>     -    returning bool instead of int. Now we've declared that =
experiment
>>     -    a success lets convert the return type the case independent
>>     +    to bool, 2023-12-16) a number of our string predicates have =
been
>>     +    returning bool instead of int. Now that we've declared that =
experiment
>>     +    a success, let's convert the return type of the =
case-independent
>>          skip_iprefix() and skip_iprefix_mem() functions to match the =
return
>>     -    type of their case dependent equivalents. Returning bool =
instead of
>>     +    type of their case-dependent equivalents. Returning bool =
instead of
>>          int makes it clear that these functions are predicates.
>>
>>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 3:  7eaf8042061 =3D 3:  66968714739 strbuf: convert predicates to =
return
>> bool

bool is not standard in all c99 implementations. I have to #include =
<stdbool.h> in order to
use this type. Please make sure there is a mechanism for that.

