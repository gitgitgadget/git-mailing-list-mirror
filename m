Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362E1E9B01
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138346; cv=none; b=V1VthvMZeAQ+Ne++STjQFil7NidbzvoZXZFuZ4HFVKZ3wgLs0ZvayFQx0xraHMygLlWEBmMl3+KULT9u2RKP1ZkJAg1MN9IEuUhELLapNKYU037QVCFI6KCsksR2Sxukt3cHYAZngNCGzO0rPdYjhfCKJtmOG7FCLUKnh2pZNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138346; c=relaxed/simple;
	bh=wnU+DqjVvoZrcUb0vyqtZa6JxPHHXDqi5ysoi/Oomc0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJdRqSb22oP3MblmVrQaveYdmaMBU0dcj19LBfWNLtyAFB4UpA5+HbZA72p/VtOQWHF7luxVHegW/bwbogvnCXrpMMJs9374DKBCZtCDgAEYmpX6LVFSAfFvCmn0BXprE+D3boHEGWxd4OC4HmyeSYGlsb55Okps+OadfFDZ/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoReJK+Q; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoReJK+Q"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4bd367926easo631073137.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740138343; x=1740743143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8OCxg5qsuda3UhwEYL/hgStgEiHtJkhsiHlsSTAv9s=;
        b=SoReJK+QbMWmyELMQm6EM0ncWZah/0vS0CNP97LmE7hBB3oBorWBeBk3ZvA/aLvSKT
         XBP3lpKeexbBeVme7o62L1Ad5mnbJmQ9Donkq5cd2Qjy8RyZVQondGLBJWMHZKqTpDym
         gPzPpD70rxXyAmPnpj0EywzllSsqZCd8o9iVBP6bg25u958wAuasW5IB9C/ZJranx/2e
         9otHmwRuuvLFM13HO3sGUdEjAy97t6CldEmVgkZHXsHhPxyostt42hOCa3+s3zhDDJ9u
         p1hIfad6C7P65dIcbk9XdEgrbpG/EU7Mu5HmSekPdHkYdxSfRcDbd7jgMcb4ppGmhBWU
         my5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138343; x=1740743143;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8OCxg5qsuda3UhwEYL/hgStgEiHtJkhsiHlsSTAv9s=;
        b=Q13WuWVeZf75On/HHdfxUWoX5zadLEJ5JM2yeLCCzRtpaEPkb0+cWC98TUDNQ51F5C
         IPF+939ANga606u0FU+045md5Uw7wnXecIqSavmIYJc7aeM/2yzHnTEO5kFSp2BN2vsP
         h2gFSFcZ9q6jGyC+4OPGlQeUWODoBaLYMTSb/c14LSU5RaVRBKiRLx9GFvlyyi+leyqx
         PNPFV75HTt6PljHEqNMCCrhYh3oz/ZB+bjzQeyjaNmufsWo5CfaJsnYDWpZbTo5AVJGM
         sf6ngJ1Lv9xNOB2jauXV3f1LQeL0GcdKTvNucpsdX2u1n7LQcmgLYqvu7GzYPW1cyPPb
         QUOw==
X-Gm-Message-State: AOJu0YwWDHhK0zMgHFZU2S/zkaZ5urXVYI1bQqg8htDVA3BGdMCXLJz7
	dAWzdmtfZiSGcKqE7rzRzfbbJ3+dX8jCkjltSony27fJ8XabfvN5z+9eDOcF29vIAl5TqLwj0BA
	aI0RgQvze2ZzZCOtSVEFSqBjGIvi14+WZ
X-Gm-Gg: ASbGncv1rQw/o+EEsQC9tS9z/Z7l9GdJoAtrtiefCED3MqNT8JWQSYXl2+s7ceeM2F9
	pIisIudaiOUgElxzx1Yzz8MGz6dhytVAc0eL+1dkHWkTzdC1gYZBtgP2iBaUyqbxi7wjigU++co
	q9sfz0tUP9oSWEizOJV8Tgh7eYJdtsLoCKN6LWOp+Mlw==
X-Google-Smtp-Source: AGHT+IHQ/0RFvTwTA1jjY5JjS1sd58ZFD3O1CaZ3b6akLJ06efpRNH3l/COJXOD8HOzDoq36TazeAiFjYQKwrW6hxI4=
X-Received: by 2002:a05:6102:e09:b0:4bb:c490:7d6c with SMTP id
 ada2fe7eead31-4bfc008992fmr1647529137.9.1740138343519; Fri, 21 Feb 2025
 03:45:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 05:45:42 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6YxB6qL8WQFZyWW@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-6-e6a3690ff23a@gmail.com> <Z6YxB6qL8WQFZyWW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 05:45:42 -0600
