Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DE33F8B7
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962739; cv=none; b=A1T80slj16KYx2we8ZTdDF+gNvlt+e4bzzYEf6VRTs9+zDD/pHcjoMqFg9/9X03NV1Ko/Hka7y+GW5vnQZxlMhdLvtR+WzTtE3NMPDpiSs5/gFK8ojyHd2RSs2kap/wlmInwN46rwX3uyxZQ4UWsXF4ucReis2+AjzXeelDmccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962739; c=relaxed/simple;
	bh=04z45PLVr2CzrQm2ML7YdIDjbXPVghrA5EL7Dq9iPME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gj0fcO6g4mqkWlGuJhjziGkLo+YmmhDnRxFbp1pFXoPP2ziHoaGn3wnH69aHrUtOZlnD/Jt0qdT6H9ASC5tB45ZqQYY03XhZWgRxV1hvnPXq5vDqPyNnt9d15GJReFAdJGhnDzB/1VSulNFkIfOD5oT/NTyQoXcKhprqB7vikFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=rt0TcsqY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=af+6jZDV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="rt0TcsqY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="af+6jZDV"
DKIM-Signature: a=rsa-sha256; b=rt0TcsqY7ukqzfrXpb0E/tst9i32l3ECM62VwRQ50xMkkJFV/0KIKd2MoPbUo12Z5xKTDkyYg7OmG7yUn/hvvRfviCF1oYgbLFV8Pmcd0sEzLgmaq14eEqkJfQivz+dK32OCaSuVPz1y1wM/yZUuyjrk3bfanUVfOdTCIrJIKSFxaHt6DQTttlDU1EkEHI/rqkVrJOdEUv0sqvWQCRx7Y538/B7RFmn0wxD9nJtRjdZNWyyH2VXVK0xDyjooVXSEYe9IkrGEsbgKNRviQs2ve7z2Ok17atihxa9fxKXVSdCnm6vRxx9ENjGPH4fg1+FOOChLz4+L5P9e4+P+vb/uVw==; s=purelymail1; d=malon.dev; v=1; bh=04z45PLVr2CzrQm2ML7YdIDjbXPVghrA5EL7Dq9iPME=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=af+6jZDVE3MXRzHliawXZ0diYzQHpU7MDg4mhzWFPMsM1RwRtUdc5cyBsJTCjgxySDS64WHFLz50fb2HPYWLO2kDu5BtU6Dqahtr+/wPXYsIxAzJst17sxuhpTOuQJcmL5OKVPxlwQKtJQeuc03ZaYdCfNcDoSH6siwVn1ZnqbNpG4/mtXAIp//pBGZYvAytQvFaO+d4Ls8JpkEH3+T0F6RwnGYFhg9mSCty1J0/MJq+lxq57YWHXTmMyuO+rz1Jdw8gDVeCjDSSpfCkuXlvucFLMGgBf6Nnb/MvCBM6UjZXtesFrSdx60g75PXf+IUdFFZEQOUbARyjO+31MfouVg==; s=purelymail1; d=purelymail.com; v=1; bh=04z45PLVr2CzrQm2ML7YdIDjbXPVghrA5EL7Dq9iPME=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 692769571;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 20 Jun 2026 13:38:47 +0000 (UTC)
Message-ID: <2dc522ee-30cb-4ea8-997b-406aef85f749@malon.dev>
Date: Sat, 20 Jun 2026 21:38:42 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] environment: move protect_hfs and protect_ntfs
 into repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260619163823.652091-1-cat@malon.dev>
 <xmqqo6h6jvuk.fsf@gitster.g> <xmqqjyrujvco.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqjyrujvco.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/20/26 01:25, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> diff --git c/environment.h w/environment.h
>> index fdd9775900..b1ae4a70de 100644
>> --- c/environment.h
>> +++ w/environment.h
>> @@ -127,8 +127,8 @@ int git_default_core_config(const char *var, const c=
har *value,
>>  =20
>>   /*
>>    * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct =
repo_config_values`.
>> - * They check `repo->gitdir` to prevent calling repo_config_values()
>> - * before the configuration is loaded or in bare environments.
>> + * They check `repo->initialized` to prevent calling `repo_config_value=
s()`
>> + * before the repository setup is fully complete or in non-git environm=
ents.
>>    */
>>   int repo_protect_hfs(struct repository *repo);
>>   int repo_protect_ntfs(struct repository *repo);
>=20
> Another thing we should remember (but should *NOT* do while these
> topics are still in flight) to do is to consolidate these comments
> into one.  The hfs and htfs getters are covered by the same single
> comment, but ignorecase and trustexecutable bit getters have their
> own comments, only because they came in different topics.  We should
> conslidate them into a single comment block once all of these have
> landed in 'master', which may happen soon after 2.55 final gets
> tagged.
>=20

I understand. I=E2=80=99ll send the hfs/ntfs fix patch right away, and will=
=20
clean up the comments once all of the associated patches (there will be=20
more in the next few weeks) have been merged into master. ;)

Thanks, yuchen
