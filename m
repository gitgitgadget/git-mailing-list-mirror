Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98E1D933A
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158249; cv=none; b=IN1yS//GVlLPoAjkEQEH7AgPjpMoYEU7Yeydf4eMg4Prhk1M/vc6aCH6cp5u8puog+xLUz3FzUWqNaE5JdIrvpIIZkrLNFLokvt6BQF/K+bG6pKbyIGPiIbLgG9S2QLBAsSW2uRmuGmOMzoYx4I5v6+vfvI4KME38m3ymE0BlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158249; c=relaxed/simple;
	bh=+jW1v5/SRnAdp+BKK/yCi4vb07OShnCH/a2dofBcf/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z/kLRVyFyd91IOgFh9QqgWTRDGZRPctgTgd4henZgQyNT8VcGIkan3MmDgGNv2tz+fyzk5QYyzoBAvTQcFAziaptNzrgy3JXmwXXOXzp7ZMxP3gBdYcedHp2OLSs9AuEBRBL1xzotiHrtnqIqyoiRciwBQew0KEEvDjpywvqyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrV9PQmO; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrV9PQmO"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a5c9becc41so13802137.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729158245; x=1729763045; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+jW1v5/SRnAdp+BKK/yCi4vb07OShnCH/a2dofBcf/o=;
        b=OrV9PQmOMejA4FAHRAQQRiRCdEnoYRIrG2PJJAYi9pALBcxPbpHHrcxGXeuIjYYY3l
         Pof4V+efTw1DwedeDRknnfsIFQDL8Y2ZWEVSPH1F3tcmx5hmXeok+v8Rv317KK2Cy9NN
         iraNGuTJJcAQrgQ8rRc0aMEY8aR8VLTAzxrPyYxIchk5LUyonWcv/OZwOXyP49osKAOM
         /szMemp1l0WkJj6jZXkJ0ATgqe3rbTAKmLF+NHWkWOC4ENTATSI2ogXeenPO2G2+qeen
         UVhB/PeTE04KHt9f+YzcAYzyHvj7DOGPFDVyWfMIY0gxBkjbPTfvtMjyh7IeH/ukjElF
         byjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158245; x=1729763045;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jW1v5/SRnAdp+BKK/yCi4vb07OShnCH/a2dofBcf/o=;
        b=CAzGeqhBhaE9D1VIHbb+JYnIPvNMKJh+xAQEPvC8lIncTwZ8QP4GK0ls2JlM2i5lPL
         WmMPjQOEq7KmlD32pefhrShkBDtg8PwZ5NlLJOKOpqL/04TrwxCwN0TnMFfDmBnV9Lx5
         0ynIrmL4/0atnMrkBVfdUPDmzdBJ4ngO5gOhijKh2ZbHScCpdcYJGvi2lW95B7VPvwqB
         IjwrPelMsYjKT0hg212ySxJ2sse6PAa3Dd8A1muJxNuDDnlUtnuaWYLDIuCOXx8MYgyK
         x0M77o3ze82vPy0ellToZXNT4HtMsYRFvgtsvguwkT7EA5ywxWQThb21VXT6ibzI/3HY
         PI3w==
X-Gm-Message-State: AOJu0Yw/JrlTUm2n8i3UJoIL07CCTMouCI9FjvRFK2GImvZXKmCjLfWx
	iwkhwC5qKvofX/XfrscRdMe1/tUz2+mGiyCXOp+NEkX/7mMDP8jULvcUJsSLzIbc3aNPe9Y2YOM
	qkVydMMf97GhgQso/v8g0Yffxo2TVitpz6YzE6Q==
X-Google-Smtp-Source: AGHT+IEzCBCqq6dAxJedI2EMguBNyhYujU6aTuaERhEhH7hKt6yY07CXdLL8wBp6/OwPFdhmVWHvNE17nAEaxmSt8Bk=
X-Received: by 2002:a05:6102:3706:b0:4a4:834f:900d with SMTP id
 ada2fe7eead31-4a5b9b99d8dmr1537735137.6.1729158245351; Thu, 17 Oct 2024
 02:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abraham Samuel <sammymore50@gmail.com>
Date: Thu, 17 Oct 2024 10:43:56 +0100
Message-ID: <CAO1n886ZRRD6m_GQsYz-AGwpbkDB4S+0+hRx-9mmN=6iJ1o7Mg@mail.gmail.com>
Subject: [Outreachy][RFC]: teach the '-e' option for git notes sub command
To: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	Patrick Steinhardt <ps@pks.im>, "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I was searching through the list for a #leftoverbits project that I could do.
I then came across this conversation

https://public-inbox.org/git/xmqqed7bhobk.fsf@gitster.g/.

The suggestion was made to make messages seeded with -m/-F to the "git
notes add" subcommand be editable when the "-e" option is passed to
it. This allows modifying the message by opening the default editor to
enable the message to be edited before adding the note.

I have checked the current version of git and there is no "-e" option
implemented.
I am also studying similar implementations for git commit and git tag
to help me understand the implementation.
However, I would like to know if I am permitted to go ahead and if
yes, I would appreciate pointers to other resources to aid me in
implementing it.

Thanks
Abraham.
