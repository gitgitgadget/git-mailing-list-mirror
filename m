Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C293491E1
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718160; cv=pass; b=gPOneFi+t8YBCvmM7PY7KkCGpHg92y/DpL4xLbmsFQtqfYA+XAyWYslGVMybdCtx40st6SnUGNmaEzr2xQYcdH+uA6NgTq6bqdj7SLY7pdqBVHV7F08hS6AELuzlyDlhGZ52ucBgj452qasrwzdMaDeKf8WviuUyjs+lYZbNIzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718160; c=relaxed/simple;
	bh=2DKnegsaCBCk5o+DnbUgQA0+MqBDCCi5QB1+jGJ69dU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG6Orvgt62nK1gu2hglMVKyzKBK6pa8/y/T7Ljy6TYThXQXkUHuNiTEw8iBtAz5B77J8FJtL8hIP5PiJv9hxQOe0H3qJ1lluiQg7q4fyEuMBA/TJIdMGl/YBbENjmin/8R14yeU1rUKEeoP61lrZ8jUsnq5hpb8eF84S8Pdf2Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJHV/0Ns; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJHV/0Ns"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948bff012f0so800608241.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 02:09:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770718157; cv=none;
        d=google.com; s=arc-20240605;
        b=FeYC3ntQPhgwxv5Qj0z9pGbrjQXRNyClGjuL4obiL5cPMlY77zg0yX6auRpTLET1sf
         2xdr+7h1+tfKBy8T/VUPGX7j+21xPbot4of+U3Lc2VdTi9KUqSio5w/FLs8Oa+oH9D/V
         0nn07e88iFR9J7aCRH12Y9koYgaz0jjWRAttglVFnL1B/ymso8IE3feixBMDGu7guGMc
         JAvCJrKKW/+e/98u/atNnY88Ao6B24x3YmpUxtW0B++r0FdUpycwAlflv2HCkQ5MvBpH
         cuh+LyuIJGWRJzFW+nZiPxH/hzZ9V9aq6wSPP4kEgTEf1EVAaXunz/drHEVlR9KAXdTz
         rW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MQ9WuLkb9QHiMlJgTeiIaVd0MKgrNLwEHGCUDYUc/qI=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=fuzJaJL3gQEtvNRKZqt6v4JPFva2CPqd+74sut4wuPrJbScExaodUjH3jFRmSpBFGO
         Lxq+29A5VRZGICLRPUnx15MHABQXh47/KkEXC4Dvlp3nPmxz1TQVj4fyApZ80xkp4dP9
         WmqvCrplYGosjSqDxQPYHD4Axv9g8X+2MYH54S9UHS5MgJreBYVArzZ6TtVoKNzPbsw5
         74Di5ns8vVeZi3IPqtSyoEOLosJh8o3vw2K66QoTdan6PZl40OJlDjqZXYBcbeJHyWbe
         zke5vCIymIaxqekeXGyPNQCoYvAvWxcZSc4h9xzcrF9Tdihkhnqf0IRGXKmmRih3r1oU
         AxXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770718157; x=1771322957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ9WuLkb9QHiMlJgTeiIaVd0MKgrNLwEHGCUDYUc/qI=;
        b=CJHV/0NsEd00g6CY/GbGr0Rn/HB5AlwGNyvv0/Kil+uwA3SUMUekPk6ofToYXwbP7L
         88gBEJUL6gJdMcxBtLYaPV2RTTZbNKXLjbzoPmYw5MdvsMH2/0I4z/HY2/nbQomW9GDz
         4TdyHX/UvNWjida3m1Uwzg0/7D2HZI1RDCRmYXTxzLN3hOJQLo4U70n6WcwTrWUJerZN
         WLxEpc5FQdp3O6qmWIziIINNs/kfBxleBETZ3vFVRjuLBdI3Cmr8yCNAZvKBBKN+a4aa
         csF3/2wYB4QBH1A2T6h0sBLpaTWpwfKiswgef8HGmEL2g4LgvSwXs1MobDslxu6EZMmH
         P26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770718157; x=1771322957;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ9WuLkb9QHiMlJgTeiIaVd0MKgrNLwEHGCUDYUc/qI=;
        b=D5VqMdX+e1PpFK58l68CYyZDT7sRb30OdZopX9qYKKhz9QZSZeWGo5mzWHKaMuXvta
         fRyO0ZgiiL6wXiE6GD9QLxilIF5znRX/v4BI2eOzKabyGKXe4w9GgmD8yXGQUpj2Ry1m
         gwS+GDUa9trOCoAO9hTI9CtZw6u8cqBIXdKwYH8VPPDDRxat1cU47+iRIPPvi7ZnZ72w
         sg2UZpt6sPjbcvjz15n0IvwjkRCEEDdugOZF0dtYWqsnN4O7A4p5GFfAo7eci6cswNu3
         uaZx8QNKKvIL2tplcPTAkxKH0FbPrA555Ghc1Ry8UwfeBlmNcMtrETt19r/msqtoL5E9
         tOoQ==
