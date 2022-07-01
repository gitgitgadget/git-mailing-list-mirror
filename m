Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15035C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 13:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiGANat (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGANas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 09:30:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479613CD1
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 06:30:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h85so2261739iof.4
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdN0KWiYLnNFpgR6/3yMJw1yd0jGlMJNx1KZLcfsK5Y=;
        b=Nb/cG5As1sO90K+MESypykrqbFEvQraXG900GRuPZ2QuXoZ/zLYVUJ/2k65kk2UwTT
         hUtL72w2luwestuPHrh3tl1ZckQLNScuGnbhQFRaJcHm2wPFcuQU2nfwGEjU1sAcvG7W
         Jo2OlATl25qtK/fQjawdeeSlpyAw63fmWM02jN1c/yfcOa9uDYZdmIdAG3NDZkJ45B2Q
         PRgZ44xWkCTGw4kigYtihWYnZPgYYqudW1iwyIMgvpPTgvytUsSt//qVZzUvDTLEIPsc
         x+ZdV3DBIqCOp41dNawgn0kwbRZjwxRcbCsiKfnBex58VCdBDoXOE+fFFrVxkNm0UUI9
         vKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdN0KWiYLnNFpgR6/3yMJw1yd0jGlMJNx1KZLcfsK5Y=;
        b=viB5YWQx80bdFIIQyDZG5FhrZ+0bwftbnsqeLVLCLdZv5uhiXbNOR42JuwwMru7gxl
         tw42vsBmb65k20dwaCZf37SLoIURgfPa0fETDqz6R3ja6+OTgmOcv+9lyieu2K/PTE4q
         j93C1vAvy7D23OYoT8YMNShBYRWIi3wsqiKRkK1g8g+myNKUQlYSOBDEj0rV7TUN1PLy
         YbZO2IMU0yAQArLhSdgXR+f/d+GIPPdlaDG8dv16fZhO7II13xYvGnkBbozqEVtrkWdB
         SM4B3S2RbDDoGw923STTn/fKRuQhDS03lhr0CuTF1aMvlPM0Zfk+YW9JYgtJmj8F6/h1
         hoiw==
X-Gm-Message-State: AJIora9toXbKz6ISY83oOAiLDwngTyDptHXknUmRBIi0X9D3pr3CnWMn
        rErgVd7e3sSlLB7ktwTrRYi6ON9RtZqYLybSZJM=
X-Google-Smtp-Source: AGRyM1tsOVH5JKBZUHJA0hIMSvKWodhdcYUYU/omvmyaGyBRNHw5clm8Jt3CVbJ+u/4erSojbLZipoBTl72kLh022nk=
X-Received: by 2002:a05:6638:f88:b0:339:df22:3d43 with SMTP id
 h8-20020a0566380f8800b00339df223d43mr8689093jal.42.1656682247410; Fri, 01 Jul
 2022 06:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <220624.86letmi383.gmgdl@evledraar.gmail.com>
 <xmqqsfnuvzxc.fsf@gitster.g> <CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com>
 <xmqq7d52sehc.fsf@gitster.g> <CAOLTT8RpBXR4PaHkaBADG9rWXyV0tRwsFD0VUqBEvPJVofMCNQ@mail.gmail.com>
 <xmqqh746qfkl.fsf@gitster.g>
In-Reply-To: <xmqqh746qfkl.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 1 Jul 2022 21:30:36 +0800
Message-ID: <CAOLTT8Qa-s8WEL-3r+JGfEimbXDFQCZvHNYo974_oq5UU-Dhpg@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 23:41=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Oh, sorry, I mean if someone need some atoms from %(size) to %(flags), =
we can
> > add them back.
>
> Ah, I see.  I am not sure about the %(flags) to help the debugging
> mode, but giving a single bit "is it dirty?" would be more useful
> than giving the cached stat info, I would think.
>

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 061a205576..ccb3fd1676 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -296,6 +296,8 @@ static size_t expand_show_index(struct strbuf *sb,
const char *start,
                write_eolattr_to_buf(sb, data->istate, data->pathname);
        else if (skip_prefix(start, "(path)", &p))
                write_name_to_buf(sb, data->pathname);
+       else if (skip_prefix(start, "(updatetodate)", &p))
+               strbuf_addstr(sb, ce_uptodate(data->ce) ? "true" : "false")=
;
        else
                die(_("bad ls-files format: %%%.*s"), (int)len, start);


I try to use ce_uptodate(ce) to check its flags, but unfortunately,
git ls-files --format=3D"%(updatetodate)" output all files are "false" :(
That's because we have not mark some flags in the cache entry, right?

> Thanks.
>

ZheNing Hu
