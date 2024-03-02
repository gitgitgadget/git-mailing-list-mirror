Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195072BB14
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709401491; cv=none; b=io/Tks58ZN/5cuDEKqqHIPA+dto/uahAmugAZQZCSlbP+BkSOumPk47OdLJhfFu3qYSRkjkm2xg7U8X0QcukUJ27YlPtS5kaKXWT6NonjpO16v1vRdMPOiLPBRtQ68taYJSzW7hxg3TNcTh4kbtGf5HwRYq/q+2Xid7+fl5I2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709401491; c=relaxed/simple;
	bh=pAdDcbEDcG5pgpXRo70Bp1H5Iy3g9R3S3/9/DM1XvxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DcXSHPj9/MEaP+2NIasFlIknkXRGB6mE+u+Nc3RmDtfbETsCyXPbVyizUvJCt6QBKvk2g5+Ryf1boyN4BChJbmdpTR3lS6zeWbQBJEfLEd6o0wJvGtZrB3yqrfZ7tKlrvLwAt6kp/6SYLbNBoCEaKU5KCZu0uAa0IprihuMQ5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pwSLkb3Z; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pwSLkb3Z"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B2751E43FF;
	Sat,  2 Mar 2024 12:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pAdDcbEDcG5p
	gpXRo70Bp1H5Iy3g9R3S3/9/DM1XvxI=; b=pwSLkb3Zt7pgZFN2JQop/K1s1fB6
	p1/2rEV/fCB1SxJeAJ+wkqkxLxu30tjsrsUfmz62fubWUEo0a38JRs8Dg3xPEhuE
	s2AVJNVNPtdDZOphOyvJi6kNcqqhkIpBTX9ag5BNNQjNo/tZhdN4iUM1hVDqdQUH
	PvY6eb1tDpbK1jg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5220B1E43FE;
	Sat,  2 Mar 2024 12:44:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEE281E43FD;
	Sat,  2 Mar 2024 12:44:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Eric Sunshine
 <ericsunshine@charter.net>,  git@vger.kernel.org,  Aryan Gupta
 <garyan447@gmail.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
In-Reply-To: <ghr0gtglhd.fsf@gouders.net> (Dirk Gouders's message of "Sat, 02
	Mar 2024 08:07:42 +0100")
References: <20240301204922.40304-1-ericsunshine@charter.net>
	<xmqqsf194n7a.fsf@gitster.g>
	<CAPig+cSt4Q0e+DioFiy7yjBgn5+gWNqQOYc0eCAgdYrZUp8VBQ@mail.gmail.com>
	<ghr0gtglhd.fsf@gouders.net>
Date: Sat, 02 Mar 2024 09:44:41 -0800
Message-ID: <xmqqbk7wy1di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8D1C5A30-D8BC-11EE-9239-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Dirk Gouders <dirk@gouders.net> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Fri, Mar 1, 2024 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>> Eric Sunshine <ericsunshine@charter.net> writes:
>>> > A more accurate message might be "'foo' is empty but
>>> > should not be (or doesn't exist)", but that's unnecessarily long-wi=
nded
>>> > and adds little information that the test author couldn't discover =
by
>>> > noticing the file's absence.
>>>
>>> The "adds little information" version may be
>>>
>>>                 echo "'$1' is either missing or empty, but should not=
 be"
>>> ...
>> I find "'$1' is either missing or empty, but should not be" suggestion
>> clear and easily understood. I'll reroll with that.
>
> This is a view from a position with more distance:
>
> I find that not so easily understood -- the "but should not
> be" part is rather unexpected and I feel, it doesn't provide necessary
> information, e.g.:
>
> test_path_is_executable () {
> ...
> 		echo "$1 is not executable"
> ...
>
> also doesn't state what is wanted and I doubt that message doesn't
> clearly describe the problem.

I cannot tell if you really meant the double negative involving
"doubt", but assuming you did, you are saying that

    With "X is not Y", it is clear enough that we expect X to be Y
    (if it were not clear to somebody who read "X is not Y" that we
    want X to be Y, then "X is not Y, but it should be" may needed,
    but "X is not Y" is clear enough).

So you think "$1 is either missing or empty" is better without "but
should not be" added to the end?  Am I reading you correctly?

I think this takes us back pretty much to square one ;-) but that is
also fine.

But the above argument depends on an untold assumption.  The message
"X is not Y" must be clearly understood as a complaint, not a mere
statement of a fact.  I am not sure if that is the case.

Instead of "X is not Y, but it should be", the way to clarify these
messages may be to say "error: X is not Y", perhaps?

> While I looked at it: there is another `test -s` in test_grep () that
> perhaps could be fixed the same way:
>
> 	if test -s "$last_arg"
> 	then
> 		cat >&4 "$last_arg"
> 	else
> 		echo >&4 "<File '$last_arg' is empty>"
> 	fi

If you are worried about "test -s" failing because "$last_arg" does
not exist, then you are worried too much.  We upfront guard the
test_grep() helper with "test -f" of the same file and diagnoses the
lack of the file as a bug in the test.  And we do not assume gremlins
removing random files while we are running tests.

