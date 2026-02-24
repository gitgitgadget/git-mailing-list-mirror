Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332F2D7DF8
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958039; cv=none; b=QMcSWVm16b1pqD9Waq9kA/WFSJH0ny6ro7E7x0A62lUmKHnhdFoapDEifk1qbxo1o6neIe4X8H/oEFSwi5q1EGZQu4qqhAAhAPWYhmo0fm/cGMjm4yeZvgmG09gNUs/YV5huq/NWzSOYbL0xFH3gnwluSqztlVfQqSSNcWbyTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958039; c=relaxed/simple;
	bh=eLOPF+6SM6sIHaBRMy2TZycIiTj3LVPIYV+7BJsvWGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3oD1mHsNRMYVOdnaK4kzUzEwvh4rfirDDMYgm7JefGBjutC551Ktx0AioykgLvgQGfiRefTAJIQzvEuy4mZN5mxJaYeBgMSPCcNA104KQ/Caxg2PSxAyxiCyIwNmYVoDWj4RmYm+Q6/JQnPjNN99zNj0yMmjJCg10AH3bGrE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8x3/lk8; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8x3/lk8"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d1959ba05cso2857492a34.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771958037; x=1772562837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHsZKjPwHHZ1MPuDRS893K8wiUc1Ph/RfaI22rwd30o=;
        b=a8x3/lk8ncqEYibT0ES/Mqaem6a37cZi8JL6dOb7aAhMXJ3G/pQq1j7aoZ9CztSji+
         /4GRnJvO8DT+y9AFEnJQsY7BlQYGwHi9C4hfx8awY88il7fL4O732U/7aGUN9sodJxon
         wQwSa461RovXR5NTwHafVyGfeI46roWJiKbHtkMww15F/Sajayn2qB8uVH5sPnq7ybUY
         NZtcQ3t8a7D8Gb/7O9TPAffW5bqFKB+wuxckJqf6wZlTZyhYoXDRTwEEGqIkCSoPGMD9
         HJ9TE6ZkCAcSBuHQVt4hXn5qB+qczpo619srkqj325sSccJ16DIkbCTsMTbTzYBGdMVa
         VqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958037; x=1772562837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHsZKjPwHHZ1MPuDRS893K8wiUc1Ph/RfaI22rwd30o=;
        b=VfeEIcpJrLO5RPUdexuv6zVtw0U7LdAS7E028J0VuUNuv//ib2e2wK/DBzx42EG7hf
         EuqMLUPGQAb+lpAkVj3tOWhIDsz9uuJbaKxIND2ro6mIXMGtWN3uQ8NzdaFtG0ukP7oE
         fZJKRShAsbUprKwNFjEYZVklqUYjsS7177ig6GKR9ZLtOWVkYVQkGIrFqUd73sLMsGAl
         8Qw8E119I9PLbJ4kz7Rdh/v13O1S0w8hknrwT5/tP4hKK5fNWD95PRgBrrkfLPsv+2cA
         JIok8mr2LAq+Kuch1LEkXbDfW3Xw7XtRI6ewJkeuzyFjXp+173zIBvMvAufGuurzWLhO
         TrFw==
X-Gm-Message-State: AOJu0YwQrA5bFkJJg1Oimv+XRGGYT4DMrnyN3yPlVsei592PFwdd0MNe
	7z6Rh+Ar3Rv6K+uBXBjqr8y4WuTiifvkSCO1A5Ml45OBNIVA/+iz1dGv
X-Gm-Gg: AZuq6aLw2QGp1Jt7MOt7pxHGzTi8C6ov5YchSYvPheIC5y9yhcbp6FCmgfJDZySp69w
	i3nIsxZ3yCMG8LCRyX27wLklDbkzvDhW1pReObBYzltKvDwgC3noat38Cmxhw9bGEIsp2I/ANi0
	YsJowFWvXFXyQGs+8R1esDamttrnrehBVFF3tQK7TrsBtJOkSAtxA5Nqv1BuUILN+wgQt3UQhyI
	BS6hiWYFnYIKIKupfE7y+z/0KLzVP2YgBleFypr4Y7MwJCQVEIF6xBIyrdhF1zsqPbAf3Vcq7TV
	lDMc5u2j7YW56PoeMFMQjarrQ1r9+Xm4GMFH3brvseg3YyreKPoVbIFOIepFxB3WjByU8p4S9o+
	ijqCVQMxQ22wPxcdLHDUfUihK/FkyuU0dfdVuoCZcNafHejqRlqF0oy1/wTyn3vMVk3YOtXzU2V
	+jnINABPxVkpKtKAjO
X-Received: by 2002:a05:6830:6690:b0:7ab:e111:1a57 with SMTP id 46e09a7af769-7d52c2e894amr6798889a34.31.1771958037208;
        Tue, 24 Feb 2026 10:33:57 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d038b5bsm10465718a34.14.2026.02.24.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:33:56 -0800 (PST)
Date: Tue, 24 Feb 2026 12:33:52 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <aZ3sI5LAj-bSt0Oy@denethor>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260223194146.3476768-3-jltobler@gmail.com>
 <aZ1wblYGQssyNYsk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1wblYGQssyNYsk@pks.im>

