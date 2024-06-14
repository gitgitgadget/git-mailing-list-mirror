Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47A19D88A
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342440; cv=none; b=MttMfbCwlMIAbPBRbT0xZCBMy4v0AtYMxQBh58ZH+wTENyyMcOmkd8DU64EQXa+pIhJxMOkzDE4pC9z89N9aN8XhNkZ+zrUqXFsMmDMxqhvmHH5iCXn9sHpKvK3XatepRY0ip52LV4TWMvKGIILaAzhZXLLU66nmoKCew5UIo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342440; c=relaxed/simple;
	bh=Z8W6elrNyb+25BN2l1Le0KEnw2/KUX5eToP4vAMLOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q71W+RlniANOaMQPSnY7Lw5EsPlb9eoU1uT2DS+qBLuBJKaoxYTiTeATbn1e5r0oNhtusunfwE2ifuCUW3HYXq1bi2HQ+36VK824mQU4t8XargpYNGgLsG/miSm69vnHm6TJJC8A8ivcHWV92e7y0BaB0biJ+H6QFt7p6zIVrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiDocGfh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiDocGfh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2ecbc109fso1516191a91.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718342438; x=1718947238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7B9Md9MdbcKZM0WQF9gGsfBqscElkoaJgXE8V6JAto=;
        b=eiDocGfhtnr8rDgGFWIKLIIYjSV2lxLwYvLecn2AEe8is78n5Zy1fua5lDXdzdAx0s
         eDd45zKPeoGI4OcA7SpdIwDuP9Jo6KoHodQxuCzzfayDS+MreuKanOhdKUz9gIomAo4+
         7smeXG/tZheZPYswd5eNpaxJfnW8V8q3xQ+oHkIzk6lEIsfAKiOCAFvTibsOTizvM/e/
         f9vJZJ9D5xidtc/pJCgnUuW3iidp23UYL/i6V593bEwtaRbQTAAKz/sga/qTo0WtkJVP
         4tClTT9a5ujnr+oLST0AI7jXWQr+zjFOm1XUi2llrZXTFT17gISEPbtfJiubR1axbVjD
         KXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718342438; x=1718947238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7B9Md9MdbcKZM0WQF9gGsfBqscElkoaJgXE8V6JAto=;
        b=KgKhrgAFC/7cWyjkkf25Mirm9CQYXZUmQq78h8P+d12KIk9t2Soitu2Op7tePFVFdK
         gkmcU6NyvKrgdt8cZFLWdyVnLtG/2fusdCIGY1rU74yslYTn/RDYX22orURe8YciTMFk
         fVBUbsunnZICF2yQsrzQd1Vk0AvPAmkhz3IlEmccx/izwcj23uSs08FOEWMASvDToAt7
         WhVO4NqCZCfeAoB1YeVmat5lM8lXWtysk05/6t4JJce5HUuu0CH8NUVMEiKHrGcRuh0u
         sfkxtmK+mz2AvT5hNCKl5JE982VemhO9dj49np8zde682X1iUtxzZKQx8/AcdxPwi+Fx
         Ftig==
X-Gm-Message-State: AOJu0YzMo1ULMcs0TnfI7R3hjYk3zbSw6G6TyUeI2sat2YmbsoaIV/Mu
	taQqeT+RUB6lClONEwCsUqZ5MO8b67ASTaTvx4J3bo4ZXcL0mIm8
X-Google-Smtp-Source: AGHT+IGYnU3/MOZjEYDwZep/GXVH/MgWhhLnikkAKYcebo+qrEr9OGjpow/C95wGbeJdxEnp2gtKVw==
X-Received: by 2002:a17:90a:b116:b0:2c2:c8b:f187 with SMTP id 98e67ed59e1d1-2c4dbd3559fmr1957460a91.36.1718342438062;
        Thu, 13 Jun 2024 22:20:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45acfa8sm2837271a91.10.2024.06.13.22.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:20:37 -0700 (PDT)
Date: Fri, 14 Jun 2024 13:20:35 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 7/7] fsck: add ref content check for files
 backend
Message-ID: <ZmvTI73P2fQ6AkOp@ArchLinux>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-8-shejialuo@gmail.com>
 <xmqqr0d0iqey.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0d0iqey.fsf@gitster.g>

