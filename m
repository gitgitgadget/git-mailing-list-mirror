Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F09287247
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774323230; cv=pass; b=qhf9i1Cs36QySU9voFHYtaPBuGo1BM5S3WhcPKvpj+9QNTkRRP3ZBRbbcsKCb0x9MDb4u3McUbTh7yrE34wuyoctm7AHQYuvSoYsScgSFDgliPDPy/cr7uVPGGchSEeE9q/lN5fuJrmszmK0SmeteeB7r8B1Ir8rbE/zWkFqq6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774323230; c=relaxed/simple;
	bh=piam+86QfQC+r4zcvrvswBf4vgFw50sAekA0QSbE+kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3on0ExWqRw+vYxg6JkJdMCGd4JO6F395sd5ar20UBY96gN8dwwUrJHK0L7hkiDmi2lQQBH65x+NNhAwwWXjAT0nnsixbI71IhVTE8UXwMlrYTNQeKp7OOpg9JbbY2ar7wdpf/SGTLw4armFYGzYCw5qWrW7PyB5pfWhiXOB6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c151551a6eso3779eec.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 20:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774323228; cv=none;
        d=google.com; s=arc-20240605;
        b=Orkz4vNLVJDwDKxyTD1na2vSEPymKLMq3sFtyaD5gUlrwxBI6fE3HEWkw/e1RWh/JH
         H7PpaLTFEvVh5YjtJmjkjbEkxkI29tNF6zX8X5UHhXitPgGvFpxG+9aYDW8meukEHTEG
         yZBrbMd+Vjn46zH8s3rFWigegzg7sL6HDZzhi13ANy6h/RmNkguM1WEI/8soQK3F3nvp
         bKRjS5eEIiyLa7OStNuHWl1aJbz+s2AH4q4Bm8UmMHDIzKXmN46mnDMvb1rYyEkXZgMF
         tX7C+DnduD7qG0RiNWf69ZmcIoFpo+LsB9UHbCT/CXhE4z6osOXDlkymlH5YRoKvAiAh
         39eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=0mA7OsksT0VaOgoqZnj9n4wfH1B4FL7k7npDKasbyt0=;
        fh=t8YpH709c3wSibd8BcbrKw+BLNNwQB+E/lqdyjFu22U=;
        b=d8sU57IvDqOGF+tBiGVFqq/v8iygkRWN7f+zh1D07r1b1NydnQ/GoIpARHIrT2JqBd
         jOk7gb+zyvXlAKw6RKreqdzhI4gMV9l8z/iUQ/Xxs2b4RFUnSoZ147FcXK/0YzmZPcsJ
         ZJ/CosIRhQ2I/yo6nfQbi81uyjJLTaVA3ddBYPpP6kzCNvquSNJssxWjrJYLOljw9Sqc
         JX86+kZQ0XLLTvCY4mFiocox0p6wgRzKiBTYP/FT8ZzmHyo05cb5fMMkTSSJKvxqOWrW
         gyOwGvvP8o/8wqwwMAVYLpJwXhNCe0MghUibAusH2uYltql8zl9n9eaj8zEVQN7Q5V/+
         6h+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774323228; x=1774928028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mA7OsksT0VaOgoqZnj9n4wfH1B4FL7k7npDKasbyt0=;
        b=qYWxGIiko54Uhciqr9VUywDOd0t5cm5XjFBj2qrRgRXWRxZOXjo98H+qbiL1xvgyoG
         9FLsdM6O3u1ewpNbSZnjObC+wDwMFW7XLhixnT7nKNf0ciBRpJ5sKhRPqiCK5rRUZLSN
         uQ1MVm4pkfrLUIzjG0SQHCKFH44IpItjePLRJ2aZ/ryDPXng0wIGyPtIedhnk4wJeqA9
         N+UmfAIQ5OT19+rAWI3Lw4mU+N5yipVCjo5lg1wJYcKPsWbWfThjn8uCDrP6Mt9GeKB5
         NlnR/tXHB9yC2FTuENRhOUH9Vg55MrBmiOeZkPUDs4VdVH0OrU//oCIeWRWoZqUbYwoP
         fA7Q==
