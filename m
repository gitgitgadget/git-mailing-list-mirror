Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71037125D5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfM5tadc"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF564E1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 06:17:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2df2fb611so2072771b6e.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698499069; x=1699103869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNpKqG0DxVmpJb1hvcmMoypuyhgGM91EeSYZDnBleys=;
        b=HfM5tadcWuTr2W8l2xcivdIyf8CKDQ0sK+wkVNUGYMOrZ2OoAWCBklB58En3QGXpsa
         vtTsf8JR6U80e6qMUzr0snRqBjCaO/BW6Wu8Tfj5ZMGLdqDrSWLTkvEsPJyxIhiGkGLX
         6cz0gD/SgpwOaM/IVIHfzaDniM4EpmkEYIl8vclQWpZLIdrIMXJHKqHWl9wA2Nad393N
         yXiGA4Dd/JZ8sFmRl0i9OUm5HcccmW40wFCN83Z3kqzYO0kw80OPtWL1QXeOaLSMqXSo
         8KiFFbDxDaxEvio9oG69zC5Pqk+7b13nr9ZY+TPjRNoVoVqKI+23wJJ/y0X5E8t0tA80
         SPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698499069; x=1699103869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNpKqG0DxVmpJb1hvcmMoypuyhgGM91EeSYZDnBleys=;
        b=xMbNjAgzrFJGS6IQrjKR3zOmKr06LvEAmnZXBrxbV3+Rb4h5EZa5xdrUDIme4NkCkn
         srWeIS1hNxiChvbVgLC5J+cdk65quUqHr9NjkvWYYM6k0prF7ZTjz5l0dANqXSEXQSih
         oMlMOADgpoFtmAZOHK/nDl6s1E2/+0AblPr7Pxpw7tqHByaN2HL5aVba319QDK058EMi
         rsMgDZKWGAwVUn/LnX0s3y093GJ7grt10yu0ov3yN38dWsftt4neF6uqIDHMYwYU4OP0
         yuVNC+jclkTkmfODPQmZ5DJSKubaNYPYZfbCQffgUoYVDDV/WhOSFbrs3fXlof8Bjf7L
         4hiw==
X-Gm-Message-State: AOJu0YyezcqxWsJSjFdOHSM2MBJHs0qM7PknxeV00KxTfn/7S3D8Tq4m
	jJq5axq8If4cry/sTpv6mC7v0j6J70Jr+kN/U9CPYvgRyU9uyyw=
X-Google-Smtp-Source: AGHT+IGcuZRu/3P/PN3wZiJ6iCuyPJNoyLPbZEQZ2pfU4Zi4Ka88aFwQIlCf4iGgWMLbcmrhea4eUarZ64oAVnOrtiY=
X-Received: by 2002:a05:6870:d88d:b0:1e9:9eba:327a with SMTP id
 oe13-20020a056870d88d00b001e99eba327amr7425524oac.28.1698499068902; Sat, 28
 Oct 2023 06:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2yJa3xvCPN6bqsa4+vSkwsdUouhqNvuH6y_CC2cJ0YSmQ@mail.gmail.com>
 <CAP8UFD3athDOto3vMr_SgSTZG_3ny=yyZ22fGcV5yoWNjJo2fA@mail.gmail.com>
 <CACS=G2yGj2FYp9XBCknKqEXh5ZWXiQFLWrWk+SAmWzDMrjJwQg@mail.gmail.com> <CAP8UFD34gre7Xxw=kFop93tLsGXc3RxasstBWpa6RaJ6VyEpFQ@mail.gmail.com>
In-Reply-To: <CAP8UFD34gre7Xxw=kFop93tLsGXc3RxasstBWpa6RaJ6VyEpFQ@mail.gmail.com>
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Sat, 28 Oct 2023 14:17:15 +0100
Message-ID: <CACS=G2yix6jQXtYXETjjCEZMYpMuwB2ViYbx8srF4MZgkXxzwg@mail.gmail.com>
Subject: Re: [OUTREACHY] Final Application For Git Internshhip
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 9:25=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 25, 2023 at 2:14=E2=80=AFPM Naomi Ibe <naomi.ibeh69@gmail.com=
> wrote:
> >>
> >> It could help to say if your contribution has been merged to 'master',
> >> 'next', 'seen' or not at all.
> >
> >  My microproject contribution has been scheduled to be merged to the ma=
ster branch.
>
> Great, please add this information to your application.
>
> >> I think that one of the important tasks to be done early is to
> >> identify what code in t/helper is unit testing C code and what code is
> >> really about helping other tests in the t/t*.sh scripts. It would be
> >> nice if you could give an example of each kind of code.
> >
> > In my opinion, helper/test-ctype.c is a unit test file containing a set=
 of unit tests for character classification functions,
>
> Right.
>
> > while helper/test-dir-iterator.c is a unit test file which works togeth=
er with the t/t0066-dir-iterator.sh file to iterate through a directory and=
 give details on its contents. It likely is used for testing and inspecting=
 directory structures and file types within a specified path.
>
> Actually "t/helper/test-dir-iterator.c" and "t/t0066-dir-iterator.sh"
> are used together to test the code in "dir-iterator.h" and
> "dir-iterator.c", so it's kind of special. Ideally this could be
> ported to the unit test framework as the goal is to test quite low
> level code (instead of a full git command for example), but I am not
> sure how easy it would be, and if it would even be worth it.
>
> >> An example of how you would migrate parts of a test, or how a migrated
> >> test would look like, would be nice.
> >
> > I'd first create a new test file, then include "test-libtap/tap.h" and =
"test-tool.h" header files, then I would initialize TAP with this command p=
lan_tests(x), where x defines the number of tests to be run inside that fil=
e.
> > Below the plan_tests();, I'd migrate and edit my specific test function=
 and requirements, and after that, I'd add my "done_testing();" and then "r=
eturn exit_status();"
>
> These are quite good guidelines, but not quite an example.
>

Using the test-ctype.c file as an example, the migrated unit test file
would look like this:

#include "test-tool.h"
#include "test-libtap/tap.h"
#include <stdio.h>
#include <string.h>

static int is_in(const char *s, int ch) {
    if (ch =3D=3D '\0')
        return ch =3D=3D *s;
    if (*s =3D=3D '\0')
        s++;
    return !!strchr(s, ch);
}

int main() {
    // Init TAP with the number of planned tests (1 test per character clas=
s)
    plan(12);

    // Character classes
    char *classes[] =3D {
        "DIGIT", " \n\r\t",
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
        "*?[\\", "$()*+.?[\\^{|", "!\"#%&',-/:;<=3D>@_`~",
        "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
        "\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
        "\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
        "\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
        "\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
        "\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
        "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
        "\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f",
    };

    // Test each character class
    for (int i =3D 0; i < 12; i++) {
        char description[50];
        sprintf(description, "Testing %s character class", classes[i]);
        for (int ch =3D 0; ch < 256; ch++) {
            int result =3D is_in(classes[i], ch);
            if (ch =3D=3D EOF)
                ok(result =3D=3D is_in(classes[i], ch), description);
            else
                is_int(result, is_in(classes[i], ch), description);
        }
    }

    // After testing all
    done_testing();

    return exit_status();
}


> Thanks,
> Christian.
