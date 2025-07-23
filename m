Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14463D76
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246919; cv=none; b=dYLBO1KWkWeDOKqZIVeZ/J1IIWMTbz6kVmFZedXmF3WAy8RD1GyU4cBv3XP547f5IKj2cjfVhV4CIDEqdcKWJ0r7H1T24Wc96ZxGnAlt617KYAl2PNsd85FXPc1O7FF3TD9zedmIE+kuJjEYABBXGzvH4kaxW9c6NPlO7bfUqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246919; c=relaxed/simple;
	bh=9+tEs+yKJ4aheaKw6jEI8U2ZVx2bX4t3/iRu8HkkvQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euBLZWCLUzx30EhWRB5ANX6Qw5Ra68oXdPyueed1HoXqCJQy3l4+w78D3c64uU1Ju7NsxtcE1FSmmOdYy6nD3J8j48NZJtihWjSy1p7VOagTONkyAN0xTqeKHFs1TfLUJDkK9qwJIkSwMlz6PxKU7Wx8uAPhqOaXt92FFyQU2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg+JVCf3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg+JVCf3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dea2e01e4so76224555ad.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 22:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753246917; x=1753851717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YO6G8+M4W6XFcRs6PVRzzmp8zb7acmxXgfrhbR1FNU=;
        b=jg+JVCf3VinjLOwvbPIaKhAj4S/VbZXZaE+PXGkVwtXP7zEUx9HoUOK7+l0hVULAHm
         cG0zI2RQm4cwt9xi/1xLZVGNOdG9sxNXZKJwQP08kXvSevqP+IE+a4aPfbu1V2HUiXIR
         ExFjccW1GJmjU1wxJJA2GKwOA6asS3W4Lw8nPdPv0Yv8JB0ko+0jCL37IyEutYVEXDEY
         pZjiFtTdBlYA2cBBkDNxxrp1wJgj/2ND+5LimrbR2OVtqZhPR+BzT2I9Qq9HHwK0sNNH
         MXMqGIA9FvHzqKO9jCdmHrBxr5gK2i4ZlWuDrxglUGWLSmFVEs5j4qNzbnzxFYZAAGRl
         2Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753246917; x=1753851717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YO6G8+M4W6XFcRs6PVRzzmp8zb7acmxXgfrhbR1FNU=;
        b=NxkSjKmoyBEWoL+cxC8Ieevupu8M9nywoDPu56Fp25fyPBQPdvLHo9WZ1MGe/7c0F1
         PKqBZXfTJtbK2u5dYUxOuwPAJYCNqAO2KUZHvJGiPOODjsySjku5vtgJ10Y44u6UIp8r
         xBT7vfxpR8VSv61ZDrY8m05ryHLKbblEMwRx7UhwU2pa1ppDiM/s9lPLbs7ZqVa2W7my
         yCbg1mzVW/zIF2ag8v5QGPrecN/mEI34Z5r3EAGHmw69KVz3FAbofXFwi4UsFwoeJo2s
         frc6VTlu3JtGWTPBTgUBPo7R7uwvK1hvbLZdD0oCoFNXDdY2XljNHG4gLNPCgor63uSN
         2ncA==
X-Gm-Message-State: AOJu0Yyu4pfCbBj8Y9PtPYtWkvu1Anj4F56aKP1DHjjnJKOd4I+1Ksc4
	5ObB5LkBTPMTCVdDtNzj9oIsXL1lMlBDvJFxfZqlvz8OCo5AK97N/+L1il6LokaJFK9MqRtDKfs
	pyr8tqllSVeafVBvnlMWDDy2t2vgmn54=
X-Gm-Gg: ASbGncvLaL9c+c7pwbL9YOf8InJacoSHHAJGcEQgHVI02hd9fQ/HhLwiLRd2gI8h1Vn
	ZMOk6l2j6086FMAO3CbVv1Z90XhYMT81XJjbfG6UIAUSvdNmqH+mJEL79+BRiwLfnPUfXekTo6B
	zqDHRw0cs/dsF0JrR1aZkypwgGGbYO0k5aJl28eMaefqVdaWOLKOqk812akG82ToM9zuJ1T5/92
	/RE6fcs
X-Google-Smtp-Source: AGHT+IEXBnca6+0IayY8S1EnIVcB7o5OInQ2P3PMjRqglQzh5L92zl4w2PbzMETNKui6McfjM1prLMHgFqt4VuFQc+A=
X-Received: by 2002:a17:90b:2e88:b0:31a:9004:899d with SMTP id
 98e67ed59e1d1-31e507b3c92mr2609610a91.18.1753246916828; Tue, 22 Jul 2025
 22:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250717075009.26262-1-meetsoni3017@gmail.com> <20250717075009.26262-2-meetsoni3017@gmail.com>
 <CAPig+cQgeqz9bNQSFRvTmoyFgqAwEKSV=KpK18DSP7FA-4GDPw@mail.gmail.com>
In-Reply-To: <CAPig+cQgeqz9bNQSFRvTmoyFgqAwEKSV=KpK18DSP7FA-4GDPw@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 23 Jul 2025 10:31:45 +0530
X-Gm-Features: Ac12FXx9qDbirDdyKJIJg3ETeJeNRFn7cvUaEJZzZakiFy9hop9BdaKLJGNBkq4
Message-ID: <CAPhwyn0a6g1HCSKqN5oUxRCp9qfThqBDady1M9kDJikP1fc+3w@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v2 1/2] builtin/refs: add list subcommand
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com, 
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 22:18, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Jul 17, 2025 at 3:50=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com=
> wrote:
[snip]

> > diff --git a/Documentation/refs-list-options.adoc b/Documentation/refs-=
list-options.adoc
> > @@ -0,0 +1,80 @@
> > +// Shared options for for-each-ref and refs list
> > +<pattern>...::
> > +       If one or more patterns are given, only refs are shown that
> > +       match against at least one pattern, either using fnmatch(3) or
> > +       literally, in the latter case matching completely or from the
> > +       beginning up to a slash.
>
> Nit: We probably don't want the "// Shared options for..." comment. If
> someone needs to know which commands share this documentation, a
> suitable "grep" invocation will provide the same information but will
> be correct at that point in time, whereas a comment like this one can
> become stale over time.


Makes sense, I'll remove it in the next version.

Apologies for the delayed response, I was away last week.
Thanks
