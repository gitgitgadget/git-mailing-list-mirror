Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF5243946
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411669; cv=none; b=R/F1msL0ahUQD0dm4dRXagdeEsMfS2FF2KRbtxsQ3t0C53gxXic11Rm05jXeqsNTO8fsfCInEFa06aFIY4dPsY0yM7jJu4mp6C/ypGhGdL/1w1qM0AKYIgBx1hJNj0YqZy2nFyTH8lmh8pdmhgLPQMCbq1fRhurLU5A1cNIm/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411669; c=relaxed/simple;
	bh=KMqe1YaQ/HtYJfk9cjFyk8OPVS13VIcZsDvIJiT2tl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ON6mJymIT8TJzEnIPynrXa8IsZHWNMpwnkjAyjuhUniBQv7aX/A1cmmPpIwaDz1+YvenS1cW3Dbg1rbHFgLyN40/rDZMAaQFKrxn8ZJ+GL8fh4kMzb2TwYeveSQZHtej/HTKv7kLtUlb0wITahlyiayiHpfw2NiBzI8zJwrXsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NRzTwdk0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NRzTwdk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761411654; x=1762016454; i=l.s.r@web.de;
	bh=W4H2beUQ+CAv60NGqUxzayL6YYNqXTj+Ky0nmLp4EuU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NRzTwdk0e8ssKf16bR2BYW9+L06h/HDAKmCeMTI6Jw9hwfJKioOWkz4Wz8y7izl8
	 P2z7rVnFne6eYyjLvhPxlXpgj4gn6slmi8wywJy7r2rTOctPQNQd4xfcoc8pTuEBA
	 c1eFUsARHHsKRMvsywHKjMKsv7UZqIFnzQH1+cdC42C4Jz/rrMhN1tCIrJ6kXtjim
	 WU5wr0RdUtZfJY25O/Dou52wQbgka/il1j1v7BwLk0cYwdie5zBhyu4Bmz0QBg4Ln
	 2BBfzQTghpUTQB3leokMZElmoaL7QG6OZzqq6shXBw17bXu3iNNgKPLnI/AAAsANx
	 OUXVGV1dVqBzn4b+AA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1v6x0d16bF-009OFu; Sat, 25
 Oct 2025 19:00:54 +0200
Message-ID: <5c5c37b6-c3eb-45fc-901a-0f8e7f6d7d0e@web.de>
Date: Sat, 25 Oct 2025 19:00:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git log format documentation/manpage
To: David Moberg <David.Moberg@mediatek.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Ed++g45XoF1tqxcBybSH8sDMGOl4VJ2vMpVlqXDoc6a/ka6CHW
 Q4jQm0xHiYPmJezVkYBt90lICpEobc6yPItupqfRs7EmgLdm9BjUbasvwji46AVtqLwoK40
 ZoJ9hRUklP+kz7ucTC9LpyjL8dZFzb35JxGxs1KmPD9HF4LtOubhi2vW77/d9Y4dn3IJuDn
 UtjyzfsjcFZoSiXcphxoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YpSy9MrUGmM=;ZknGjaoLE5Iyr5GKMKmHkDVsuqc
 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

On 10/24/25 10:06 AM, David Moberg wrote:
> Hi I'm trying to replicate the "oneline" log format and add notes to=20
> it. What I can't figure out:
>=20
> 1. What is the format string that corresponds to pretty format=20
> "oneline"?

=2D-oneline on terminal:        %C(auto)%h%(decorate) %s
=2D-oneline otherwise:          %C(auto)%h %s
=2D-format=3Doneline on terminal: %C(auto)%H%(decorate) %s
=2D-format=3Doneline otherwise:   %C(auto)%H %s

The %(decorate) part also depends on the config setting log.decorate.

> 2. What is the placeholder for the title-line? By searching for=20
> "title-line" in `man git log` I couldn't find anything. Surely this=20
> is in here somewhere? Searching for `full-commit-message` also left=20
> me empty-handed.

%s for subject, %b for body, %B for the whole commit message (subject
and body).  Email terms because Git was developed for Linux and commits
were exchanged on a mailing list, like we do here for Git.

> 3. How can I display notes (%N from `git notes add`) as in-line=20
> information (stripping away newlines at the end)?

I don't think that's currently possible.  You might assume that %w
(wrap) with a huge width would do it, but it doesn't.

> How do I figure out the placeholders?
>=20
> Suggestion for manpage improvements:
> 1. the pretty formats (oneline, short, ...) should come with a
> (t)format string that it corresponds to. They will act as great
> examples.

Good idea.

I would also prefer the named formats actually being implemented as
these format strings instead of being hand-coded -- for clarity,
simplicity and for proving that the placeholders are powerful enough.

> 2. Make sure the descriptions of the pretty formats ("<title-line>",
> "<full-commit-message>", ...) are searchable.
Expanding the current one-word descriptions, e.g., with synonyms,
seems like a good idea.  Care to send a doc patch?

Ren=C3=A9

