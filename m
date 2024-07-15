Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048233FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054825; cv=none; b=JZHsGLSjwjJNVjxqHNK+GLLPUTDpEp4ZkRr9CBgWVku3mpuz8b1n23CYM94mBP8CvWPpbjBmtfUKA89VDyxJuIdPWMMqxhK4SMzPQkdSIwERWE68RiHYv5cWLww8/JNYRDtwpgyvG9BTf5Kin/e6sIgLYpmbhxFF8zyyrYWm3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054825; c=relaxed/simple;
	bh=o7mm3hOCJ5gI45I+LVxzAQhDkGrrTno+QRHdrsNjh5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=d0zXuWMeCW6FGPpORqns/j/lSqZV6mCHFQvgciBHfIUp5QYApaMYrAmk5ruuIbetfBcBqIdog7y2CmNWH1OnlBRwV2wlKIP9IlWII0Ou5fUbkEaRmZI6ei96Vk9yxdJxYxbOgKHAHEhjUHCJ4kEnwzAX7gje8qhejNgTdrOQTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MceBk5gZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MceBk5gZ"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2459053a12.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721054823; x=1721659623; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQNHCSXJvfvLBgoYKyorwU4ojIuhjky5YtQtV9SdWFI=;
        b=MceBk5gZXWA8F9AlJdS7jxYketWs62NYQ9kQO0IrJHyhPGek7ItyHFYh2+mzSWQjAb
         mYZK7uIrTHwELtzTwv8DM65EwRFZNhQVyflBt6foYtOcgAV0voLBqnTeAuI4ksOkyZkf
         ZZuE7wXt+4sUJtL4nhmBFVx4dnZD3M/7/mUwDgr4z5UgrHEqn+EVffhgqmyvSzyBnF6Y
         Ga5X+XjlkRCMuISjhfiWAd1IVGalzo7Rv3AN1mKqrDuaIuTsJWcuBFMnpdLUi1Er9XZs
         XHShBLfW51H17VX8WtTTllE8Has4A+7+UfMdOUFSLhX9IIHGbJ+eRKFFyM8cLOkbcqUO
         6kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054823; x=1721659623;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XQNHCSXJvfvLBgoYKyorwU4ojIuhjky5YtQtV9SdWFI=;
        b=Yp2FN5/9XLq6gKFJowXFFIm7ujhS99uwAY/wqn9ABpUOnGjqh70njrRX+4RsR4KlcY
         lraj0fH1C6TNWpmHSfoUQQc0CPC9DtKf8q0B4NpGNkkkI5JRQ4AERxS16puZZ0H8Br9x
         iA0XUaKRekoVifxDXlTOvpxsu5HOMJ+FxGNhoDgycnDwNVHZkxZGuX9lk1R887/28GRm
         8LG8Q6p4g+31G6o4OWpTtZJiz3XHah8BP1dTrwsnFl/95eNN3XGjeYBwVi94zZ9vr0RZ
         TVEt4lBYwcN4ynXOgYqsWr/eoudYzfhIkQU7OtGAgWkfjWjuVhEPl/BIVwzhhHlL2Cqo
         es2w==
X-Forwarded-Encrypted: i=1; AJvYcCVaIwn5+vZslKhKAcK6cIcEN8iH8s/aT0bL1gFccnuaMLycpGa7xhUn89gGsy5fTAAL1Wu5K1KWzyA91rWoceJ9JttJ
X-Gm-Message-State: AOJu0YyyNX3FPVJJ9IRjbelvxJkRpcBrWz7RFUp7xLaI8G4c/1OHFoeG
	gSS0at+d0PBQHMzwrHfWGSk8PILht6K2neKOOsJD1bfWFwStXT/W
X-Google-Smtp-Source: AGHT+IGw0IdrYTDVmlWyQMNN0jyQ/ezWUiBR8OJuez/Qu+U5tbNKPRQ9FrkwsajoPlXDy2JQcL5DVQ==
X-Received: by 2002:a05:6a21:78c:b0:1c0:f648:8571 with SMTP id adf61e73a8af0-1c3ee50fd32mr151420637.4.1721054822547;
        Mon, 15 Jul 2024 07:47:02 -0700 (PDT)
