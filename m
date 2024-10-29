Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94F194ACF
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217828; cv=none; b=ocMiaYZiWXur5CBobQbRb8XuWMtZlmik8BNOme+Byigye/fGye9jUD4uWPH2HsaU5Gp4Jx/d/j6Iq4n9CZrI6btZ2pKdQcxKvqYvVPJXghEptjnLyhAPHoVmpOXf86Q7XkoYdtHXXBILNWbq8mElFEkbv7LwVIOY8mfsshmmhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217828; c=relaxed/simple;
	bh=V3ToZ4nrMfK6WQIq/HvwNs3tooW3ofJ0a9H9M4vwdWk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abNkxou41+Da+vlFEoNohiPanLx68qiEvh3+rNLxALghq4E5r+zpIHK+asYwVyfXqjV8dJIp1rBBUaHl9+cDaGj+xn6dPwX/H78E50egIBpf5C9+8Hh6oBrLZ93VPbaHndKNGiisyBaHmGOLgltX1eftBufA2iCycY52yD8mOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga3R6CmT; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga3R6CmT"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a484e9d537so1700433137.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730217824; x=1730822624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nchWBOJnBS7cutUzWqFliFVA/qi3PsLuGNDGuVlgLho=;
        b=ga3R6CmTyVPqgQIY6mF61Ri81wztcu2EBBctngKTRGe8yvQ2Ik0w7064Q9NFvCJpxb
         y4BswEg6QN15s5xL4hbS1AtTTivcm2rUa8EzRGjqM5TVt6vEwttuV6GfdPTGwjGLp6PI
         ykew+RtJM2rdN/3AiLiYbHE/gRDV/bBiDHMuRC05DsL3RCQVluXv1Pr6hpaR3RHS5gTs
         6BkiIyO2aZLcGiNCA/1n3p/SGJvAxme9gjhvVw4Oq9Ue7xdBI/sjtjwdkuNk4/Pg82F0
         pPoIFQCjsPnqMWRv7pw+4leefGlOoJDFJ/0wFUYp0vJ2iE6CFEZFXKtw+oq9hYjuJdHX
         CvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217824; x=1730822624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nchWBOJnBS7cutUzWqFliFVA/qi3PsLuGNDGuVlgLho=;
        b=FGzffZNpUJUOOeFZW6IaYP+HK5PiYLLL2bgKgTXagIg5/gYwLAC9i9dX1Nd2gXbPz2
         FdsLA2rw2szDetn/WSmbTH8hMPq0IpqHWhDRQYW3QRhOr3CvCrFDqRSMw60zeMqA2G7u
         QkxsUy+sp1Hwkqv/c3f0weSEMaRdHrABhoo3/1C0UlOfpasopZ+4raMrgfHb5VY2cw7B
         P/sGIBiKrZ1R9F/bFS8QSOTTAsGYmZ8PO01tZ3cdUqq8kkRt/v/+LiL/NZcYIM36TQhL
         RXGxBFa252ZQbAOlx87mG8kPvrE4uH3meTT9v+jrpFBxpYGW9vd5F8Fnvmi0enRaacCT
         Kkdw==
X-Gm-Message-State: AOJu0YxJSJwA79ZUwywQvZYO/jC1PHnwOMiXc24zilA+9vvDGbF+d6nX
	V6xc/UMEQc1grxRa7WOkffBN8AhnCwn023uAam34kSP847mTsm1yB6sQgNprK2FvsUtowteh+NH
	h9rsdAG9cqn/7B8jWxGsdwi92VmXCdfuS
