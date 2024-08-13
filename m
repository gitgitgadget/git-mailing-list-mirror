Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CD38FB9
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581736; cv=none; b=sKLT98V4AEPN3KxsXkW/Jgb9SB44oavf3IgG5Btn5oDGGEIZR65Px4sYINqTyjQasU7Ey6DimeFZP5FKb5sjKrS77JtXb3qfVKN89lT1gT400Ld0wxv0rzEKMaLJ9KrIcBNHAUX2DMAWZiTD788FdbT46gQdTiRWY1HpgR0t9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581736; c=relaxed/simple;
	bh=qme/Cizzo4C1b9vMGYJPO5GlyCKZZqQv9mc6AMb9bIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ClZb/j7IRrJ1ibb2eFocbYAM+4LXJ2MqSBL3cuQa88ftD/dlPtV8H8lng8OmqbzBPb8lRmT+KSL2mFI8d/mBWDcJ+On6nD75HO6ycp4Z1Pnx4FrR194KGrgPtMyfyYwLfmjScWuLbPD8Vw5pE3LZZVMaBLtZJPS5fv6F1P6Y/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZYRRUP1X; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYRRUP1X"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E730120CAB;
	Tue, 13 Aug 2024 16:42:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qme/Cizzo4C1b9vMGYJPO5GlyCKZZqQv9mc6AM
	b9bIg=; b=ZYRRUP1X8SfkQzymFDDOhp200DBgG3ChgHya+oiIMudwG3JbT12aRV
	YNB1iNDNQB1r2QD27SlYx25FPFyeTLSI9w65XjucYPiidOvsF079NVPqZRakQrhU
	5UJsjd10GnfguzfsF58Lxqlk/ULCxoGkczGizvRS8UcUJR+CNJfJA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF96220CA8;
	Tue, 13 Aug 2024 16:42:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFAF720CA7;
	Tue, 13 Aug 2024 16:42:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
In-Reply-To: <xmqqv8048mx2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	13 Aug 2024 08:25:45 -0700")
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>
	<35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
	<xmqqv8048mx2.fsf@gitster.g>
Date: Tue, 13 Aug 2024 13:42:08 -0700
Message-ID: <xmqqcymc40kf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8315C8E0-59B4-11EF-87DF-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Fix whitespace errors in the clar that make git-apply(1) unhappy. This
>> has been cherry-picked from the upstream pull request at [1].
>>
>> [1]: https://github.com/clar-test/clar/pull/97
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  t/unit-tests/clar/clar/sandbox.h  | 5 ++---
>>  t/unit-tests/clar/generate.py     | 1 -
>>  t/unit-tests/clar/test/.gitignore | 1 -
>>  3 files changed, 2 insertions(+), 5 deletions(-)
>
> A funny thing about this step is that the copy I carried for the
> past few days was an empty patch, because out of habit I use the
> "--whitespace=fix" option while running "git am".  As that fixes
> the whitespace breakage this step addresses while applying the
> previous step, this one becomes empty.
>
> I'll requeue these patches with --whitespace=warn instead.

Oops, it turns out that this is insufficient.  I'll add the
following as a separate patch immediately after this step.

Thanks.

 t/unit-tests/clar/clar/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/t/unit-tests/clar/clar/fs.h w/t/unit-tests/clar/clar/fs.h
index a6eda5e5dc..3e39890bd3 100644
--- c/t/unit-tests/clar/clar/fs.h
+++ w/t/unit-tests/clar/clar/fs.h
@@ -146,7 +146,7 @@ fs_rm_wait(WCHAR *_wpath)
 			ERROR_PATH_NOT_FOUND == last_error)
 			return 0;
 
-		Sleep(RM_RETRY_DELAY * retries * retries);	
+		Sleep(RM_RETRY_DELAY * retries * retries);
 	}
 	while (retries++ <= RM_RETRY_COUNT);
 