X-Gm-Message-State: AOJu0Yzhr7A6DEhz01WX0aBShB1vFd/wF0BQRfNg41uWcrTYZqmEgMxA
	csIZlHCqAFOiXPWMqM9nNtOqrh88Si0XmsxbHfHgXzlVKbkwGvwVBGhgnYLDI3fM2LG3M3j0cLC
	q8tD9jETj5yI047rUXrZvY+kqPEMhV40=
X-Gm-Gg: ATEYQzxRrXVyXtIw1T4j1A3svv38dGkXRJB9kLahfXl8G61EVXDY18/q0prg4/ATIV3
	YtD2VMmAwYr53Su9dyoqkOi8dw8xBn+t9QKpfBwjAPlGh3QqSc7bQOY27QJr1mO0bjYUn0+z3FG
	JEujrM8WdsMTIqVYn+SOWgI+fMGVPJw3Wtf9uC0DxIBxGFpMYH2RrD6BhrjVEuFfbb8Tpt4eEBb
	wTqCJQ+Jtedjqzkal0q8mxtCyYnApOYaY6XGXCvRuoIWRz1h4DnnfvzSPm1FwDNLe1o1l3CGKzB
	9gdHey9MYjI1BYX+nZkpLO+ybMmNzY2Ct+FwuYni7Q==
X-Received: by 2002:a05:7300:5711:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2c109839f30mr3270248eec.3.1774323227652; Mon, 23 Mar 2026
 20:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322065509.5384-1-mateopatinodev@gmail.com>
 <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com> <CAFRsFoV+k-8GMf=62GJwxP=o0Fy5RRBGW+h4NqOLjFbU6z96tw@mail.gmail.com>
In-Reply-To: <CAFRsFoV+k-8GMf=62GJwxP=o0Fy5RRBGW+h4NqOLjFbU6z96tw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Mar 2026 23:33:35 -0400
X-Gm-Features: AQROBzDiPh8XMPRJ8Bcipfi1SW3uP6hZ2h4Q5e3vTEQZHRkiKafbnTEM4bgPr2M
Message-ID: <CAPig+cQcLJxxtsH0OeSP2DVUbSg8x95B-7n18fK9BVTJVywEtQ@mail.gmail.com>
Subject: Re: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
To: Mateo Patino <mateopatinodev@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:11=E2=80=AFAM Mateo Patino <mateopatinodev@gmail.=
com> wrote:
> On Sun, Mar 22, 2026 at 4:59=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
>> Although feedback to Robear Selwans's submission from some reviewers
>> was subjective, Peff's review[*2*] pointed at a major roadblock;
>> specifically, that strbuf has always promoted strbuf.buf is a
>> writeable C-style string, so it is not safe simply to assign a pointer
>> to a literal string to the "buf" member, and it's not practical to
>> expect that all consumers of strbufs can be audited and modified to
>> work correctly with the "new world order" that STRBUF_INIT_CONST would
>> introduce.
>
> Since the Git codebase widely assumes strbuf.buf is writable, I wonder wh=
ether
> we could create a new struct that is specifically documented as a read-on=
ly,
> non-owning view into memory, something lightweight like `string_view` in =
C++,
> which is an object that simply holds a pointer to a string in memory and =
the length.
> For example, in C,
>
> struct strview {
>     const char *buf;
>     size_t len;
> };
>
> This struct would not care where the memory that `buf` points to exists. =
The
> memory would be owned elsewhere and the caller would be responsible for
> ensuring that the memory is valid throughout the lifetime of the struct. =
I think
> this could help pass around string data without requiring ownership or
> allocation, particularly in cases where the data is already available.
>
> A small downside I see to this approach is that we'd need to write a few =
helper
> functions that accompany this struct, and they would likely share similar=
 names