X-Gm-Message-State: AOJu0Yxl+v6UZ1NAYKX8ojUfoziuq3aGvNTFsinfpf7MeURc6unKChtE
	e98WY8NO66izbjCM+9uYGZRq0DlPd8NZMNMI//KjIkj8nqP5rERwBRj8U1vLPSEUdoaxxerbXmf
	/aX8YNjsd+RsdyxyieUKkaiE9orszBMlnDLvE
X-Gm-Gg: AZuq6aLbqlsXSGiWdZpKw8Vnh6ix+I3605To/6qQmCP0Kjp3H7hTH/aCYxkvS9BC/xL
	9cvqRVsr+IZylF9f0dEslW+X6iXafpxsebyxr6fLtZAU0o+99dnUX9OuugAMAdpX870qV6A/vz1
	jxvQkVMqSo2wFYCYX/T5uS0i/h/mmMMvIArchbBxXqlJcXI88b98E8yV7427Jt+XchTkvoricoN
	gOBehGAU8ivLYtsK0JK3AR/rMiEQimVTuIO5VaXYm6y6ObIFr4qlfp2MY4ci4jbV296OEIzxxte
	OhvDw3QdIGwyi5mcy6PlvBxdIZCWh4G1KEsWfl6Pqywohh3hOqxo
X-Received: by 2002:a05:6102:d8a:b0:5dd:84f1:b51a with SMTP id
 ada2fe7eead31-5fae8c57374mr3479120137.43.1770718157496; Tue, 10 Feb 2026
 02:09:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 02:09:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 02:09:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYoMdqDDbt-BArQQ@pks.im>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com> <aYoMdqDDbt-BArQQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 02:09:16 -0800
X-Gm-Features: AZwV_QhwdE9TWI9iGR0k18-ezTz8vjLuZjH8M41s0fU0Gt1eXvXpX5vZNmDbZx0
Message-ID: <CAOLa=ZTQzckcqOcEgw+4pH+iXFTM3c7QX_tOnVSEujH1VWk4mw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] refs: forward and use the reference storage payload
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000c688de064a75724e"

--000000000000c688de064a75724e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 09, 2026 at 04:58:19PM +0100, Karthik Nayak wrote:
>> An upcoming commit will add support for providing an URI via the
>> 'extensions.refStorage' config. The URI will contain the reference
>> backend and a corresponding payload. The payload can be then used for
>> providing an alternate locations for the reference backend.
>>
>> To prepare for this, modify the existing backends to accept such an
>> argument when initializing via the 'init()' function. Both the files
>> and reftable backends will parse the information to be filesystem paths
>> to store references.
>
> Maybe add: "to store references. Given that no callers pass any payload
> yet this is essentially a no-op change for now."
>

Will add.

