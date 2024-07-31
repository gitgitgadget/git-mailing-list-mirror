Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159551AD9F6
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431279; cv=pass; b=asQ+AnYQGg3V/v5IkdgMjOGy6Ds9dqqkeFkyuH7t/UIIKMVlVIg6MHTyYSdrXQ9NDu2xjDS5ow4Ec28DVYLMkqE9pRk1Iy4ds91J/fcENxGBBy9g6WUqtBB4F9vJcYysnZz8TpumcHLl9yRlB4xcEb5BbHgQ+f9ezUv8/6KXlSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431279; c=relaxed/simple;
	bh=hjs+wSqgfIOswzXvF3Meq3wafiMjl9a7Y42QHw109bo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ivakXqK5g3A9DxSItu0r/Sw9+dT3aG+zSrxKBR4XH78Qst5RvbSsnNWYWXTZaxBN3SC1BUOjrh4irXS2UujdYOOvOxLvh5YvOGLucoPq87rWPb8A2RGmqy5sBVIQt42ZcltiiWZtG6eCxwbRtOJvOKwkDS5BLvYFpzYaQrcJ3II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me; spf=pass smtp.mailfrom=boanderson.me; dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b=doN6Ot4o; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=boanderson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boanderson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=boanderson.me header.i=mail@boanderson.me header.b="doN6Ot4o"
ARC-Seal: i=1; a=rsa-sha256; t=1722431269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cDAypWDZUpH/o8QB/WQyO5scOof3J9apjzThVDh75A7vjsRgkpXo4KV5AXuF3Oy3flXhHNxTA8lbkNalfytCR7h0AQqdJcZg5m1JdDi+UmzKRZCQSMAZiByYms7+xnbLtywLMEtCgeTRBx00hrVrkLSLT+fCYapCCvi9KvFT0z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722431269; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EcndRTqWKBOsaNISPkRn8sKna0IInP7tAJ3R4zm4rXI=; 
	b=KYSr18Eumr+4hgRyo8jwI/mlbvpwOwZfzDlD6D0i+SG8NGODFkSU2j0NcI5aKRe9pgDLrezDomm+ovXX/7ZJmrV0HfPfpGo4gsX0jQzgzo0b3vGPhMQhtcCFcuXj8foEvktvCgtsSFL4uR+iwPUYqJhlKsX2RlPmize/zKJ+YKA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=boanderson.me;
	spf=pass  smtp.mailfrom=mail@boanderson.me;
	dmarc=pass header.from=<mail@boanderson.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722431269;
	s=zoho; d=boanderson.me; i=mail@boanderson.me;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EcndRTqWKBOsaNISPkRn8sKna0IInP7tAJ3R4zm4rXI=;
	b=doN6Ot4oaTwEa27UuUi6lJDIzZid/4h0STsmovLzQ45+h0t9NWudLjorg1nySK74
	pqYhVdF36TbxYHhARdYjN1aoUE0prtizkPb4EAe/Uj1+n2dh3f1h9eZdSbaLbeKwjrs
	N/u9+T7JGnYg0GQy77+zQywDbxmnO2KO98F/A30A=
Received: by mx.zohomail.com with SMTPS id 1722431265884861.4821840265395;
	Wed, 31 Jul 2024 06:07:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [patch] credential-osxkeychain: Clear username_buffer before
 getting the converted C string.
From: Bo Anderson <mail@boanderson.me>
In-Reply-To: <20240731074228.GC595974@coredump.intra.peff.net>
Date: Wed, 31 Jul 2024 14:07:32 +0100
Cc: Hong Jiang <ilford@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
 <20240731074228.GC595974@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-ZohoMailClient: External


> On 31 Jul 2024, at 08:42, Jeff King <peff@peff.net> wrote:
>=20
> Hrm. Just looking at the code, here's a wild hypothesis: the problem
> could be not that the buffer is not NUL-terminated, but that after the
> NUL it contains junk, and we print that junk. That is, the code looks
> like this:
>=20
>          /* If we can't get a CString pointer then
>           * we need to allocate our own buffer */
>          buffer_len =3D CFStringGetMaximumSizeForEncoding(
>                          CFStringGetLength(account_ref), ENCODING) + =
1;
>          username_buf =3D xmalloc(buffer_len);
>          if (CFStringGetCString(account_ref,
>                                  username_buf,
>                                  buffer_len,
>                                  ENCODING)) {
>                  write_item("username", username_buf, buffer_len - 1);
>          }
>=20
> So we asked the system for the _maximum_ size that the string could be
> (and added one for the NUL). Then we got the string, and we printed =
out
> the _whole_ buffer, not just the string up to the NUL. And your fix
> "works" because NULs end up getting ignored on the read side (or at
> least cause ruby not to complain about bogus utf8).
>=20
> If that hypothesis is true, then the fix is more like:
>=20
> diff --git =
a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6ce22a28ed..1c8310d7fe 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -141,7 +141,7 @@ static void find_username_in_item(CFDictionaryRef =
item)
> 				username_buf,
> 				buffer_len,
> 				ENCODING)) {
> -		write_item("username", username_buf, buffer_len - 1);
> +		write_item("username", username_buf, =
strlen(username_buf));
> 	}
> 	free(username_buf);
> }

This is correct.

The reason I couldn=E2=80=99t reproduce the problem and how few will =
have noticed up to
now is that for most users the CFStringGetCStringPtr call, which =
correctly uses
strlen, does what is necessary and we return early. I don't entirely =
know the
precise criteria where the fallback is used but I imagine it depends on =
certain
system encodings/locales.

The patch changing this to strlen looks good to me to apply to master & =
maint.

Bo

