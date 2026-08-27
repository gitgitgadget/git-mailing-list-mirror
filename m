Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC8374A0D
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827782; cv=pass; b=uoRkJvjxk8AVTW20AKC4s8JOINo4qvCdx4V7OxjATuegDa8bbsIRvAIg780YNEdedFwwQtfuAbKRUK6D6U47PMsn+YAxwiOAv1XCZzVZ/zqT7cpkRYqvUi263ng4lmnZ+07sa7RXDDV5ysqtwuP8ZjbyCNNdSjJ58dBASCoYexw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827782; c=relaxed/simple;
	bh=N8KbQvJtuU7G0dkqKoqtzEHj21fZge67072BmO95koQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=UjdES6MIVp1dCUKZYOilaAWm15An1r09rKACKZrq4d4oy83iJFn4jXRvajXFgwtc2CauRvjcwruCP5EdI6aebX6Llwwqi2p7161p8MKcc5a5L1aoR7QXjbx5Gst/n4r2BxIumj9aFnV/SUNmTVITvOHVxYlEgpIP3HzXYRopXKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNeWySO2; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNeWySO2"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-77f0b9740c8so720713137.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787827779; cv=none;
        d=google.com; s=arc-20260327;
        b=lNEhKp0CsznhhiWYnlRPuy4QBcnMw7JwS9aS21ObQg1YWqkgCQb5z4pxQs4J8V/duT
         LbczxmevG19J4cpLFNrXXVylXAOwK+SyOgigWvxl9NwpGPKhYbA4BiSu9eIv9eYc5FK0
         lmSBpe3ARFsVPUciPCI12i7NP4n+lst3qwTQ9NUd8tnscrL1DfpWfMRHMtPdnS0cHcz4
         RW+wL5WGLfZImrKShuQUgju/5P41M061re8I/+GPauwB8IcPvQk8DCUCTEY/G/w/19zf
         88gyz3HV/42F97P/EiAbaWaivhn9rthFrUKi7Bv/D86Eo4hPjKJnQrX3PfR5mRNnYznZ
         Kl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=SBUOpjZayjYz+3Cy9kDVnIHnATn65Xk8C3BuX66ZjSc=;
        fh=6cMRCSINn4XBkmbm4H3ZkuFhU3J5dCL3QsTJiLzMnV8=;
        b=OS4R3tHSHkP8jcjv4FZyCMb630TRO+zV9+kv8EIhVNLS2Z7LDsvuX22wQ/MTKsCY25
         yt77jQNh2HPT6VV6P4iqN9PIIbfTxtP0n2JDPQHqHN3ODxFVPXzoaX3sitN4MCJLuVJk
         YRrQM8j+9hqnK3fFwJEVWlumcH2AirETo+gXIH7x54Lqyas5lhJRhYkCFPeADFu96vn8
         5+ZWN6ZrAdn5XS8Blh8OUU6Ymp6afwsjNbG+8Cx8AEGk9Y0CvlTg7r15mtjhVRm7gJkX
         Ibk29DW8/sL0mAsLHPMHLEf2HYa8Mc2JKI8JkVy6qXSwNv3n1Qz9B2zA2WtMromh+Y0p
         45eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787827779; x=1788432579; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBUOpjZayjYz+3Cy9kDVnIHnATn65Xk8C3BuX66ZjSc=;
        b=jNeWySO2c7xRsBDmv3p2jDkU0C0jVdZk7UZRR4TYFMUfCf2Ff8BVG0pKzhvU8eLTvk
         kXfJ9992QImmkK8xKYYscS6A4dWXhAKclBEPEMWbBW44KCbKNqa7bQ4DDxmkkyxbRJL7
         IQmaK2z2oDr4ZPI/ngbymwzXhCyz28saj/0c215/Bkr24wE7p3MXWCeNFVeSOZzGdrj9
         lj+gcl5fzVpgQv/CGof0b0bdSKSgR9Z1t+6hilxttDe6OMZ4taNFf6Clyi/SAQjWPrl3
         Qeos2SdpIgAu2ZLZCZhsTf/8WEZ8c8k7t86BQgK7OO6QObP7siD0gTKbVGukE1+H5aSf
         OAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787827779; x=1788432579;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBUOpjZayjYz+3Cy9kDVnIHnATn65Xk8C3BuX66ZjSc=;
        b=sBaw8IjJgiDOEmgVeZMHLlT6jTZ/CN0q/qix/O9276JNUU11frYgvLXgD+qoxtKbcl
         A5srhVNYk4gBxfyXEoKQcZ+uDQLkRkvV+Eo7YF7d6uc9h/RsUKhMMZa4x+9zKHgPqtwF
         SL5J2504UTJ59DK3UERCEjX9RZYSLGCgBO2dAtkVsadyYfUWYX4jChqZsv3xuxcROH5/
         r+ZpwpGi+Wm9LeQJrcI29hfBWGBc6sPHyOfBoybknTNVrmwsGpDQ/yYgr9ftx0Kw1eIy
         PxyBSEe/mNp40d0xS89BCyz2R8YPCrIrN2S4Ox2IBSWEXWp/cjYX/kmZw7rEWpyHUJ0F
         OsRg==