>> diff --git a/refs.c b/refs.c
>> index 36f3441632..d9df25d7c0 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3425,3 +3426,33 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>>
>>  	strbuf_release(&path);
>>  }
>> +
>> +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
>> +				      bool *is_worktree, struct strbuf *refdir,
>> +				      struct strbuf *ref_common_dir)
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +
>> +	strbuf_addstr(refdir, gitdir);
>> +	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
>> +
>> +	if (!payload)
>> +		return;
>
> I think you should add a comment here that explains why it's not
> necessary to modify the `refdir` in case `*is_worktree`. I'd arguably
> even move that code into `if (!payload)`, as we otherwise only set it to
> reset it later. So:
>
>         if (!payload) {
>                 /*
>                  * We can use `gitdir` as `refdir` without appending the
>                  * worktree path because...
>                  /
>                  strbuf_addstr(refdir, gitdir);
>         }
>
>> +	if (!is_absolute_path(payload)) {
>> +		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
>> +		strbuf_realpath(ref_common_dir, sb.buf, 1);
>> +	} else {
>> +		strbuf_realpath(ref_common_dir, payload, 1);
>> +	}
>> +
>> +	strbuf_reset(refdir);
>
> And then you can drop this call to `strbuf_reset()`.
>

Fair enough, will do this.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 240d3c3b26..b192ce606d 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>>   * set of caches.
>>   */
>>  static struct ref_store *files_ref_store_init(struct repository *repo,
>> +					      const char *payload,
>>  					      const char *gitdir,
>>  					      unsigned int flags)
>>  {
>>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>>  	struct ref_store *ref_store = (struct ref_store *)refs;
>> -	struct strbuf sb = STRBUF_INIT;
>> +	struct strbuf ref_common_dir = STRBUF_INIT;
>> +	struct strbuf refdir = STRBUF_INIT;
>> +	bool is_worktree;
>> +
>> +	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
>> +					 &ref_common_dir);
>>
>> -	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
>> +	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
>>  	refs->store_flags = flags;
>> -	get_common_dir_noenv(&sb, gitdir);
>> -	refs->gitcommondir = strbuf_detach(&sb, NULL);
>> +	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
>>  	refs->packed_ref_store =
>> -		packed_ref_store_init(repo, refs->gitcommondir, flags);
>> +		packed_ref_store_init(repo, payload, refs->gitcommondir, flags);
>
> It's a bit weird that we end up passing the payload even though we
> unconditionally ignore it in `packed_ref_store_init()`. I'd argue that
> we should either pass a `NULL` pointer as payload, or let the packed
> backend call `refs_compute_filesystem_location()` itsefl.
>

I'm considering passing in a NULL and relying on the 'gitdir'. Mostly
because the packed-refs backend always comes linked to the files-backend
and as such should simply rely on the 'gitdir' provided by it. Let me
know if you think we should go the other way.

>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index 4ea0c12299..028fbc0585 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -212,6 +212,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
>>  }
>>
>>  struct ref_store *packed_ref_store_init(struct repository *repo,
>> +					const char *payload UNUSED,
>>  					const char *gitdir,
>>  					unsigned int store_flags)
>>  {
>
> And here we should probably explain why we don't have to respect the
> payload.
>

Yeah, will add in a comment.

>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index c7d2a6e50b..bd09b1280c 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -666,4 +667,18 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>>  					  unsigned int initial_transaction,
>>  					  struct strbuf *err);
>>
>> +/*
>> + * Given a gitdir and the reference storage payload provided, retrieve the
>> + * 'refdir' and 'ref_common_dir'. The former is where references should be
>> + * stored for the current worktree, the latter is the common reference
>> + * directory if working with a linked worktree. If working with the main
>> + * worktree, both values will be the same.
>> + *
>> + * This is used by backends such as {files, reftable} which store references in
>> + * dedicated filesystem paths.
>> + */
>
> I guess we can say "This is used by backends that store store files in
> the repository directly."
>
> Patrick

Makes sense. Thanks.

--000000000000c688de064a75724e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eac2a88546d268b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tTEE4b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGh5Qy80NmN6RWJ2QkF1cVc5S3NleHpJVDJTT0xTSgpyWWoyT2pDTnhl
YlowclVjYmpmKy93YWFXeG4rRUtXV3ZRV1ZQSXhIb0E5Y2s5dmxrcU5Gd0FQUjVZL0oyZFdpClE0
eHJZeDB0YloyOWdITnhELzZ5UUNrNEtUUmM4OEZIdFBQb3ZOTkxjQWEwVmtSUkxtN0ord1FtSlJj
VmRkRDgKd2w4ZXVrc1NCZ2lOMUpFbTErUDlWYjlSVU0wQzAycFd3TEY0dmxVUWR6SFdRU05Cb2lx
a0FyY0dtL29SR3I1WgpVY1l6WUZHZ2NENnZkYk93TUczNUEzWTJaTVVCV1lGeVUydTQ5SHYyalQ0
K1BtM0VWMnZIWkQ1WElXeDhHWm40CmQ5MWt3OW9YZ3JVdUhla1lYRGlBbm95OWJIUDFGSlR5NFU0
Tys0d3FHNnJsakkwTGFvTGdaTUxGWXBXMDlpOEwKaDBCRXVYRFIreHp5d2VNN0NkaEtGejVrV2d2
Y3Vvakh2b0FneDRKK2hJdlBMOW9RbnhTMDhQVWt5OW04dUxJSwpxa1hCMkU2MENXTXMvNGJmZVg4
aDJHRmptZEwvVjBJMWFWbzdIcFBvZ3pLRTd2dXY4TzhQak1PNFhRNHFJV08yClBtTCttalNZVXJk
NW1pUmgvUmpHTm1pbEZsNjkrRzJreFZ3akJFND0KPTMyLzMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c688de064a75724e--
