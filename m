Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C65680
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321656; cv=none; b=FUNfJRNIlN3AjCPTEYVaz4jKDob+jcY2EafElup69VT3KA0XT69O6AhpeihDkI90oGjxs21c1JUuse5NhT+ryNcYFWhqdEZX+QKo4Cg6smDk70zvF74vHdTgN3s6oELTr52KfAhHeOcAJtjUerhbecszezmxAr6mFQWgn25CcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321656; c=relaxed/simple;
	bh=wpZ8niYJW62Ne6OF/MCiAAN/OOlnc2grSkpaXt18pL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCtHelpv+tkC4EyhryHbAGnS+czsg0cGrkcxSO+LFZ8MnhHZCq9odIqc8BmHs4bkFr8103QpnmEH3LtXfsrx7QYIPdRrhIFIzDJeMKcggzToaSeNu2Ffph9PiHXEgRG5qm3bikrt/bImKu57t4M8P/uPHhSyVMuuaEuDxy7IO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N2R0v+YC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N2R0v+YC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A79A34F13;
	Tue, 16 Apr 2024 22:40:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wpZ8niYJW62Ne6OF/MCiAAN/OOlnc2grSkpaXt
	18pL4=; b=N2R0v+YCW7uQs806w74k5THtQgKAGGNaPtS4z9Yk/lEDEKDW5o8nj0
	hyrWoNDSLJ0bWvvXsulwdrAaO+c/aPQpAprp107cbkFMZhs6iqIslRJ3m1ajI9kL
	rYPmZISrNT31Ws14jsKtyhE646bCl0VCELFuc1zDrilnSmUk+M7Xk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7467234F12;
	Tue, 16 Apr 2024 22:40:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA28534F09;
	Tue, 16 Apr 2024 22:40:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Patrick Steinhardt <ps@pks.im>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Kipras
 Melnikovas <kipras@kipras.org>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
In-Reply-To: <owlyzfts52ln.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 16 Apr 2024 16:07:00 -0700")
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
	<xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
	<xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
Date: Tue, 16 Apr 2024 19:40:44 -0700
Message-ID: <xmqqfrvkd843.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4729450-FC63-11EE-B7B7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Linus Arver <linusa@google.com> writes:

> Anyway, should I do something like "#!/usr/bin/env perl" or similar as
> another patch? It should be more portable than the hardcoded path we
> have to /usr/bin/perl.

The project preference always has been to replace #!/usr/bin/$prog
when installing to match the system's path, without having to assume
that "env" is available and is installed in /usr/bin/

We are not installing this thing (yet), so how about giving an
instruction to run "perl contrib/contacts/git-contacts", only
assuming that the user is intelligent enough to be able to react to
"perl: not found" by installing it on their path?