X-Forwarded-Encrypted: i=1; AHgh+RqPSWXCmIUEfIJuUJwTGEYGfPF2yUGsYbhmIGYp/Udk26RnWtUIs1j+TJefmyhKbOS7OE4=@vger.kernel.org
X-Gm-Message-State: AFuF++l4hjTKxPorEyRQmMvFk66sCGhB2KxRSyHMH+25j0djKa9Sm3L+
	w8UvnuFC++SwGOvT9wNGaEn+53oH0SszN1NfW539iac7Nnwd4R3G2ipTtAOqFdqw5etDoAqFkjk
	V2IR+aMk/IZnZZzI5a2Jc9zsYdAyW5os=
X-Gm-Gg: AR+sD11vTK2vcgWkYtrJd9WSEFdAuFt11QfNFYO96SxYJpVK9q5gx/H9Cki2W/g7O82
	6XySmfoNPqQD9/6onp85J/J2HPgtLf1IcUs69ybHrEnYq2ewiJaR7xx5VI6wCu3W+CqNrUasXdT
	Eml+dUgqEawOQ6a4YpL1pJ1OYqDqc1Vei9oHDOsGuVfy5RTCAIxgV492YghyJ2FZDlMRnllDkRd
	YSBJebIMPE410iaFOanzbdoCUfsBl4escSlvpC32eyybGCCa4tVH+enhT/FBmFABipajCInufMy
	+ORsjihH036F8mJu7LprFAzjzLpJVg5b1J6jDj9X7wR8lC2vDhyNQ78lj3HQ0Tsr9epXjTSSsv6
	9VZgRvqMwM6u02mIqja5NYjvgeS3dpmZhPKQ=
X-Received: by 2002:a05:6102:5f04:b0:778:30ee:f44b with SMTP id
 ada2fe7eead31-782c20fc837mr4140694137.13.1787827779278; Thu, 27 Aug 2026
 03:49:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:49:38 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:49:38 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-5-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-5-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:49:38 -0400
X-Gm-Features: AcwNN1WvBUKgHPuLk2t8xwvJguMXNrzRjJwVoDYnZ9RBCT5eFHjQw_ZerdILUcA
Message-ID: <CAOLa=ZQaetcmzOWzba=peCadW6i_JqhMth5cmQOZ32xz-E-zoQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] odb: provide infrastructure for pluggable fsck checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b4462a065a0517d4"

