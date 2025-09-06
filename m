Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BD5661
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118654; cv=none; b=SniaNECy0pRhg7KND1fol4VnqSPe8EG0MpHYZJoNvSLQvPqmLTsGUdhavh3IluLFY0wYov6K4O3lC2IaQ0mR8B0vrtGzCucyrbXijGHlUKmapRhHXXxJVv26NQgwV97k0dmVEB3d9XvvtLFwKhdC/yTMuWrxhAyJXtWKyuSAA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118654; c=relaxed/simple;
	bh=INudRSYV1C/hexMZiNzYLA3XEoa2shRjWS8Zytgdzps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CCOWCq8GotNLUnK34jZazXbjubr3b7XurkgF40tRUjYH52IBogufzwZ58+9dhC3PulY7jYSEbOYJ1tj6BPJePny/gak/ciR8t9+AabsehYKmImVBjtZQV9uqH6P3xritsQrore8gF5RQui+25GFrodm5UZ2gXj3lU2QokrNzKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3nO6Ms5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3nO6Ms5"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-724b9ba77d5so31252977b3.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757118652; x=1757723452; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INudRSYV1C/hexMZiNzYLA3XEoa2shRjWS8Zytgdzps=;
        b=E3nO6Ms5cizVlfEZtaXYeJsgVMENELbR9cdBsOYKeXSNV0PgUYHjvxaxd3LfQbKO3C
         UUDOCwKCifXS/mmeagwoQKsC9tteqVhh3p0eGNlNymWCOCPFdjhfRBFL2DHrGx5RzEuJ
         EhHUnjZgck7YsNzC+YTxiEDLls727nDqMP8qBlrr1vXtbsKvodO00un3zfdX2lBHkw+K
         bJcyr1YCJDFEZSZt5OeftAb1XoekIN/eXmK0+eK5jd5peHgSnc6KIrEruCv/Qo5K8IoW
         T20Ye/EHo3F8DDs0hqIM+0XJg8lXbTRxROJd0tusegjo6uInln+st0AxGaSMW/oa6bFj
         agLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757118652; x=1757723452;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INudRSYV1C/hexMZiNzYLA3XEoa2shRjWS8Zytgdzps=;
        b=vib10UdkeVdp5aWz/zSNo2uDpgRtD8O8A1lOg/1HL3M+oDBL5OGW2xt0J9wefcOaV5
         gU8JsXsGhWcmVoc85yI9xXozZioqFPqd7UBH91HgIZLS0fCefz1JF4gggWFG1NLxEQtY
         E06/kJRTiqX2ii47B7zApAHldSAeKD6ZIqDy7o4xi5fnPmO0DnveGn/okuD8sW+/l/1n
         6c+NrODtKiFsZ6tcb8KJ0W3nMANbY5HCpt97s5bqbA6P7NNhBT+w4ES1cvzI3ZU9WG0D
         07vfYWcyseKmpcTNDI14gCeo+JrSQyopmnYTQAD2e33Ka5eS/HOUjucAlFlRPly1OYIe
         STVQ==
X-Gm-Message-State: AOJu0YwOiFeIvUaQNqaCCjBZ3L7P2px+VC60wEctv7Hg+/q6Ku8NJOfZ
	7hP2xBh/0mkxvUY53+hb+WJ6mCN0ujkl/IrDjRmK97rdD+vNy62uEY6nBtqheqvNjA5FlAveny+
	VsQgxR5YF0pwXG2/v28dBH1B1xkS4GK8CTX/L
X-Gm-Gg: ASbGnctStrmNiinyjcHAi043TgKJeahEGglMhq+fo3aX0WlnICLHohvRPjIv9mNIAIp
	FHTm/7+xRHJCuV7IDszThn8KK92xLCHZ5dn1aqdJ5oMj6Tk53fheNM7BVK7VhOncvTbt2cCuXCT
	Qlezo0TjDdHAeCsXTTKDkA1h7aLKM6ANzXyiEOoFIJS8KPFNymKqN9zJ3ke35fILqfpjOcBy2+d
	LfsRwVkVujheZickS9sDdrTspaOFgkruaN+M+y1D8E+0q4=
X-Google-Smtp-Source: AGHT+IGQYbdHP/W/uQv2GwXTYQJRcicH92quP5XM90Q6UknDvTemuzFPC89u1nMH86KqRPKFSfCmcBSz8TsLPAf28qw=
X-Received: by 2002:a05:690c:6013:b0:721:437a:2e76 with SMTP id
 00721157ae682-727f368de50mr6809257b3.11.1757118651751; Fri, 05 Sep 2025
 17:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Bohman <debohman@gmail.com>
Date: Fri, 5 Sep 2025 17:30:40 -0700
X-Gm-Features: Ac12FXwMoAy0sxFugj8NFCooyYJJ_-5yBiOpfTFH99u0WtxkWxHCwSxgeQ2BJHI
Message-ID: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
Subject: git-2.51.0: Fetching tags does not work
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is into a bare repository:

git fetch --tags

The command notates the tags it will update, but they do not get added
to the repository.

I reverted to git-2.50.1, and the problem went away. This is a
regression in git-2.51.0.

David Bohman
