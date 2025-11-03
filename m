Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01259314D3F
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190322; cv=none; b=Apt1XO7dmdZ7lU1+fhsPOpj6eNLKypl1Fju5/DLZumTQxCcCB4ZoLewR4UwKHbsNatv6+4cRuKPzwTrh2vP1JdRBMGHCxdVSClJywaGLx5Qz9fFYIEMvJIUA0OEghrXvMv81xJsHQfYVrndouEotbZ/hOl0bag20P5wzZDXUTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190322; c=relaxed/simple;
	bh=rbXXJiwnwcqj63Y922doRIgNziCgNPxu3a1PdUg2P+c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3m/sTd09e41v75HlY9TKRWfcnOdd4dFGu1hDxNvF7rDLO/4ZZovaJ7iUa4hhP48xhZaOEK9Yagwhaj/wo3UN+L7S+4ismff4qYVwV/PIgbJBwwEafHyXkWvs1Y2DbAMP0LSokPJoeaWC2hnAQmzb5//Npxv96FUOR1NTC67IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWV8rM0+; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWV8rM0+"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5d980e08e06so2903601137.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190320; x=1762795120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wO9Ud8wipHTRMPmitxrNW44mV+9HP+gCSvhOAk5YRs=;
        b=TWV8rM0+SRlNsnYE9OX7UVVSEftFeJyt+pMMB7bQ/jL4/tWdrxwHPo3q4NiXM8L8u8
         MWYudARD/SmLHdWP0vyL+M2LBpwX8OWk4KTdAFK9OVShEBswdSfPXzf/qurhll58Vu+a
         QUFBcJ1QhAGf3aLbSdcsrBQfl3dx6SISuAdp4a/RiRZFmbDz75JFgQOE4j20YAm1S3kA
         sQ84fUJoffonpYYWdEbLrUWWtmcSiew2Et8z8wIWGxr7HvGlRTWC/8v/8jsRHvmKaT0Z
         oTubDTX1Q6IcX9MZ+zzrM01DEGq+MoVa1zMFTZQOkVAC3vq3Drk257cWQUawsS1Xvdxn
         7J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190320; x=1762795120;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wO9Ud8wipHTRMPmitxrNW44mV+9HP+gCSvhOAk5YRs=;
        b=p5eK5RelzR2L1h4xY4ZAOznWNFH98oi8o2mW7w9dkcI1oOgrklyyW1hQJfPRwCsbuf
         yTB4r7T32ld4G5NBXab5WiwIgMzAAy3EQUQsgPT6Spqnyo5AxOPdajNqN3mpAJPQEhZJ
         Y40uELWDqEXbcUDIlrEZxZ5mW2lqfYYAT6UxOazcT32xeVjlHFLYFHChHgAezRx04e+G
         qxjdQ4iLg4SNwYxLgIc3OPNqfRXdzCixbNe9TuItj2Ew3WmAVV2G3f9qogTUk6i0idDC
         bXb7Z3NtB214oFTeZuwHAxrjdfl2boKFPIRkIsqCfPDm/KB0iCpU2ZMAkygRTGlqqKLK
         5MHQ==
X-Gm-Message-State: AOJu0YxBorDB9F/OzUspT6QnhRc0yrUAEJjSt/vbhkr3kf6grbAjgJtL
	ti//5GZIU3c7/QHumBXlX6Ld1gaYPXacfXBy8+u2uLubD6Airkcp2eO7A4n9W4TO2qFV91tQWQb
	DurhAJ/poQhy3sC/Lj58AnaNmVaXzhrAqGTKO
X-Gm-Gg: ASbGncvxVgRCIWg7lVk3u3jgusKSnSL0cEt4brJrAaUt5wMxO0pv8+fah9FXVWVnFfZ
	R0akM5MuYTW/gX5byv2/8l9AV4Ixtb0ek7dWJtk3qmRkPVAXttSPXkoT9/iS1hcaw/PB7nqJNVe
	ZAZIRneXFOWEytAvJrJ8iZMkqZMIKhabf55qCbl/bwTZayA78fZY7dvc1ljJBIuzvlgB1giL7lc
	7gDEcdoWIlUUPse6uanSB/5M0eWQ5r2Wij1UwIsLNZaYt++SOk4NHThnx8DM9NHzEWYl9uqFXJl
	Ll41kpQlg9f+5m9G0dm05n1CDA==
X-Google-Smtp-Source: AGHT+IGqX4fWfQqVpMPP3NdWDuK9mZFaMJVADwqkrfdARuUtsyLv8CZEeIJ+MDAVPB4QgyCp4CIWyW1DOydbxte1L6M=
X-Received: by 2002:a67:e01c:0:10b0:5db:e67b:32c7 with SMTP id
 ada2fe7eead31-5dbe68a7ba3mr717460137.5.1762190319662; Mon, 03 Nov 2025
 09:18:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 09:18:35 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 09:18:35 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQi1g9TX7FoDgo9n@pks.im>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>
 <aQi1g9TX7FoDgo9n@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 09:18:35 -0800
X-Gm-Features: AWmQ_bnMa4_622t-OKBxr26KfR6zfpesOwXRTW_D8o5toGtAMJpe61f2Jy6QGrw
Message-ID: <CAOLa=ZSsEygvz1_aj4KomfF0Jo0vJi3yVLtJbhLX=RLgW6_GzQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] maintenance: add 'is-needed' subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000007d67b0642b3e8a2"