X-Gm-Features: AWEUYZkxudabeJkFe7QoYPfu4KevB74EnLe5DigEMd_tsCi-_LnxdhQ5d4RnRi0
Message-ID: <CAOLa=ZT_PVwD0=hFEEqxutFyrQRiz3f4iB8019Sax7_nEwrJfw@mail.gmail.com>
Subject: Re: [PATCH 6/6] update-ref: add --allow-partial flag for stdin mode
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d3782f062ea587b7"

--000000000000d3782f062ea587b7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 07, 2025 at 08:34:41AM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
>> index 9e6935d38d031b4890135e0cce36fffcc349ac1d..529d3c15404cdc13216219fba6f56dde91f4909c 100644
>> --- a/Documentation/git-update-ref.txt
>> +++ b/Documentation/git-update-ref.txt
>> @@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
>> +'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z] [--allow-partial])
>
> I think it's time that we start to split this line into multiple lines :)
>

Yes, indeed, will do.

>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 4d35bdc4b4b57937112e6c4c9740420b1f1771e5..83dcb7d8d73f423226c36b61374c86c6b29ec756 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -562,6 +563,30 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
>>  	report_ok("abort");
>>  }
>>
>> +static void print_rejected_refs(const char *refname,
>> +				const struct object_id *old_oid,
>> +				const struct object_id *new_oid,
>> +				const char *old_target,
>> +				const char *new_target,
>> +				const struct strbuf *reason,
>> +				void *cb_data UNUSED)
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +	char space = ' ';
>> +
>> +	if (!line_termination)
>> +		space = line_termination;
>> +
>> +	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
>
> Whew, that's a lot of placeholders.
>

True. More prone to errors too.

>> @@ -723,7 +754,8 @@ int cmd_update_ref(int argc,
>>  	const char *refname, *oldval;
>>  	struct object_id oid, oldoid;
>>  	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
>> -	int create_reflog = 0;
>> +	int create_reflog = 0, allow_partial = 0;
>> +
>>  	struct option options[] = {
>>  		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
>>  		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
>> @@ -732,6 +764,7 @@ int cmd_update_ref(int argc,
>>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>>  		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
>> +		OPT_BOOL('0', "allow-partial", &allow_partial, N_("allow partial transactions")),
>
> You can use `OPT_BIT()` to set a specific bit in a flags field..
>

That would be cleaner, will fix.

>> @@ -749,13 +782,19 @@ int cmd_update_ref(int argc,
>>  	}
>>
>>  	if (read_stdin) {
>> +		unsigned int flags = 0;
>> +
>> +		if (allow_partial)
>> +			flags |= REF_TRANSACTION_ALLOW_PARTIAL;
>> +
>>  		if (delete || argc > 0)
>>  			usage_with_options(git_update_ref_usage, options);
>>  		if (end_null)
>>  			line_termination = '\0';
>> -		update_refs_stdin();
>> +		update_refs_stdin(flags);
>>  		return 0;
>> -	}
>> +	} else if (allow_partial)
>> +		die("--allow-partial can only be used with --stdin");
>>
>>  	if (end_null)
>>  		usage_with_options(git_update_ref_usage, options);
>
> The implementation is quite simple, nice.
>
> Patrick

--000000000000d3782f062ea587b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc4196442c4d722_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lNFoyVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm1FQy85bU1nUFAySlhCTnQ3SksvQ3UxVGh0dVpxZQpaYVVzUVdwMmdI
UE9BUjBXa3dyMm51NDluMzEvSWZSM0NwWGRJOGx0RHZmQnVDcmk5czBpRUNOa0FtUDVkNno3Cm50
UDVZREorRXUvWnFTWEgwcGV2eEpaV0NMQ1FiQkhmZGdCK3ZvR3lHQW9CY0NtWVVNczljemlNSVk3
dVk2NmcKNlRUS1M1a2Rnd0dlSlhLVjNDK1VkMFlWamdaR3pXdWdDOENVNlBnUGR0ZGVZRElOZTRI
UWVPa2RUSmF3S2RpcQpjdy9qWkQraWhYUkxESEdRQmJXRlNLa213NVhRbjBVclpBT2pyVE5oc3lh
V1lqdUlVSjQwVUo5endJS0JweDlpClMwSDBLNmVDZmtxOEViYXovY3lhZnYvMkQzRHJsM2JQbDhR
VnV6RnRVNXoxTmRvWkpHZTNPUFZpcnBQTGh6NEcKUGxDTEZWN1U2YkJDVFp1dEh6QUFSMzRzaStM
RUpmWXFRV3NkdnFmL25NN2FTYktFdUxGMUs1MUtnalRWcjMxRQpPbEhuT0JUelhPbDZKbVhtZzBi
YTRibGZxbFl2SlNZeGpqdXVTaVBlUDB6c3ZJalA2S0VWVXVoUmJmbHZZdXFlCjdoczhTRHVBWnB2
bDZzMGJkUXNDY2N6WUxQQThyRnVRaDdhMFpjQT0KPUpCZEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d3782f062ea587b7--
