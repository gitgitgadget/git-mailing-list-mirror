Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C463A451B
	for <git@vger.kernel.org>; Fri,  8 May 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232799; cv=pass; b=t2hbUgBf35fIByySb7JYcnyjpMZzn7usjCwGkxOtRciSRdaqZl3P5ttAvYFvcqLnyMbPRd3vHZxOzC24OpbXbH5a433t1jsa2F+ln7WoD7++QiorAtEzqEfgZABTqGDVFs6l+klpxIrnsEXELVenBBRGDY1J/hd76o5EJVUI+6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232799; c=relaxed/simple;
	bh=gJQyEiTzHT7VUOCzZ2xuXVnygMxsS4uscUUI8QKsXJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Urb3HvsntakfdFk/ilJVv4OFluqAWLDzojOJEbbks6TZ/TPL5ValrFRZYn3wvfK7Rs5UZG63UVa2bCkct4+mQEGw1PfqX1VEcnO0FJesFcqcXiXAg829dSoAup0Nm0ZoK/MGFhyeBV+wBYnwaVz1aW0ShY3DhR7U9kgxzkipZb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=hLDa0y/n; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="hLDa0y/n"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f30a4601bbso1958173eec.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 02:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778232797; cv=none;
        d=google.com; s=arc-20240605;
        b=GsCQW5ti2imMw/kHY0aQk8+iybRDFnFcSnrHCSV3lnNtU9weyFljY03OSOM2CPQ3DZ
         aDgSQ+HNFXm0BglYqOPGcWT9Ef0FK+SuxoUmSHI8f1CZNQTiSye20C2LLGkLoU2eGOe5
         dtVgQdW2eA4jYfyLxp34tw+ejAlAajri42EZ8NygFUbQkBNu0TZnXOeXoPCRmabESe34
         ZMkvYlXR2QcZqtESCpstM54L1WEP3Hk5vCWL8vYVtbuZ41SZ1FqQKJApZ24tuECQ8VQb
         W5QqJ6NYUkLnTgQdohg3i9unCinN83DWiXWZQC1dXeIgwIZAiI8Q1wPQ+Nfaln3zkrvl
         8HXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KVNOTL5HtH+9yqFJSDTcLodAanX6nmk0Inq9K+dyUCA=;
        fh=Car1/DDP1W8+TrPjU8yHXmh7iwiLqJHY+QqtUbVQB90=;
        b=dYGh243ph5ybNGxlrgXC0lWKQ6QALbLgYxGq9fllal4KVWGM3l7O7Tu1JQP+53BhGx
         5FLhk5XlfuEyshUfauz2SuL2yw9O1UyCIIzPf6vi3ZvPAY/nKsuWD+zcn1bfthLvJ54R
         RuQxJd6fcjBP7mL0gst9+SkGO0usYOWjKioqNkxgPJoUs8IUSlwzj70fc/dI1AlLPT1c
         eCY7OHIRcFATBQ1r3ymhdMmGFv84nelc1A7I/NBDBWT3g0SvNrE6ysZnbkbG/ldvNGgG
         an+lF0DoMPV8FXAp4lxbSSAZL+V9jwVXzn/U7mIiaUM4oLcob9mfN3pV4/9CiMBViB71
         CYjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1778232797; x=1778837597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVNOTL5HtH+9yqFJSDTcLodAanX6nmk0Inq9K+dyUCA=;
        b=hLDa0y/n6RxxnoA/AKqveWnnc7C0toRXYahCpv+goZQRWRFxBpVMlyGSKTsE/yIBeb
         lcQ5LIlY0ucslVx3SLMnT+DoiXEMhXVuRWCLabLo8XcHKIoyJdOWGCWPYIVHsunW4+8j
         aXE4HkEOR7pGYyfZu85kmAmeY2Pl0HAU9OxvqQvv6XQsDRLs6QbzhNJwlsmAsilp+2tj
         AL0ibqH8eO8+x3ruFlc/5nCZLX/5ODFwabp3bT0QNXsPHWZQXwGZ/kh+45LBWDSW0v+P
         6Dl22negzxGi8TLsc83hbTewao1687cirXNqxm3I8FaO/SSIgmwcnwxJhCQxisoWYXTc
         Jmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778232797; x=1778837597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVNOTL5HtH+9yqFJSDTcLodAanX6nmk0Inq9K+dyUCA=;
        b=o40SvAZylMjnlUCMV5e8unnWcmSllJo2v26u1oV/G3SN6/+uRr8bw5r/SapS11Oz8f
         fUBRui7/TfHFnlJSmdgSqt1btSMx2vBj63Zq5mw/2Qgc+Wj5XMTnVqhDedKofAys1Vki
         STr//cbi9OiR8AIsmXiNZRekTZg8u8Qpv1lhLSqg/dRPrsayv/rhf6xTNyoO7kAP6G2c
         ggvKraYZUTczBsnnbd7v9z6sMtCBY06yn23Ja5eTTpNZsZ2Vy+kAZjxcj8D7HEFYB2Kb
         WZ81DJrnbb8PHjBpI+jyTlXHRbDEwU1tOTz+/qWhV9W3WNZ1BBnVkpsgMvnwoH4LplU2
         ZhPA==