X-Google-Smtp-Source: AGHT+IGYRToSQgctV0bcWXbpZf7du62liayT762qY2TS56LJ8hQvNXIyb5yYra/Mdc0kCLX6AXwOwrASKIlGY89NQ60=
X-Received: by 2002:a05:6122:91e:b0:50d:2769:d741 with SMTP id
 71dfb90a1353d-5101511ccbamr10542263e0c.11.1730217824471; Tue, 29 Oct 2024
 09:03:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 12:03:42 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zx+7wTYEkrKGIIR1@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com> <4e883a4d1ccabb35cc6d122f23a475fca0d71ce1.1730122499.git.karthik.188@gmail.com>
 <Zx+7wTYEkrKGIIR1@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 12:03:42 -0400
Message-ID: <CAOLa=ZTYNpbgveEa=c7Hu6ePauzdG7U_0jDV3MjkFhV5SsC2yg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] packfile: pass down repository to `has_object[_kept]_pack`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cff43a06259fba01"

--000000000000cff43a06259fba01
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 28, 2024 at 02:43:43PM +0100, Karthik Nayak wrote:
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 0800714267..2b2816c243 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
>>  			return 0;
>>  		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
>>  			return 0;
>> -		if (has_object_kept_pack(oid, flags))
>> +		if (has_object_kept_pack(the_repository, oid, flags))
>
> Do we want to use p->repo here instead of the_repository? I think the
> answer is "yes" since in this function we are given a pack "p" and want
> to determine if the given object contained in "p" is useful to pack. If
> not, we want to search for it among other packs here, likely within the
> same repository.
>
> (Again, probably a moot point here since this is all going to be
> the_repository anyway, but just thinking aloud...).
>

I don't think it is a moot point at all. We do want to move up the
layers and cleanup usage of global variables. Reducing the work
required definitely gets us there faster.

