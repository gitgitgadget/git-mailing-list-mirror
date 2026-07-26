Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634635DA53
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077560; cv=none; b=kmRiOKomQEvPm15VkcuqJEQAIu0bHjWjicZvVRMFf1tHq4k43CnO3luzvm0ndhJILLYLT5BfrZrYR31knumoXrNxfyAyO5yBugm7cxAFtZMwJ0tEBoS24SnqSvZyHD8udUbpS169dzHpn0l6NBg6MK9bflwwLdrdwkOAEQ94Dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077560; c=relaxed/simple;
	bh=/EI6iGx3TW36XHVIPDGKWsrks6ckfkbhnJT+pdeXAM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=MU2oQZpZQLyKIe3hsSqSiUXDS1UGhg23G8Fld5QroyAt0lD5Q8AMRYZC6SiAf+ZKEMUAF8nAC/EKNWpWD60oiPXV6fyAjTRImF4dEKBJGyqwnyZvbo4ky5L1LqgBHxy9jul6zW3p6pwubPScGCYr4nA33OOmjD9v+1ZTqCfo8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0erhXos; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0erhXos"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49553515a8bso22837515e9.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785077557; x=1785682357; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LWkEqsrQ7zMKpykPK/LkCltvuIZAFaq1BH6vpyVrmhM=;
        b=P0erhXosr+PmMNpg70YFho5hvZ9jSkxLEc+mFDEVoRW1e4zLUlKUqRjyqQym9EyWvJ
         dw2//b8s+hVId9i9ClVlGAN8JmBH7hbcJ4l997HAzS25POp+0hkGb1IlSZWYXxxlT/H3
         1PtDvuORyHg4/a1KrCw7h5iRwr/+vasKXFfgTLu2mjQf2vU9XgWOKEl3qjK/YGhXYbix
         Uuuq5yjD1AC8u8twrKbGBK1CDSbp2WosdoqaIj5V0G80tysfavH68Lzu2Jx9GhBKObLz
         yEX/mAAdp1jh3GeiIw/A+hnnmixf/OgWDqPx0PtyiJatCcG72EDr4Xpw5tASxYNaiQkt
         0NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077557; x=1785682357;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LWkEqsrQ7zMKpykPK/LkCltvuIZAFaq1BH6vpyVrmhM=;
        b=Y4yqDZSQx2cljFqZ3bdNO+DpLfTSlJb9DhdDl+i0VYlcXX8VO79wUhdqCJLixeNRvj
         r6P4z3v5PhtCaOI7G2F3UsnihH4EuGB6TNw9kGSBzv7qMXwuzNDlvGZ4Gl4dGAeLSxnP
         J8YrVlnc13lVaN3S3xAB9k0lSJjQyCYY8HF0+EbVQq5nlTRI/bx/cCW6qajF6Fkp/3rs
         ak9WXJddbH3ulu2un2ceMPXh0Vvw5xuwsgjuZVJqzZj3QaXFxWa6g61WcRUwAqdf963p
         uvfBvLt6OwQGf24jci2ln4VACGX3xJV4S7CoYC07TNIqyLo2diosVp7U0SDrFTwWeQXg
         x5bQ==
X-Forwarded-Encrypted: i=1; AHgh+Rraa2dSYgtAgQ/2XvJzL5N3E9YJLT50mAMhIG1Rtb4h/yV8LFYTIP4HRQxjB4sn2J8cToo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntAPSRuPsMAsS09XgK7mC0ioz+SpuRJWwl9/xfF/I4HC3hdN+
	eLF9go+EkXRLc1FxGZLVStl5ru3ztpMJKShj8Btkczq56XJAvOmrKLng08KPYgIE
X-Gm-Gg: AR+sD10/xFUFB33ui2NU9NMouw6jNdxufIv8hJV3ti+fKDnuBB+dlscvcunDgyUGy15
	YgmiRIQ+ZEzRU8xQ7n9mBJsjcEm9kbKFna6vGj9kJlOMyAJcN40G6iTqN+Am5AOt4m+gfsYlVjy
	LMrVvLmA7V3GFraSgkaLr6z3x9EbrbnrR9iRuBn8qfvqybn1YlB584M8NbjOrFtB882w/FRbE5W
	n/Oju+TQKMJvsW1fH3PAJ4SNbcd4C/Nxtd4SMjNku2QrhXBajWXTxnxY9TpRNgr40TTfh1NbdHp
	F3CFJfVI8DnSE96ZVdZhg9sSnqq55dyWcMqS1+8dovj5+PXH1BgKgsL6CQm8QFU2MtAVWPxDd41
	tHF7SeL5zFJVHh6uJpWKjc3r5kAXlE46vqIApUhS+mQcyvBm0rvlXDP0/plWAxt0MHIcbyS/VjW
	pZf+7mvGebTRXHeAFXYm9UEpdiaJ33v2dIWvUugBdjTSEaSoiId9ELH2KtR1lpSi6pQ0VRMwggd
	PIVFqr7F/rgYO9Qid2FRC3eI4yjdQ1KhrmpfOaOVC08ucUctolMNxIEGhNVWCJBGJgsNjvV8tiI
	IEK/l2dGYb7Bm5quAu3//Qrp2BkFThx2y+eUrFy8qgFOkEjBXEtXbOxhEE2qZc9X7g==
