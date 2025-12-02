Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746519E98D
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635416; cv=none; b=gVKtcOlUvCEXgc1BApmYQdjxJ3IT8PZpCekXWTqjWS4lYafE27r/+RIB7qheNnvgHLEl+vCjLrvJFalOqhdZ+1OJqnG5qofNH947Vo4NynWX1IJNTdDrOJJd6hsUiJUJmDM1gv6tM7KgRGVrmjMlDH9/O4/lr6QdfBokNoBl+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635416; c=relaxed/simple;
	bh=/zXhx0YuAxnelBA+7RisZ7SiHaq/wv3a0qh/rtRa08M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VOmQf98LZxLzCiluQGRaRv7rjBxgNpp7jHlLq23zxlJJ2Knoe/nVPoP5orMPCBhbAu/Cx3bM03AdurOOh8cANNWYKMMSN9xwjzeCmDgz1Dyq33mgPKkFEk05l5DUVDPv+M1LRZQXdd8a+FAoLbMn49ITQF3HlTz4iXcaLkzVN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpqgDM5s; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpqgDM5s"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso2902094a12.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 16:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764635413; x=1765240213; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zXhx0YuAxnelBA+7RisZ7SiHaq/wv3a0qh/rtRa08M=;
        b=bpqgDM5sCA/pBOPAzSmUe2VB5AnFqaWTzJuCk4YQpK0uFd26kDbqN3j0dYVBJcHYg8
         lRzH7nQ1waxhNYKRgYCC+MakVs7k9JHtm+q3GvPFrWLuEMqFctcDkC9xn6qo8lPnz9hi
         j/V5jnnwctKAyne07zhtWKGatxnMz77a+B1Obna8EmsGnGCGpUMX+Lz3uRpRgutKiHFb
         cOlE5jeFY56jfjyqZ1ghrWE4WLmBRg08w6Rjacv5FpK14V2B6VB0Vxky6DL6V7yUXU6b
         XKQzf6V1zJB9W7ymQlCnZIP3KC+oR9OXiX/0E7ymiL1TAiYFgrsrUWWN166hM2mVNAGo
         Vzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764635413; x=1765240213;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zXhx0YuAxnelBA+7RisZ7SiHaq/wv3a0qh/rtRa08M=;
        b=rDKGUjhTI8wxlmbPdAq0t658OAyJ92TGTzInmAtNDZt963OUtU3BVl7uHBugH/Q70U
         k1vtZrDelrFzrBf55uXcMaMh1mb3ov1F/GqLLJY73ZHSgiox2g34FgVryNi7EIbqR507
         mKpdypGgQqjvH42VDTewi/QFpQDjE8mPX2AlZnAEsOBIycnesrWj9aE9eUXTDWcMl75s
         fo+LfBK8TQF9fzII/jMQROYnCvpncBfn8onFl41cfBOTdYZyjvmWHtKHqDOSvRtmil/4
         f5DGBXqKroVpZFh/3wmuOsNzRqwen49bw8NjUSkhh00pVY3goMjbeuybhOIy0WyMrvlm
         wMxg==
X-Gm-Message-State: AOJu0YxQKseR+QLp2ZOIBjEuneGuQJJ+iR86xdwGv8y/6bHMZRbU6AeV
	/oVVEmla/BD0lriZKGsVbtjM5v0PAzLL1etd298aaLPXNgK/kq3c6jqY
X-Gm-Gg: ASbGnct3S5+DUAUTxDjDxlH3Kryn02MR70cAC85QUWQq/TBueq6d01zH9L3/g/eOt47
	T3OiQNqodJVjqZt/57RiuzHG/Ez5G48u8xEXeTI99CycJ6/9YtFXS0aUUrWFe2cHYUgFKiTrcZ1
	R06Z+wI6qunDTbp1t/ZmAuZ42FpTYiJm5Yx3s/5OTdfxWgbq9numCopj5kySDm2HkGQHOCLh2hA
	SoJ7UTnQbE+UoIPPPGdCEgqP02lrmKGsSrzpO39+ifBgRtet6BRQ0OuwmzlmjyW7KHFvAUkPQDL
	wfid69aDpkfM4fj8Z+p0pcjDKW8UhArwdZIoB24GisfSinQmaoTT7mhcaeP0AHTDslBK9ywIUIw
	P+M6uCFR2oC6MLsecVpZOVCvKeTrvVM+VipXhdQBlvASXZMocFphd4bJ1wHV8jnOTGPwqBkMFhl
	2eH63jVboPHO4R5GNFp50aiiAqkfPX98hPRwKIVzbM
X-Google-Smtp-Source: AGHT+IEt0078T7vzPaItukT/AcfjHQ90+dGik4xJJO22BZYhydrxL3EmnxjLuvOdBUigB8y8/PlP4A==
X-Received: by 2002:a05:7300:fe46:b0:2a4:5028:342d with SMTP id 5a478bee46e88-2a9418914f7mr12181923eec.33.1764635413123;
        Mon, 01 Dec 2025 16:30:13 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm62995872c88.4.2025.12.01.16.30.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2025 16:30:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <3hzpywampwjfsckljdqhyabhkupqmrzbcsc7fhrkg2cl4rjzzm@mygtkda7soxj>
Date: Mon, 1 Dec 2025 21:29:59 -0300
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EF2A8F3-93A7-499C-9307-413CBFB0C4D5@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <3hzpywampwjfsckljdqhyabhkupqmrzbcsc7fhrkg2cl4rjzzm@mygtkda7soxj>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)

Hi!

>> This patch is based on top of master b31ab939fe (The fourth batch, =
2025-11-26)
>> with lo/repo-info-all merged.
>=20
> Any reason this isn't just based on master? It looks like this patch
> should apply just fine as I don't see any dependencies.

Yesterday, lo/repo-info-all wasn't merged yet to master :-)

> Reusing the same `parse_format_cb()` makes sense and also matches what
> we do with git-repo-info. Looks good.

Yes, this callback is used by both subcommands, this was a really
straightforward change.

> Did you mean to use the -z option here?

Ooops, yes, sorry. I'll fix it.


