Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80E4EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjF3Sry (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjF3Srh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 14:47:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BDC421A
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 11:47:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b7f2239bfdso16946515ad.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688150856; x=1690742856;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yy4XGi8vej+P4mZjowK4+YUWkJIaAudlbf2sI+0Fj/E=;
        b=D9pJJXhbRBWUKM+0rHrf7Rn2eMfHrDejq53d7mU6refSQSgobiOTIe8f+QlMCjvErF
         guITQGTY6QD+lJtu1IgVWvz+15Rdo+ib7IzSmIqTURRUnoVpdyrmtNIPUP+BXfqjExIn
         fbGyij+67JyQSX7VrDtVzuszXe2B3ctOnhsjFaMn7tFdTUjLIKcgdNwaGdrGEESX86rn
         E8mCLWAQEP/Nq+K9vrpm+ezNwyRUDuQfIkWrlQymUtP3TVtrdlOuZ28vj5DCL0UBKUek
         J1bMEfUohihLSwUgtfCtg9xsgJrS3LrsABLHB/ekZh69Zipw7nVQJuUMCkXKkn0BNWM5
         YvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150856; x=1690742856;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy4XGi8vej+P4mZjowK4+YUWkJIaAudlbf2sI+0Fj/E=;
        b=l+CuRmMARatH8l+T+2uNHRxC9erIU9zbYzlo9wkAN6zWsmQRIWdq4HcNzM3Ra1QCdE
         XWf0/Po+j2FmYyOP4whYSu3Ry2Ua07uQ6wx/BxiKuoZjghAqgBR2TeF3wv5xQTSSWW/O
         mpznvcuPBmBTE6/sswTE0N5CdfpbxDyyYjFRlPQm9MhjvIYdwxqDV8byqO4SbMlEpOeu
         8R25yvhIl4xpy7GAMmSHLaL+ndCamk3kIy6ayh5lS5Hlsr7zoxlBneMKkeR0TfJTC3sk
         hDvKcCjM59VPyRGeW8xlpG/ad1kYqoPePTkF7G3yGGfOaqPL1hUuXhzFDbyxk6blGovV
         vtBA==
X-Gm-Message-State: ABy/qLYpymDdHmSw1GvhTATp/2NbnaDSd2YmeLG1vPZAnt+/+4/esutV
        WCeevdWpih1Yp3ydQD7i1A2FOufdMveVMw==
X-Google-Smtp-Source: APBJJlEFU+vbuB8SR4+3LI8cxa2l0YNZZgVdFS92bdnfqZiWWWDsJj5nAcwBaXxqaFbWxM24ufZjkw==
X-Received: by 2002:a17:902:7c82:b0:1b5:2fdf:5bd8 with SMTP id y2-20020a1709027c8200b001b52fdf5bd8mr2689993pll.8.1688150855651;
        Fri, 30 Jun 2023 11:47:35 -0700 (PDT)
Received: from smtpclient.apple ([2600:100f:b06f:d200:7dff:5278:d08c:fa9f])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001ac897026cesm11119583plh.102.2023.06.30.11.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 11:47:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   K Wan <calvinwan@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Date:   Fri, 30 Jun 2023 10:47:06 -0800
Message-Id: <667C1DBB-CF32-4BAA-8887-2B343CD9EA12@gmail.com>
References: <a99a5134-3bac-64d4-b4e7-f02e8578090a@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
In-Reply-To: <a99a5134-3bac-64d4-b4e7-f02e8578090a@gmail.com>
To:     phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (20F75)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi=20


Pleasure exclude my email from this discussion.

Thank you

> On Jun 30, 2023, at 6:08 AM, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
>=20
> =EF=BB=BFHi Josh
>=20
> Thanks for putting this together, I think it is really helpful to have a c=
omparison of the various options. Sorry for the slow reply, I was off the li=
st for a couple of weeks.
>=20
>> On 10/06/2023 00:25, Josh Steadmon wrote:
>> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/techn=
ical/unit-tests.txt
>> new file mode 100644
>> index 0000000000..dac8062a43
>> --- /dev/null
>> +++ b/Documentation/technical/unit-tests.txt
>> @@ -0,0 +1,141 @@
>> +=3D Unit Testing
>=20
> I've deleted the sections I agree with to avoid quoting parts that are not=
 relevant to my comments.
>=20
>> +=3D=3D Definitions
>> +
>> +For the purposes of this document, we'll use *test framework* to refer t=
o
>> +projects that support writing test cases and running tests within the co=
ntext
>> +of a single executable. *Test harness* will refer to projects that manag=
e
>> +running multiple executables (each of which may contain multiple test ca=
ses) and
>> +aggregating their results.
>=20
> Thanks for adding this, it is really helpful to have definitions for what w=
e mean by "test framework" and "test harness" within the git project. It mig=
ht be worth mentioning somewhere that we already use prove as a test harness=
 when running our integration tests.
>=20
>> +In reality, these terms are not strictly defined, and many of the projec=
ts
>> +discussed below contain features from both categories.
>=20
>> +
>> +=3D=3D Choosing a framework & harness
>> +
>> +=3D=3D=3D Desired features
>> +
>> [...]
>> +=3D=3D=3D=3D Parallel execution
>> +
>> +Ideally, we will build up a significant collection of unit tests cases, m=
ost
>> +likely split across multiple executables. It will be necessary to run th=
ese
>> +tests in parallel to enable fast develop-test-debug cycles.
>=20
> This is a good point, though I think it is really a property of the harnes=
s rather than the framework so we might want to indicate in the table whethe=
r a framework provides parallelism itself or relies on the harness providing=
 it.
>=20
> > [...]
>> +=3D=3D=3D=3D Major platform support
>> +
>> +At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
>=20
> I think we'd want to be able to run unit tests on *BSD and NonStop as well=
, especially as I think some of the platform dependent code probably lends i=
tself to being unit tested. I suspect a framework that covers Linux and MacO=
S would probably run on those platforms as well (I don't think NonStop has c=
omplete POSIX support but it is hard to imagine a test framework doing anyth=
ing very exotic)
>=20
>> [...]
>> +=3D=3D=3D=3D Mock support
>> +
>> +Unit test authors may wish to test code that interacts with objects that=
 may be
>> +inconvenient to handle in a test (e.g. interacting with a network servic=
e).
>> +Mocking allows test authors to provide a fake implementation of these ob=
jects
>> +for more convenient tests.
>=20
> Do we have any idea what sort of thing we're likely to want to mock and wh=
at we want that support to look like?
>=20
>> +=3D=3D=3D=3D Signal & exception handling
>> +
>> +The test framework must fail gracefully when test cases are themselves b=
uggy or
>> +when they are interrupted by signals during runtime.
>=20
> I had assumed that it would be enough for the test harness to detect if a t=
est executable was killed by a signal or exited early due to a bug in the te=
st script. That requires the framework to have robust support for lazy test p=
lans but I'm not sure that we need it to catch and recover from things like S=
IGSEGV.
>=20
>> +=3D=3D=3D=3D Coverage reports
>> +
>> +It may be convenient to generate coverage reports when running unit test=
s
>> +(although it may be possible to accomplish this regardless of test frame=
work /
>> +harness support).
>=20
> I agree this would be useful, though perhaps we should build it on our exi=
sting gcov usage.
>=20
> Related to this do we want timing reports from the harness or the framewor=
k?
>=20
>> +
>> +=3D=3D=3D Comparison
>> +
>> +[format=3D"csv",options=3D"header",width=3D"75%"]
>> +|=3D=3D=3D=3D=3D
>> +Framework,"TAP support","Diagnostic output","Parallel execution","Vendor=
able / ubiquitous","Maintainable / extensible","Major platform support","Laz=
y test planning","Runtime- skippable tests","Scheduling / re-running",Mocks,=
"Signal & exception handling","Coverage reports"
>> +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.c=
om/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lim=
e-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-ba=
ckground]#True#,?,?,[red-background]#False#,?,?
>> +https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#Tr=
ue#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-backgroun=
d]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
>> +https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-b=
ackground]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lim=
e-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#False#=
,?,?
>> +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[re=
d-background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,=
[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-backgroun=
d]#False#,?,?
>> +https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#=
Partial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow-=
background]#Partial#,?,?,[red-background]#False#,?,?
>> +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?=
,?,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#=
False#,?,?
>> +https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,=
?,?,?,?,?,?,?,?
>> +https://nemequ.github.io/munit/[=C2=B5nit],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-bac=
kground]#True#,?,?
>> +https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-b=
ackground]#True#,?,?
>> +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#Tr=
ue#,?,?,?,?,?,?,?,?,?,?,?
>> +|=3D=3D=3D=3D=3D
>=20
> Thanks for going through these projects, hopefully we can use this informa=
tion to make a decision on a framework soon.
>=20
> Best Wishes
>=20
> Phillip
