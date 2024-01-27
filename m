Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C729A2
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706322702; cv=none; b=RguaGgqAvq3BihHqR/q3ZtTYFQdweotpO3Ov6Hw/LdYDiUYyniCKEMFUD+/XgkhCitd+Xj7UDZ4JnBaErCYjMghJuKbkdkD9mvza82AZ4UDk6ccsLKmkjuwKaXenI1Hw9Seamejcz2mvw0wwvUeEJo8JLv48lAIeo5Ch5Tzf2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706322702; c=relaxed/simple;
	bh=6k86pDPXkq8PHBw42t/bWp8rm3Sdb+SlO6/lQ4q8zKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOXFnGdY3DuKoB/8eYuu8pYMIsj2KoL283uCafzcu1cNtIY0xaRfr4w5vsl5gXUCpAP+E9FAvSTTsGFbgQj+mptG8d34uZht9ZOFS+9+Ci0qqVxNmdv73boYHbOGGV7mAPqPbb8FGtpOofYOvS4DYkXjS1pI3Xhga8C3cK5f+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLna81kb; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLna81kb"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a057a0144so223990eaf.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706322700; x=1706927500; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBCC18aKFQb0RG2zQcpuL/gzGCATOmzhxwvfnJOJ8ic=;
        b=mLna81kbf2zD51986RLuTHwuHYR6wef+hnjfWQgg6fqGI3Aco0QZBpXFeuU9WAfS8t
         oG08mcnYgucOLpdDJyIetM8sz2wo6cr9+1Y+o4/h0WMhYllhiGn1VcKbndTmbqfo47bL
         CAz7ybyKOwhUzijv08PJxcMn7EqrSIGEUM4dDmTNArcdgvq0cbNCCV0oYWuWAHvLEgDm
         iUoEyEuI8riEloTA2qL7qnhTbDH1ph5ZZxuDHz/6BFwgwAH23k43Wzwc8fdIrv7eq0jv
         aBxyscyzFkoNJZXuPwNXi4eSp2rV6+xpnx+XHBeH9s9XWP1ZB8uEV95csQcqilXLlpGU
         9qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706322700; x=1706927500;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBCC18aKFQb0RG2zQcpuL/gzGCATOmzhxwvfnJOJ8ic=;
        b=ljbUW2OIB8WK2MhzQRrUuco/JLr+Go32nEn8Nx7fifzi1Op8gl0bkmgySnBxD06Hkf
         TPdL0saoPh8nuSqhWDEhuDNHnoqipP53dJJEBVZgfSEg/UlEnZBPCA2Oc9iowu4HzLQP
         j+xgSgNfS7ZIWWOMol/3emIs28tCUIvUoDo6R3IZLZJZM9MslhWTTCUzNhr74v6FYxkS
         P5zboht4ESzbHPk6111Ab1vy5vAgGvMwrn0SernzYk1Z5BKKjT93nZQ7zta+fvOaT+kl
         /Og+AFUP9okFCUS7HLamRaV9Nbku6qE4bI3be2ABZC4sjnG5I5mAwDVGBU1dPkJItwbC
         qJ1g==
X-Gm-Message-State: AOJu0Yx9IGPuNYHdcHSFfjHtDROk/AZxRYVjMOVMaXq/1a3OSYUxBfVb
	Zhv4SGwh6TVP6sHGx4wYN+zSvev/dZkRPOZsjfRaLoQenvHNlMVz
X-Google-Smtp-Source: AGHT+IEw3LhreCcRpmyhjPf4fHy0xcyrBWyvFXJiJg22HvB9IGDz/E2CILqPb2qRY7SpKvpPRch8RA==
X-Received: by 2002:a05:6359:459d:b0:176:c1e1:7556 with SMTP id no29-20020a056359459d00b00176c1e17556mr1272728rwb.0.1706322698474;
        Fri, 26 Jan 2024 18:31:38 -0800 (PST)
Received: from [10.37.129.2] (ool-4573e4cf.dyn.optonline.net. [69.115.228.207])
        by smtp.gmail.com with ESMTPSA id or32-20020a05621446a000b0068189e9d3a3sm672738qvb.112.2024.01.26.18.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 18:31:38 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
Date: Fri, 26 Jan 2024 21:31:37 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <BE30DB47-1488-40A3-BD0C-804F97DE0C88@gmail.com>
In-Reply-To: <20240126221357.2940676-1-jonathantanmy@google.com>
References: <20240126221357.2940676-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jonathan,

On 26 Jan 2024, at 17:13, Jonathan Tan wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>>>      ++--fsck-objects[=<msg-id>=<severity>...]::
>>>      ++	Die if the pack contains broken objects. If the pack contains a tree
>>>      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
>>>      ++	that blob (for the caller to check) after the hash that goes into the
>>>      ++	name of the pack/idx file (see "Notes").
>>
>> Not a new problem bit I have to wonder what happens if the pack
>> contains many trees that point at different blobs for ".gitmodules"
>> path and many of these blobs are not included in the packfile?  Will
>> the caller receive all of these blob object names so that they can
>> be verified?  The reference to the "Notes" only refer to the fact
>> that usually a single hash value that is used in constructing the
>> name of the packfile "pack-<Hashvalue>.pack" is emitted to the
>> standard output, which is not wrong per se, but does not help
>> readers very much wrt to understanding this.
>>
>> [jc: dragging JTan into the thread, as this comes from his 5476e1ef
>> (fetch-pack: print and use dangling .gitmodules, 2021-02-22)].
>
> Ah...I can see how that documentation isn't clear. The intention of that
> commit is to check every link to a .gitmodules blob. The tests perhaps
> should have been written with 2 .gitmodules blobs (in separate commits),
> but I think the production code works: I tried changing the test to have
> 2 commits each with their own .gitmodules blob, and error messages were
> printed for both blobs.

Thanks for clarifying! Would you mind providing a patch to revise the wording
here to make it clearer? I would try but I feel like I might get the wording
wrong.
>
> (If someone changes that test, e.g. to have 2 blobs, the ">h" in the
> "configure_exclusion" invocations look superfluous and is perhaps a
> copy-and-paste error from other tests that needed the hash later.)

thanks
John