Received: from localhost ([122.170.25.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc271c1sm41766705ad.125.2024.07.15.07.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 07:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 20:16:58 +0530
Message-Id: <D2Q70KGM98S7.3FMTY19CAFTEM@gmail.com>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, "Josh Steadmon" <steadmon@google.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Git List"
 <git@vger.kernel.org>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <d768f700-654a-4030-bd45-e8e3dea351b5@gmail.com>
 <35f828d3-6d3d-4b86-b6bb-a35753d91b9b@gmail.com>
In-Reply-To: <35f828d3-6d3d-4b86-b6bb-a35753d91b9b@gmail.com>

Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 02/07/2024 16:14, phillip.wood123@gmail.com wrote:
> > Getting rid of the untyped test arguments is=20
> > definitely a benefit of this approach.
>
> That got me thinking how we might make type-safe setup()
> functions. The diff below shows how we could define a macro to
> generate the functions. DEFINE_SETUP_FN(char, ch) defines setup_ch()
> that takes a test function and a char that is passed to the test with
> the initialized strbuf. I'm not sure that's the way we want to go for
> this test file but I thought I'd post it in case it is useful for
> future tests.
>
> Best Wishes
>
> Phillip

This seems interesting if we want keep using setup() architecture. But a
bit too much if we have to keep doing this in every test where we need
setup(). Maybe some of it can be abstracted away in test-lib? Anyway, I was
a bit surprised that we didn't just use 'const char *' instead of 'const vo=
id *',
as we pass a string to all of them. So, I don't see the value of using 'voi=
d *'
in the first place in this test.

Thanks.

> ---- >8 ----
> diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
> index 6027dafef70..8fc9a8b38df 100644
> --- a/t/unit-tests/t-strbuf.c
> +++ b/t/unit-tests/t-strbuf.c
> @@ -1,27 +1,60 @@
> #include "test-lib.h"
> #include "strbuf.h"
>  =20
> -/* wrapper that supplies tests with an empty, initialized strbuf */
> -static void setup(void (*f)(struct strbuf*, const void*),
> - const void *data)
> -{
> - struct strbuf buf =3D STRBUF_INIT;
> -
> - f(&buf, data);
> - strbuf_release(&buf);
> - check_uint(buf.len, =3D=3D, 0);
> - check_uint(buf.alloc, =3D=3D, 0);
> -}
> -
> -/* wrapper that supplies tests with a populated, initialized strbuf */
> -static void setup_populated(void (*f)(struct strbuf*, const void*),
> - const char *init_str, const void *data)
> -{
> - struct strbuf buf =3D STRBUF_INIT;
> -
> - strbuf_addstr(&buf, init_str);
> - check_uint(buf.len, =3D=3D, strlen(init_str));
> - f(&buf, data);
> +/*
> + * Define a type safe wrapper function that supplies test functions
> + * with an initialized strbuf populated with an optional string and
> + * some data and then frees the strbuf when the test function
> + * returns. For example given the test function
> + *
> + * t_foo(struct strbuf *buf, struct foo *data)
> + *
> + * the type safe wrapper function
> + *
> + * setup_foo(void(*)(struct strbuf*, const struct foo*),
> + * const char *init_str, const struct foo*)
> + *
> + * can be defined with
> + *
> + * DEFINE_SETUP_FN(const struct foo*, foo)
> + *
> + * and used to run t_foo() with
> + *
> + * TEST(setup_foo(t_foo, "initial string", &my_foo), "test foo");
> + */
> +#define DEFINE_SETUP_FN(type, suffix) \
> + static void marshal_##suffix(void(*test_fn)(void), \
> + struct strbuf *buf, const void *ctx) \
> + { \
> + type data =3D *(type *)ctx; \
> + ((void(*)(struct strbuf*, type)) test_fn)(buf, data); \
> + } \
> + \
> + static void setup_##suffix(void(*test_fn)(struct strbuf*, type), \
> + const char *init_str, type data) \
> + { \
> + void *ctx =3D &data; \
> + do_setup(init_str, (void(*)(void)) test_fn, ctx, \
> + marshal_##suffix); \
> + }
> +
> +/*
> + * Helper function for DEFINE_SETUP_FN() that initializes the strbuf,
> + * calls the test function and releases the strbuf
> + */
> +static void do_setup(const char* init_str, void(*f)(void), const void
> *ctx,
> + void(*marshal)(void(*)(void), struct strbuf*, const void*))
> +{
> + struct strbuf buf =3D STRBUF_INIT;
> +
> + if (init_str) {
> + strbuf_addstr(&buf, init_str);
> + if (!check_uint(buf.len, =3D=3D, strlen(init_str))) {
> + strbuf_release(&buf);
> + return;
> + }
> + }
> + marshal(f, &buf, ctx);
> strbuf_release(&buf);
> check_uint(buf.len, =3D=3D, 0);
> check_uint(buf.alloc, =3D=3D, 0);
> @@ -66,10 +99,9 @@ static void t_dynamic_init(void)
> strbuf_release(&buf);
> }
>  =20
> -static void t_addch(struct strbuf *buf, const void *data)
> +DEFINE_SETUP_FN(char, ch)
> +static void t_addch(struct strbuf *buf, char ch)
> {
> - const char *p_ch =3D data;
> - const char ch =3D *p_ch;
> size_t orig_alloc =3D buf->alloc;
> size_t orig_len =3D buf->len;
>  =20
> @@ -85,9 +117,9 @@ static void t_addch(struct strbuf *buf, const void
> *data)
> check_char(buf->buf[buf->len], =3D=3D, '\0');
> }
>  =20
> -static void t_addstr(struct strbuf *buf, const void *data)
> +DEFINE_SETUP_FN(const char*, str)
> +static void t_addstr(struct strbuf *buf, const char *text)
> {
> - const char *text =3D data;
> size_t len =3D strlen(text);
> size_t orig_alloc =3D buf->alloc;
> size_t orig_len =3D buf->len;
> @@ -110,12 +142,12 @@ int cmd_main(int argc, const char **argv)
> if (!TEST(t_static_init(), "static initialization works"))
> test_skip_all("STRBUF_INIT is broken");
> TEST(t_dynamic_init(), "dynamic initialization works");
> - TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> - TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> - TEST(setup_populated(t_addch, "initial value", "a"),
> + TEST(setup_ch(t_addch, NULL, 'a'), "strbuf_addch adds char");
> + TEST(setup_ch(t_addch, NULL, '\0'), "strbuf_addch adds NUL char");
> + TEST(setup_ch(t_addch, "initial value", 'a'),
> "strbuf_addch appends to initial value");
> - TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> - TEST(setup_populated(t_addstr, "initial value", "hello there"),
> + TEST(setup_str(t_addstr, NULL, "hello there"), "strbuf_addstr adds
> string");
> + TEST(setup_str(t_addstr, "initial value", "hello there"),
> "strbuf_addstr appends string to initial value");
>  =20
> return test_done();

