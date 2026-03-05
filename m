Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62358366043
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752607; cv=pass; b=b3jcKe2NRE80qJ+jIia6gKc7iCNNrcCahb4p8rO5viaMZ5JUqQ32pnphb61lmqXPsHSByoBGyRRLTDe7XdJSwtYjO8QKG4QHfY30HSMoDY5xCTW48i/4RMHxZSSKjBXLtNcYw+9fJMoezTASwyHBWmBy/atK/2ryEHKKQt7VLno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752607; c=relaxed/simple;
	bh=AeCFjVXpLbbNIb8CTsP0Z5vjPQmkwP1iq3GDHUHrmlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V01MZ6oQxN15Zx699GgnyAOZDxYJrQaRtStb3/aHphdqVXX4NeLz+5jz25E5amW38aljwU2RPIQZhPySSWxjGamWH+1BMf5BOiKTnfYLpHmRS/KxKTbFuX8KYEYzIltjrQAQlVy8Kc1fnGnTVu0/6bRno0Rgo31h9PKNLmVdFtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4yr2AD5; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4yr2AD5"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6759a5576f5so6035291eaf.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 15:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772752605; cv=none;
        d=google.com; s=arc-20240605;
        b=ElPZSa7TF8Mq0zjofw5lH+YP2RfrLrosdSdY8miHolDD8BXvl2onKH/UY7AGi8lqwP
         x3b+Nr2Fdz6H+x23t6jnGYn7p5BFFQaJxk7qstgpWh36o0Ef1J5GVlddv9wEmsdvuo9T
         hhVnPUHyKKFlYL1ePf/HrPT5srFSf+rQ7+8numgML3G1NvrAjvKCLMuj+iMHLCFCx8ut
         UONwoFxn1h+eSRrW2r4Rzs1uDK3vc922Dby927JsYLleOpjR+SlnJsKFFoGWiii0Z++B
         ZLMYbhO1gTZtZPAZdZFlE/q7bMjheqEONzIXbfP2FDMH0QI1p4T7qOefeBM4rPGX8vEk
         aMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vPjjLFpQA/I670v+wyJ7DcSo6eaokVqHtIzSlUFHejE=;
        fh=QdKQB88OiOFVFHDP5V/X6bCh1fS8U4BKZcf/TQxiYm4=;
        b=c3QG77O/v9We3ex8Taa69XNJ8pyp1GGMMz/kVaToHG2lg55QDOqGoXTYK632OwhMa4
         qKHhzThLFTRd/cAFTwtXMm/A18ltedDcSsd5PzeGxnRheuKoSom3YDilPHwrZ0pbmsZS
         XNBN2qncpLSFp9Oli9AK0mw1wbBCz9gUEghBjwhyyIC2iz0MG4H0sbiVX1doOfnpdYAo
         W9hlX5bpsYl9l5u6MAMEn9Efohy6WbMYMccxfkWeqgRLcwOFUCFjo3tHE/hEh3R9yq/n
         ILHF3CVieg59GQZc7zMjWgN0me2OYCOUwbd1W3c9htjYRuQBPJotS2ZdanKQU5a0zYnM
         68oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772752605; x=1773357405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPjjLFpQA/I670v+wyJ7DcSo6eaokVqHtIzSlUFHejE=;
        b=G4yr2AD5/JbRupHTStTxM0iP3RH9kKmSXa2NuLWKrc8TSXlS6TE68wtuaNXmmUVhf2
         1o1UbZn9XyMWxgPk4RD1D/cHoufEwxtuUfRvhgEK2jQHJjXkz7cAjkkCQkkutnCQrIUX
         bVvtR12415n9a/cDOHy/dDk87gK+yI3TaLw7OhfzYM2GXVLSW5FOKLcNe/IyUVi2nsP6
         t/L3k+l2OEaHl9uFhFr3WFkyFFdzstSedW7j3CjSoS/caU27krLsDfPoFhtPbOC4FtDp
         +iyY4ICDTd/HGTCV4iKixu3AHfopgZUqHzxH63VEZiTuCJ0eYjcf+MeuoPwXLWplTGnP
         9aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772752605; x=1773357405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPjjLFpQA/I670v+wyJ7DcSo6eaokVqHtIzSlUFHejE=;
        b=CKVDWbvyH/xvDP7u0Q4GMStk5kTGOq4Zhd8a59eegBEpwqIe2Vh96jg9M+xpgLCyXl
         wnWcSI858yxQIoqtXZC4SOHNje+OFL8z7fZKRZ8OPxjVX7MqW/aYsBo91e0+mtLFAweo
         +3ht7+hVtdxKT2lmajLAEVMAnmMl9G86NNfXF11fV76zQTU0/hmhPaorZ/Sn57CjGsv3
         ZEZwkCsMZPMEUb9KAYDxQnnij95DBaumHxYyMsp55Tg5bntLuBfsNzo7bNKLe2jIrDns
         l9OvSSDtf/MsaXuMnauY0NKTQLE4IlIWy0nY9hmsAJSVam62NSs+TLyQaP3AaVKUsN63
         BWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBWvN1du3rYyUugxA7fuR1ZrT1+jI9hGoJGI770lHg94G4CB50oP4upr6q+ptfJsytpfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCbPes6W+wwUzhGuf6fZ6hrzV2gtG7xp4ZPmlduZgKZzqaS81
	nXoP6kauNkwZvKXCak/tRaOuD4bzCrJiRx6lFu9gs2TCfRIGl2Wnkkaac8DOY4GOAaCzb+skxCY
	XI5aiU669CWdiZBN3+PycpUvmX22Z1WblAQ==
