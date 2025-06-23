Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35A33E1
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750649319; cv=none; b=mjY25Clx8CHrUUYpclSk4PgIEoIe59LM1lbthXVl5peBnilQxCiP7XRmzlV6nAqwX7G9EikYVAaaXE/T4SEomZ1yOI5hYD6zf1FZCkmxiJRBSTqR8MeBktlBf6XRPWUMecAq/2YRVWosZDdC+HIvB8WC2SQGOTtx2wknyya1mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750649319; c=relaxed/simple;
	bh=5PqZ89eZEMP4U9PcjXi0kzmfQyqkUB4GMcv/v7KPRoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p0uzPWrowr7MpT0TIVV4ONTjwEllCIvQB5YemYIZGk51K5F132Y/cbYnqGXsIxykAeUGCxwsNwOSRso37NAO025PpaB5fjguVb0/OHAH5F8H/68rh0tv8ZQbBS0iysann5HCoDFYzMEf2iqq3u+9eugjUiHQ/HfpFH/+erd+yhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=Jcb3dUfs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="Jcb3dUfs"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTXrC-007Jv7-L4
	for git@vger.kernel.org; Mon, 23 Jun 2025 05:28:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=V1lZDUj17p8fdGcWjvkX+PZy7EN11k0ScGmaEx/MaAA=; b=Jcb3dUfsKmQWuPzpxxZXX6fGBy
	mFunP1uCsgTzslcanyr6sJqOc/SSrFb8U2sMWUIjSoScgZ+dvnXjM5bys8Y0LQaz+Y25EAXmxwzZX
	JZLXEpbZCYsXyJUkA7wcxPRPEnMSNTe1d+ooOBh6TIlWNFESkt0i3FCZE+ZP7e9oBIwljkkXLppdQ
	SHWu+W24J5rpvepLB3iOe3meK7pwLiTC5duulKz3R4Ojpgryb++QjIYwRtYClKwJG6u+fp7nR8mZZ
	8OIe4OsX/5d+ULKOeBMYKY6e4jgjXrFGbbdmzboeesH3XYetfDiErUPuyFMAnukUiWxnghZZ6des6
	F4jzNrDg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTXrC-0003UL-6g; Mon, 23 Jun 2025 05:28:30 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTXr1-005V0a-V0; Mon, 23 Jun 2025 05:28:20 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <xmqqmsa27cdn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Jun 2025 06:48:04 -0700")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<xmqqmsa27cdn.fsf@gitster.g>
Date: Mon, 23 Jun 2025 12:28:16 +0900
Message-ID: <874iw7f86n.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
the libc `getservbyname' call to determine if a non-numeric port is a
valid service/symbolic port name.

I've sent a v2 revision which hopefully includes all of the above
suggestion/changes.

-- 
Maxim
