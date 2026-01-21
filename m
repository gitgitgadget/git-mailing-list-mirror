Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F79342177
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002053; cv=none; b=reS/saguXgJCjFSOWrTVRf+qXQ9RNADw+Fz7VYCvcFAFohlCqaLtMNsxNTiA4Nf4j2KWKe7tjD/fHK78lIZOSZtdQXZnuu/9N2U1YSpNj3pLwKTL64DrxoOobH7sh5g8oQn9dlEE2CjJ7folTPZ1H9nGgO7wcrdnYIfCvQt2ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002053; c=relaxed/simple;
	bh=mdUw/wbyRzPR0wa6Rsgfh6WzXovLLHhBdsE2Ls2gzfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8beaRJgjX03a0aNZUvL7v9RzVIA2AiQnSpr/V0XmM6/0CM8ek9dL3ZKsxXTPJWDkm2y2S8PP62RYSGNkd76j/YYec4Onn4SbqkM0PhOOCDJ84X7HM33zaBN+0Ph8AGfiWMwz0DGfCjdJ2r2tlU3iQ128cBnNKoA+B8v8EsgIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=f+adwX6M; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="f+adwX6M"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 8F4624D9B1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 14:27:21 +0100 (CET)
Received: from [192.168.3.191] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 67D0878035B;
	Wed, 21 Jan 2026 14:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769002034;
	bh=mdUw/wbyRzPR0wa6Rsgfh6WzXovLLHhBdsE2Ls2gzfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f+adwX6Mhf1sYoz8lhqQhFYdCyWfAyFM7w3bGCmjskP99uLtzFW5q1kXBwEQpgkTU
	 Dtfeci7BD15hbI9xRE7Fj6ydcqRNG7Op04EavwnJq74duVkOEnX8QLsPuMsWaRc8Kr
	 YOCBfYDOGK1V8JeIT6ZXVbzrDEeluWhHFE9cVx+7bUV0wdSgAG/K0CMD7InYZ1h0hD
	 WWAqmafhSav3UxlC8LvVgWyqkEsbWzaf/RmbdcFcgZE06UA4CQptjOPXKzeN31p2nO
	 Nys5DuwNCmJrPNrZF5F5rvlGxm094wlLZiDKb8T9xUTQqmKiCjCr7Ems1AmiWIcvEr
	 oH1QpDJHs/FCA==
Message-ID: <adfdcc47-470a-4424-9268-31699decee16@free.fr>
Date: Wed, 21 Jan 2026 14:27:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
To: Junio C Hamano <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Elijah Newren
 <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Sergey Organov <sorganov@gmail.com>
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
 <xmqqldht2fgd.fsf@gitster.g>
 <CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
 <xmqq5x8w2t3o.fsf@gitster.g> <xmqq3440x8da.fsf@gitster.g>
 <xmqqy0lrx4l2.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr, en-US
In-Reply-To: <xmqqy0lrx4l2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/01/2026 à 00:11, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>>>
>>>> If I've understood all that correctly, then I have the Python version
>>>> installed for building Git and it understood the syntax. Given that
>>>> the Ruby version is newer, I think it should also work against the
>>>> spec.
>>>
>>> We have CI jobs to catch the differences so hopefully we know soon
>>> enough if one is so badly broken ;-)
>>>
>>> Thanks.
>>
>> We didn't have to wait for CI jobs.  You can try
>>
>> 	make -C Documentation lint-docs
>>
>> which reveals that somebody is not expecting these multiple things
>> there.  I think Documentation/lint-gitlink.perl needs updating.
> 
> Perhaps something like this.  Haven't thought things through to spot
> negative ramifications, though.
> 
> The original comes from f81a574f (doc: test linkgit macros for
> well-formedness, 2025-08-11); its author Cc'ed for better ideas.
> 

The initial motive for this script was to catch malformed linkgit
occurrences that were present in the docs: stray git-foo[1], without
the linkgit macro and misnamed gitlink:git-foo[1]. Not knowing what
would come next, the regex was coined very broad, with the assumed risk
of raising false positives.

The issue here is in handling the ifdef macros which are block macros
and are more easily detected as such. I would reject preemtively lines
with '^ifn?def::' instead.


----- >8 -----
Subject: [PATCH] lint-gitlink: preemptively ignore all /ifn?def|endif/ macros

Instead of testing if the macro name is ifn?def:: as if it were a inline
macro, it is faster and safer to just ignore such block macro lines before
hand.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/lint-gitlink.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index f183a18df..b5d982e8e 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -41,10 +41,11 @@ sub report {
 @ARGV = $to_check;
 while (<>) {
 	my $line = $_;
+	next if $line =~ /^\s*(ifn?def|endif)::/;
 	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
 	    my $pos = pos $line;
 	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
-		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
+		if ( $macro ne "linkgit:" ) {
 			report($pos, $line, $target, "linkgit: macro expected");
 		}
 	}