> to the helper functions of `strbuf`, though I think this has been accepte=
d in the
> past in other places throughout the codebase.
>
> Another consideration is that this proposed `strview` would not address t=
he
> lifetime and ownership issue in [4], but having a safer way to pass read-=
only
> strings seems like a step in the right direction.
>
> What do you think?

I think this is a solution to a non-existent problem. Being written in
C, Git does not (generally) have a need for this sort of structure.
When Git code wants to "pass around" an immutable string to functions,
those functions simply declare themselves as accepting a const string,
as in:

    void do_something(const char *s) {...}

In the less common case that the string is not NUL-terminated or only
a portion of the string should be processed, the function also takes a
length:

    void do_something(const char *s, size_t n) {...}

This is a common idiom in the Git codebase, it's perfectly safe,
doesn't involve ownership concerns, and there is no reason to stray
away from it. The proposed `strview` is not safer and is probably not
as convenient, thus adds no apparent value.

But, having reread the threads which your initial email referenced, I
think the bigger issue is that we're dealing with an XY Problem[1].
The original problem "X" being discussed was how to achieve static
initialization of some string variables while still allowing the
variables to be later pointed at heap-allocated memory, but at the
same time avoiding memory leaks when those reassignments occur. The
proposed solution "Y" was to somehow employ `strbuf` to solve X,
however, it turns out that `strbuf` is utterly unsuitable for this
use-case. Unfortunately, this "Y" proposal was then turned into a
GitHub issue[2] which has led to this email thread as well as those
aborted and misdirected submissions which you referenced earlier.

If we take a step back and focus on the original problem rather than
focusing on how to twist strbuf into something it was never meant to
be, then a potential solution becomes clearer. Let's restate the
original problem:

  static const char *global_var =3D "thimble";

  void maybe_assign(const char **var, ...) {
    if (...some_condition...) {
      /* ??? free((void *)*var) ??? */
      *var =3D some_heap_allocated_str;
    }
  }

  maybe_assign(&global_var, ...);
  ...
  maybe_assign(&global_var, ...);

When maybe_assign() is called, it doesn't know whether or not the
incoming `var` points at a static string literal ("thimble") or at
some heap-allocated string, so it doesn't know whether or not to first
free() `var` before assigning the new value. To solve this, we need a
flag which indicates whether the string stored in the variable needs
to be freed before the variable is reassigned. So, this suggests a
dedicated, simple structure and a few related functions and a macro or
two. For instance, something like this:

  struct str {
    char *s;
    int free_me;
  };

  /* initialize `str` from a literal string (i.e. "foo") */
  #define STR_INIT(X) { .s =3D (char *)(X), .free_me =3D 0 }

  void str_release(str *x) {
    if (x.free_me)
      FREE_AND_NULL(x.s);
    x.free_me =3D 0;
  }

  /* take ownership of a heap-allocated string */
  void str_take(str *x, char * s) {
    str_release(x);
    x.s =3D s;
    x.free_me =3D 1;
  }

  /* assign a string literal (i.e. "foo") */
  void str_assign(str *x, const char *s) {
    str_release(x);
    x.s =3D (char *)s;
    x.free_me =3D 0;
  }

That's probably about all you need to solve the stated problem. Given
the above, the original problem statement can be "fixed" by taking
advantage of the above structure and functions:

  static struct str global_var =3D STR_INIT("thimble");

  void maybe_assign(str *var, ...) {
    if (...some_condition...)
      str_assign(var, some_heap_allocated_str);
  }

  maybe_assign(&global_var, ...);

Clients which need the value simply access the `.s` member directly.
And there is no need to have any functions to morph the string in any
way. If a client needs that functionality, it is easy enough to create
and populate a proper `strbuf` from the `.s` member.

[1]: https://xyproblem.info/
[2]: https://github.com/gitgitgadget/git/issues/398
