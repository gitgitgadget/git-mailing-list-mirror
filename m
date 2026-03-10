Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD523AEF4E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118510; cv=none; b=oxrbb24FLIWMc76wijGKLN5YqNi/fQFNpozkVzg1khAYUSe/mgJadpMoMCDkscBU9KDhcIMdO6lhBzT2fHi4Vws97pI5wFrg7oKA0CUT4yDWp60GhQt2Ka659b3pHSs4KcdJtZzQuPgVmeoVBp4X8ZfUBnWg1XSW4/nI8/aaZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118510; c=relaxed/simple;
	bh=bGx4DLUp1b/t0leJoDB7lL9puub59JLBJrR7D4aclXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSvEAjvYecVe8cVSkv4E5X+8o/gP/Ok2hZFja3lIj8q0WDES8Ogq/UxtOTjAtwGVXXTXS6RTJuahMd1Iux7gZsS9dSPoGOp1B5RSTHx0pDycc39Sj2Xl153bQNj1jaao8L0wmN0eNXUS6uJUTho3bO/XH3xUs/nP1NACTqGoXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=l83S8CWG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OqK1osnC; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="l83S8CWG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OqK1osnC"
DKIM-Signature: a=rsa-sha256; b=l83S8CWGfTfRNMr7Je1e9McaPL35lESPEdofvoAxQ0HZHy0Q4y9ejKLlZd0YoI5a9alCBlSvIvtanzKsv8I10YSU+5fNvlMfMSjh3HokPAgpciawovhdzle476P6WPpAGsE8fHiyAHiOf/GQgxrxkh+G8oCGtKSkwow7ajETIGuN/bqxOjfg4iUAVKMlPFlYXqXY8r/ftVNZDL0wcg6uatZEzW4PzA5jtilpHokCTMWduX2HRe4DOdz28uNrsqrpk6XzhaWuyIJZ/vzS/G1RbtS2J7I4RYqCUPAr5rsvVNUNaxyZ7jNUREHCCpjzna0XANo2QzZAlVCKeUIx7Oge4Q==; s=purelymail1; d=malon.dev; v=1; bh=bGx4DLUp1b/t0leJoDB7lL9puub59JLBJrR7D4aclXA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=OqK1osnCee3t9fVDg1D29/ctEcj6Tv5lKEWJSzlHYmWBRS9QzmLuviKybdezW1oiw7Lg+QveDfCfDuH6tHWsKThI9ZvBKSxy+hukyPtAkMGd998WcN+aQUjNQhb4mzhp5zfR5kycsUkEb+QS1BG22Ya+cP2sRNusi3Id+dgW7s0GTK5ZgKsgPE7biOTsd8J4C19QC8hTtN0xoN1BBLHWdJ2UOu2ZXSm1BfB7YeyGcFDL+qHUHxQVfBwDIUZ7L+x9FUaFm++qGoie9hpnViSxL6cEFP8v06oDoGZ8KeCaD0g67sgX70RAp4iUHV5xwME+ubTUYa3bxrANpQR0W8ASvQ==; s=purelymail1; d=purelymail.com; v=1; bh=bGx4DLUp1b/t0leJoDB7lL9puub59JLBJrR7D4aclXA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1268901863;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Mar 2026 04:55:07 +0000 (UTC)
Message-ID: <fcc68ecb-09b1-4063-bcdf-5052eb42dfcf@malon.dev>
Date: Tue, 10 Mar 2026 12:55:02 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
Content-Language: en-US
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <xmqqh5qswo45.fsf@gitster.g>
 <20260309172719.125419-1-cat@malon.dev>
 <CALnO6CAJfton4KwywVeRFbynWH9zu4nY4c6uXOnEdddKtZpeqA@mail.gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CALnO6CAJfton4KwywVeRFbynWH9zu4nY4c6uXOnEdddKtZpeqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Ben,

On 3/10/26 06:00, D. Ben Knoble wrote:

> Which makes me notice: 3 is the default if the config option is unset
> _or_ if <n> is not provided. Is there a better wording to indicate
> that? Maybe the simplest tweak is to clarify that <n> is the thing
> which defaults to=E2=80=A6 (since a first read might leave the reader
> wondering "what defaults to diff.context or 3? ah, it's probably n=E2=80=
=A6").
> But a glance at other docs makes this pattern seem common while some
> do say "if <n> is specified=E2=80=A6", so idk.

Indeed, the current wording isn't clear enough. I'll make corrections=20
wherever it's needed. I think Junio provides a good template that's=20
great with just a few tweaks ;)

Thanks for the review!

Yuchen