--000000000000b4462a065a0517d4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The on-disk consistency checks in git-fsck(1) are conceptually
> backend-specific: while connectivity checks and object-level parsing
> checks are generic, verifying the physical integrity of packfiles and
> loose objects is meaningful only to backends that use these formats:
> Having these checks live in "builtin/fsck.c" violates that layering,
> because it forces the command to reach directly into format-specific
> internals.
>
> Provide new infrastructure to make these format-specific checks
> pluggable and implement stubs for the different source types we already
> have. In subsequent commits we'll move functionality over piece by
> piece.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c        | 16 +++++++++++-----
>  odb.c                 |  9 +++++++++
>  odb.h                 | 23 +++++++++++++++++++++++
>  odb/source-files.c    | 13 +++++++++++++
>  odb/source-inmemory.c |  8 ++++++++
>  odb/source-loose.c    |  7 +++++++
>  odb/source-packed.c   |  8 ++++++++
>  odb/source.h          | 21 +++++++++++++++++++++
>  8 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 3f6056535f..adbe192e56 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -965,7 +965,9 @@ int cmd_fsck(int argc,
>  	     const char *prefix,
>  	     struct repository *repo)
>  {
> -	int check_full = 1;
> +	struct odb_fsck_options odb_fsck_opts = {
> +		.flags = ODB_FSCK_FULL,
> +	};
>  	int keep_cache_objects = 0;
>  	int name_objects = 0;
>  	int check_references = 1;
> @@ -977,7 +979,8 @@ int cmd_fsck(int argc,
>  		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
>  		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
>  		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
> -		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),

Question: OPT_BOOL sets 'check_full' to 0 when using '--no-full', does
OPT_BIT provide similar functionality?

> +		OPT_BIT(0, "full", &odb_fsck_opts.flags,
> +			N_("also consider packs and alternate objects"), ODB_FSCK_FULL),
>  		OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
>  		OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
>  		OPT_BOOL(0, "lost-found", &write_lost_and_found,
> @@ -1018,7 +1021,7 @@ int cmd_fsck(int argc,
>  		show_progress = 0;
>
>  	if (write_lost_and_found) {
> -		check_full = 1;
> +		odb_fsck_opts.flags |= ODB_FSCK_FULL;
>  		include_reflogs = 0;
>  	}
>
> @@ -1047,10 +1050,13 @@ int cmd_fsck(int argc,
>  				    mark_object_for_connectivity, repo, 0);
>  	} else {
>  		for (source = repo->objects->sources; source; source = source->next)
> -			if (check_full || source->local)
> +			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
>  				fsck_source(repo, source);
>
> -		if (check_full) {
> +		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
> +			errors_found |= ERROR_OBJECT;
> +

So most of the functionality will move into this and we'll cleanup
around in the following commits.

> +		if (odb_fsck_opts.flags & ODB_FSCK_FULL) {
>  			struct packed_git *p;
>  			uint32_t total = 0, count = 0;
>  			struct progress *progress = NULL;
> diff --git a/odb.c b/odb.c
> index 1fe20808eb..766043b685 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1177,3 +1177,12 @@ void odb_reprepare(struct object_database *o)
>  {
>  	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
>  }
> +
> +int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
> +{
> +	int ret = 0;
> +	for (struct odb_source *source = odb->sources; source; source = source->next)
> +		if ((options->flags & ODB_FSCK_FULL) || source->local)
> +			ret |= odb_source_fsck(source, options);
> +	return ret;
> +}

The odb iterates over all the sources and does a consistency check,
looks good.

[snip]

The changes in this commit look to be in order.

--000000000000b4462a065a0517d4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc32ddbc51c9c7ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUZrQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMksyQy8wV0lKQlUwZ2d1NzJsbmxnVktXSks1b0QycApQSUQrcjZBa2VB
ZHF5VStOT3RsVFRwZDVuSXg1b3oyeEhkZGMxdFVWYklWSWhIM1VkMnNOdXRDdTBTTWt4KzVnCkV2
akhteXRUdXdqeFJzMnJZTGxrTVFJMVVCMTNFNFNaZUJTbjJDbWl0N3lpS282NHdtOXozVVZLTHIw
ZUhLVXQKZ0tTeGtJWEMrUW9ONE4wb1NKdmZMc0VFaGlqWUVNamgvVE9rSC94WVp2WEVtbERXcWZ1
WGxGQ2FTUHlXOE1jSQozQ1BCR1FzMnd0UGdoUnJvZGhiVWVhMDB5M3lFY0oyNTdwZTZSK25meW92
OGhrK055emkrWDBIYXUwNlhYRFdRCmsvekZLYWx3VTYyblRpcmxrSGd4QlYydGZweVpkbkd5enFL
dmpHdGQ0eTNwSmlDb2JBRVBnMzFlY2o0SXRBbXQKeFh2enZrOHRQOFEvM2FKaWhVQjY2Y2NKckVu
RUMzdE9zdTJ0VmRwUDh2ZVZyQUJjc2Y3RFJaa3FTOWtRSlhCSQowQktSc0tIZGJBZkRGOXA2T3hV
T1ZpSFZnZzlTcjRvcXYrbDVVSlByT2dRZndQVG03VTVCTnNaVjZKNUc1bTNlClZpRHV5Z0s5QzVj
dFRBNlFVSlU2bVJ1S3Z0enpXM2lHWWJDNDRaYz0KPTZzdVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b4462a065a0517d4--
