Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91D139D04
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308824; cv=none; b=UPz8GbKKvQIC5/Vw8O4KOho3etZv938nB3fHmXetjBaBkAtTjBR1jKLkse8/0AFIl/VRh1UW8gexoVB1cA17vUcg2m7VnNDLUZwFG2xUByQS0Du9A3CA3ZNul+V3TNAwHcBse4WpFsTqFveqv5+JwNzzKepbAK4sFN5irPGpbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308824; c=relaxed/simple;
	bh=u8SOLMCc8Br0Y4q4sraNcihAlwhTRxi1zw1vEXqnPrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d2AWdihMziS1DVEm4Am1pUV9VosxM7vS/VdgSndd87wzU+z3ByLIRR2qcpNd3YU8SaxMCgc62ekjswoefX2uJiVaS5SBm95GomgTH2gI9pPIp6WE7vDbp3S0cBTWnhUPcmDJijvviJGV3NgzskBq/MvhabqE2o07R+//3RDrFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk5x6u8/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk5x6u8/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a517457163so4598483a91.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713308822; x=1713913622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcYgPfnK6JFXU8LnazCJD+3BaDmao76xIzWEjFVNZko=;
        b=mk5x6u8/o0vzufSmeWlv/itssmCfPk04Ikl248b0uwtGniXsUGJyKidspXNVzuLZp9
         tjF2PAnGdodn84CPeoOy/Kl2KKh6mBn8fwjQg3ccaYq6oPgB5EmMZDy8DD81VwvDEF6l
         kppFpaqNA3Nca+8hm0Rm+Wsxn2yDqLe3sxc/70aqYmE0439jSwZIMBO/mB3OY/Fd+gZu
         4foerE5KmwxLhcOs8E93ecx38iWWYGf8vdWJDRoXaDHz10KC1UA6xXVGmg5IlsYbIXYV
         gBtQRKIoYmAt6M8Aw/+tNOPDc+IC+yp3Pt0bcT0UlJMPpYkIvfMb1PEItNYqWH2JSAmI
         F5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308822; x=1713913622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcYgPfnK6JFXU8LnazCJD+3BaDmao76xIzWEjFVNZko=;
        b=JMP9JfL8tCZuKDNxc15P5Eti0FxtrX7iFVTKYwS5BkRMcR5rSROpyiZBxdbAmnVZA9
         vgZLcVcLv6zuqkBtL5oL5ftIGdsn3R7dvxvx3OmOPcH8Gt2hZlI1xfkKSyUVIE6EuedO
         Qbzm0bVB+A9921ZuiNWuMJ07b7Bpmm0Gh+tZYCdzbY9qekMRP0B8oMgzn5EdpUHR5S8i
         WSJpn230N2yaIGUWr5Us40cDwfAOKsIxtKMeSslce+nyx+60vwrf7XWkGLZoiiwN/ckT
         bD2AsfiPJlk7GMbcSz7lLMrtYPOTjT+0G4caodcwtim7Ukv0TU7tXajpfcGgGHKQcC5z
         e3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvP9oCDMbyxcYgz/lg6iY/fTu8s350ZHCDTCD1a9wTcBNmZd/mj4LBESSbanFT2WihYXClhBXa3kxaxjlOQv3iqxdu
X-Gm-Message-State: AOJu0YwY31QfZbgBmeDyvm24OeEehAkgVYrUZRY5RvJaWSOv1Fi2uufr
	+1+ElccauU/w8xDay/j3sysuMBoPmUv2B/waeGeA4WYegWZ1Lha8X0JQCxht6LhxOmnGETH42Z5
	foA==
X-Google-Smtp-Source: AGHT+IFFQi8X/2dCYJ8OO1lwG75EsQ7Bx9PB5CAlnyaSLapKfWI6+M8ov8C/762Eff/if6PJi2E2CzZ9no4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:180d:b0:2a5:22cd:25f3 with SMTP id
 lw13-20020a17090b180d00b002a522cd25f3mr88092pjb.2.1713308822381; Tue, 16 Apr
 2024 16:07:02 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:07:00 -0700
In-Reply-To: <xmqqjzkwdigv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com> <xmqqjzkwdigv.fsf@gitster.g>
Message-ID: <owlyzfts52ln.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> In the context of _this_ document where the user is working on _git_
>>> project towards submitting patches to _us_, it is far simpler to
>>> drop the above paragraph and tell them how to run the script in
>>> contrib/, e.g.
>>>
>>>     $ perl contrib/contacts/git-contacts <args>...
>>>
>>> without hinting there is anything platform/distro specific, and
>>> instead to have them all work from our sources.
>>
>> Indeed. One small change is that the script already has the execute bit
>> set so I can drop `perl` as $0 (the execute bit is removed when it is
>> copied into /usr/share/... on my system).
>
> We want to be a bit careful here, though.
>
> The script begins with "#!/usr/bin/perl", but on some systems ther
> eis no such command (but /usr/local/bin is on user's PATH and perl
> exists there).

Doh, I already sent a v5. Sorry about that. <wears cone of shame>

Anyway, should I do something like "#!/usr/bin/env perl" or similar as
another patch? It should be more portable than the hardcoded path we
have to /usr/bin/perl.
