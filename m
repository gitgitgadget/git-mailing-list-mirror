Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E7379C37
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125606; cv=pass; b=mF651qK0UeK+79TYca0j5fgg/mXaNx2ACjCWIVXhMG+iNJ8PNA6KwLhux85ZIMrES8Rp3VWV36+Dyay8XwVYiHkDmcW+xRVV5Sj05u+sDnBWrDqdsSHs8R+tzNw17xodfPYMMUXXg/7QvHu3gRCVZ79wSCFHCPRZ9W5tT5w32bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125606; c=relaxed/simple;
	bh=AJGpRmDO/MHpPZdPbnM4brK4roXwZiyl8UboG//Cf/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGGzt9HnHmsSlOzumL+Z56ZUXLzdAYGH/x2mM3qmUMclwKVClJOFceui4VYxSJn1xsepNY7zCMVyGd4jJeCnz3kHpn9/Vz0i3Bh7x+dWsRbNmvHtHVZm7Ec5Fgogn94v5Zop9CUI1CaS9dIuRbUDbApfw0Mo9u+fKUfgelrYZQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaeY1iTx; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaeY1iTx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso293764a12.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 03:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782125604; cv=none;
        d=google.com; s=arc-20240605;
        b=RjDq9++Ey6KAUp/7jWGGBMO5rnppbs9PR6nizKYPRcGdmq6JT9tMkjkeRCnLVoeDkA
         ieu9714u0wYAJdpScdf4wfp8DzGwSUX2dP0YGbiNGxl20KVY2BUKAytOuibkMJ0ddbAU
         19KWMReZgC1CBi1KeVIJVbXkU5CKSsy9/n22/l42Ai1LybEZZEu0/nGImypohEumPEUJ
         Sv2Jv6IciUJfAgzrWtx5pPfm1iuvB+jQFRrLTN+IPWkJG2JVl4G7zUWAnWSuM1A5BCdR
         h/x6N0rlMpubpCMhhhZAoWDiNoIawXFMFaLtHpCT7xQid2cBfBO5OjUtLJLCxfXht48N
         9OyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AJGpRmDO/MHpPZdPbnM4brK4roXwZiyl8UboG//Cf/Y=;
        fh=mEdrNmgY9f9ZqsJlO+hru96O466VH032WQ9/b2JN5NM=;
        b=WzDncDTAkQRGq5BqJpoA4JBBsGeN378a+rcNXLPyCuUXTm98ig2rm3MRQ8SShUf564
         cRdy2J4M6igXFur2uYE4+zmXdKm+Db4nwEr5RpfoTilIdFBIGnM6n1o7nf/YD8LyQurC
         qIFJWcCMcwqMtHQb9Tkv813+xKlddS6jLboo5RvaQl/o+nOx7pqNCNUDhfyNG+MdMuYA
         j+9tskxn27CZ0+30t6oWzHVmSgXzpQFR2V/w/Km/4N4vLxiUNeIfFK5UAQl5+WJcKnKT
         Vq5rAEvL9K8D5NERnmVC8aTRh/TGPwxrnccLcEPyAlv8EybBGWWFuvuCVOwoSLKMoUTC
         2Orw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782125604; x=1782730404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AJGpRmDO/MHpPZdPbnM4brK4roXwZiyl8UboG//Cf/Y=;
        b=OaeY1iTxata9L1M5UM1CSlsyDlyglj9m12rpqvR7kNdfoSVMOEwurSPxLGnUtfXZBH
         BOw2Hg939WVqJVfEE64kCmM9gh/PLLCqF+w5GGe2HNtJxc58vhslRbFa3QywPF/ba7HT
         mJqYQgXRq/K3ZqhcVDJ/fdz9/31vy29Zi2Ae68guNqt0JIyiMF7YeeYIHDHqHf6fgTpV
         xF5F6bahJV/6D7VBW+haOJKh1BmVMbgzM5dwI/tLh9YqWTy7kqLYXxpbyOqg372Y8smb
         +qmCpNMCk0bwwOJDFhoUvSxzJ6UnkRkhhXNIQ4Al0JMcFEtlOXwixTcAym2cSCa+hGIx
         a98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782125604; x=1782730404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJGpRmDO/MHpPZdPbnM4brK4roXwZiyl8UboG//Cf/Y=;
        b=kgoDaYcOBLuY7Wt4Y2JVR9Eo0uCWVUXNdRRGmep3TvnqIy5zjxIO/Pmte7NJnmPf+x
         lAy4X69JF3fSJE4NThcaVF2+DwkIp9IccqV8GOrGxUVcgOCHKrClXzl7C/UJIg7kClCm
         Ib2uDhUOFkf6hrKJzX1h6C9Vt+ySfsaQ82ciLfxulxsi/NjMWr9TwWfb5pYS+neLIP2T
         pA+/gYfre8Sh3+p01IL0O6k+x+dauZSQdo/8iZIEHfUSJyELfj6Olq6/Jf6ZPeRsB2mg
         +zFXyNJ99w22KRFGHvIN3Jk9g4r83l2593SjS9tIlqq7jv9LCItthwSiFSOQOGSlbVZX
         AV9A==
