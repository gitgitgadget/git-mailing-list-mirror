Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA17D417
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401483; cv=none; b=cl5xKd56UhXWRY/OCkihdGP8b+RFSi92bb76jLgUpkLlJO4ocDJu+Y5MkUcBj2u6a6c1C0a6WrwKv0/BjGoAHZ6mvp9irBTgftkCsE8/wd6So9Ja8SuuAI3puYO9nbtwub+nlecHLbXJhBT7KZftYnzKx+E6wVBdJuO977ygQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401483; c=relaxed/simple;
	bh=ORqfgM4qvdMK6ZxaDZr4/SOv2Pdk/sPApSjF6v82BjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVF31zKZEs+zS5XcZJDuW4a5YBcKk9C0GhJRkZZ2L/z2itjx7jLkuR9mDWpBF2LJr0VEEoBlymFdA+Gog+qKbB6gqrIY+PJtFrtoSlg0O5Ho4lU0mHLZXyYJEqt8wKGhb45h9OFAFqllKvAaiJ2CdsDAcsmm8aFWBYP0vVWRwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pn+fCPHC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pn+fCPHC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC4122FDA6;
	Mon, 29 Apr 2024 10:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ORqfgM4qvdMK6ZxaDZr4/SOv2Pdk/sPApSjF6v
	82BjU=; b=Pn+fCPHCFTIuJZtWTGQZdwDOrHisLji+4LnItthcLMsAHftuAVLClB
	pz5EZ7HGxC2YHHcJL4QSduJVdOi48pBKJeKyDxgOVb0ao7C9BxmM8vci/XDksmQo
	p4IUaKoawSRfspocH5uQEDsS2vbXqE4MuCUsywz+lV5ODVq9kbWhs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B26512FDA5;
	Mon, 29 Apr 2024 10:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A5B22FDA4;
	Mon, 29 Apr 2024 10:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git l10n discussion group <git-l10n@googlegroups.com>,  Git List
 <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,  Arkadii
 Yakovets <ark@cho.red>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Dimitriy
 Ryazantcev <DJm00n@mail.ru>,  Emir SARI <bitigchi@me.com>,  Emir SARI
 <emir_sari@icloud.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Jordi Mas
 <jmas@softcatala.org>,  Peter Krefting <peter@softwolves.pp.se>,  Ralf
 Thielow <ralf.thielow@gmail.com>,  Teng Long <dyroneteng@gmail.com>,
  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.45.0
In-Reply-To: <20240429074151.17385-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 29 Apr 2024 15:41:51 +0800")
References: <20240429074151.17385-1-worldhello.net@gmail.com>
Date: Mon, 29 Apr 2024 07:37:52 -0700
Message-ID: <xmqqa5lc1bgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1038D96A-0636-11EF-9161-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.45.0.
>
> The following changes since commit e326e520101dcf43a0499c3adc2df7eca30add2d:
>
>   Merge branch 'rj/add-i-leak-fix' (2024-04-25 10:34:24 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.45.0-rnd1
>
> for you to fetch changes up to 2cf631412d8c0213151c38c15e2e7e46fb881bdd:
>
>   Merge branch 'master' of github.com:alshopov/git-po (2024-04-29 14:50:23 +0800)

Thanks, all!  Pulled.
