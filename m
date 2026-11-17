Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794912183;
	b=rK0ppCLgB+ehe9NV0ZpolXBfkL/u7sLvJ74MKCpPXLE5VlNQnrRhuZq05K7bdGwFGLJD
	 Kydk9LoFU4ZwhiulZzAoRZpDCjDaNRmCKTrdKyc59C/wkHS4hoTur+v0ShtPkrESDwc8K
	 w3H2Crip3Mbsnjdoe1+IbPAEBywoQMPHfz4UzTjp9zlibw8d60B2JhqxjgrY0LpIN4nCA
	 R0hdQnYwSEQwZ51c7IKO2NTe+7hf6YxsvmSfxQg3qnr0OWCqRJL8W7l203N0v/MjZi/eR
	 1PEO12f/aFp5wglKFqPgwFU72O1Kztn/wNTK+WG1bR5ETMyMIE6U8ILvfWhsxVlASYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912183;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=IGudq6IUWrw6/bQx0p5Ae3TDbfg5TXEreK1O60rIg0g=;
	b=1KNp0tjUL8mAS1OY8K4yuqjF1aVIhOWkUYzR2amLDZNQUUfwhr128f1vSnt7O7RunYu6
	 nMjDMmx/XqWep+9ZuE6/epHocG6S14fSXhA0I8YKaq2RsoGPzl/QwDe3wZYTjpL46iA6L
	 jkLbFs3BryHvM75awaIdQIH6f2NEszjCMSqcpqj2dOnyk0uEbcRZfBvkEVXgYhvnS8dxf
	 VZfrEQXQQL43zH0iXOxeFaYe9D2P6vxbF79sDAC94PQzc+ClXPR3xpPkU+NCNbBr3itSr
	 lxraUHeIynW3jHvWaaDNd2fJ+9ymM5XShyNqZ3luVjIx8wZUrZ/SxyGABMpwocHruFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MwjbLA1J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.105
Received: from sender5-pp-e105.zoho.com (sender5-pp-e105.zoho.com [165.173.182.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB0606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MwjbLA1J
ARC-Seal: i=1; a=rsa-sha256; t=1794912149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kfePPz5/XaVCfJJNBpYqz43rnaP0h8CNRRoNGlTpPdTOhv1DEi17oT7hvQytMZu39DDQshBjYaEsmJ6+poWmalG0yH3AwCp+Foa6KKjJ5mRSafcUBGgJjN/muvIfABCTVQsVEZpJighS8B6SjmKEVIov3zyLWJrA897Z5rT688U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794912149; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IGudq6IUWrw6/bQx0p5Ae3TDbfg5TXEreK1O60rIg0g=; 
	b=kx7X2u6iZZurJcBVppm3NLx1hnqgHjNnfbij0/HGxjMSIguOLZmPEtcovp0rYMz/jnU/y6/w9vJf/PVPCGVvZgGpXuCL8tXoPuxwZkUq8BZ/jVsI4ftiOlsFqUcXHkevMaYuolm6mUokSn+RjNHD4INkCSeZd7QcGMfzgpiqby4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=MwjbLA1JFRgVGOV6jPNy/ZGtXLxnT63M5ndgC0ovKU9q+VXPOrx/aPAPHUH1rXBdMbqWgx5tzkAtNmJCv4J8hJX6Iru28vuKAzwP6XRSy1nh4gxbM6rAK9fLf2pf3pS8iY/wBBWqz9Xx0Li7qiBnl3IKFoaF8tayMtcSZIKB+9k=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=IGudq6IUWrw6/bQx0p5Ae3TDbfg5TXEreK1O60rIg0g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794912146709185.7163319889828;
	Tue, 17 Nov 2026 02:42:26 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "brian m .
 carlson" <sandals@crustytoothpaste.net>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Axel Rasmussen <axelrasmussen@google.com>, Emily
 Shaffer <emilyshaffer@google.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/3] setup: reject compatObjectFormat == objectFormat
In-Reply-To: <avqyiXdZIFoJbw34@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-2-adrian.ratiu@collabora.com>
 <avqyiXdZIFoJbw34@pks.im>
Date: Tue, 17 Nov 2026 12:42:21 +0200
Message-ID: <87ik1vkacy.fsf@collabora.com>
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

On Mon, 16 Nov 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Nov 12, 2026 at 09:57:38PM +0200, Adrian Ratiu wrote:
>> diff --git a/setup.c b/setup.c
>> index 186815c780..52a9462edd 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -918,6 +918,13 @@ int verify_repository_format(const struct repository_format *format,
>>  		return -1;
>>  	}
>>  
>> +	if (format->compat_hash_algo == format->hash_algo) {
>> +		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
>> +			    "extensions.compatobjectformat",
>
> We should rather say "extensions.compatObjectFormat" here with proper
> casing, as this is user-facing.

Ack, will do in v2.

>> +			    hash_algos[format->hash_algo].name);
>> +		return -1;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
>> index 69723b88ff..858aea62a5 100755
>> --- a/t/t1302-repo-version.sh
>> +++ b/t/t1302-repo-version.sh
>> @@ -98,6 +98,20 @@ abort 0 noop-v1
>>  allow 1 noop-v1
>>  EOF
>>  
>> +for hash in sha1 sha256
>> +do
>> +	test_expect_success "compatObjectFormat equal to objectFormat $hash" "
>> +		test_when_finished 'rm -rf same' &&
>> +		git init --object-format=$hash same &&
>> +		git -C same config core.repositoryformatversion 1 &&
>> +		git -C same config extensions.compatObjectFormat $hash &&
>> +		test_must_fail git -C same rev-parse --git-dir 2>err &&
>> +		test_grep \"'extensions.compatobjectformat' is '$hash', the same as the object format\" err &&
>> +		git config --file=same/.git/config --unset extensions.compatObjectFormat &&
>
> Nit: do we maybe want to use the modern alternate `git config unset`? If
> so, we should probably be consistent and also use `gi tconfig set`
> further up.

Ack, will do in v2.
