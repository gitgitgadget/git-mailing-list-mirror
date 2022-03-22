Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD3C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiCVRtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiCVRtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:49:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB52898A
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:47:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so20234083oig.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYYPkH2ZJuLHA3flxY8VSPSXX2Pj6L5U1RcV8Bh/qlk=;
        b=DdG2TAVJ0zKgO3/UBDZfUdn/KOYcI403zbREyj8QHrfX3/Iz4zZRdfs0beRiBlamFA
         wg3cx3KrcehbJpYHX6iyShPe/Th7259sgSgeatjC4sXM/isOeq42c+i9x9ogchSrq2Da
         +HNc6CcSyZciN2G+YEJJEPIJgiHcU9R4o59DpCW2X/WMUEEAXpb1aLnVt7RrUPTvFazD
         bZeQGYT2dQz86yWgW6cn5617lUane5xUEUkCOXHgNG+LzDwMAKrG1S+qwrrsySmWpm7w
         wGhpo5gd5P3f/Id++SAO9EV1Sf2UR/fVt4JsTHLy7CqZkXW9Bdr0NjI0EoOZ6fqF6XWT
         zL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYYPkH2ZJuLHA3flxY8VSPSXX2Pj6L5U1RcV8Bh/qlk=;
        b=j9xOVaZNJtp9tkckbgYzkOwSe52KbfmbcJITJaRza5fkp/UB9airLDVx4W6X0A25lD
         ayZ6owCWWohPtNi26KSAsKgJcmUmHTj0fXFYRqrQuFexKZScvtqGCjSGD/GHA+3SKNqx
         sJhM3gdvtSe4eThUwu59GT5h5h2IhjkljsPGN+9LiqFBCllFK/13NjXnfsmivS+/07+q
         htLmyPd+Jln6lc81SBCURFJ52eFpRmUwgh/Az1KCbK6U/cg/HMXsUVxVoUCaj4zZwIpu
         s2dQbDytzjVMcvfeeiLkcor7/Fz06NQbrKa/BLr7P9l2b27l+TEUrq5nNwpA/OTOdVQO
         YiJw==
X-Gm-Message-State: AOAM531WUieBKcpkcy6WKdJvmOTX5esuaMNjUIyut5PD6JioL3Nt7Xpw
        6yojhg0nE0S0D1L4Z3fdA0Aa9m03LuG6YAnd4wg=
X-Google-Smtp-Source: ABdhPJw8RjXxZJClsbzGOV04NLhTg49Bd57wWdsO66QkB3WO6NZBD6bW3rkDYY15YTr6BRNOJtwWF0FIy8XwdqoLLDc=
X-Received: by 2002:a05:6808:655:b0:2ec:ce86:303c with SMTP id
 z21-20020a056808065500b002ecce86303cmr2707860oih.217.1647971274356; Tue, 22
 Mar 2022 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220321225523.724509-1-gitter.spiros@gmail.com> <220322.86r16unzer.gmgdl@evledraar.gmail.com>
In-Reply-To: <220322.86r16unzer.gmgdl@evledraar.gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Tue, 22 Mar 2022 18:47:47 +0100
Message-ID: <CA+EOSBmKue=z98NnCPENN3uc6NzXXJ7kBBJB8cJ0k_WRozX1sg@mail.gmail.com>
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mar 22 mar 2022 alle ore 09:51 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
<avarab@gmail.com> ha scritto:
>

First of all, thanks for the review.

>
> On Mon, Mar 21 2022, Elia Pinto wrote:
>
> > EXIT_SUCCESS or EXIT_FAILURE are already used in some functions in git =
but
> > not everywhere. Also in branch.c there is a returns exit(-1), ie 255, w=
hen
> > exit(1) might be more appropriate.
>
> On existing use: That's quite the overstatement :)
>
It was not a quantitative assessment. I just wanted to point out that
the macros stdlib.h EXIT_SUCCESS and EXIT_FAILURE already exist in the
git code.
> We use EXIT_{SUCCESS,FAILURE} only in:
>
>  * contrib/credential/ code.
>  * sh-i18n--envsubst.c
>  * EXIT_FAILURE in one stray test helper
>
> So out of "real git" that users see only sh-i18n--envsubst.c will ever
> run by default, and the reason it uses these is because it's as-is
> imported GNU code.
>
> I'd think if anything we'd be better off doing this the other way
> around, and always hardcoding either 0 or 1.
>
> I'm not aware of any platform where EXIT_SUCCESS is non-zero, although
> that's probably left open by the C standard.
No. It is defined be 0
https://pubs.opengroup.org/onlinepubs/009604599/basedefs/stdlib.h.html
>
> For EXIT_FAILURE there *are* platforms where it's non-1, but I don't
> know if we're ported to any of those, e.g. on z/OS it's[1]:
>
>     The argument status can have a value from 0 to 255 inclusive or be
>     one of the macros EXIT_SUCCESS or EXIT_FAILURE. The value of
>     EXIT_SUCCESS is defined in stdlib.h as 0; the value of EXIT_FAILURE
>     is 8.
>
EXIT_FAILURE it is not defined what precise value it has by the standard C.
However linux, aix, solaris and windows define it as "1". Only Z / OS
calls it 8 but I'm sure git  doesn't care about it.
Z/OS

