Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795088836;
	b=kDcgUzq/mPpLz+sjGT+AHijy7Q5qGnjFaKBk2EalqeTko7HDcUPNn1FEwQfB41E9UHTP
	 DkfdEZ+YsuG2NHIgHHOK31C+QJZ1tsGY8L7dpBOf/pTJc5HTLTizYsGCbfLiMchw5mkv/
	 P8kaabHC+iRm8p1a86L8Opn5RqjqH+XWinTed4QJ0aocRXiKuZEvkUyWODH6STPCV30i0
	 PYRbi4r5Sp17ppqrHJhGOD7iyL/C4fIxUKIf6vUnMklr/r9JpVsXuM25sDlIDlNoj74MW
	 wqPotarDMBszqbXA76ll6KOCDPIsM63TuhWJzg7KzMZnEsNSvsUpvRlFDrWrLsxkl0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088836;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=KRW+2XUYPd97qcKVwSNUHnV+BM6I9e15hpLZ+NEu3+I=;
	b=uyOy0g+CGLdSjw83tTYfZ9VZIkUzmCjJEugoLOjfU9U1l0JYC5PseoCeSQNOPcvzGNKM
	 eCVsrYBT+Pypc9BBxbt0aaAH7EA42lgsK/7sDxWFzRi/XV9E86V/Ki0XESah4t2LmftBx
	 dTi7RDJbHDlXNInZBBJYWO1zx2bYKs5ys77DX5rMscCw67Y/UBtpIzjqmgkOZEnwHGeHf
	 m5uMk7PHZBUR1f3BHN8e//yukN5ajFU/u9IZctnwWV7TfcYMN6rvZaEDUij679txeORxS
	 TDzKwJRdKQkN9iqJrR2e1fG3b5ZAheU+2meQo0L42+g+motEQlQ/a2MpK84dJUY/pnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=OKZsbvP2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
Received: from sender6-pp-f119.zoho.com (sender6-pp-f119.zoho.com [165.173.180.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EB606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 401EB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=OKZsbvP2
ARC-Seal: i=1; a=rsa-sha256; t=1795088819; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HegmvZGasKf/h7XSIm8nFQ0F5BZUZDubZu5E5z3NHC8y9iTbyFFXwtQqch+8RBpn7uM9hbpGEgEVAypPf1IgT0A53Xon/jDYfu3quhUiFsA9DFUQ3+FbRgRTpvoZAU2p2lljxqEvjr/F/hOE8Sg7mRJjOv+ERGZaM6+GjSsjTbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795088819; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KRW+2XUYPd97qcKVwSNUHnV+BM6I9e15hpLZ+NEu3+I=; 
	b=m+GoH9jSTNodvX1/5AyBXpiosdWOErs3MuJpyXYyPxCYq9kPLChGD2O5yEIHaSlD0lMwhjsHrwCTqjCAEl2fB+YF1toUcuPWi6p7KpYwvfV00S8OeEL04kjM9MTUsmxTSZygrbjpATjBVDwZFj8u6JJ6yYeEpcuc3oo4paAIlRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=OKZsbvP2PB7eIsObfLGm2Lk1+pRdKNeZe+kfFUnNRUNIdrn+7R1RUDz1hLiTyWbZD5Xnaf9KKjjIq8xcUSO2wP8QAfZdnbb7a/ZE1/dNRQpYcGqRHDo9/Dc7f1euDR2B0/08qTgsf1Ccyf+LypY9p7f8yosTHgZVa73i65PvYVA=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=KRW+2XUYPd97qcKVwSNUHnV+BM6I9e15hpLZ+NEu3+I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179508881799786.0801293885371;
	Thu, 19 Nov 2026 03:46:57 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andreas Wendleder <gonsolo@gmail.com>, Phillip
 Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] submodule: only suggest submodulePathConfig when it
 is disabled
In-Reply-To: <xmqqzev63pnh.fsf@gitster.g>
References: <avuJBGlB3pRU3JU0@pampelmuse>
 <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261118163249.1693361-3-adrian.ratiu@collabora.com>
 <xmqqzev63pnh.fsf@gitster.g>
Date: Thu, 19 Nov 2026 13:46:53 +0200
Message-ID: <871p8hjb6a.fsf@collabora.com>
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

On Wed, 18 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> When a recursive checkout refuses to use a submodule's git dir, the
>> error message ends with:
>>
>>   Enabling extensions.submodulePathConfig should fix this.
>>
>> This is printed even when the extension is already enabled, which is
>> confusing: the user is told to turn on something that is already on.
>
> The motivation sounds sensible.
>
>> Move the suggestion into a separate hint, as submodule_name_to_gitdir()
>> already does, and only show it when the extension is disabled.
>
> Hmph, but submodule_name_to_gitdir() does
>
> 	/* validate because users might have modified the config */
> 	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
> 		advise(_("enabling extensions.submodulePathConfig might fix the "
> 			 "following error, if it's not already enabled."));
> 		die(_("refusing to create/use '%s' in another submodule's "
> 		      " git dir."), buf->buf);
> 	}
>
> which does not really check if it is enabled; it just hedges the
> message by using "might fix ... if it's not" and lets the users do
> the work themselves, which is not necessarily a bad approach to take
> to simplify our job.
>
> Similarly, builtin/submodule--helper.c:clone_submodule(), which is
> another caller of validate_submodule_git_dir(), has an unconditional
> "Enabling ... should fix this" message, which we may want to give a
> similar treatment.

Ack, I mis-remembered that we already checked the extension.

Happy to reword as you suggested, but for v2 I'd also like to explore
dropping the "hedge" and actually check in all three places, it should
be a trivial helper which reads repository_format_submodule_path_cfg.

>> Reported-by: Andreas Wendleder <gonsolo@gmail.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  submodule.c                                | 10 ++++++----
>>  t/t7425-submodule-gitdir-path-extension.sh | 14 ++++++++++++++
>>  t/t7450-bad-git-dotfiles.sh                |  1 +
>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index d00d820d42..64cd8005f7 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2171,11 +2171,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
>>  
>>  				free(dotgit);
>>  				if (validate_submodule_git_dir(git_dir,
>> -							       sub->name) < 0)
>> +							       sub->name) < 0) {
>> +					if (!the_repository->repository_format_submodule_path_cfg)
>> +						advise(_("enabling extensions.submodulePathConfig "
>> +							 "might fix the following error."));
>>  					die(_("refusing to create/use '%s' in "
>> -					      "another submodule's git dir. "
>> -					      "Enabling extensions.submodulePathConfig "
>> -					      "should fix this."), git_dir);
>> +					      "another submodule's git dir."), git_dir);
>> +				}
>
> It is not exactly a new issue, but this makes an already too deeply
> nested block even worse.  I wonder if the entire "if not dry-run, do
> these" block should be moved to a private helper function to make it
> a bit easier to read.

Sure, I can add a helper here as well in v2. Thanks!