X-Forwarded-Encrypted: i=1; AFNElJ8NDMzacOn1Gla1SI3szh+ERFujuvUo03/G79ZUVNLi9SVtMQNqy2u+eY3R7zRJy5rs8zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkLCwR1gbo26VE8eB2FcgfB8amvYfYPa6sJfF5Y0RXGVglISP
	cWxQH641huPYQsZBaFPQHXSorR6AtJ1e7prW3/bqTLaHLoBQ8/oUPRfqh42rDcrKXhsjkqjIkr/
	CpsTHibqcphHM8M2yyxuQDzm6CKCWJ2ViwJd6pSRzxFmJDYf/cu7VdyFTKxHkBlDcy1A52rMHwA
	WzY45bp4hqXw7787dShThnuXTYuE5KbVm8hyGwskqtiLdFQrKhXP7dtXwsHpqil1qEwxonabCHK
	jN3Fj2c2z59D3XyJoN+KoaI5mx+lBPzgIbN5HYeIuTBntEymjynlekTTJ/Wmdq8izSEYmAm6TO/
	kBn9UX6FfYnveek=
X-Gm-Gg: Acq92OGS7ifb1/riQeibF/CP/34rtEGQJPN0OBd1TudQUeXMdf4N9J0mP2UXAb6dBsC
	pPerOH2so+rjT9xoVe5atFSSeNt9Vf7W7T5hgPbpWKGwFinaScOIWNJIExMUtdVnXj4qR8eHS7p
	cUe+chpcVsFHDWKajCRdYm2jIAG5akgx1oVEOkHoVA8vS8x8zzJ37D0Eg7pdal5jJCRsM8qSo3N
	okXZYJZGzZXo8+fS1UIlhZlOCGaqEieW4eKJbh0rcl3fCOqY0qfDHpgjLZF5QeKqmzMLXPtBY8a
	lRdc5SnCbYTznQoQbAU=
X-Received: by 2002:a05:693c:2c02:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-2f54d79b90fmr5820975eec.22.1778232796294; Fri, 08 May 2026
 02:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com> <xmqqlddufw5d.fsf@gitster.g>
