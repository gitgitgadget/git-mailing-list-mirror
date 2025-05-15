Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0329898C
	for <git@vger.kernel.org>; Thu, 15 May 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308661; cv=none; b=AEkPVywE07q73WCNHi++7EOgufOPmTZw+LxF7S337sQWl7fGkFrOD5GWd4OVlxS3Psn0eGld2dYFcJd2jI8UbD+15wYj6X/hui/y10OFqFcZVVRLOe2a8Z7vCYiXUFuU8b4+x8kje1Ja+FhiyH+5bYfxvzbVz7rnUaxbTQGh2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308661; c=relaxed/simple;
	bh=6GtmAmsg+KnaezrHUVCSaFUY4Z8DFYbWCeOuqEPPwBs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCO9/Bf5U924kWcHEVetmCutf3IFTbOSr3wf8Zhq4FO83mpeFCMrMbustrJfyKZRUfWcPQa7b6pi9ehMK5DENEn+gTOwmzbrvN2iCZGHPTmKTI/3aRZUq4KM1FlZJtBPQoDspdi0gVzueX/ruXVlK2seQXhod/i/zz/9aaj5K20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqiq4qyQ; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqiq4qyQ"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240764f7c1so250073e0c.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308659; x=1747913459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfmKsirsTSzywabgudqXP97f3YL6f6EK6zz/M/OqRoY=;
        b=Lqiq4qyQpZZrawXB1fPf95Vk7Rs2JBgIuBX+aheosbG86JeFlKZ3vhj+/75O8EaV5v
         JrARuZCy5+xO6s0DSG/XtMa4s0H+Yojm/qnLLmEXYQ6idcLRCAhILinHSz4v4dz77ghK
         C0VTan310uds2CSoFZ4IoSxIbs7KbhURkXP5m6j992eWTalSPjlvohxMV/hhaaw4ioFi
         kF0GrXmH02yT3AT1mACBeekTG7VwG8+T/lNeYCt9LdC8mONxfHQ7EUAY9JfnAk8CJiJr
         uZ8EDeLdW2lh7EbDtiLIZg5bfUy38mowgxe3WKwfv4yeSBi9I1cyXoQuPFyLeW658DVt
         D8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308659; x=1747913459;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfmKsirsTSzywabgudqXP97f3YL6f6EK6zz/M/OqRoY=;
        b=TBQSFRj86hpF7Jo2x3Um6v1bBFVyP8WDwrfBQ6JZgx2oBZzGbvKtSQEcshxjvVXzU0
         UB+fTY12/7fGqGrMMBj8dq4/cccdl9CYB1O8JP26ccClIVmv/zuPnYWM8xfwoyz0uA5C
         S2p/BMMhYLjVBHOYwQO9J49/I95rN+WmVioeFtRhfr89lzV0o1v2iHSSooIFQ9/xpRlw
         Na2Cn6ag95lq28KSX4kTy1nzPsKAHnGkUpf3VaxRIXPVGP5IJkbTSV9SxGw7BEEsgoqy
         cIRyqjXR2KtY/SVrAfezxvWdHKY7qP5me3eCiQr8MIy7fwcBx2AwZUv0ROJ5UjPAjZOd
         vlnQ==
X-Gm-Message-State: AOJu0YyPgnpHS9jhab4kqi3pZ2Hq/zUoC8VUfsD9w6a5jImWCtU+kbS8
	RnncJYCFDw8kmvU4bYJ4rJxm3aU953yM2jyutBqKJmcArpynnCRL52mbcT66SWtxuyNxsM8h68k
	TpxFyqA8tT4K9R0rOhPyCJm3WYyECmHOM
X-Gm-Gg: ASbGncsZ//bDjKmyXXg/2vkscDK4fi5skWkfeW8jq1nw1SOWmBWQYpc+kzQSq9NgHUz
	g80Tz5WiB67LEpNiyBXvpjyeXAz3lQpQ6ZDQdbNghDrM9ljcc5itIPTp6mOjbrJx2fnxpV8R//K
	mF8vxmFtArvZrmg5hjhZCS875wZFp8BPc=
