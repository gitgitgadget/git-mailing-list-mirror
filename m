Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038094C83
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649682; cv=none; b=KPYS/P0XWVS3hFO07i4RFM9BRVG8WMsOCsHfj4bQQk85tgoMGoGF1hMhgMqoOiM/6w4ZaocAH/iZ4BwnZbQikH+galdr7lmzTHRCt4QkeZwKe2nieTCd8r+rozcGAMabxfeME/OdpmDyA2aFmJ+S95Arlu4jCP+AQ2zgiiUULWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649682; c=relaxed/simple;
	bh=Dl2UlC9V2LZSQ1XIbJIXRtjEPBp3THf/YlWHVTz1SX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CaZq01UNeE0E2D4QVWI9+SrJKKBvHKXw40TGnCKLshWGMRd5mt2cJDYpGVL+MS9M9hf/TM4RxkA68ycyTOXi9MA3+AmjfnA7DRfUZ+gryyETqRRHd7E4az8JPqykxqBL5l4wqfmJf6WCTEI3OqfrbrUn0tHHO5fnNAJk/r9PmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=EdXOKlKL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="EdXOKlKL"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTXx3-007KRN-Om
	for git@vger.kernel.org; Mon, 23 Jun 2025 05:34:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=b1ZoSPzaRGoOdAX0tDQWPaFJoCcCZE+3KOTYfw+QEfk=; b=EdXOKlKL0uQcACJLuQME1A7gh1
	DuknGZJydImzokyCIiji3Qhc2Tz9bcJCz+KFmHvY5u+j6wN0S+ZLLZaWG9bVi77NjhFR2HTKSAqNS
	a6LPtdq8spCn2ZIYqMMD6nHIlEgZTZGCg06ti9c40VwlOmCfjPWrp0tBtaArWmcTURgTDQWGza0RZ
	Z+/x132NZ/rxsP8YPkQa+eOFTuEz96VN/wDAANy6ngQoWKodjfdjI8Zm8Dx889eEEmlCpqlAWvBXT
	DlaklZKInzR1HAePSSTnTuq3yqwCXZZ6E8hvZ66gp/q/pCVt25HG80OCUPUBdIhzczuLl0w2K0J4+
	UUpuj0WA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTXx3-0000SI-Cv; Mon, 23 Jun 2025 05:34:33 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTXwr-007xw7-8E; Mon, 23 Jun 2025 05:34:21 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <xmqqmsa27cdn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Jun 2025 06:48:04 -0700")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<xmqqmsa27cdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 23 Jun 2025 12:34:17 +0900
Message-ID: <871prbf7wm.fsf@terra.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

tldr; all changes discussed implemented in posted v2.

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim@guixotic.coop> writes:
>
>> Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
>
> Please downcase "Honor" and drop the final full stop, per convention
> (see "git shortlog --no-merges --since=2.months" for examples).

Done.

>> Symbolic ports were previously silently dropped, which made it
>> impossible to use them with git-credential-netrc.
>
> Wouldn't it make sense to issue a warning message when a defined
> $nentry->{port} is not unrecognized?  Wouldn't it make sense to
> do so even before we add this new feature?

I agree it's subpar that the current code silently drops the port when
it doesn't match the expected form. Since port values aren't validated
in 'git-send-email' at the moment, a proper fix would be to have routine
to validate ports in a common library and applied everywhere a port is
read from the user or a config file, ideally, in git-send-email or
elsewhere.  Maybe it could live in Git.pm ?

Edit: Done.

>> This is a supported
>> use case according to 'man git-send-email', for --smtp-server-port:
>>
>>    [...] symbolic port names (e.g. "submission" instead of 587) are
>>    also accepted.
>> ---
>
> Missing sign-off?  See Documentation/SubmittingPatches

Done.

>>  contrib/credential/netrc/git-credential-netrc.perl | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/credential/netrc/git-credential-netrc.perl
>> b/contrib/credential/netrc/git-credential-netrc.perl
>> index 9fb998ae09..ad06000b9f 100755
>> --- a/contrib/credential/netrc/git-credential-netrc.perl
>> +++ b/contrib/credential/netrc/git-credential-netrc.perl
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/perl
>> +#!/usr/bin/env perl
>
> An unrelated change to introduce the use of /usr/bin/env in this
> patch is unwelcome.  Besides, this is a source that is processed
> by the nearby Makefile, which uses the toplevel genererate-perl.sh
> to turn the "#!.../perl" line to name the correct $PERL_PATH before
> the build product gets installed, so I suspect that this change is
> totally unnecessary.

It was necessary on my system to test the uninstalled version, which I
simply symlinked to ~/.local/bin/git-credential-netrc for ease of
testing. I've split this small change in its own commit. Using env
in shebangs instead of hard-coded locations is good for portability in
general, and the generate-perl.sh substitution will work still.

>> @@ -267,7 +267,9 @@ sub load_netrc {
>>  		if (!defined $nentry->{machine}) {
>>  			next;
>>  		}
>> -		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
>> +		if (defined $nentry->{port} && $nentry->{port} =~ m/^[[:alnum:]]+$/) {
>> +			# Port may be either an integer or a symbolic
>> +			# name, e.g. "smtps".
>
> Do we know symbolic port names are always limited to alnums?  Or on
> some systems some byte values in the fringe, like "_" or "-", are
> also allowed?

Looking at /etc/services on my system, I see hyphens, indeed, e.g.:
're-mail-ck'.  That's now handled by the `is_port' predicate, which uses
the getservbyname(3) call to determine if a non-numeric port is a
valid service/symbolic port name.

I've sent a v2 revision which hopefully addresses all of the above
suggestions/changes.

-- 
Maxim
