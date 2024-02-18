Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE96BFB1
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708267741; cv=pass; b=Hie5v2ZTMpyj0FS+1oy+eG+p89xu9qknAa8vVPsWPXL9a7+PH/hFBnZSPrOjlxfrdLvrBk28QJd+CXOcUI0piRf7BunB9HxQAxP+8t5LOz6icMUgGT6RYcyDEjij+OlhlhdNEgXLPadwfGPjU0MLDCVEl336FOY4f3Z9E6553RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708267741; c=relaxed/simple;
	bh=N2h14mZhBrfg4DXBH9nzCvrQzMy2GQ4OvhXCiBCq6lw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ucPp/6tD/8Obf6jrxLB+RGZrsr3LNYdXFXuYPIgbgOAdv22UhHxyPmHZlhPgx0tVBjoZ6Zl8/R5F3ZYIlUj0nwTZxYujRv4k2Y/zjBgDTDpHBemCz7aug0JrMa6SouPwZA+v/0qUfrgJ3GU3lD193mMBuo1HOFw5gaOxjc5MVsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me; spf=pass smtp.mailfrom=boanderson.me; dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b=dnXTNAdI; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boanderson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b="dnXTNAdI"
ARC-Seal: i=1; a=rsa-sha256; t=1708267735; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZRibY4/X8tQbt6Mw4KxTbAcQJ4G+s26oXiquKRRhRcm+PfEw+BAOHSlCNpFPX0y0YyRUlzX4V9mdpWbQ8joknULFoKU3B+sxSIHpQa02KyLwNisAadKa4C0crWY9bD9EFUzWi+AzR5O+O+qNcX8oW01Yt7Nhgnip2v0LFe6fr9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708267735; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WOwpDzTJmqO3MGho9e1V5H7sUUSD5dtz3S5D76NCZkA=; 
	b=ZToWmt+VetO24C3CP1uriF+2TGHPg3uNLpze0pCIxIbVKPZKrDeL7tbF0fWEas5LPbjNLcJ3Wx/lmxeODy3FT1TZecXrahMxFoqam4LJXIxkuW+9TuYYd4IhyqGEbXnk/2NnZq7N2GaLWJ4hAM2uZHRZzeUSwmkJiaMB9hj5Sqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=boanderson.me;
	spf=pass  smtp.mailfrom=mail@boanderson.me;
	dmarc=pass header.from=<mail@boanderson.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708267735;
	s=zoho; d=boanderson.me; i=mail@boanderson.me;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=WOwpDzTJmqO3MGho9e1V5H7sUUSD5dtz3S5D76NCZkA=;
	b=dnXTNAdIYVs5hX7Pgg/a/DHxmNm5n+Q4yNs6JqsJSqxAQhbAo6yGdnUHnq8Jna9r
	aBFaRGIsuw2NNJ/WWT08IBqu+LnDDnC+vJGbHYCGokTo2jqTIPqA9VH943NpF2MAy21
	EjRguIvUQjCjU3foMTcLyidJHwI5s5ccCd+sGSho=
Received: from smtpclient.apple (w-65.cust-u5093.ip.static.uno.uk.net [212.105.168.65]) by mx.zohomail.com
	with SMTPS id 1708267733608397.459673733846; Sun, 18 Feb 2024 06:48:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/4] osxkeychain: replace deprecated SecKeychain API
From: Bo Anderson <mail@boanderson.me>
In-Reply-To: <CAPig+cR_XYjArdYpU-qm+Wont=yEEXe5hANRyz+YRdhv=UZf=Q@mail.gmail.com>
Date: Sun, 18 Feb 2024 14:48:41 +0000
Cc: Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFC4D25B-D6ED-4706-A804-CA0183B84604@boanderson.me>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <f7031316a043b36fac10ecf784d2294894967e7b.1708212896.git.gitgitgadget@gmail.com>
 <CAPig+cR_XYjArdYpU-qm+Wont=yEEXe5hANRyz+YRdhv=UZf=Q@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-ZohoMailClient: External

> On 18 Feb 2024, at 06:08, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> I haven't studied the SecItem API, so I can't comment on the meat of
> the patch, but I can make a few generic observations...

Thanks for taking a look!

>> diff --git =
a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
>> @@ -3,14 +3,39 @@
>> -__attribute__((format (printf, 1, 2)))
>> +#define ENCODING kCFStringEncodingUTF8
>> +static CFStringRef protocol; /* Stores constant strings - not memory =
managed */
>> +static CFStringRef host;
>> [...]
>> +
>> +static void clear_credential(void)
>> +{
>> +       if (host) {
>> +               CFRelease(host);
>> +               host =3D NULL;
>> +       }
>> +       [...]
>> +}
>> +
>> +__attribute__((format (printf, 1, 2), __noreturn__))
>=20
> The addition of `__noreturn__` to the `__attribute__` seems unrelated
> to the stated purpose of this patch. As such, it typically would be
> placed in its own patch. If it really is too minor for a separate
> patch, mentioning it in the commit message as a "While at it..." would
> be helpful.

