Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D5221
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708236543; cv=none; b=NPMRaqlNhPlZ+mGHXX3tsUksPQMYZ4NcQTrk16GNgzHcelWYKEqHFTa0ot0EkR5WenGZh+Pyb9Y/rrHp2ld0m8oLmdnCcNoFaO6isskBsKo8o8ekhX/kJLEbOeVqwEkASObsCaOkHKyZy7NWJYMD9RgJrQ63ozK9rZpOVXnvH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708236543; c=relaxed/simple;
	bh=bHRG3TRdwOjMuILoYhxvHVzZiLrkLjUUk6Wadl0qHZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmPCE3yKTX3lbBsss6fUZqnt/JRWasINDwtVAF06nUWvC/FCcNNzUn03j68GDAF/JmY94/43rPjSRv46d5GQgQXU7b/GC/4+EfeBSV8F9/J5dvmG38UxG5RfyzF866n1yWEAbexVrVu8/XHHJzZk272eSYyX10uRL3kbsvK689I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78717221b97so247754485a.0
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 22:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708236540; x=1708841340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW2G8dcSwU1ISrIe35BcrBujmG/w1eFzyrM8u1MMSRc=;
        b=R75zmGx6/kCnZo1D88F0raWJ96csCjcnQ4ArNYXjtWKSp6z5Zd7hplUPp9SCaFghEM
         e4blQmIwHesCeEhiw2a3xhWmjBfd0Ig9qRc2VWSlkC1tjxl0sRJ63xWBOuHO5ZBy8Zuc
         sagM7qpQC2t5/tDvuXG6IwZ8KHepKdurGzFeHmrX8BdqJw0AziYT4zWeugkOdki0bgDd
         eAxYO1e2lE1ITRuSh7E9dKtJVvVtmoAgDD/jwC8vzLP+j+xyJK+YJQIYNt/NMapzrfdb
         HpXBiZMFeX4MZvrnjz3hN4ePuSOZsaOEpYzapM53ApP6SZN+qBbwQu79p4cLWCNxHkeM
         aysg==
X-Gm-Message-State: AOJu0YzfyFfLZCqMGbzA2G3OOe7YenopTOxFP6CH8y/nntIAbVmyT1xT
	QjN7MHMEUZaC6c4XQeTQlLMOnoIGMi9Z0abe+44xJKdQ+vhlWX/a/dlQ2o2lKG8m+wNdoRNDMf8
	YP0tiFDN9dz9n7+9ZUicEN8LFIwYlLpOCyQc=
X-Google-Smtp-Source: AGHT+IHjeyZ98VymvgTM6Hmtkn2urdTLyyDZTwgiZQJLp8vJzpGbyIinbD3SYs/wgRprT9ijzvnjAcB50OX5H2jeBmw=
X-Received: by 2002:a05:6214:20c3:b0:68f:3295:2457 with SMTP id
 3-20020a05621420c300b0068f32952457mr10703882qve.43.1708236539744; Sat, 17 Feb
 2024 22:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com> <f7031316a043b36fac10ecf784d2294894967e7b.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <f7031316a043b36fac10ecf784d2294894967e7b.1708212896.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 18 Feb 2024 01:08:48 -0500
Message-ID: <CAPig+cR_XYjArdYpU-qm+Wont=yEEXe5hANRyz+YRdhv=UZf=Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] osxkeychain: replace deprecated SecKeychain API
To: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Bo Anderson <mail@boanderson.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 6:35=E2=80=AFPM Bo Anderson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The SecKeychain API was deprecated in macOS 10.10, nearly 10 years ago.
> The replacement SecItem API however is available as far back as macOS
> 10.6.
>
> While supporting older macOS was perhaps prevously a concern,
> git-credential-osxkeychain already requires a minimum of macOS 10.7
> since 5747c8072b (contrib/credential: avoid fixed-size buffer in
> osxkeychain, 2023-05-01) so using the newer API should not regress the
> range of macOS versions supported.
>
> Adapting to use the newer SecItem API also happens to fix two test
> failures in osxkeychain:
>
>     8 - helper (osxkeychain) overwrites on store
>     9 - helper (osxkeychain) can forget host
>
> The new API is compatible with credentials saved with the older API.
>
> Signed-off-by: Bo Anderson <mail@boanderson.me>

I haven't studied the SecItem API, so I can't comment on the meat of
the patch, but I can make a few generic observations...

> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -3,14 +3,39 @@
> -__attribute__((format (printf, 1, 2)))
> +#define ENCODING kCFStringEncodingUTF8
> +static CFStringRef protocol; /* Stores constant strings - not memory man=
aged */
> +static CFStringRef host;
> [...]
> +
> +static void clear_credential(void)
> +{
> +       if (host) {
> +               CFRelease(host);
> +               host =3D NULL;
> +       }
> +       [...]
> +}
> +
> +__attribute__((format (printf, 1, 2), __noreturn__))

The addition of `__noreturn__` to the `__attribute__` seems unrelated
to the stated purpose of this patch. As such, it typically would be
placed in its own patch. If it really is too minor for a separate
patch, mentioning it in the commit message as a "While at it..." would
be helpful.