https://www.ibm.com/docs/en/zos/2.1.0?topic=3Dfunctions-exit-end-program


SOLARIS
https://gitlab.anu.edu.au/mu/x-lcc/blob/24be447de544ed06d490ca0b2304a653136=
2156a/include/sparc/solaris/stdlib.h

AIX
https://www.rpi.edu/dept/acm/packages/egcs/1.1.2/rs_aix42/lib/gcc-lib/power=
pc-ibm-aix4.3.1.0/egcs-2.91.66/include/stdlib.h

WINDOWS
https://docs.microsoft.com/it-it/cpp/c-runtime-library/exit-success-exit-fa=
ilure?view=3Dmsvc-170
> Now, I don't know z/OS at all, but e.g. if a shellscripts calls a C
> program there would $? be 1 if we hardcode 1, but 8 on EXIT_FAILURE?
See the previous answer
>
> We also document for some of these programs that on failure we'll return
> 1 specifically, not whatever EXIT_FAILURE is.
>
See the previous answer.
EXIT_FAILURE is always 1 on all popular platforms that git has been
ported to. So you don't even have to change the documentation.
> These patches also miss cases where we'll set 0 or 1 in a variable, and
> then exit(ret). See e.g. builtin/rm.c. You just changed the hardcoded
> exit(1), but missed where we'll return a hardcoded 0 or 1 via a
> variable.
My patch was just meant to introduce some standardization into git
using the posix/c standard. No more, No less. As other major projects
do, I didn't invent anything.

SYSTEMD COCCI
https://github.com/systemd/systemd/blob/main/coccinelle/exit-0.cocci

Lxc cocci
https://github.com/lxc/lxc/blob/master/coccinelle/exit.cocci

>
> And then there's changing exit(-1) to exit(1). That's existing
> non-portable use that we really should fix. But I know that you missed a
> lot there, since I instrumented git.c recently to intercept those for
> testing (it came up in some thread). We have a lot more than you spotted
> (and some will error if mapped to 1 IIRC). Most of those also want to
> exit 128, not 1.
In fact, these exit codes are more like shell-specific return codes to
indicate the "type" of the error.
I repeat that it was not the purpose of this patch to fix any problems
that may exist with exit codes. Certainly not using coccinelle. But I
agree it's a job to do. But not in this patch.
>
> Anyway:
>
> All in all I think we should just double down on the hardcoding instead,
> but we should fix the exit(-1) cases, and that's best done with some new
> GIT_TEST_ASSERT_NO_UNPORTABLE_EXIT testing or whatever.
>
> A lot of these codepaths are also paths we should fix, but not because
> we exit(N) with a hardcoded N, but because we invoke exit(N) there at
> all. See 338abb0f045 (builtins + test helpers: use return instead of
> exit() in cmd_*, 2021-06-08) for how some of those should be changed.
>
> I think we'd be much better off with something like this in
> git-compat-util.h:
>
>     #ifndef BYPASS_EXIT_SANITY
>     #ifdef EXIT_SUCCESS
>     #if EXIT_SUCCESS !=3D 0
>     #error "git assumes EXIT_SUCCESS is 0, not whatever yours is, please =
report this. Build with -DBYPASS_EXIT_SANITY to continue building at your o=
wn risk"
>     #endif
>     #endif
>     #ifdef EXIT_FAILURE
>     #if EXIT_FAILURE !=3D 0
>     #error "git assumes EXIT_FAILRE is 1, not whatever yours is, please r=
eport this. Build with -DBYPASS_EXIT_SANITY to continue building at your ow=
n risk"
>     #endif
>     #endif
>     #endif
>
> Or *if* we're going to pursue this a twist on that (I really don't think
> this is worthwhile, just saying) where we'd re-define EXIT_SUCCESS and
> EXIT_FAILURE to some sentinel values like 123 and 124.
>
> Then run our entire test suite and roundtrip-assert that at least we
> ourselves handled that properly. I.e. whenever run_command() runs and we
> check for success we check 123, not 0, and a "normal failure" is 124,
> not 1.
>
> I know we'll get a *lot of* failures if we do that, so I'm not arguing
> that we *should*, just that it's rather easy for you to test that and
> see the resulting test suite dumpster fire.
>
> So I don't see how a *partial conversion* is really getting us anywhere,
> even if we take the pedantic C portability view of things.
>
> All we'd have accomplished is a false sense of portability on most OS's,
> as these will be 0 and 1 anyway. And on any stray odd OS's like z/OS
> we'll just need to deal with e.g. both 1 and 8 for EXIT_FAILURE, since
> we *will* miss a lot of cases.
Z / OS is a false problem. git on z / os runs in a linux partition
https://medium.com/theropod/git-on-z-os-f9234cd2a89a#:~:text=3DOn%20z%2FOS%=
2C%20Git%20plays,added%20feature
% 20of% 20codepage% 20translation.
However, calling pedantic a solution widely used in other projects and
provided by standards (EXIT_SUCCESS and EXIT_FAILURE are reported by
the c/posix standard for generic success / error codes) does not seem
to me an appropriate term. But YMMV .

Thanks
>
> 1. https://www.ibm.com/docs/en/zos/2.1.0?topic=3Dfunctions-exit-end-progr=
am