Acknowledged. It is indeed a bit of a nothing change that doesn=E2=80=99t =
really do much on its own, but when paired with the port variable =
reorder could potentially make a =E2=80=9Cminor code cleanup=E2=80=9D =
commit.

>> +       va_start(args, allocator);
>> +       while ((key =3D va_arg(args, const void *)) !=3D NULL) {
>> +               const void *value;
>> +               value =3D va_arg(args, const void *);
>> +               if (value)
>> +                       CFDictionarySetValue(result, key, value);
>> +       }
>> +       va_end(args);
>=20
> A couple related comments...
>=20
> If va_arg() ever returns NULL for `value`, the next iteration of the
> loop will call va_arg() again, but calling va_arg() again after it has
> already returned NULL is likely undefined behavior. At minimum, I
> would have expected this to be written as:
>=20
> while (...) {
>     ...
>     if (!value)
>         break;
>     CFDictionarySetValue(...);
> }
>=20
> However, isn't it a programmer error if va_arg() returns NULL for
> `value`? If so, I'd think we'd want to scream loudly about that rather
> than silently ignoring it. So, perhaps something like this:
>=20
> while (...) {
>     ...
>     if (!value) {
>         fprintf(stderr, "BUG: ...");
>         abort();
>     }
>     CFDictionarySetValue(...);
> }
>=20
> Or, perhaps just call the existing die() function in this file with a
> suitable "BUG ..." message.
>=20

In this case it=E2=80=99s by design to accept and check for NULL values =
as it greatly simplifies the code. Inputs to the credential helpers have =
various optional fields, such as port and path. It is programmer error =
to pass NULL to the SecItem API (runtime crash) so in order to simplify =
having to check each individual field in all of the callers (and =
probably ditch varargs since you can=E2=80=99t really do dynamic =
varargs), I check the value here instead. That means you can do =
something like:

 create_dictionary(kCFAllocatorDefault,
     kSecAttrServer, host,
     kSecAttrPath, path, \
     kSecAttrPort, port,
     NULL)

And it will only include the key-value pairs that have non-NULL values.

It would indeed be programmer error to not pass key-value pairs, though =
it is equally programmer error to not have a terminating NULL.

>> +       username_buf =3D (char *)CFStringGetCStringPtr(account_ref, =
ENCODING);
>> +       if (username_buf)
>> +       {
>> +               write_item("username", username_buf, =
strlen(username_buf));
>>             return;
>> +       }
>=20
> According to the documentation for CFStringGetCStringPtr(), the
> returned C-string is not newly-allocated, so the caller does not have
> to free it. Therefore, can `username_buf` be declared `const char *`
> rather than `char *` to make it clear to readers that nothing is being
> leaked here? Same comment about the `(char *)` cast.
>=20
>> +       /* If we can't get a CString pointer then
>> +        * we need to allocate our own buffer */
>=20
> Style:
>=20
> /*
>  * Multi-line comments
>  * are formatted like this.
>  */
>=20
>> +       buffer_len =3D CFStringGetMaximumSizeForEncoding(
>> +                       CFStringGetLength(account_ref), ENCODING) + =
1;
>> +       username_buf =3D xmalloc(buffer_len);
>> +       if (CFStringGetCString(account_ref,
>> +                               username_buf,
>> +                               buffer_len,
>> +                               ENCODING)) {
>> +               write_item("username", username_buf, buffer_len - 1);
>> +       }
>> +       free(username_buf);
>=20
> Okay, this explains why `username_buf` is declared `char *` rather
> than `const char *`. Typically, when we have a situation in which a
> value may or may not need freeing, we use a `to_free` variable like
> this:
>=20
> const char *username_buf;
> char *to_free =3D NULL;
> ...
> username_buf =3D (const char *)CFStringGetCStringPtr(...);
> if (username_buf) {
>     ...
>     return;
> }
> ...
> username_buf =3D to_free =3D xmalloc(buffer_len);
> if (CFStringGetCString(...))
>     ...
> free(to_free);
>=20
> But that may be overkill for this simple case, and what you have here
> may be "good enough" for anyone already familiar with the API and who
> knows that the `return` after CFStringGetCStringPtr() isn't leaking.

Would it make sense to just have a comment paired with the =
CFStringGetCStringPtr return explaining why it doesn=E2=80=99t need to =
be freed there? I=E2=80=99m OK with the to_free variable however if =
that=E2=80=99s clearer. Idea in my mind was pairing it based on =
`xmalloc` but I can see why pairing based on variable is clearer.