> @@ -19,70 +44,135 @@ static void die(const char *err, ...)
> +static CFDictionaryRef create_dictionary(CFAllocatorRef allocator, ...)
> +{
> +       va_list args;
> +       const void *key;
> +       CFMutableDictionaryRef result;
> +
> +       result =3D CFDictionaryCreateMutable(allocator,
> +                                          0,
> +                                          &kCFTypeDictionaryKeyCallBacks=
,
> +                                          &kCFTypeDictionaryValueCallBac=
ks);
> +
> +

Style: one blank line is preferred over two

> +       va_start(args, allocator);
> +       while ((key =3D va_arg(args, const void *)) !=3D NULL) {
> +               const void *value;
> +               value =3D va_arg(args, const void *);
> +               if (value)
> +                       CFDictionarySetValue(result, key, value);
> +       }
> +       va_end(args);

A couple related comments...

If va_arg() ever returns NULL for `value`, the next iteration of the
loop will call va_arg() again, but calling va_arg() again after it has
already returned NULL is likely undefined behavior. At minimum, I
would have expected this to be written as:

    while (...) {
        ...
        if (!value)
            break;
        CFDictionarySetValue(...);
    }

However, isn't it a programmer error if va_arg() returns NULL for
`value`? If so, I'd think we'd want to scream loudly about that rather
than silently ignoring it. So, perhaps something like this:

    while (...) {
        ...
        if (!value) {
            fprintf(stderr, "BUG: ...");
            abort();
        }
        CFDictionarySetValue(...);
   }

Or, perhaps just call the existing die() function in this file with a
suitable "BUG ..." message.

> +static void find_username_in_item(CFDictionaryRef item)
>  {
> +       CFStringRef account_ref;
> +       char *username_buf;
> +       CFIndex buffer_len;
>
> +       account_ref =3D CFDictionaryGetValue(item, kSecAttrAccount);
> +       if (!account_ref)
> +       {
> +               write_item("username", "", 0);
> +               return;
> +       }

Style: opening brace sticks to the `if` line:

    if !(account_ref) {
        ...
    }

Same comment applies to the `if` below.

> +       username_buf =3D (char *)CFStringGetCStringPtr(account_ref, ENCOD=
ING);
> +       if (username_buf)
> +       {
> +               write_item("username", username_buf, strlen(username_buf)=
);
>                 return;
> +       }

According to the documentation for CFStringGetCStringPtr(), the
returned C-string is not newly-allocated, so the caller does not have
to free it. Therefore, can `username_buf` be declared `const char *`
rather than `char *` to make it clear to readers that nothing is being
leaked here? Same comment about the `(char *)` cast.

> +       /* If we can't get a CString pointer then
> +        * we need to allocate our own buffer */

Style:

    /*
     * Multi-line comments
     * are formatted like this.
     */

> +       buffer_len =3D CFStringGetMaximumSizeForEncoding(
> +                       CFStringGetLength(account_ref), ENCODING) + 1;
> +       username_buf =3D xmalloc(buffer_len);
> +       if (CFStringGetCString(account_ref,
> +                               username_buf,
> +                               buffer_len,
> +                               ENCODING)) {
> +               write_item("username", username_buf, buffer_len - 1);
> +       }
> +       free(username_buf);

Okay, this explains why `username_buf` is declared `char *` rather
than `const char *`. Typically, when we have a situation in which a
value may or may not need freeing, we use a `to_free` variable like
this:

    const char *username_buf;
    char *to_free =3D NULL;
    ...
    username_buf =3D (const char *)CFStringGetCStringPtr(...);
    if (username_buf) {
        ...
        return;
    }
    ...
    username_buf =3D to_free =3D xmalloc(buffer_len);
    if (CFStringGetCString(...))
        ...
    free(to_free);

But that may be overkill for this simple case, and what you have here
may be "good enough" for anyone already familiar with the API and who
knows that the `return` after CFStringGetCStringPtr() isn't leaking.

> +static OSStatus find_internet_password(void)
>  {
> +       CFDictionaryRef attrs;
> +       [...]
>
> +       attrs =3D CREATE_SEC_ATTRIBUTES(kSecMatchLimit, kSecMatchLimitOne=
,
> +                                     kSecReturnAttributes, kCFBooleanTru=
e,
> +                                     kSecReturnData, kCFBooleanTrue,
> +                                     NULL);
> +       result =3D SecItemCopyMatching(attrs, (CFTypeRef *)&item);
> +       if (result) {
> +               goto out;
> +       }

We omit braces when the body is a single statement:

    if (result)
        goto out;

(Same comment applies to other code in this patch.)

> +       data =3D CFDictionaryGetValue(item, kSecValueData);
> +       [...]
> +
> +out:
> +       CFRelease(attrs);

Good, `attrs` is released in all cases.

> +static OSStatus add_internet_password(void)
>  {
> +       [...]
> +       attrs =3D CREATE_SEC_ATTRIBUTES(kSecValueData, password,
> +                                     NULL);
> +       result =3D SecItemAdd(attrs, NULL);
> +       if (result =3D=3D errSecDuplicateItem) {
> +               CFDictionaryRef query;
> +               query =3D CREATE_SEC_ATTRIBUTES(NULL);
> +               result =3D SecItemUpdate(query, attrs);
> +               CFRelease(query);
> +       }
> +       CFRelease(attrs);
> +       return result;
>  }

Good, `attrs` and `query` are released in all cases.
