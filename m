Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330023741
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729904; cv=none; b=TJJAWUh+/IMbM5cR0Lq70UkSksG2blrTI/dichecbPx0xEQn5lBvUbtVUgXk2hLTkMEmHHfww6Kl8l3fcWw3StkrO4+juY5fmtQ5nGvW8+2rQITg3iE79Uuf0lPQF+nPAbLRCgmPNb5Ivxg1BjeZOltBIRCkyZPT3oMEsNQq0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729904; c=relaxed/simple;
	bh=PZNC9L9yGPWhDZ/bq9YsnkwmPK/5ZCOnkvC/mnthzWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjCgbWmxQkBf6ikkQCVJh9X9i6HhhpgqLKNnZBdRd16uSxQuFp1wYo4yMiicEpWIbExVei4eVyn5Fladv+XQhX5n01+P0+0XNOxFHtmDPVtdrS+OtQ16l723wmrMRnNj9CdwMfbbtPzpY5rvqyz+sU8UjDA3fZUZFxeX5Oa45JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=gOT4Bdjg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="gOT4Bdjg"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsp1-00A1BQ-4Q
	for git@vger.kernel.org; Tue, 24 Jun 2025 03:51:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=vMJnP3YFm9Z8r3VD6olDBm0Pa1uAU6UdbPdq2sVxqKs=; b=gOT4BdjgSMHVf5MKhrtunGtC6A
	txidMo/Ig90EVfI4Dv6g2sbFQm+kEJGRjGyGlZTnMsJR5jsy/RsiAdllDml206d/oQNrBlFDYoalc
	yraulQ7E8UgAEeTUb7W0yPMJVGDaZbLlfcQTx0a1lh811AfQ0CXf4v+dp623Y0JPS3Cg6VAc44+5s
	M6voXN8alpHJKVeYjlRpCLjG5wjeVQoReUPvwSKX5in1tBC1gnSTZnmzBjbcb7P4AkOHI5mI0rhTu
	mQQ6WCCNWFvrRqQtuWTVHUtlfyymFhoyxgHqV95MHxqDjhBU+qEW1vRQIeOtsBdCAWBro7jeK+ACh
	KYXSh5hA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsp0-0007pU-M6; Tue, 24 Jun 2025 03:51:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTsox-00Dept-03; Tue, 24 Jun 2025 03:51:35 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] contrib: better support symbolic port names in
 git-credential-netrc
In-Reply-To: <xmqqh6065o9f.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	23 Jun 2025 11:03:24 -0700")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<20250622152535.11837-4-maxim@guixotic.coop>
	<xmqqh6065o9f.fsf@gitster.g>
Date: Tue, 24 Jun 2025 10:51:31 +0900
Message-ID: <87o6ud52l8.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi!

tl;dr: I've submitted a v3 with most of your suggestions implemented.

Junio C Hamano <gitster@pobox.com> writes:

[...]

>> diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
>> index 67a0ede564..8a7fc2588a 100755
>> --- a/contrib/credential/netrc/test.pl
>> +++ b/contrib/credential/netrc/test.pl
>> @@ -45,7 +45,7 @@ BEGIN
>>  diag "Testing with invalid data\n";
>>  $cred = run_credential(['-f', $netrc, 'get'],
>>  		       "bad data");
>> -ok(scalar keys %$cred == 4, "Got first found keys with bad data");
>> +ok(scalar keys %$cred == 3, "Got first found keys with bad data");
>>  
>>  diag "Testing netrc file for a missing corovamilkbar entry\n";
>>  $cred = run_credential(['-f', $netrc, 'get'],
>> @@ -64,12 +64,12 @@ BEGIN
>>  
>>  diag "Testing netrc file for a username-specific entry\n";
>>  $cred = run_credential(['-f', $netrc, 'get'],
>> -		       { host => 'imap', username => 'bob' });
>> +		       { host => 'imap:993', username => 'bob' });
>
> Is this rewriting an existing test, instead of adding a new test to
> trigger a feature that didn't have a test coverage, while keeping
> the old test?  I am wondering if we want to ensure that both
> ":port"-less case and "host:port" case keep working even after the
> change to -netrc credential helper in this patch.

That specific test *is* using a port, but a symbolic one (imaps), which
used to be captured as the 'protocol' in the Git credential hash/array.
Now it's captured properly as a port, which is represented in Git
credential by joining it with the host name. The test needed adjusting
for that.

[...]

> Hmph.  It _can_ be used to validate a random end-user supplied
> string names a port, either by being a port number in the valid
> range or by being a valid service name.  But another use case in the
> code after this patch applied that is equally if not more important
> is to ensure that a valid port specified by the end-user is turned
> into a port number.  We should not name such a sub as if its primary
> functionality is to serve as a Boolean "is_foo".  Perhaps call it
> port_num or something?

Naming is hard :-). I like your suggestion. Done.

>> +sub is_port {
>> +    my ($port) = @_;
>> +
>> +    # Port can be either a positive integer within the 16-bit range...
>> +    if ($port =~ /^\d+$/ && $port > 0 && $port <= (2**16 - 1)) {
>> +        return $port;
>> +    }
>> +
>> +    # ... or a symbolic port (service name).
>> +    my $num = getservbyname($port, '');
>> +    return defined $num ? $num : undef;
>
> Wouldn't "return $num" work here?  getservbyname() would return
> "undef" when the given $port is not a valid service name anyway, no?
>
> Or even "return scalar getservbyname($port, 'tcp')" without an
> intermediate variable $num?

I've re-read the doc (perldoc -f getservbyname) and you are right, in a
scalar context it would return an undef value when the service name was
not found in the local database. Done!

-- 
Thanks,
Maxim