--00000000000007d67b0642b3e8a2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 31, 2025 at 03:22:25PM +0100, Karthik Nayak wrote:
>> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
>> index 540b5cf68b..edcc88f4d0 100644
>> --- a/Documentation/git-maintenance.adoc
>> +++ b/Documentation/git-maintenance.adoc
>> @@ -84,6 +85,11 @@ The `unregister` subcommand will report an error if the current repository
>>  is not already registered. Use the `--force` option to return success even
>>  when the current repository is not registered.
>>
>> +is-needed::
>> +    Check whether maintenance needs to be run without actually running it.
>> +    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
>> +    Can be used along with `--task`. Ideally should be used with '--auto'.
>
> Okay. I assume when `--task` is not given we'll check all tasks
> specified by the configured strategy? Might make sense to document if
> so.
>

Actually no. It's similar to the 'run' command, if nothing is specified,
we check `maintenance.<task>.enabled`. By default it is only enabled for
'gc'. This is important information, I will add it in.

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 72177305ff..4d20487ed6 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -3253,7 +3253,60 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
>>  	return update_background_schedule(NULL, 0);
>>  }
>>
>> -static const char * const builtin_maintenance_usage[] = {
>> +static const char *const builtin_maintenance_is_needed_usage[] = {
>> +	"git maintenance is-needed [--task=<task>] [--schedule]",
>> +	NULL
>> +};
>> +
>> +static int maintenance_is_needed(int argc, const char **argv, const char *prefix,
>> +				 struct repository *repo UNUSED)
>> +{
>> +	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
>> +	struct string_list selected_tasks = STRING_LIST_INIT_DUP;
>> +	struct gc_config cfg = GC_CONFIG_INIT;
>> +	struct option options[] = {
>> +		OPT_BOOL(0, "auto", &opts.auto_flag,
>> +			 N_("run tasks based on the state of the repository")),
>> +		OPT_CALLBACK_F(0, "task", &selected_tasks, N_("task"),
>> +			       N_("check a specific task"),
>> +			       PARSE_OPT_NONEG, task_option_parse),
>> +		OPT_END()
>> +	};
>> +	bool is_needed = false;
>> +
>> +	argc = parse_options(argc, argv, prefix, options,
>> +			     builtin_maintenance_is_needed_usage,
>> +			     PARSE_OPT_STOP_AT_NON_OPTION);
>> +
>> +	gc_config(&cfg);
>> +	initialize_task_config(&opts, &selected_tasks);
>> +
>> +	if (argc)
>> +		usage_with_options(builtin_maintenance_is_needed_usage, options);
>
> Shouldn't this check be directly after the call to `parse_options()`?
>

Yes, I moved it around, will fix it.

>> +	if (opts.auto_flag) {
>> +		for (size_t i = 0; i < opts.tasks_nr; i++) {
>> +			if (tasks[opts.tasks[i]].auto_condition &&
>> +			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
>> +				is_needed = true;
>> +				break;
>> +			}
>> +		}
>
> Okay, we need to guard against the auto-condition not existing indeed.
> This is only due to the "prefetch" task though, all the others do have
> the callback.
>

Yup, that's correct.

>> +	} else {
>> +		/* When not using --auto, we should always require maintenance. */
>> +		is_needed = true;
>> +	}
>
> I guess for now this is good enough, but it's not quite true. Some tasks
> won't require maintenance even without `--auto`, like for example when
> the reftable stack only has a single table.
>
> Patrick

Good point. Thought I'm not sure how we'd go about it. Initially I
wanted to not have an `--auto` flag and simply make it the default
behavior. But that would restrict us from introducing the `schedule`
flag in the future. Which I think might be a worthwhile addition.

--00000000000007d67b0642b3e8a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 67256f142fdb75e2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSTQrZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHRqQy85NG1kdzBrSDl0V0VGT0pwL2JPUXNnc3lDMApjM2t6blVicVZ1
MGxvUk5aTUI3OTBRaXpzMUdpUkNXakNaTFZkamVEYWZiK1V4TGVnY3ZxNWFRQjE4dnZwb1lTClUz
YnpKZ2JLR2d2NlhCakc2ZEMva1FrNFNmaURGa2lxbUlKV3JmUHJ2dDd5VnRmRXhvYTlpRW0yN3ds
Ly90WEcKcDY3b0RZMHBLYnJHZU13QmZLTlNpYVJ2SzJST2JlaHNVTndRblo3dGJmUFhMMzEwcmp0
L0VOaTZCZTFLd010MgpkTm5MUjNBN20wWUhBeEtLUVoxZ3BLY1BCdVJnS1ZlY255N3VyNDZBNFYw
b00vSmYvaUtaWnc2YStMcDRUMDFDCjdicDFvdkdNNHk4ei9TcFZKcjZKQ0VobEFYcFM5MmkvNlVI
cjd3VVdXVUhTZmVKRTRHc0ZwNG1pTXFyOHpDc2UKWDQxTGp6dWVpRGpTNzZhZHRZVkU4MW5ZRisw
V3pFZWVuZWVINVVIa1RRNlZod1dWeC9KQ1MvVnRqdzg4dXhoRAp6R2pIelpSaXNQWGZ4cHhNT1BH
bFo4U3p5Ukc4UE1JbUorNWFJdHhmK0hnbFZ5UUJaL1FTbE5LdWVyd1FpVDR2CkhJSG1GM2lxNFhh
TXczcmpCY0pVbHo5WGFubHF3MGNDOFgyVW5UZz0KPXVQbUQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000007d67b0642b3e8a2--