In-Reply-To: <xmqqlddufw5d.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 8 May 2026 18:33:04 +0900
X-Gm-Features: AVHnY4J-v4ehZv5HLo3PyLtZLGmiGnUqgmhtd-lmCQxl2RDiOyogkCe-UQ6hgUc
Message-ID: <CAOTNsDyygMEz4dgfkWKb=wWP0g9MhNFgDHzPPEODbMGmDQLTOQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: link osxkeychain helper against Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Shnatu <snatu@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 11:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Shnatu <snatu@google.com>
>
> If your name is "Shardul Natu", we'd prefer (not 'require', but
> 'prefer') that the patches authored by you also identify with that
> name, both on "From:" and "Signed-off-by:"..
>
> > When Rust is enabled, ensure that the git-credential-osxkeychain
> > helper is linked with the necessary Rust libraries.
> >
> > Introduce the RUST_LIBS variable inside ifndef NO_RUST block
> > to hold the Rust library dependency, and use it in the helper's
> > build target. This cleanly handles cases where Rust is disabled,
> > making it a no-op and avoiding any build failures on systems
> > without Cargo.
> >
> > This addresses reviewer feedback from internal CL 910223487
> > by simplifying the variables and avoiding confusing "LINK"
> > terminology.
> >
> > Signed-off-by: Shnatu <snatu@google.com>
> > ---
> >     Makefile: link osxkeychain helper against Rust
>
> Thanks.  I've added to CC: a few folks who may be more clueful in
> the affected area than I am.  It somehow feels strange that we have
> to have RUST_LIB and RUST_LIBS separately, and apparently with the
> new definition the latter is expected to be a superset of the
> former, and it is unclear what are the things that should be added
> to the latter without getting added to the former.
>
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2=
288%2Fkiranani%2Fnext-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288=
/kiranani/next-v1
> > Pull-Request: https://github.com/git/git/pull/2288
> >
> >  Makefile | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f86173f93a..a17dca22b1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1593,6 +1593,7 @@ ALL_LDFLAGS =3D $(LDFLAGS) $(LDFLAGS_APPEND)
> >  ifndef NO_RUST
> >  BASIC_CFLAGS +=3D -DWITH_RUST
> >  GITLIBS +=3D $(RUST_LIB)
> > +RUST_LIBS =3D $(RUST_LIB)
> >  ifeq ($(uname_S),Windows)
> >  EXTLIBS +=3D -luserenv
> >  endif
> > @@ -4082,9 +4083,9 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
> >  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
> >       $(AR) $(ARFLAGS) $@ $^
> >
> > -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/cre=
dential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
> > +contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/cre=
dential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIBS) G=
IT-LDFLAGS
> >       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> > -             $(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Securi=
ty -framework CoreFoundation
> > +             $(filter %.o,$^) $(LIB_FILE) $(RUST_LIBS) $(EXTLIBS) -fra=
mework Security -framework CoreFoundation
> >
> >  contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/c=
redential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
> >       $(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLA=
GS) $(EXTRA_CPPFLAGS) $<
> >
> > base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2

How about simply wrapping the RUST_LIB-related sections in ifndef
NO_RUST, as shown below? This way, we can avoid defining
RUST_LIBS.

diff --git a/Makefile b/Makefile
index f86173f93a..daa1691950 100644
--- a/Makefile
+++ b/Makefile
@@ -947,11 +947,13 @@ else
 RUST_TARGET_DIR =3D target/release
 endif

+ifndef NO_RUST
 ifeq ($(uname_S),Windows)
 RUST_LIB =3D $(RUST_TARGET_DIR)/gitcore.lib
 else
 RUST_LIB =3D $(RUST_TARGET_DIR)/libgitcore.a
 endif
+endif

 GITLIBS =3D common-main.o $(LIB_FILE)
 EXTLIBS =3D
@@ -3027,11 +3029,13 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
        $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^

+ifndef NO_RUST
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
        $(QUIET_CARGO)cargo build $(CARGO_ARGS)

 .PHONY: rust
 rust: $(RUST_LIB)
+endif

 export DEFAULT_EDITOR DEFAULT_PAGER

@@ -4082,9 +4086,9 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
        $(AR) $(ARFLAGS) $@ $^

-contrib/credential/osxkeychain/git-credential-osxkeychain:
contrib/credential/osxkeychain/git-credential-osxkeychain.o
$(LIB_FILE) GIT-LDFLAGS
+contrib/credential/osxkeychain/git-credential-osxkeychain:
contrib/credential/osxkeychain/git-credential-osxkeychain.o
$(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-               $(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework
Security -framework CoreFoundation
+               $(filter %.o,$^) $(LIB_FILE) $(RUST_LIB) $(EXTLIBS)
-framework Security -framework CoreFoundation

 contrib/credential/osxkeychain/git-credential-osxkeychain.o:
contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
        $(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args)
$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
