Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7ED5187FF
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924408; cv=none; b=nfu47k3QdqbXG0YjpVinRP/c19BP7gxHtzC8bSkZCNHqmh1Kvr+lUN5x6jasbLEXXyUN/r8nH7rp/4ExdNpzUW8tm62fpay7nJhkBfaTfziUyMM47YNAJgZ26cQEdnLZHXv3cEEn8UIqDhJaJMW8H85zjTE7zOao/c2L1fjOnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924408; c=relaxed/simple;
	bh=SqpELeVPwZCQYsha74jD97G7yzo6epixjDyDTze8ZIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo8jh3WZ/REpJmy05IUVryiKQPvAIO97BsS78F1mNSBl+qpyqCYtXO03psKi1673YVsqb6ODFxGbUtN7Rc1sDxlDnVEbiANa50HVJwt5C7IPywPa/eiiKonn9QRu96q+r0kjWqXHAXjFlwVKtT0w7Uxne2rvXXrFebPUp1pPeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuaSnT4P; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuaSnT4P"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a691d29614so1097399fac.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924404; x=1792529204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u93XUsEoc5YvIPJoXrcc8dPxHcDAIYyZaLStAMO1fEc=;
        b=CuaSnT4PQKHrNhLJ+8zT4G2XaaxZcJv7PZDvGVMIJc+BKmlVWcw/4EXRRAxjeya97Y
         5yngY2Okb8sU7XrWpL9qdNyQgtPR/g8WVOmk7n1ixThxDCmZvjvm8FGTfcAdxGi4ykon
         YV7DgIDimg74rpHj+8krGmR2NZtv+zFWhfaNQsQai9fcOcvnbxwAMm5NRJcFPrkJ+ZPl
         9XPikwKwk2CFaG8AmkaAdKuWQXlv9UN43yNAvWapLvsbHeBAjKUCyXEjfvpUxhpnSyB4
         uIpY9ipJdXdr0Ag5RVVVuBK4Un05knGmUB4Gkr/fkvbqFSe4VLWhajxGzrcEu7d3VFP2
         y/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924404; x=1792529204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u93XUsEoc5YvIPJoXrcc8dPxHcDAIYyZaLStAMO1fEc=;
        b=gp5zlMdxLWfUzNYeP9kS0uAMtrEpYUU0DC8ZkxxBDsrfx8jpT8reKNIHX1w0kvPLEi
         peLKtbpbU0+50c5c5bSbaZLjw2dCImIdLiTJMhvWoTQGSoQaIXZg4VYHNXaaVMo/i0HW
         FTwcYT9UbFmer891VSoW/XT89+uwa9xhGNWIBvV9+NLvLISgzJivAlEtRs8t+2YhyqGO
         4M0GtB/u0YeKjvJ3Ep03oY1lfH1KJs9GKpaaqBXiCFpupVuTWymsw4Lak7X/kuEXyalv
         KEL+yG7JfwObk1MZGCRr/XhCp5C+SVCOcLKr9q4LkZpa1mWfGqhgwt0engm0Jy/sk87w
         zwDA==
X-Gm-Message-State: AFq9FYLXR5tUglDWbzWtr+BwSWN8RfG6vYOSsDyiZ8Og/AeVnWsx4Cwe
	KcJFP3PL5b3N4OlyHOGP09dNT0PgsMcRwx1mSkCfQmoVNlwNW9Bx4tWX
X-Gm-Gg: AYBFou1CMzA7pb7skIf8uC0p3UNtOAjPu9bxy1hEH+Xi8eiSA5Kycf7dXZAE6ekwTwb
	6/ojnZhbqfmFq9vmzd8nWlLu3Gk8qkkfIg8pN6ffxxa61JtpmbSnSl5T/VQsjM1n+CBdFHTRdvT
	A+VNAjQiupESNGTYNqsAxa502WN7Ry2WTmDXDXlaPuluWT/KAPeWb2yiRzpxLU7kGhXl9TGM4jO
	KJEpMZNYbl2G81d08flOtoBnrGm8jVwkuUKb2OMicXYCkCSOTgsHHqyI6/KJdOttfaWonuzsPgs
	7QoPWmR87C98EQWcCRbMBmgbMkLRkpgBfBtAPOKDEE867CPqtqdjIBTnOlt89lgoHVI9VlDNxNM
	uNM4hV5ddPa/Z2NS8MlIE6F+jESt496Y+NykpxaS71pisaYepy6uI0EFbVAHkgHkAJmfo9bz+e6
	Tx0QW4DTbDLDdBpJ5SHV24XR8/6chWDR/mpBJICQPkt083NaJkrPNghI2ZXdB27zTGykIBl5aCl
	KtqNlSedwFCSO92RznUWGs=