X-Forwarded-Encrypted: i=1; AFNElJ8Yaobu0yM1X+8KJ7ilhYQRB+7NycqwdtBaAsnEHuU11a7Y7yMKY3sLhr19WSOtW5mLp5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLNLVbWAXNFHiy0UUE76vUaSSnOVPLRbZVRNMjDUD8zBR+CBz
	Hqm0UAd+TFA4Vep1PREt7t8btazp/vPGF/VICbS08gZ5CFzw995f0N6lbhjyg71UVPGyaCEXW0u
	dUZ6UH5C7qc6kNfwDVaEHh3UiwkHiI3w=
X-Gm-Gg: AfdE7cmItvlGSXgEEDzr1r4o+IEBEGeh2uHL4dd/zQfX9Lt4zWESbTNOOM8gvhJagpT
	zvwLqoXNX4GXPwx+LXF5c5b9z/ija3uQTJuPvGkyy4RI9xllhwVFeTChKZtgrQEVbdvGWa6kpHX
	3jZbjuweOYNfpV/by1hIas/oQHUiev+Pb60Z+SnwZUnjcdRiiV4DMb7kJJnZiq3XeLH7BVJF43r
	Qgq3gDt+O/FXGRGlm2KWXze7lKAS1CAqWfghYyJEJyzSc4DspPH+gn3WybaDiqy0W50LzuI
X-Received: by 2002:a05:6402:4307:b0:697:849f:7dd1 with SMTP id
 4fb4d7f45d1cf-697849f8021mr3010930a12.5.1782125603819; Mon, 22 Jun 2026
 03:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com> <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g> <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
 <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
 <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com> <a3bd3514-dab4-49b6-a210-bc7b8ddd701d@gmail.com>
 <CAHwyqnVQwK1w9ap1-e=ii4a-BVOZ=oQtCdkTxB=TJF30kNaZoQ@mail.gmail.com> <ddf37b2d-29b4-4a3c-b7d9-b681af028b24@gmail.com>
In-Reply-To: <ddf37b2d-29b4-4a3c-b7d9-b681af028b24@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 22 Jun 2026 12:52:46 +0200
X-Gm-Features: AVVi8CcKDjVWQsFXYY57QOvlMgXnMb8SNZWyDHTg7-4W8eJrDIzhz8ik1Off-3E
Message-ID: <CAHwyqnWztMhKkDGkfh0cZzT+gAuFZ4_n-vhvJsXrSY1apgqSRQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> clearing the upstream setting of
> merged branches.

Why do we need to do that, they will be deleted anyway since they are merged?

> It also builds a list of upstream branches rather than
> just pruning the set of to-be-deleted branches in the
> refs_for_each_branch_ref() callback which seems a bit wasteful.

Good point.


Harald
