Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6C269AE0
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489697; cv=none; b=jODR8PIlETaBdydMbN5tMlb5mkyyJuUZsXAxdoyx31nVDecfMKrSiAkcJ3D229Nba/0Fi3WhuwAwpWyLbd3WhwMp2tRfxY1aWKYCunKbBsi5DqQmQsYAgObuCfs6jf/vpabo6VBIwRt48gUxZnTkTeCb1hREVh2g/h0B1MfEHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489697; c=relaxed/simple;
	bh=zB2ggN/Sn2QaoufTpsvQ98G7JQtHsqlNqmJ6V1c2Q0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO7Cs8NKlVHw4uNIQaM4qrRW7GVnKsit6ESMaO/bkaPCtltFnaTNpLYNbs+r6EE0dON5EDjDEmmfPcyJ2a6ZGx409Vm7wLcqry3PMhpWDw6irn5i9kGUK0OF4WcJ/MJIKXP6nhiWWEgPL1jJfQBOhov4V2Cj/Q0MBO3vY5vSiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNGdGYXG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNGdGYXG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so11079300a91.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489693; x=1741094493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvauXIW4rY6MIUf51ccjmKEOY4tK+Uf8uEi09qLgXDA=;
        b=CNGdGYXGAy09gQ8dRPum8RtpHo+aGYSOfHX8r/a43cXupl76zHGXmUmbhJqLZuBsHF
         ZvLVmiANvzkLOzAHWkBFsWJVYHQ7FUCSInvnDjV94ttTfYjg6xVQPLwJfwXDhYUquKju
         f0nVd3NAS5aGGFdrAqyJLIlqoi8GRbPlR8azk+vpQtf43BsElr/T0LWVSQoUPHU6gfrN
         MIbCI/t2jhj0FSTg7r/3c07bbOILW7Nf4+dgrGXOawbHAbKtQw1cB3HgI3KtL7250HWd
         8DRsbkzjuuLWGUXNwhELT6QN70HCNH3VcEZNSioVF7AueC092K/DrN/yYuRiqrCabJq2
         XCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489693; x=1741094493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvauXIW4rY6MIUf51ccjmKEOY4tK+Uf8uEi09qLgXDA=;
        b=IPo+29eCY+8o2m/DCYTqybW9u/IT/yhgvmFFqYMmEVITGHEabKO1zPuf/bFqZLLZCK
         FGpKQSoHzN9CuvGOJb8s0DLG3IzK5AUBt00hxQZDDwRiSxgILL0V9DChGWhrJziKdyij
         dVbkCxZMCW5jq7HQ46KvuZb6w+rSqMwaygcBk+ntADTk6OA/G+jK3bjWtXqr0upbMa0w
         GqzDemcU/eAZEHFrEB4XWNqWZGWkqe28jL0aLfaW7Ltcw4pM882y8mruTgcsZ0xtly8h
         +LyhC25n9wYYxEdeEw7gOV/ewpsYXooypkyocWbajbYGm1zDYlf855I7yd36wPbNspjw
         8Zvw==
X-Gm-Message-State: AOJu0YwcbESn00hc7UEWS4sLbbdmwW6kdQXQ5SqYTDezAAUOd5dA4Tjk
	58DBy16Tt+6BpLEjzFWrPCGFsD0kKN2xnLRdgvw0XiF+tHAm5HJfGLP8WQ==
X-Gm-Gg: ASbGncuiqa7asbgPVu6QG/XAVkOXxN6VABTq5uo0MNyM5YwSh3gLRN1Oen6sX7Dzq8O
	mnPMzRJaiKeJLXJeXDxrYsl6aIBXsR6owzz2Eqb2tODL7u+jhrLn0UXMVNJr6A+ip2AXzgs3dTT
	cR1FHNxBO16YRQqsAcNoNFVFyHrY8IF2MGlwxJKVpejdYYa1SwQgyDHGX2yShZm+22utfRfPezz
	4kdjGFbFgzGaWlG5+18JPxvxf3/imhIvUG0qERdVVh3eka/GwfRDAD6yZaDuoUigJO81ywrvBpG
	WdahuizeCSi8pcPLsqQ1DA==
X-Google-Smtp-Source: AGHT+IF1Z0GFjcGasZrUk3ddPLqurgyxTd1BOYMA0grmvDYTU7nkZN9M2Rwk12gnDp6vJCTPspQxPw==
X-Received: by 2002:a17:90b:4d0d:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2fce8724453mr24609451a91.26.1740489693419;
        Tue, 25 Feb 2025 05:21:33 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe6a39aa3csm1521156a91.10.2025.02.25.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:32 -0800 (PST)
Date: Tue, 25 Feb 2025 21:21:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 4/9] packed-backend: check if header starts with "#
 pack-refs with: "
Message-ID: <Z73D5XLzzg-OPmdT@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

We always write a space after "# pack-refs with:". However, when
creating the packed-ref snapshot, we only check whether the header
starts with "# pack-refs with:". However, we need to make sure that we
would not break compatibility by tightening the rule. The following is
how some third-party libraries handle the header of "packed-ref" file.

1. libgit2 is fine and always writes the space. It also expects the
   whitespace to exist.
2. JGit does not expect th header to have a trailing space, but expects
   the "peeled" capability to have a leading space, which is mostly
   equivalent because that capability is typically the first one we
   write. It always writes the space.
3. gitoxide expects the space t exist and writes it.
4. go-git doesn't create the header by default.

So, we are safe to tighten the rule by checking whether the header
starts with "# pack-refs with: ".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6c118119a0..9dabb5e556 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
-		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
+		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
 			die_invalid_line(refs->path,
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
-- 
2.48.1