X-Received: by 2002:a05:6808:1a05:b0:4e6:6079:c33d with SMTP id 5614622812f47-50c532f457fmr12504729b6e.10.1791924404124;
        Tue, 13 Oct 2026 13:46:44 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-518a72a6048sm9888796b6e.5.2026.10.13.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:46:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:46:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 1/5] odb/source-files: fix performance when reading
 objects with alternates
Message-ID: <as6Vx2ba17tztb2q@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-1-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-1-b7030ff2b26f@pks.im>

On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> With the move towards pluggable object databases we reorganized how we
> access alternates. Before the introduction of pluggability, we were
> reading objects by first scanning through packfiles from all alternates
> before scanning through all loose object directories. With the change
> though, we are now iterating through the sources one by one, checking
> each of them for whether they contain the object either as a packed or
> loose object.

Ok, ideally we want to go back to checking all the packfiles across each
source for a given object before looking through the loose objects. This
would be more performant. Make sense.

> Checking whether an object exists in packfiles is comparatively cheap
> because the list of packs is cached, and the pack indices are likely to
> be in the page cache. In contrast to that, checking whether an object
> exists in loose format always incurs one stat(3p) syscall. So scanning
> for objects one alternate at a time led to a performance regression in
> in the case where most of the objects are contained in a packfile of an
> alternate, as reported in [1].

Ok.

> We could fix that issue by introducing another flag that tells the
> backends to only search the optimized storage backend. But that is
> adding more complexity to the object database layers that is ultimately
> only really required because of the way the "files" backend stores its
> data. So for an alternate backend, such new infrastructure would not
> really be a good fit.

I completely agree. Introducing a special flag here would really only
serve the "files" backend and also make the overall interface more
confusing. It would be best to capture the desired behavior as an
implementation detail of the "files" backend itself.

> But since then we have moved handling of alternates into the "files"
> backend itself. One of the consequences of this is that this backend is
> now having full control over all of its sub-sources, and that also makes
> it way easier for us to optimize for this access pattern again.

Yup, now that alternates are controlled/managed by the "files" backend
itself instead of being discrete sources themselves, it becomes possible
us to update how objects are read internal to the source.

> Do so by first trying to read objects from packfiles located in any of
> its object directories before trying to read loose objects.

Make sense.

> The following benchmark demonstrates that this significantly improves
> performance in some cases. The benchmark uses the Git repository itself
> and sets up its object directory as an alternate, while the primary
> object directory is simply an empty object directory. It then reads all
> commits enumerated via `git rev-list HEAD` with git-cat-file(1):
> 
>   Benchmark 1: git cat-file --batch-check --unordered (rev = HEAD~)
>     Time (mean ± σ):     179.4 ms ±   2.6 ms    [User: 114.6 ms, System: 61.4 ms]
>     Range (min … max):   177.1 ms … 187.7 ms    16 runs
> 
>   Benchmark 2: git cat-file --batch-check --unordered (rev = HEAD)
>     Time (mean ± σ):      95.0 ms ±   1.5 ms    [User: 79.8 ms, System: 15.0 ms]
>     Range (min … max):    93.0 ms …  97.9 ms    30 runs
> 
>   Summary
>     git cat-file --batch-check --unordered (rev = HEAD) ran
>       1.89 ± 0.04 times faster than git cat-file --batch-check --unordered (rev = HEAD~)

Nice.

> [1]: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
> 
> Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 455f409db0..9268f5aa9a 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -426,6 +426,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
>  	enum odb_read_status status = ODB_READ_NOT_FOUND;
> +	enum odb_read_status ret;
>  
>  	/*
>  	 * Reading an object may fail even though the object exists, for
> @@ -434,15 +435,15 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>  	 * prefer the first such error in case multiple reads have failed.
>  	 */
>  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> -		enum odb_read_status ret;
> -
>  		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
>  						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
>  		if (!ret)
>  			return 0;
>  		if (ret != ODB_READ_NOT_FOUND && status == ODB_READ_NOT_FOUND)
>  			status = ret;
> +	}
>  
> +	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {

Ok, now we iterate through each source to look through all the packs
before looking through the loose objects for each source. This matches
the behavior desribed above and look good.

-Justin