On 26/02/24 10:33AM, Patrick Steinhardt wrote:
> On Mon, Feb 23, 2026 at 01:41:46PM -0600, Justin Tobler wrote:
> > With git-fast-import(1), handling of signed commits is controlled via
> > the `--signed-commits=<mode>` option. When an invalid signature is
> > encountered, a user may want the option to re-sign the commit as opposed
> > to just stripping the signature. To faciliate this, introduce a
> > "re-sign-if-invalid" mode for the `--signed-commits` option.
> > 
> > Note that commits are re-signed using only the repository object format
> > hash algorithm. If a commit has an additional signature due to the
> > `compatObjectFormat` repository extension being set, the other signature
> > is stripped.
> 
> This part here might use some explanation why this part is not done so
> that a future reader that ends up here doesn't have to wonder whether
> this is done with intent, or whether this was done because it was hard
> to do.

Good point. I'll expand the explaination here in the next version.

> > diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> > index 479c4081da..b902a6e2b0 100644
> > --- a/Documentation/git-fast-import.adoc
> > +++ b/Documentation/git-fast-import.adoc
> > @@ -86,6 +86,9 @@ already trusted to run their own code.
> >  * `strip-if-invalid` will check signatures and, if they are invalid,
> >    will strip them and display a warning. The validation is performed
> >    in the same way as linkgit:git-verify-commit[1] does it.
> > +* `re-sign-if-invalid` is the same as `strip-if-invalid`, but additionally the
> > +  commits with invalid signatures are signed again, so that old invalid
> > +  signatures are replaced with new valid ones.
> 
> Okay. It's a bit curious to say it's the "same as `strip-if-invalid`",
> but I get what you mean by this, and I think a user would, too.

Ya, maybe it would be better to say that it is "similar to
`strip-if-invalid`". I'll try to rework the documentation here a little
bit in the next version.

> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index b8a7757cfd..e34a373d2f 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -2836,10 +2836,11 @@ static void finalize_commit_buffer(struct strbuf *new_data,
> >  	strbuf_addbuf(new_data, msg);
> >  }
> >  
> > -static void handle_strip_if_invalid(struct strbuf *new_data,
> > -				    struct signature_data *sig_sha1,
> > -				    struct signature_data *sig_sha256,
> > -				    struct strbuf *msg)
> > +static void handle_invalid_signature(struct strbuf *new_data,
> > +				     struct signature_data *sig_sha1,
> > +				     struct signature_data *sig_sha256,
> > +				     struct strbuf *msg,
> > +				     enum sign_mode mode)
> >  {
> >  	struct strbuf tmp_buf = STRBUF_INIT;
> >  	struct signature_check signature_check = { 0 };
> 
> Should we maybe call this `handle_signature_if_invalid()`? Otherwise it
> sounds as if we already know the signature was invalid.

That sounds better. Will adapt.

> 
> > @@ -2866,6 +2867,30 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
> >  			warning(_("stripping invalid signature for commit\n"
> >  				  "  allegedly by %s"), signer);
> 
> I wonder: does it still make sense to warn about those stripped
> signatures in case we re-sign anyway?

Ya, good point. I was originally thinking it would still make sense to
keep these messages since we are still stripping the signatures, but it
might be misleading if are also re-signing them. We could keep these,
but add an additional message if re-signing. That might be a little
noisy though. Maybe we just adapt the warning message when re-signing.

> > +		if (mode == SIGN_RESIGN_IF_INVALID) {
> > +			struct strbuf signature = STRBUF_INIT;
> > +			struct strbuf payload = STRBUF_INIT;
> > +			char *key = get_signing_key();
> > +
> > +			/*
> > +			 * Commits are resigned using the repository object
> 
> Poor commits. Maybe s/resigned/re-signed/?

Poor commits indeed, will change. XD

> > +			 * format hash algorithm only. Consequently if
> > +			 * extensions.compatObjectFormat is set, the
> > +			 * compatability hash is not currently used to
> > +			 * additionally sign the commit. If the commit payload
> > +			 * were reconstructed in the compatability format, it
> > +			 * would be possible to generate the other signature
> > +			 * accordingly though.
> > +			 */
> 
> Same as in the commit message, we should document whether this is done
> intentionally, or whether it may require more work going forward. If the
> latter, it might make sense to add a NEEDSWORK comment.

Ya, I think it should be possible to support compatibility hashes in the
future. I'll explain this better in a NEEDSWORK comment.

> I think meanwhile though it's okay that we don't handle compatibility
> hashes yet.
> 
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 87fb6605fb..e7eb42d9d6 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -1156,6 +1156,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode)
> >  		*mode = SIGN_STRIP;
> >  	else if (!strcmp(arg, "strip-if-invalid"))
> >  		*mode = SIGN_STRIP_IF_INVALID;
> > +	else if (!strcmp(arg, "re-sign-if-invalid"))
> > +		*mode = SIGN_RESIGN_IF_INVALID;
> >  	else
> >  		return -1;
> >  	return 0;
> 
> One thing I wonder here is which signing key is actually in use, and how
> the user would specify it. In git-commit(1) you can for example pass
> "--gpg-sign=<key-id>" to specify the key. Do we want to allow the same
> here, where you can pass "--signed-commits=re-sign-if-invalid[=<gpg-key>]"?

This seems sensible. I'll explore this in the next version.

Thanks for the review. :)

-Justin