On Thu, Jun 13, 2024 at 12:38:45PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In order to check the trailing content, add a new parameter
> > "trailing" to "parse_loose_ref_contents" function.
> 
> About this one.
> 
> >  int parse_loose_ref_contents(const char *buf, struct object_id *oid,
> >  			     struct strbuf *referent, unsigned int *type,
> > -			     int *failure_errno)
> > +			     int *failure_errno, unsigned int *trailing)
> >  {
> >  	const char *p;
> >  	if (skip_prefix(buf, "ref:", &buf)) {
> > @@ -607,6 +607,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
> >  		*failure_errno = EINVAL;
> >  		return -1;
> >  	}
> > +
> > +	if (trailing && (*p != '\0' && *p != '\n'))
> > +		*trailing = 1;
> > +
> >  	return 0;
> >  }
> 
> We know what the garbage looked like at this point.  The caller owns
> the "buf" pointer and we are pointing into that buffer with the
> pointer p, and the garbage is right there.
> 
> So I am not sure if losing information by using "uint *" is a good
> idea.  Wouldn't it make more sense to take "const char **trailing"
> as a parameter and tell the caller where the trailing junk begins?
> 

Yes, I totally agree that using "uint *" will lose a lot of information
here. Actually I have used the "const char **trailing", but I made a
mistake to result the wild pointer. This is because when
"parse_loose_ref_contents" handles symref, it will never handle `*p`.
When the caller defines `const char *trailing`, it will be wild pointer.
But I think we could set it to `NULL` when handling symref.

I will change the code in the next version.

> > +static int files_fsck_symref(struct fsck_refs_options *o,
> > +			     struct strbuf *refname,
> > +			     struct strbuf *path)
> 
> This does not take things like HEAD or refs/remotes/origin/HEAD to
> validate.  Instead, the caller is responsible for either doing a
> readlink on a symbolic link, or reading a textual symref and
> stripping "ref: " prefix from it, before calling this function.
> The "refname" parameter is not HEAD or refs/remotes/origin/HEAD but
> the pointee of the symref.
> 
> So I'd imagine that renaming it to fsck_symref_target or along that
> line to clarify that we are not checking the symref, but the target
> of a symref, would be a good idea.
> 

That's not correct. The "refname" parameter is EXACTLY the symref
itself. What we do here is to check the "path" paramteter, there are two
situations:

1. For symref we will strip "ref: " prefix, and combine the girdir and
the stripped content to get the "path" parameter.
2. For symbolic we will get its actual path (here I made a mistake, I
totally forget the situation when it points to absolute path, I will
revise the code for handling it).

The design here is just check whether the symref points to the correct
thing. It does not care about the pointee. The code will traverse every
regular file under the "refs/" directory, eventually we will check the
"pointee" status. For example, a symref "sym-branch" and a regular ref
"branch".

  sym-branch: "ref: refs/heads/branch".
  branch: "xxxx"

The design will not report any error for "sym-branch". I think we should
discuss here whether this design is OK.

> > +{
> > +	struct stat st;
> > +	int ret = 0;
> > +
> > +	if (lstat(path->buf, &st) < 0) {
> > +		ret = fsck_refs_report(o, refname->buf,
> > +				       FSCK_MSG_DANGLING_SYMREF,
> > +				       "point to non-existent ref");
> > +		goto out;
> > +	}
> 
> Is that an error?  Just like being on an unborn branch is not an
> error, it could be argued that a symref that points at a branch yet
> to be born wouldn't be an error, either, no?
> 

The reason why I choose "danglingSymref" and warn severity is that I let
the code be align with "git checkout". When we use "git checkout" for a
dangling symref. It would produce the following output:

  $ git checkout branch-3
  warning: ignoring dangling symref refs/heads/branch-3
  error: pathspec 'branch-3' did not match any file(s) known to git

So I prefer to warn severity.

> > +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> > +		ret = fsck_refs_report(o, refname->buf,
> > +				       FSCK_MSG_DANGLING_SYMREF,
> > +				       "point to invalid object");
> > +		goto out;
> 
> The use of "object" here is highly misleading.  Yes, you can call a
> filesystem entity like "a regular file", "a directory", etc. "an
> object", but the word can refer to many other kinds of "object".  In
> fact, I originally read this to mean "we are referring to an object
> in the object database that is corrupt" or something, but of course
> that is not what we are complaining about. We are complaining that
> the symbolic link points at a file of wrong type (like a directory).
> 

Yes, it brings a lot of misleading here. I will clean the code and
commit message (I also used object in commit message).

> So, in short, missing is probably OK.  Pointing at a wrong thing
> (like a directory or block device) is not.  Where, if any, do we
> catch a symbolic ref that tries to escape the refs/* hierarchy
> (e.g. ".git/refs/heads/my-crazy-ref" that is a symbolic link that
> points at "../../../../else/where" that is not even part of the
> repository), by the way?
> 

I intentionally ignored the "escape" situation. Actually, the path could
be either absolute or relative. It may be a little complicated. I will
find a way to support this in the next version.

> Thanks.

Thanks,
Jialuo
