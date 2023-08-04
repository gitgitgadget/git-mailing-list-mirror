Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F21C00528
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHDWJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHDWJM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 18:09:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0AE4D
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 15:09:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c0cb7285fso338729766b.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691186939; x=1691791739;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqS/9TTsNp/5EU6kUiV8u7sbDpv1YAUBre6YCSmJZU4=;
        b=DPypVBN1VokXF9T3beusrGkf7U9Slbd13fLgWYVkQWVWggizU8K4bclhkTqtz0KDMF
         jP+JG055ffZc3U+dke9DYLKWm2vg4wH16z5id7+7/OoDLKOy7Nvq7zjIG3Q2fmeqGtb5
         zk3HgNRPQGHr7XIYh0DCe6k4ZruJNNUDtNL2z6rC3FZyew6nKxGkIGgVBWziw9r6sOPk
         VEmVDnxChN5EaWJnkUY3VY0wpshpFgxjcc9XD0ZlV4RXkPaspwQkXLkIOdhO/x64zbiL
         F3noW9ijTnPG3WU5hrD5zrAL3Ethce2i3edIC/NLDil92gIFtD0DjZrFuGIeBf8u6gOo
         DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186939; x=1691791739;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AqS/9TTsNp/5EU6kUiV8u7sbDpv1YAUBre6YCSmJZU4=;
        b=eVUvr2OagF9SDy09kNV7jZ0JwmnUBycutNd/OPMbdaBXRqwWO+TEBMtEJWbZNgWbML
         F43NuJb6e3/7bu+6a8dRO1N3LYxBakGXMCXyMBA2UzkuHfciX+N2ynk6hfZmRevqGbvL
         tohuKNSi99IFxnXkhbIBQihFQKVNugm5gIpdbptW6BZ3ujuo4vycyno4mfoxvyCYoHI9
         RywD3ga8/sWtxL252dtVqxzn6dYEjgKFCvSPFLUq8MKYi4qsqCSvt39S9OzN0s8JoV5+
         U/JqEPcgMMl/tvBVc5S8LPTDpynQcoJJCEw9qFmQVjsBc91/niJPxahr3Op6nD3Ci3wD
         9olg==
X-Gm-Message-State: AOJu0YyBmoNN+LxvK/ueozrVYrFOeQ/z+hwXSEj5rS+m1le9/XFi3jkl
        tbbVkT/2mr4MY7uiHbbT+whk4RYDuRM=
X-Google-Smtp-Source: AGHT+IF2Mryxw7tLW6eBGgxexj2IAn8LxDVZX+i3bbzwb3YWXVJCKW2v0vP0i8yVw4kQANqqsYNADg==
X-Received: by 2002:a17:906:11c:b0:99b:c845:791d with SMTP id 28-20020a170906011c00b0099bc845791dmr2115798eje.76.1691186939066;
        Fri, 04 Aug 2023 15:08:59 -0700 (PDT)
Received: from smtpclient.apple ([2a02:2f0f:d016:e600:3888:bc68:ea33:cbbf])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906184100b00993017b64a8sm1858850eje.224.2023.08.04.15.08.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 15:08:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   curs java2 <cursjava2@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 5 Aug 2023 01:08:46 +0300
Subject: =?utf-8?Q?Git-filter_=E2=80=94force_-_my_code_disappeared_before?=
 =?utf-8?Q?_being_pushed?=
Message-Id: <8CB4A72D-1047-48B0-9371-580C0F259D94@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (20E252)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Laura, I m a QA engineer, I am in a critical situation where I ha=
ve lost my code which was not pushed on repository and cannot get it back on=
 local computer due to a fatal mistake.
Because I had a deleted big file in my project/branch (an .ipa file) Git did=
 not let me Push the code even though the file was not anymore in my project=
. That was very curious.

I had superficially read that Git rejected my Push due to caching that file a=
nd should use Git Filter
Because git filter command on my branch did not work I have added =E2=80=94 f=
orce argument and it deleted my code without having no clue about this conse=
quence.

Now I can see in git log 2 commits previous to this calamity moment but I ca=
nnot see the commits done right before the fatal Push and git filter. I cann=
ot restore any commit I get permission denied and I don t want to loose any p=
otential data that could be recovered at this point.=20

Is anyone so kind to help me recover my code, if there s any chance? I am us=
ing Osx last version on my computer.

My email and telegram (L102030  ) are open for any recommendation.

Thank you in advance.
Kind regards!
Laura=20=
