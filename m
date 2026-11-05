Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896580;
	b=QIfC6tvDKKm0a9aW5RdrQtCfYkX2ncUYz4zkKL6JA8x0iEKi1NsIt7Osv3+EtB/CGNIk
	 maYb3QJiY+fAeBBiuQoa0SRFLKVmZE+EM6YsCZNKTcsa8cXLgOmoXQEFIqOWwsE8dFQxl
	 STkjGX0TcNj9N/CzL07QXwVU/PHGuR0cmJsqfSLBe8hS7TvWqKX6KyOClbLhdqIwabnue
	 qCj2/uGJVU6J+ZXhX0cxXvEWY4frfnvpWfM55wCySe4llzzgRwm0g+ctZDuVuD5ogtJ7f
	 /vcEKh6yQ9aPU+OxekjFj57jeqtwCa2lhJB0LHca0P/1ocfSCqXuKO0zJfofHa9fzLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896580;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=mZeHz4zTdgKqAURdRW/+j0IWElLe8PycZfpNnfG9BEg=;
	b=1RpK6+IolC/4x8aAWZr72gNIMuyTdebMJrCMZn71cp40lNETPzQOfmRSsuCYIDHN91Hm
	 JxeJ1w9C62rKh0ndnsn7Cj/AJc/FqxGd8nvrhkNnksWfKv81eTbSMYyQi5/pPAEt7jgNn
	 C+YkxN3PPO43HWxqevg2J587gMxLUL7my/u3h2SoVeVXVgYEgPd8+Pus2S08Gp/qd0JA0
	 ZJf3aVKPMI23IGVtsLIpVxwQBom2uUmoPcQTopXD13exd1F4nJ8GXXCEusGS4nZFd+JLU
	 xb27r+eWpSXXRwfuZCOFMi4+kN0bd17CiX25IN88l6IJkhpIzzzTaCYoq/w7IUgq+cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=I5up3f0R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.120
