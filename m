Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7773C46D
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5mr5iwW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 352031BC4C5;
	Fri, 15 Dec 2023 11:44:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ahkQ/zpOJgDNKrjLh6jAHSVmiwKMD1cwxOu6V5
	f5rDc=; b=i5mr5iwWjY5+SewnDXVjQ9VngBAUgEVyJo68oZ6sVsicy3ChycOFeD
	e/0Kn0vAbvDuMb+gf5zNYXL6byeDIvU6YzDhdC1bCbM+VAGWSWd2uP4c55PNFYBt
	9QqARtC3q80CCijTRkEl/ni2W1hdauvCHPDgbBkXBGfGCXBiNhU0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 258531BC4C4;
	Fri, 15 Dec 2023 11:44:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84A1E1BC4C3;
	Fri, 15 Dec 2023 11:44:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v4] tests: adjust whitespace in chainlint expectations
In-Reply-To: <CAPig+cSNZ75WSjxfJFoVPBTkv7yQpxGz1c4ugCyQRLytpNLjig@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 15 Dec 2023 02:17:20 -0500")
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
	<fb312f559de7b99244e4c86a995250599cd9be06.1702622508.git.ps@pks.im>
	<CAPig+cSNZ75WSjxfJFoVPBTkv7yQpxGz1c4ugCyQRLytpNLjig@mail.gmail.com>
Date: Fri, 15 Dec 2023 08:44:43 -0800
Message-ID: <xmqq5y0zmn44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 402D34FA-9B69-11EE-B769-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Aside: I was rather surprised to see this output from git-am when applying v4:
>
>     Applying: tests: adjust whitespace in chainlint expectations
>     .git/rebase-apply/patch:205: new blank line at EOF.
>     +
>     .git/rebase-apply/patch:219: new blank line at EOF.
>     +
>     warning: 2 lines add whitespace errors.
>
> But upon investigating the two "test" files in question,
> dqstring-line-splice.test and dqstring-no-interpolate.test, I recalled
> that I had to play tricks to escape the single-quote context created
> by the Makefile when generating t/chainlinttmp/tests in order to allow
> chainlint.pl to see a double-quoted string. So, the abovementioned
> blank lines are indeed expected output from chainlint.pl given the
> tricks played.

Thanks for being extra careful while reviewing.

