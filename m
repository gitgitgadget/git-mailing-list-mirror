Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832D7478
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771665419; cv=none; b=Vv14PBRzygjdQyWMgNTcjJNcZwdLJd3PaVj9FwjkNVgznxDrt9mnP7HtXuIc3oqUe6DDeLbfBsRc/fal3bJSmvqe13OWBhuwLMhFcdjrBvZXHt166rDu1u6uz10A8ZSEoN+DIGlS6o6ADZAqR5xhAqG+THYHc8rN9WWwcNQ1S8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771665419; c=relaxed/simple;
	bh=BRkDhEV+o7jQDZ0riudQKk6t7BMFTe26SKiVQxcomok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITrEPdWRoW8cMMcXszaFTuBJBMKWnKgpFzx9CU4Qnh+ikOvEkZnbTeaiXnhFEfDcspP722YInWEUS/Cyl6bkg4rIBhB07FcFWd5Ul+HLVA4QLcGoAX1nQzMV7AKQDMQcR/gZUNUSaEngtgRrISaml3uBxGF//hohGPvIcKUAV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=otdx9Idm; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="otdx9Idm"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 0C2061D49A;
	Sat, 21 Feb 2026 09:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 0C2061D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771665416; bh=BRkDhEV+o7jQDZ0riudQKk6t7BMFTe26SKiVQxcomok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otdx9IdmhF736ZKCWOWyovDd3dD5AxkMobO7PqQ1X9z9O/Ss9d91nPUesIKjFc8gt
	 oPo2+nakQLuSvC10E9iu+f9kdqxCqiO1OmybpSThCGhwImOP9YJFRMHY14hKxFs6o5
	 oXQ31IdYAerhif0mru+1+9DvX6B558ITW9G03Yf8=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 8QwiKAd4mWnACAMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 21 Feb 2026 09:16:55 +0000
Message-ID: <319bf98c-52df-4bf9-b157-e4bc2bf087d6@dev.snart.me>
Date: Sat, 21 Feb 2026 18:16:52 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] send-mail: add client certificate options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260220081717.555185-1-dxdt@dev.snart.me>
 <20260220081717.555185-2-dxdt@dev.snart.me> <xmqqh5rbz83b.fsf@gitster.g>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <xmqqh5rbz83b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 01:35, Junio C Hamano wrote:
> This makes me wonder what the use case is for giving separate key
> file with a certificate file with its own private key in it.  The
> documentation above clearly describes what happens (i.e., the
> separate key file makes the key embedded in the certificate file
> ignored), but I cannot quite think of a reason why anybody would
> want to do so. 
I know. The design of the Perl SSL interface is not top notch.

https://metacpan.org/dist/IO-Socket-SSL/view/lib/IO/Socket/SSL.pod
>
> For each certificate a key is need, which can either be given as a
> file with SSL_key_file or as an internal representation of an
> EVP_PKEY* object with SSL_key (like you get from Net::SSLeay or
> IO::Socket::SSL::Utils::PEM_xxx2key). If a key was already given
> within the PKCS#12 file specified by SSL_cert_file it will ignore any
> SSL_key or SSL_key_file. If no SSL_key or SSL_key_file was given it
> will try to use the PEM file given with SSL_cert_file again, maybe it
> contains the key too.
>
To summarise:

  * PKCS12: the key in the cert always takes the precedence
  * PEM: if the key file is not given, it will "try" to read one from
    the cert PEM file

I don't know why anyone would want to put the cert and the key in the
same file, not even openssl impose that, but somehow, somewhere, there
are people who do and Perl had to cater for the kind as it seems.

> The key in the separate file is still something that
> corresponds to the public part in the certificate, no?  The certificate
> can say "The subject of the certificate may use a private key that
> corresponds to any of these three public keys", and the certificate
> file may only have one or two but not all of these three public
> keys, or something?
I think this is why they made the logic that way (at least for PKCS12)
to prevent the exact madness you were describing. Still, I'd agree that
the asymmetry is horrendous.

I'm just trying to expose what's possible with the Perl SSL interface to
the user as much as possible. Paranoid people(like me who would want to
set up mtual vertification to deter bot attacks) would want both PEM and
PKCS12 because major implementations including Thunderbird and K-9 only
accept PKCS#12(imposed by the application and imposed by the operating
system - Android, respectively) while the openssl x509 stack is more
suited for PEM(separate cert and key).

It's a niche, I know. But something tells me that you'd want to push
this feature forward. Thank you for the rest of the comments. Will come
back with the revised patch that I hope may unconfuse you. Good to know
the project is in good hands.