Received: from sender5-pp-g120.zoho.com (sender5-pp-g120.zoho.com [165.173.182.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC53606B3C2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC53606B3C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=I5up3f0R
ARC-Seal: i=1; a=rsa-sha256; t=1793896564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hAmwn4BkEVeaxozYpA/VwFi80EI4JlnYHr0l5jD4SKCJBEeN97cTsWTWuWiqpioEuKan2oktyrIBxApZpp5yXtuLalQKAp7Es1YkPh14MxlumxU42sDpcbV7riA9+dxcloV1MxSvw5OL7gKe20BOzSasIXhNNqfonQf1XNI0bQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793896564; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mZeHz4zTdgKqAURdRW/+j0IWElLe8PycZfpNnfG9BEg=; 
	b=XI+McmfKOYhFRb5qSBvl3DTnxpkDPX0PLMkVoIhCF0Bh2V2RsYIbHsNvy2qp6dANuOZbxbE4QmTTXGieMZtXHQEvfv2GqHboxd3tiNzD1j40GxP9xgT7VMjAcN5sT5wvFXpxiHxHuIkgEkzR5gHdglnRpWj6rGqVpDvnW5zNOzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=I5up3f0RcuZUUr8fS2DmY5W2ifr7sDd3Qj4hgHcKKMKh7MdMYTNHZBdbQw9snUOP2xB/kaeAmFrnpmitFDV7Dg7BUkCYY/tpjj/kpLKAc9IuS1ClKj2m/nS4Dl8vkAAbUnO5za6Er6zzhERRhzisfd+mabYVxLOjhme/Q4ts5LE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=mZeHz4zTdgKqAURdRW/+j0IWElLe8PycZfpNnfG9BEg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896562485184.01729688739943;
	Thu, 5 Nov 2026 08:36:02 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "brian m .
 carlson" <sandals@crustytoothpaste.net>, Axel Rasmussen
 <axelrasmussen@google.com>, Emily Shaffer <emilyshaffer@google.com>, Josh
 Steadmon <steadmon@google.com>
Subject: Re: [PATCH] ls-remote: add --show-object-format
In-Reply-To: <auyO7lmLKD2OSwnD@pks.im>
References: <20261105104541.790881-1-adrian.ratiu@collabora.com>
 <auyO7lmLKD2OSwnD@pks.im>
Date: Thu, 05 Nov 2026 18:35:57 +0200
Message-ID: <87cxsjxmky.fsf@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Patrick and thank you for the awesome review, as always.

I'll let this sit for about 1 week to also give others a chance to
review, then send v2 addresing all your feedback.

On Thu, 05 Nov 2026, Patrick Steinhardt <ps@pks.im> wrote:
<snip>
>> diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
>> index d71c4ab3e2..1abf7b60b7 100644
>> --- a/Documentation/git-ls-remote.adoc
>> +++ b/Documentation/git-ls-remote.adoc
>> @@ -64,6 +65,13 @@ OPTIONS
>>  	upload-pack only shows the symref HEAD, so it will be the only
>>  	one shown by ls-remote.
>>  
>> +--show-object-format::
>> +	Show the object format (hash algorithm, e.g. `sha1` or `sha256`) used
>> +	by the remote repository before printing the references, on a line of
>> +	its own. This also works for a remote repo without any refs, which is
>> +	useful to find out which object format to use for a local repository,
>
> A bit curious that you first say "repo" and then "repository". I'd just
> drop "repo".

Initially I wrote repository twice then the lines didn't fit, so I cut
repository -> repo to make them fit. :)

English is also not my first nor second languege, so I tend to keep
rewriting multiple times before sending. It's still not "good" on the
Nth read, tbh.

I'll try to improve this further to avoid redundancies, for e.g. I just
realized I wrote "--show-objoct-format" then immediately I repeated "Show
the object format on the next line". =)

>
>> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
>> index fe77829557..6d961f9961 100644
>> --- a/builtin/ls-remote.c
>> +++ b/builtin/ls-remote.c
>> @@ -150,6 +154,8 @@ int cmd_ls_remote(int argc,
>>  
>>  	if (!dest && !quiet)
>>  		fprintf(stderr, "From %s\n", remote->url.v[0]);
>> +	if (show_object_format)
>> +		printf("%s\n", transport_get_hash_algo(transport)->name);
>
> Should we maybe make this a tiny bit more extensible by not printing the
> object format without any kind of prefix? We could for example instead
> print "object-format: %s", which would allow us to add more fields in
> the future without the need to make parsers be order-dependent.

Yes, this is a great idea, will do in v2.

(I just need to know the sha1 vs sha256 information, the format can be
anything at all, no strong preference on my side).

>
> Also, one more question I had is whether we know that the hash algo will
> always be populated here. I would assume so, as we have this logic a
> couple lines further up:
>
> 	ref = transport_get_remote_refs(transport, &transport_options);
> 	if (ref) {
> 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
> 		repo_set_hash_algo(the_repository, hash_algo);
> 	}
>
> But in theory, this logic would also work alright if the hash was
> NULL.

Yes, the hash format will always be populated by the time we call
transport_get_hash_algo() here.

>> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
>> index 2e1d4f7586..7e82154fe4 100755
>> --- a/t/t5512-ls-remote.sh
>> +++ b/t/t5512-ls-remote.sh
>> @@ -332,6 +332,52 @@ test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
>>  	test_expect_code 2 git ls-remote --exit-code --upload-pack=./cat-input .
>>  '
>>  
>> +# Run "ls-remote --show-object-format" with the given arguments over
>> +# protocol v0 and v2, and compare its output with "expect".
>> +test_show_object_format () {
>> +	for version in 0 2
>> +	do
>> +		git -c protocol.version=$version \
>> +			ls-remote --show-object-format "$@" >actual &&
>> +		test_cmp expect actual || return 1
>
> It's a bit weird that we expect the caller to already have written
> `expect`. A better interface would be to have them call the expected
> object format as another parameter.

Ack, will do in v2.

>> +	done
>> +}
>> +
>> +test_expect_success 'ls-remote --show-object-format with empty sha1 remote' '
>> +	git init --bare --object-format=sha1 empty-sha1.git &&
>> +	echo sha1 >expect &&
>> +	test_show_object_format empty-sha1.git
>> +'
>> +
>> +test_expect_success 'ls-remote --show-object-format with empty sha256 remote' '
>> +	git init --bare --object-format=sha256 empty-sha256.git &&
>> +	echo sha256 >expect &&
>> +	test_show_object_format empty-sha256.git
>> +'
>
> We could easily deduplicate these tests by looping around `for hash in
> sha1 sha256`.

Ack, will do in v2.