X-Google-Smtp-Source: AGHT+IEaA0CoyUc9vZEt9hBrleewNtk1Tt2z8RW3d1Nn4skbxmlA9nH8gA+NsRDJyVPv6m8Cl2LoJADo7C9Q1vwqczI=
X-Received: by 2002:a05:6122:250e:b0:52a:90d1:ed2d with SMTP id
 71dfb90a1353d-52d9c5c48eamr6455290e0c.3.1747308658722; Thu, 15 May 2025
 04:30:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:30:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:30:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aCSNDbUX-MMJZj5S@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-3-7c65f46493d4@gmail.com>
 <aCSNDbUX-MMJZj5S@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 04:30:57 -0700
X-Gm-Features: AX0GCFsfhlRCNYppbM1K8dRYM5Gfh5cg7lua4jNS7BHC7EoH6b0Hs7TUCyJTGh8
Message-ID: <CAOLa=ZSDvAqiebkHfSV_Z6dNiBzrPU-inxMnFP7-Kzs0VDXOTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] receive-pack: use batched reference updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000eb05a106352aff8d"

--000000000000eb05a106352aff8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

[snip]

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index be314879e8..b4fceb3837 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1843,35 +1843,91 @@ static void BUG_if_skipped_connectivity_check(st=
ruct command *commands,
>>  	BUG_if_bug("connectivity check skipped???");
>>  }
>>
>> +static void ref_transaction_rejection_handler(const char *refname,
>> +					      const struct object_id *old_oid UNUSED,
>> +					      const struct object_id *new_oid UNUSED,
>> +					      const char *old_target UNUSED,
>> +					      const char *new_target UNUSED,
>> +					      enum ref_transaction_error err,
>> +					      void *cb_data)
>> +{
>> +	struct strmap *failed_refs =3D (struct strmap *)cb_data;
>
> This cast is unnecessary.
>

Yes, will remove.

>> +	const char *reason =3D "";
>> +
>> +	switch (err) {
>> +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
>> +		reason =3D "refname conflict";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
>> +		reason =3D "reference already exists";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
>> +		reason =3D "reference does not exist";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
>> +		reason =3D "incorrect old value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
>> +		reason =3D "invalid new value provided";
>> +		break;
>> +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
>> +		reason =3D "expected symref but found regular ref";
>> +		break;
>> +	default:
>> +		reason =3D "unkown failure";
>> +	}
>> +
>> +	strmap_put(failed_refs, refname, xstrdup(reason));
>> +}
>
> I'd have expected something like this for git-fetch(1), as well, so that
> we don't silently swallow failed ref updates. Would it make sense to
> maybe provide an array of reasons by enum so that we can reuse those
> messages?
>

I think you've convinced me of this, As Junio also mentions, I've now
added a function to provide a mapping from 'enum -> char *'.

