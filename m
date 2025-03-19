Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C72135C3
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375773; cv=none; b=nvimE10Dkn3S3ZRMCsyWnGSCPkUor6FkkAwpArV/v0UBapFx1oDa2q35OQeSnY2G8A4FoM/uWRZy3taVMtofI952vVj1/iMBM7kFkJY6KL9xLw7o0g68wC+TGAwhMVHF7Ek/WxSlOm39LBSi7XX2z/m61TM6iWNGo6sSjWOus/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375773; c=relaxed/simple;
	bh=/QYNcKjTHTCWQy8rY8Q0vnCKb4oGEvvTNk8Fn+TXqtw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjoJsnr6kLb0mXf0bc2iK5u0vuMHpwSvtH37eOdGXuUOa/PUAQ1IzsuEXpDS+XJoioD5CbCD06K6JJeyskZkKKe3Ufg6aAaLIaPDNpCRWK9U0xO2YwmBpEd8/Loj5UyPZwwDHMc0vk8YnFkSZwZXGp9QGiWMLf1MLvoK7UgS3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/itlQDe; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/itlQDe"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523dc190f95so3215205e0c.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742375770; x=1742980570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOglMw6pbt/hppclOqC32WEULGpQPbmSKDIeRGbYY1M=;
        b=N/itlQDecoVYL2jULrQsnQckIUpMt28WB3CrmGKk8UkhprwdpDJm803Q2/XUQ0QG3i
         dinV335eZ7R04Ha1zztFzHFDJ/r4P1JVOUFdUJGcQsGU1+m/hVY9nDjsnDjxTsH64QKx
         7SPFnF7jpIScpHZuUP+nQpz+OajrF8YvYGCW9tiYrVBIHHEkKe4VQ3R/KolBu4JDQrUj
         G5bgVZ0YLq71uiIb8m5nFS4hplXedvV4RzQXqk7RwVX/heD34LH3I8c4zCGHULGOqnhC
         yijmbO5Zh7fKezxJ/uxO+YLz4C+loXumClh6kKRBKvhff2Aj/1yjRzRT/NWFqtahxQsI
         Ih0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375770; x=1742980570;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOglMw6pbt/hppclOqC32WEULGpQPbmSKDIeRGbYY1M=;
        b=EjcVhHPEI5pbS5I7oBa4M2odgJ4JQ8s1vLImaLQlqQfZ+wUqzO1Lzt1mam4PMxBDrG
         5wM+he9Ug2D4dsCAAbEwsmF9XWTlbFj+D76tBo+W4e/nXXILaVd/UUKGojuuMYe5SJ0S
         FI2e0Y20xQ3MMBmEkmhOHOGjhTg4ZfzhBpTjjxiXCUTjbLmfuh6ZWG132WEgrBZKwsmB
         GqAXXEUhl6dc0sBR45A7BiodIvnqKuyZUIHI4xJVVD+VeuUKosqpnw8m8XJRs526Baq8
         91rqejnlTS0rT1pVJTGvuZd3QsWqwb3+VC8Ptqouj8BdKgOpQqtLebEX/Ti5nFa1qt7l
         HBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlvhkHOTkXyDgo+dldKVzwNqTPLGK8hQlbPMgb9umE9iO4OaKigI1lDXOAr55Xp/Cqeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBjA8B0f2J5z/DCTcTR+u6WIJsL9yE6uLGOpVJuzOR8NflAsF
	aiOdaCQxorGRXdvCORxrV1cEteewtZQCLIIqKZ4cwOSDd5bQcgHTkyNsnEmtWRsuaVDEeQsaGJl
	DWSQOp0zQsBl1EptW6/HXOE4wgol9SuQX
X-Gm-Gg: ASbGncuuDZ1fI3VlSM4PMGTNa55yXBMPIFCfjJCGuQP4M1O0oC7OOIk9lXK8ZcCuBkI
	XSjMgISRI13DC8cTHVwJWZVpqlog4Yia+OfliQjua/cU6MBhiSPPXEf1e6fN4wdCgwqG41PIlrb
	5t9vQTVvjby5R8V9vIkardxjLDXfebZj7UyuJwTZmZNgSVjbPoPsG941Xkui4V
X-Google-Smtp-Source: AGHT+IHa+yRx36/gFtcMvdTnw26z04aj2ZxsQb9H/8plhLrJbEfrdgR1QBX4sIwp9UnDb3/IV/72sowRZbc8hvqldIk=
X-Received: by 2002:a05:6122:4004:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-525890b2accmr1113323e0c.2.1742375770264; Wed, 19 Mar 2025
 02:16:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Mar 2025 02:16:09 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8734fagwn2.fsf@iotcl.com>
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
 <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
 <8734fagwn2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Mar 2025 02:16:09 -0700
X-Gm-Features: AQ5f1JqxDsDxDQPaIuM5lAXpVowAXAZqazgSkRzQH46qsNU3Ch9H5iqunV9ysBw
Message-ID: <CAOLa=ZQ-ndKuYMABLveNjLnbR181+RD9_NGHAJsZbdc9eV2nEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000da3dfe0630ae78cc"

--000000000000da3dfe0630ae78cc
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>

[snip]

>> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
>> +			   struct repository *repo)
>> +{
>> +	int ret = 0, do_all = 0, single_worktree = 0;
>> +	const struct option options[] = {
>> +		OPT_BOOL(0, "all", &do_all, N_("drop the reflogs of all references")),
>> +		OPT_BOOL(0, "single-worktree", &single_worktree,
>> +			 N_("drop reflogs from the current worktree only")),
>> +		OPT_END()
>> +	};
>> +
>> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
>> +
>> +	if (argc && do_all)
>> +		usage(_("references specified along with --all"));
>
> What is the intended behavior when both `--all` and `<refs>` are
> omitted? It seems nothing happens at the moment. And no error nor
> warning is printed, that feels a bit odd to me.
>
> Now, when you do `git reflog expire --expire=all` it also seems to be
> doing nothing at all. I also think this is weird. And I don't see any
> test coverage for `git reflog expire` without `--all`.
>
> But what is the expected behavior when you omit `--all` and `<refs>`?
> Should it give an error or warning? Should it use HEAD, just like `git
> reflog show` does?
>

As discussed in the other thread [1], ideally this should be raised as
an error. I'm leaving it for now.

[snip]

>> +
>> +test_expect_success 'reflog drop --all' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit A &&
>> +		test_commit_bulk --ref=refs/heads/branch 1 &&
>> +		git reflog exists refs/heads/main &&
>> +		git reflog exists refs/heads/branch &&
>> +		git reflog drop --all &&
>> +		test_must_fail git reflog exists refs/heads/main &&
>> +		test_must_fail git reflog exists refs/heads/branch
>
> Should we test output of `git reflog list`?
>

I don't see why, we're concerned with individual reflogs and 'exists'
help check against those individual reflogs.

>> +	)
>> +'
>> +
>> +test_expect_success 'reflog drop --all multiple worktrees' '
>> +	test_when_finished "rm -rf repo" &&
>> +	test_when_finished "rm -rf wt" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit A &&
>> +		git worktree add ../wt &&
>> +		test_commit_bulk -C ../wt --ref=refs/heads/branch 1 &&
>> +		git reflog exists refs/heads/main &&
>> +		git reflog exists refs/heads/branch &&
>> +		git reflog drop --all &&
>> +		test_must_fail git reflog exists refs/heads/main &&
>> +		test_must_fail git reflog exists refs/heads/branch
>
> Shall we test HEAD in both worktrees does not exists?
>

I think it would be a good addition, but I'm not sure if its worthy of a
re-roll.

>> +	)
>> +'
>> +
>> +test_expect_success 'reflog drop --all --single-worktree' '
>> +	test_when_finished "rm -rf repo" &&
>> +	test_when_finished "rm -rf wt" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit A &&
>> +		git worktree add ../wt &&
>> +		test_commit -C ../wt foobar &&
>> +		git reflog exists refs/heads/main &&
>> +		git reflog exists refs/heads/wt &&
>> +		test-tool ref-store worktree:wt reflog-exists HEAD &&
>> +		git reflog drop --all --single-worktree &&
>> +		test_must_fail git reflog exists refs/heads/main &&
>> +		test_must_fail git reflog exists refs/heads/wt &&
>> +		test_must_fail test-tool ref-store worktree:main reflog-exists HEAD &&
>> +		test-tool ref-store worktree:wt reflog-exists HEAD
>
> Naive question: why is `test-tool ref-store` used and not
> `git -C ../wt reflog exist`?
>

That should work too :)

>> +	)
>> +'
>> +
>> +test_expect_success 'reflog drop --all with reference' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit A &&
>> +		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
>> +		test_grep "usage: references specified along with --all" stderr
>> +	)
>> +'
>> +
>>  test_done
>>
>> --
>> 2.48.1

[1]: CAOLa=ZSj11TSTs6CywSX1Q9AAfW28zssS2yrGf8PmBOgd06Etg@mail.gmail.com

--000000000000da3dfe0630ae78cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 583221155cbdce50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mYWkxZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnEyQy9kUlYyMGNscDlRQVVJNWxLNUNPWjVqUVRUagoyMExUVVhjemFw
U2JQSncyRGd1UXNOemQwdFZQWU5kYmYzSk02R3hzd2FydWV0MkdDbDBnR3ZqaXR2QjhyV3lQCnl6
dkVBN0pNVWRmWW96TEg1OUx2S2NuREc4cTNmNmxjRnFkT1hJUHZLb2dyUG44clBjWVp3ZklRL1lK
Wnc5eGYKQ3M0RmVJZGJtTUY1Z3BVSmtPS1pFVmZmRW16MEdZc3FwWDFKL1lnaGM0UDV1N1dDTGtw
ekpuME8xQzBYL3BpUQp4UXNVU1dHcjNkZFl3TmUwWVhzT25JSjUxallyalpxaTFzRmRmMjM2R1Rk
N0RqMnVKZmNsOUxQTmZESXB0bFozClUrL252VVFQRE1wYTl3OVErZUJacnFVaVg4SGF2aEpWWnMv
dUN2T3lWbkpBaTZnVTNyeVp3OVhOSjJzSXd6dUsKeVF1S2hhZ0FQRHFDeFArNUN0clJpUlUxV0N3
R1Z3WVpkaTJKMUNDRnVPL0t3S1JuSy8wMmJ3cU5TUlVudkFRZgpKNFhHL1hHWGFqU1ZsdkFFZlgy
cVF4VHNKQ2twaUxTdkppV3V3VHJ5OTdTSHBDTWwyWEdvRC9udzZvOWwzMkpSCmhUOU5tWG45SXJW
YWhaUmZNN3hTVkR1a2IyM1UxWnZ3aktpTWdBPT0KPURhYnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000da3dfe0630ae78cc--