X-Gm-Gg: ATEYQzyIg7pmgOgu3D6wutKsL4tNC9VH7EkUTdjojHWKOahmvoBRBdioCpRQ52atKNV
	uz0QfCDrhPGoFkOfPrdz/L+OZRYTkf38izGDDD0xN2pnklwwhfJHiGUEr+bQPf+lmLcBBMpgRi+
	rWHneNrQP3DWIKtMyjH20mqCL+2/rWKZ2gqLV6tk5kAxqMEPNPezoo6WULSoYo2KMHYiaSe5ACV
	rEOwjwCTzPGkk3OzHOI6OlhrPdKy+0s2QmHKdS9RtITsS4LcAm4Z6UYzSdxIqZ6tqjnSlE+3yIU
	MKXYog==
X-Received: by 2002:a05:6820:f07:b0:67a:608:8dff with SMTP id
 006d021491bc7-67b9bd49544mr169851eaf.61.1772752605280; Thu, 05 Mar 2026
 15:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com> <20260305220214.GB736322@coredump.intra.peff.net>
In-Reply-To: <20260305220214.GB736322@coredump.intra.peff.net>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 5 Mar 2026 15:16:35 -0800
X-Gm-Features: AaiRm51vswMAJWEE8X53PWDOXWcQZK8uDRb024r-ENWDgZDVmEYj8xVQYnqsPkc
Message-ID: <CA+P7+xp7HTykrBdr8WKb__M3Hj09-WQ6HRrTb9ZiHbWV1U=GhA@mail.gmail.com>
Subject: Re: memory leak when cloning a repository
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 2:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 05, 2026 at 12:51:17PM -0800, Jacob Keller wrote:
>
> > I tried digging into why this leak occurs but so far I don't have a goo=
d idea.
> >
> > This happens when running on next: 7842e34a6654 ("Sync with 'master'")
>
> I can reproduce it on master. This seems to fix it:
>
> diff --git a/connected.c b/connected.c
> index 79403108dd..e0f8ff38cb 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -90,6 +90,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  promisor_pack_found:
>                         ;
>                 } while ((oid =3D fn(cb_data)) !=3D NULL);
> +               close_pack(new_pack);
>                 free(new_pack);
>                 return 0;
>         }
> @@ -128,6 +129,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>                 rev_list.no_stderr =3D opt->quiet;
>
>         if (start_command(&rev_list)) {
> +               close_pack(new_pack);
>                 free(new_pack);
>                 return error(_("Could not run 'git rev-list'"));
>         }
> @@ -162,6 +164,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>                 err =3D error_errno(_("failed to close rev-list's stdin")=
);
>
>         sigchain_pop(SIGPIPE);
> +       close_pack(new_pack);
>         free(new_pack);
>         return finish_command(&rev_list) || err;
>  }
>
>
> I think this has been leaky forever, but it's usually leaking a single
> mmap, so nobody notices. But I noticed something odd about your trace:
>

Wow thanks for the quick response. I tried looking at this but I
wasn't sure where it was correct to put the pack and I was having
trouble tracking the storage of the mmap through the compat_mmap.

Yea, we're leaking but its not a huge deal if the program is about to
exit generally.

> > Direct leak of 27168 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f0e100e6f2b in malloc (/lib64/libasan.so.8+0xe6f2b) (BuildId:=
 25975f766867e9e604dc5a71a8befeaed3301942)
> >     #1 0x00000122ab77 in git_mmap ../compat/mmap.c:15
> >     #2 0x000001169466 in xmmap_gently ../wrapper.c:884
> >     #3 0x00000116959b in xmmap ../wrapper.c:907
> >     #4 0x000000d168fd in check_packed_git_idx ../packfile.c:179
> >     #5 0x000000d16cce in open_pack_index ../packfile.c:282
> >     #6 0x000000d25273 in find_pack_entry_one ../packfile.c:2078
> >     #7 0x00000099f969 in check_connected ../connected.c:148
>
> We're in the compat git_mmap, which implies you're building with
> NO_MMAP. We turn that on automatically when building with ASan (so that
> we can detect single-byte overflows even when mmap would round up to a
> page boundary). But as a side effect, the "mmap" for index and pack data
> is done with a heap-allocated buffer. So now ASan/LSan will notice and
> complain about it.
>
> We usually disable leak-checking for our ASan builds, so we wouldn't run
> the tests with the compat mmap. And our leak-checking builds use LSan,
> which doesn't set NO_MMAP. But if you combine them with:
>
>   make SANITIZE=3Daddress,leak
>

Right. I built with meson and set the option to build with
-fsanitize=3Daddress. I might have set leak too I am not certain. I was
not aware of the NO_MMAP.

> or even just build with:
>
>   make NO_MMAP=3DMallocHarder SANITIZE=3Dleak
>
> then the leak will be reported. I guess maybe you're building with
> SANITIZE=3Daddress, but then running the result independently, without
> setting ASAN_OPTIONS=3Ddetect_leaks=3D0.
>

Ya, I don't have that set. The only options I have is (as of recently)
to set LSAN_OPTIONS=3Dexit_code=3D0 to avoid changing the exit code on a
leak detection (after many hours wondering why my bash completion was
failing due to the leak I reported a while ago...)

> Anyway, I think the solution is probably something like the patch above,
> though probably it needs to cover the case where new_pack is NULL.
>

I can double check that later today. Its low priority, but I do think
it is important to avoid leaks since code can be refactored into
library status over time where a leak becomes more problematic.

> -Peff
>