X-Received: by 2002:a05:600c:a086:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-496b56e6e44mr70968205e9.8.1785077556792;
        Sun, 26 Jul 2026 07:52:36 -0700 (PDT)
Received: from localhost (81.red-176-87-232.dynamicip.rima-tde.net. [176.87.232.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a8547sm145367955e9.14.2026.07.26.07.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 07:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 16:52:34 +0200
Message-Id: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
Subject: Re: [PATCH] change utf8_strwidth() return type to size_t
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Hardik Kumar" <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
In-Reply-To: <20260726123427.173877-1-hardikxk@gmail.com>

On Sun Jul 26, 2026 at 2:34 PM CEST, Hardik Kumar wrote:
> The patch changes the return types of `utf8_strwidth()` and

Regarding the presentation: "The patch changes...", try to avoid this
pattern, I think something like this would fit better:

utf8_strwidth() and utf8_strnwidth() return int, even though the value
they return is always non-negative:

- utf8_strnwidth() accumulates the width into a size_t and otherwise
  returns its size_t len parameter,
- utf8_strwidth() just forwards its result.

Change their signatures to return size_t instead.

If you want to mention the TODO, I would add it after the '---'.

> `utf8_strnwidth()` to `size_t` (implementing a //TODO). Both functions
> have been updated in the header file also.
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  utf8.c | 13 ++++---------
>  utf8.h |  4 ++--
>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/utf8.c b/utf8.c
> index 96460cc..1081573 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder_=
p)
>   * string, assuming that the string is utf8.  Returns strlen() instead
>   * if the string does not look like a valid utf8 string.
>   */
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  {
>  	const char *orig =3D string;
>  	size_t width =3D 0;
> @@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len, =
int skip_ansi)
>  		if (glyph_width > 0)
>  			width +=3D glyph_width;
>  	}
> -
> -	/*
> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
> -	 * return `size_t` instead of `int`.
> -	 */
> -	return cast_size_t_to_int(string ? width : len);
> +	return (string) ? width : len;

nit: parentheses at "(string)" are unnecessary.

Also, cast_size_t_to_int() had an overflow check, we need to be sure
that no caller relies on that check. If you have checked for that,
please mention it in the commit message.

>  }
>
> -int utf8_strwidth(const char *string)
> +size_t utf8_strwidth(const char *string)
>  {
>  	return utf8_strnwidth(string, strlen(string), 0);
>  }
> @@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type=
 position, unsigned int wid
>  		       const char *s)
>  {
>  	size_t slen =3D strlen(s);
> -	int display_len =3D utf8_strnwidth(s, slen, 0);
> +	size_t display_len =3D utf8_strnwidth(s, slen, 0);

We are fixing a caller here and that is correct.
But these functions that we've changed in this patch are called
throughout the codebase, we should fix those callers too.

We can check who their callers are with:

  git grep -n -E 'utf8_str.?width'

builtin/repo.c:390:             int value_width =3D utf8_strwidth(entry->va=
lue);
builtin/repo.c:395:             int unit_width =3D utf8_strwidth(entry->uni=
t);
builtin/repo.c:585:     int title_name_width =3D utf8_strwidth(name_col_tit=
le);
builtin/repo.c:586:     int title_value_width =3D utf8_strwidth(value_col_t=
itle);

(there are more)

From what I reviewed, no caller will break because of this, but I think
we should fix it for consistency.

>  	int utf8_compensation =3D slen - display_len;
>
>  	if (display_len >=3D width) {
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0..531e968 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int *=
/
>
>  size_t display_mode_esc_sequence_len(const char *s);
>  int utf8_width(const char **start, size_t *remainder_p);
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> -int utf8_strwidth(const char *string);
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> +size_t utf8_strwidth(const char *string);
>  int is_utf8(const char *text);
>  int is_encoding_utf8(const char *name);
>  int same_encoding(const char *, const char *);
>
> base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca

The signature change looks ok.

Regards,
Pablo

