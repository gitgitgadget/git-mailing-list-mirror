Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E78C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 15:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351136AbiETPzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbiETPzX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 11:55:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A69170F14
        for <git@vger.kernel.org>; Fri, 20 May 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653062108;
        bh=ijtp4XSQoHPbVfwVOmtRM8f8bWvFhPNXXQ+dsDXbHq4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dz7knBI++qShNzK1mvORQbuYY8ZQ+474p7nFdbV+opshVpXbNjWEEX+tUrjQpPvrZ
         0KOJoPPnuyr7Vxp+q6xy4DjiCC2Qemr1DmYKEikrxqwrHGxPvHCywHQDreV4VdN5v5
         TJwEN1l0UiyyYiwzJkzKxA6n8oIRxwniMaUN/e8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1ntRkF0zjn-0034gv; Fri, 20
 May 2022 17:55:08 +0200
Date:   Fri, 20 May 2022 17:55:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment
 argument
In-Reply-To: <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com> <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com> <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
 <xmqqbkvuwxps.fsf@gitster.g> <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-294935800-1653062108=:352"
X-Provags-ID: V03:K1:ct0omeutuX/NoiQIOhUx+IACKOT7NMwjf2/pQvNgX1+c8Re5HxW
 UCNHnK1+27npdNSpmEX8X/jq1+lxqu/Dz3oipZSXU6QqXuHU4eXIa8xgykUAQY6XXxfsUaM
 FX9ZDiRTm0wGafqTUeZDwpS8KwsTlfOg9Qs8I7qN+IFsrXNz13DxLspLvTd1qsQx6GEa/Sm
 6PK3Pj7SiMEdpbw3B+Yqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WlrpH8qnLbA=:M8TtgBCDO4+aN+H7SwUyjh
 OyqK4jwaiNVfOa30cn6LEYIc569FjK/QzM9c85Vz66RjlSYq6OSFSAhF97jAYq0YQ3SCRdT2j
 sNjqXJWjOJp2EMqrLIFQGjiZ3IrCZllS7UqBF/U9WJmQNN0HZSY0S19jpB0fErfq7TeKHgQdO
 B7HFtiRAuZLomleuQg8wT6tmr6sYjS65NlR6iMX3HQjNm6kjh+Pwk6yEogUTgQs1s3T+BHQxw
 SEJFm40f+9df6H/W4QwfS4YJ7fHkLD9E3aSy8VBTWrVBJ68esCL1GGd0OY4G+07WSvg8hbGC/
 B2p7nH+WpuerSS2v4Vkj9XDeYQh/Pj5Tp4L1dkHUqTe1u16CogVHQz5qUd4HCTOCEXBsrzn53
 jWUYSltf2HOP3xXY1SWjUCGlkb3s9IW1SsT8fzlBr66EDQcNnw5BjIH2UKUYVQrSrL8iyAvtI
 WgImQKGhTUmA1dhfyv/MIJRc/nYwpk99Y2GWG7p3xvNIQkvpj+dI9w5MpFAPLmqQ3TWQJeB0+
 8jP8KMkOwO0GI5W4Nj5jJhHNJVoWwRZigodq3esdpukcG+N6L/QhdIAfgPNTmwmzpVSmwG+3Y
 rXu6uU1P+3ToQwyp5GheUJu22wHAhm0K0gBu+vybvpephZ/kklvt2JX3tXKWX1kZxkUSKmArz
 G1JkcnEb/kdizq9jq9F5QjLVFfMv23OgJNmnh+9hHUcBzY6XJCWzarB78KXgIfwxlOy86/pie
 r842UNrblsLD2WD7ofWkNWQ5qcdq4EU6c605twaPxfXVF55VIqOHMVvAe5JX/1gMUuccPFGls
 7vjNcY1lsg2VZC00QiAPjM1Qznk5SyFZOVHsZeyi6GDAdlAwlxWD754rLfsByC/ziwYlUhO7N
 /qClNykQB+xcFw3R55TFnLXdB8lOg8zBBIdu6Zhe+Rx5a3zOTu33QX+hQp5FLWfVnybJDGh1n
 rM1QsuACpw9koGm3/LTm2Gch5E9X04SANIWwMcYpdtILXjV/RYWUNSKZOentGl37awyzW25ZE
 g9lbHnuyhmzwXURYCEQ0extibIJ3ieGheVwyCjjaK9+ie4/Dr04zdylvxQ8/MfaKq19wPhuUO
 BwBxAg6WhkIbOGgMEBDuUGRopi/BrJjXZIK9ViHmcsfSUO3RPxcoNrbug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-294935800-1653062108=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 20 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, May 18 2022, Junio C Hamano wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >
> >>> +test_expect_success '`scalar [...] <dir>` errors out when dir is mi=
ssing' '
> >>> +	! scalar run config cloned 2>err &&
> >>
> >> Needs to use test_must_fail, not !
> >
> > Good eyes and careful reading are very much appreciated, but in this
> > case, doesn't such an improvement depend on an update to teach
> > test_must_fail_acceptable about scalar being whitelisted?
>
> Yes, I think so (but haven't tested it just now), but it's a relatively
> small change to t/test-lib-functions.sh.

Let it be noted that I fully agree with Junio that good eyes and careful
reading are very much appreciated. And that in this case, that would have
implied noticing that `test_must_fail` is reserved for Git commands.

Scalar is not (yet?) a Git command.

Ciao,
Johannes

--8323328-294935800-1653062108=:352--