>>  static void execute_commands_non_atomic(struct command *commands,
>>  					struct shallow_info *si)
>>  {
>>  	struct command *cmd;
>>  	struct strbuf err =3D STRBUF_INIT;
>> +	const char *reported_error =3D "";
>> +	struct strmap failed_refs =3D STRMAP_INIT;
>> +
>> +	transaction =3D ref_store_transaction_begin(get_main_ref_store(the_rep=
ository),
>> +						  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +	if (!transaction) {
>> +		rp_error("%s", err.buf);
>> +		strbuf_reset(&err);
>> +		reported_error =3D "transaction failed to start";
>> +		goto failure;
>> +	}
>
> Okay. We now create a single transaction with failures being allowed.
>
>>  	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>>  			continue;
>>
>> -		transaction =3D ref_store_transaction_begin(get_main_ref_store(the_re=
pository),
>> -							  0, &err);
>> -		if (!transaction) {
>> -			rp_error("%s", err.buf);
>> -			strbuf_reset(&err);
>> -			cmd->error_string =3D "transaction failed to start";
>> -			continue;
>> -		}
>> -
>>  		cmd->error_string =3D update(cmd, si);
>> +	}
>
> So here we only need to queue each update.
>
>> -		if (!cmd->error_string
>> -		    && ref_transaction_commit(transaction, &err)) {
>> -			rp_error("%s", err.buf);
>> -			strbuf_reset(&err);
>> -			cmd->error_string =3D "failed to update ref";
>> -		}
>> -		ref_transaction_free(transaction);
>> +	if (ref_transaction_commit(transaction, &err)) {
>> +		rp_error("%s", err.buf);
>> +		reported_error =3D "failed to update refs";
>> +		goto failure;
>>  	}
>> +
>> +	ref_transaction_for_each_rejected_update(transaction,
>> +						 ref_transaction_rejection_handler,
>> +						 &failed_refs);
>> +
>> +	if (strmap_empty(&failed_refs))
>> +		goto cleanup;
>> +
>> +failure:
>> +	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>> +		if (strmap_empty(&failed_refs))
>> +			cmd->error_string =3D reported_error;
>
> The reported error may have one of there values now:
>
>   - The empty string. Is it correct to set the error string to that
>     value? Shouldn't it rather be a `NULL` pointer?
>
>   - "transaction failed to start". It makes sense to update every
>     command accordingly, as we wouldn't have updated any of them.
>
>   - "failed to update refs", in case the commit failed. Does the commit
>     fail only in cases where we couldn't update _any_ reference, or does
>     it also retrun an error when only one of the updates failed? If the
>     latter, we shouldn't update all the others to "failed", should we?
>
> In any case, it feels weird that we use `strmap_empty()` to check for
> this condition. I'd have expected that we rather check for
> `reported_error` to be a non-empty string directly to figure out whether
> the transaction itself has failed as a whole. Like that, we'd know that
> we only ever do this if we hit a `goto failure` branch.
>

This is silly mistake on my side. This is exactly what I wanted to do,
but instead of:

  const char *reported_error =3D NULL;

I did:

  const char *reported_error;

Which obviously raised:

  In function =E2=80=98execute_commands_non_atomic=E2=80=99,
      inlined from =E2=80=98execute_commands=E2=80=99 at ../builtin/receive=
-pack.c:2059:3,
      inlined from =E2=80=98cmd_receive_pack=E2=80=99 at ../builtin/receive=
-pack.c:2636:3:
  ../builtin/receive-pack.c:1899:43: warning: =E2=80=98reported_error=E2=80=
=99 may be
used uninitialized [-Wmaybe-uninitialized]
   1899 |                         cmd->error_string =3D reported_error;
        |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
  ../builtin/receive-pack.c: In function =E2=80=98cmd_receive_pack=E2=80=99=
:
  ../builtin/receive-pack.c:1864:21: note: =E2=80=98reported_error=E2=80=99=
 was declared here
   1864 |         const char *reported_error;
        |                     ^~~~~~~~~~~~~~
  [31/31] Linking target git-upload-archive

prompting me to do this. Let me fix this. Thanks for pointing it out :)

> Patrick

--000000000000eb05a106352aff8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 94363cf7105a29dc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbDBIQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTdJQy85QmJSWUtROGRFQTZ4akNvQWpwYU43WUV1QwowV2NZODlNUWFC
TGQ0SlhmYVg3Q0xmT0NQSHI0ZjZDemFHaEplRncwbnYxVmtTMFpYTnErbjErVzkreGhJSDVQCmxx
SDlkb3JjVWo4ZmkveXhrbkVHZWVvdmUzUlArbVV0Ri9VK3VZKzB0YkgrWGVTTU1KcS9BVFFQTmtZ
MHRWalgKR3dOZXJTUnFMaFZRazZIU2pMcWZuT3RHQlpsRnZEbGRCcEpleHNLblZxWnpQNFQvaHk0
Q1liVGUrOUVTMmZLSgpNdU9xQWh4WGdIT25DdDNDV2VrYThEditUeTZRZndET05uc01XVzNyQWRC
Q1RQajdKWGQvM3h5ajhndEtpM1RuCmVBbmdXZXZDR0pMRmkyMTZNenJzYjN0amlTMWE0YnVoNEVS
b2pJdGhONlBKMjg1THFac0xMNXZORUR5L0pSWUgKRXlnLzZKeSsvd2FCYlYzQ2o0NEVSUm91MXhl
MDVYV3dhRHg5UzZlQXFYMEMzbjhOWXVqOFZmRm9rZnFLVTBzSQpRR0xSUWFPeWdlci9xcjYvc004
d1Z4Y2lEaE1sRTRMalpKYzBtRm1lWVk3RHluUkt2ZGt3TS9KZXpuOFJkM0pJClJtbFdHMmNucFFG
ZDkrbmViWkhLNXEwY2lNU3RzTjVhVzhtdWtjZz0KPVZjenUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eb05a106352aff8d--
