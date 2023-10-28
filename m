Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305F8C1B
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmMhFzXB"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECEEF4
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 01:25:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso449167466b.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698481501; x=1699086301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq/vX4zUVc+V3snJ2KLvV2dSjXgEgeMGDmek3o1Y11o=;
        b=RmMhFzXB2+h+3/eq7LvguZrWqMfHw9jpf+XbYPBNCbGHuNoDZj1k154rH5tHMz8Tc6
         ypA9m+AcyKwSQdpi58qKHqke0ttbjvaU70AkztAC5377stmycD2hkDdgJxB80K9Ictks
         LVKuNk/ZilVfUPMel/FiR7DpefYYW1ZftpI9wXI43jAtdoX67eKOmO7PLF98HMVX52jv
         FAl/AmOZZx5pat8cgFIvi5XKzJ1ulmaQXDr0LJJzFu1766J6XSkyyw8B/OiuEkg04rxt
         PWuE577BpW/7VLnoTqzSi6WEswggTZp9tvnjBlFli2xYbgIHsE5sLUAJMDYmls3CjAF/
         +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698481501; x=1699086301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq/vX4zUVc+V3snJ2KLvV2dSjXgEgeMGDmek3o1Y11o=;
        b=mPP+hZarvOPQofv7LXPxWTbRtGgJYD+gkXei6qKGTM3FUP2Km9/hisccONJzGSPfSP
         0ZM7ZQZjcV9bg/MMJxw65hNNonGX9makLVnXTtix1AowWksAB7LE/0QWrSMUAQKiwGFh
         DGhodwmPtWIxIdHQ0X+vRqGXceTXFEXmcJkMsRF6dOh1DhtEr7JWBYPpQOeucm3lvJHB
         roD41i+pTEVwDD5sBx8CIw4eyPBEtDALr8Xz1IsGRiqE1nazv3PensYgSGVALOo5/YCi
         WgIEaCFmhiLXDQxjmEAdnEBw5iOrZr3SNs8yf3bM2H/cGEL3lEq+VTdIozQgJD2RUJ+Z
         dPIg==
X-Gm-Message-State: AOJu0YyxeMoDv0i19lWyilweulZC3cHHGmAq1+vTf333/mYJhPYCqM+E
	BEJ9p8xfLHClm9TCR1P9CyuGlgELu7ouYL+ustQ=
X-Google-Smtp-Source: AGHT+IEXmdgFEt3GpH7ut1g4URjOcHLDYbyKE+6srM15Xc8CQXHFplZ7FLHsXq2fSjAWVpNtpL0o4u9ud+fS1Q+WMYU=
X-Received: by 2002:a17:907:3689:b0:9b2:babd:cd44 with SMTP id
 bi9-20020a170907368900b009b2babdcd44mr3786042ejc.44.1698481500538; Sat, 28
 Oct 2023 01:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2yJa3xvCPN6bqsa4+vSkwsdUouhqNvuH6y_CC2cJ0YSmQ@mail.gmail.com>
 <CAP8UFD3athDOto3vMr_SgSTZG_3ny=yyZ22fGcV5yoWNjJo2fA@mail.gmail.com> <CACS=G2yGj2FYp9XBCknKqEXh5ZWXiQFLWrWk+SAmWzDMrjJwQg@mail.gmail.com>
In-Reply-To: <CACS=G2yGj2FYp9XBCknKqEXh5ZWXiQFLWrWk+SAmWzDMrjJwQg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 28 Oct 2023 10:24:48 +0200
Message-ID: <CAP8UFD34gre7Xxw=kFop93tLsGXc3RxasstBWpa6RaJ6VyEpFQ@mail.gmail.com>
Subject: Re: [OUTREACHY] Final Application For Git Internshhip
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 2:14=E2=80=AFPM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>>
>> It could help to say if your contribution has been merged to 'master',
>> 'next', 'seen' or not at all.
>
>  My microproject contribution has been scheduled to be merged to the mast=
er branch.

Great, please add this information to your application.

>> I think that one of the important tasks to be done early is to
>> identify what code in t/helper is unit testing C code and what code is
>> really about helping other tests in the t/t*.sh scripts. It would be
>> nice if you could give an example of each kind of code.
>
> In my opinion, helper/test-ctype.c is a unit test file containing a set o=
f unit tests for character classification functions,

Right.

> while helper/test-dir-iterator.c is a unit test file which works together=
 with the t/t0066-dir-iterator.sh file to iterate through a directory and g=
ive details on its contents. It likely is used for testing and inspecting d=
irectory structures and file types within a specified path.

Actually "t/helper/test-dir-iterator.c" and "t/t0066-dir-iterator.sh"
are used together to test the code in "dir-iterator.h" and
"dir-iterator.c", so it's kind of special. Ideally this could be
ported to the unit test framework as the goal is to test quite low
level code (instead of a full git command for example), but I am not
sure how easy it would be, and if it would even be worth it.

>> An example of how you would migrate parts of a test, or how a migrated
>> test would look like, would be nice.
>
> I'd first create a new test file, then include "test-libtap/tap.h" and "t=
est-tool.h" header files, then I would initialize TAP with this command pla=
n_tests(x), where x defines the number of tests to be run inside that file.
> Below the plan_tests();, I'd migrate and edit my specific test function a=
nd requirements, and after that, I'd add my "done_testing();" and then "ret=
urn exit_status();"

These are quite good guidelines, but not quite an example.

Thanks,
Christian.
