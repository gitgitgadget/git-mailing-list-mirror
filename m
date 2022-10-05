Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A56C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 20:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJEUYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 16:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJEUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 16:24:18 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D797F274
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665001439; bh=oSocTbUM609U01h4B+jl3esLi84HeoQSGtIepTebIew=;
        h=X-UI-Sender-Class:References:In-Reply-To:From:Date:Subject:To:Cc;
        b=KITAAOBqNx8suPeSK5RGtAbOaCxRoC/PkBIHS2Q7SyklPm2sc0g3LkSQZ7lH+JYrI
         BA6rJliCbF+wJfzv5P6Y6XQohGEpSrNHX6TsELsncTpG4PGmw6UgRbxw4V0AmmglMa
         IHMyRHB6CXf642Pnsa8m9u3VkwraZHXIql9tOAfQ4Doo9fODwqF9G4j2fM5CBlblsa
         jFefHO1ApHxVbc7HetHCu3JJJndAI4y3paPV8UWfv7nu0YjjDa9ymcFk29JlBEGmoU
         W50rQzofLKQ2XNM9aQgxc+rqGxJerbMu+7xgvyywW1smfEw/y4FqHSEgeir+iLG9og
         qSEY8Uur7KoGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mail-oa1-f45.google.com ([209.85.160.45]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MOm0x-1oqIaX2Svn-00QGAx for <git@vger.kernel.org>; Wed, 05 Oct 2022 22:23:58
 +0200
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-132af5e5543so6367655fac.8
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 13:23:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf1SUq5tlNdgbvZtsvKx0JVZUnhbor31PW75EeX93UDZXhm8a4zs
        jPlo2HPZfKN9Wq5Y/TkL+/JJ3v2JBzTOBZaAOm4=
X-Google-Smtp-Source: AMsMyM7GhDuqSCof+Rvkv2wB/EDthbbBzb1sEFqkD8WBOcPm+kbkPHUweq4cCOawTrOYidEdWUOKDk/utwDrEq1Codg=
X-Received: by 2002:a05:6870:5629:b0:132:ecde:2e28 with SMTP id
 m41-20020a056870562900b00132ecde2e28mr726588oao.182.1665001437336; Wed, 05
 Oct 2022 13:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAOCJVAML0axQXbYZncT945SuG3-GfmDtDQ4_8cnkQmF_SZtHw@mail.gmail.com>
 <YzvnadnAYce0dIpi@danh.dev> <xmqqczb6oyie.fsf@gitster.g>
In-Reply-To: <xmqqczb6oyie.fsf@gitster.g>
From:   darkdragon <darkdragon-001@web.de>
Date:   Wed, 5 Oct 2022 22:23:40 +0200
X-Gmail-Original-Message-ID: <CAAOCJVAAwgECsJPfm7eHOMmKPewJzxHTKhjwacxPRYWJkSpX_g@mail.gmail.com>
Message-ID: <CAAOCJVAAwgECsJPfm7eHOMmKPewJzxHTKhjwacxPRYWJkSpX_g@mail.gmail.com>
Subject: Re: Install-prefix when building should not be hardcoded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIZFvmiL+4+eErXOxcO+WSL/BlA/YTTT+TwohNB6fa/mPlVrxau
 pLJO3Lr8YHuzO2RRWaA5tLQFsg+f6MelKGFfUooldcMvqI/2yjh2qQIez0ijsM7lyXUVbHD
 v5MtmHN2yPB4vjGrLy17OVVgxwhaboylp4jiS016shfeXSbY3tgm+FJFSwdAFygokMxetWe
 dPrC0wH57JsXqv3MxOHFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTwvXzRwIjo=:pUeu5Gi4XnW/PBqpL8rmfL
 2Gvj4L6TYGvqI+Ulhura1w+4s6co16UaAOQj8XnotcJtme6xEyeb+fTKtyeaNH9sb3rsaCs7W
 HFjx/vQ3gZTjsjKgg/3k2H8Go4j21/GsPAMRIjy+Sq1r4ATTqXC5Qj0oZ7yB8VjIHxWs/R2Ar
 TrsPtlYAV+uc/hEGzaTo1zFgjeneKnVU5Vj4UlQTpDjSGDmKiUmECq1RvyOShH8DU1rLpOXWL
 C/+2cL5gnpjMjxGA4K48mtBz6VLf4ypuM2KM1MxgXoOIZAp3Ooz71d/PdWLgp/h0kHtMfuMLp
 VZcztpzH4CDBIBJyw2WiRm2Wd3HZM8rfSdekW2Oas0GJHHCBp+bXej817kNB56Mj2gKhijEvV
 zwV30ofcR58NdmQ7fv0BJTGpgZ4ssOam5o8s9JoeUwUJQLsjZs5R/8MynQ1hxl34NEUMaQ/fT
 DXCCbBRR2+yLOZoiRDKk+lAx8V+q8iZ5/0whgebXMROO8PyH0y2CeuM+Ylm2zdTzHVEtcYL3L
 uznfZCVpcblmpJ7THWyy9NFXxTF3R00OO7oELALxb6xqtptEpwrwnsZwI8iAB1A+tOlUpfVUO
 Oac7+aLG5S+PyIo/F9DvhKnX7QosiqCK8I11EWGMOmkRv098Qq335+5C4OsDU3n5fEmuGXh9r
 UW9vfDSIrNyHtXKNc0rMeqXx24TvdezAoyH7uHpRLgz7b+NUn9WHR8mvTqML61hIgmbNh4g/+
 X6MydUmWv0C1nuGoiedpzeSEEPqBYO1FVWUxB4yTaSrIAqD/3WuopiEqmhTkR3vJjuZns3His
 183n1ET/XtFgKf1yJ17+o3jlG1jkDvid2Wk8eN9Efsu2fr8DW51o+dfvnAUOp0w+bBq+SG0vt
 +AI1MwTeK8024wpRoMxNH6vlG0VAs9OBOLubgaIJRt93nsV1Z83SpsNWs4DEQinrFnMq5bk3Q
 Kkv3X52vfpP//Z+k7suItE2UXWpD0EO6gChfP/ZDsUKq2zJbRB4nz5qxcAPEXs0fLL9kFSKjY
 bu96cn5vUT1oiksO4CoLEY1VHsT4BiKSzqk9csi6CPBD6rAdA+rdnfQRg4DEui97MyyMRS/A9
 Iea25KxHSzHTTDsEXA0Tu9hq2K22G2beV1oZt8BPqGoHojiR7/WSaZkk09TtT2JYgSOHuwTQj
 xvfuzMVqqNq0ED0cZ8mY9B1q0L
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2022 at 9:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:
>
> > On 2022-10-04 09:38:24+0200, darkdragon <darkdragon-001@web.de> wrote:
> >> Even though in Makefile, it is stated that git will figure out
> >> gitexecdir at runtime based on the path to the executable, there are
> >> many output files where $(prefix) will be hardcoded. Even git
> >> --exec-path will print out $(compile_prefix)/libexec/git-core instead
> >> of using run_prefix.
> >
> > I'm not sure about this part.
>
> Perhaps it is related to the use of RUNTIME_PREFIX (which I don't
> use myself)?

This seems to do the trick! Thanks a lot!