>>  	}
>>
>> @@ -3627,7 +3627,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
>>
>>  static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
>>  {
>> -	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
>> +	return !has_object_kept_pack(the_repository, &obj->oid, IN_CORE_KEEP_PACKS);
>
> Here we don't know what pack "obj" is contained in, which makes sense
> since this is a traversal callback, not something that is iterating over
> the contents of a particular pack or similar. So using the_repository is
> right here.
>
> Although... should we be using to_pack->repo here over the_repository
> (in builtin/pack-objects.c)? The rest of the code definitely does *not*
> do that, but I think probably should.

I think so too, I won't change existing code, but makes sense to do it
in our patches. Will amend.

>
>>  static int cruft_include_check(struct commit *commit, void *data)
>> diff --git a/diff.c b/diff.c
>> index dceac20d18..1d483bdf37 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4041,7 +4041,8 @@ static int reuse_worktree_file(struct index_state *istate,
>>  	 * objects however would tend to be slower as they need
>>  	 * to be individually opened and inflated.
>>  	 */
>> -	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
>> +	if (!FAST_WORKING_DIRECTORY && !want_file &&
>> +	    has_object_pack(the_repository, oid))
>>  		return 0;
>>
>>  	/*
>> diff --git a/list-objects.c b/list-objects.c
>> index 985d008799..31236a8dc9 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -41,7 +41,8 @@ static void show_object(struct traversal_context *ctx,
>>  {
>>  	if (!ctx->show_object)
>>  		return;
>> -	if (ctx->revs->unpacked && has_object_pack(&object->oid))
>> +	if (ctx->revs->unpacked && has_object_pack(ctx->revs->repo,
>> +						   &object->oid))
>>  		return;
>>
>>  	ctx->show_object(object, name, ctx->show_data);
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index 4fa9dfc771..d34ba9909a 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -1889,7 +1889,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
>>  		bitmap_unset(result, i);
>>
>>  	for (i = 0; i < eindex->count; ++i) {
>> -		if (has_object_pack(&eindex->objects[i]->oid))
>> +		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
>
> Interesting. I think the_repository in practice is fine here, but I
> might have expected something like bitmap_git->p->repo, or the
> equivalent for the MIDX case.
>
> So I was going to suggest something like:
>
>     static struct repository *bitmap_repo(const struct bitmap_index *bitmap_git)
>     {
>         if (bitmap_is_midx(bitmap_git))
>             return bitmap_git->midx->repo;
>         return bitmap_git->pack->repo;
>     }
>
> and then rewriting this as:
>
>     if (has_object_pack(bitmap_repo(bitmap_git), &eindex->objects[i]->oid))
>
> , but we can't do that, because the MIDX structure does not know what
> repository it belongs to, only the object_dir it resides in!
>

Exactly, I agree it should be achieved from `struct bitmap_index`.
Unfortunately we can't with the current state as you noted.

> And I think that causes wrinkles earlier in your series that I didn't
> think of at the time when reviewing, because it seems odd in retrospect
> that, e.g. we have something like:
>
>     load_multi_pack_index(the_repository->objects->odb->path, ...);
>
> where we pass in the object_dir path directly, but other functions like
> prepare_midx_pack() that take in a 'struct repository *'.
>
> I wonder if we should be initializing the MIDX with a repository
> pointer, so that it knows what repository it belongs to. I suspect that
> we will still have to pass in a separate string indicating the
> object_dir, likely because of the --object-dir quirk I mentioned
> earlier.
>
> But my main thought here is that we should be able to infer from a
> 'struct bitmap_index *' what repository it belongs to instead of using
> 'the_repository' here directly.
>

I also think it makes sense to progress to the goal of removing global
variables in a way where we primarily focus on a single file/subsystem
at a time. And directionally between the bottom <> top levels.

This patch series focuses on the `packfile.c` file, so we cleanup the
file and remove associated usages of the global variable and try to also
follow some form of cleanup as we go. But for other files, it is okay to
still rely on the global variables. Slowly when the cleanup phase
reaches those files, we can give our focus to those files.

So here, it would be nice to have MIDX have a repository pointer too,
but I think we'd be overshooting trying to refactor that in this series.
So I'd leave it as is and focus on that when we get to cleaning up
`pack-bitmap.c`.

> The rest all looks quite reasonable to me.
>
> Thanks,
> Taylor

--000000000000cff43a06259fba01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f87b46550405b262_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jaEIxd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEgwQy85SnZnMmtJUzJFWWxRVXpoV3F1WW9lMTkxbQplMEE4REVKZ1dX
UWVoY2xOYSt1dCs2MktrSkR0aDM4bUl6Z1M0UWVGTGJqYWpHZnU5Tkc4QmNPUDZLQXZ2dC84CmZH
cW9zdkNmR1ZRVTY4R0I0YTJHU2VQTnJFRjN6ZTJXc1pOdGtDVC9mcUs5OFFZeStiQ3hMNFNYWk5Y
alo1TXAKMXVzRUJCL0JydzUxa3dKaXNMaGVQeFFkQmJ3enNDSVhqRmcwcXpxeTh5WS9sVWkwUUsw
SzhETEZnSFh5UzlOSApGVG1IbEFtV2tsVXV5MGU5Vit3NW9NQ2tvZ0cxSThpaFdUZjRCUXlRZEJa
VlJoeE5BZGQyMU5HakdJRTRzSkZyCnora0RCcC9IWjFCR0RvOTVjR1gyQktTZ2dYYmtPQVNmYTd1
THlYZC9xNHBYcFJ6QXpQbnlJS3FUUFI4ZjJwdzMKYTZBTG9CL3Qxd3Q4QThPOENWV2VFeEg5K2pL
TE94MjN5VmNKZ1Vwd21ZL3FjTmV5TXF3Z0ZzNEY3cWUxcjI0LwpRdWQ0a2dOYUl5V0xQcXgvRnha
STlFRVl2WjVkc3FYMDdvTkRLdk5Ub1RPMjVBYmwxWWFMOVZoNjcrZVMrUGxBClVja3FaeHNsV3hp
YVZEL3FzK0FvbnB1RXd6VzRCdDdoL1NBT255ND0KPVRZM3YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cff43a06259fba01--
