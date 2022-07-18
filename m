Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiGRLNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGRLNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 07:13:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB71FCC9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:13:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so18726218lfr.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cx2joou8zLAPsakH4a56oZS8l/5rPZYtdYcHLZbH/wM=;
        b=R8G+IqQ/AlRhfhmCf+D1LcdcDmvL9JAjGP7jkTKREiKeMCW5Tke0dk94mix9oZx+MP
         lmZ22forUA2IGdbG9DLraJ5wPfcZa8wzsew9QDRab09o0gx0HC9Z3eFDuwwwYpUZZFYW
         t5Ns6xw/AO2HzaQj4S8+mOlaCMByfFDZTqpUuNDkgye9m9iVu8LsGOqhJ+xFSSmyCufK
         4dT0GaZX7LaN9PWVDF9Qh0zb5hx8u5HyAEEBTqbRE0WXVDaw+0uZ55qu+rcmCpLVitpD
         CQWx6cC111R8YZz9jFWcp3haBk7iAixk0BNovXdSKJ94QLr2r8Hs0OyHjupcJ5Y3xJWf
         ZhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=cx2joou8zLAPsakH4a56oZS8l/5rPZYtdYcHLZbH/wM=;
        b=w5yA+32lQzXTaB4Fvcq2WuvhPBN7/t6kMQCxnEKPPHykVAfSetA/9ORXvuLxY3++ex
         rbwMpPuEsYSI1ILUIaisfPSEll1Nwo/lxD2GvMsIhyLdQEP+vKyN4pViiAxSZVQYk4Sd
         vzfiG8uTqOjIYV2faAcfewljntPxczQb0MhaqiBmTupDwtTtvtavfD+wC6ATmOLccOdR
         IfFdw+7zTsDpm+/WYNuF4HJwK9l4JT56aQwsWOYt5TelxLvwbgrLsRh5FgEFFjaKQhXe
         Q0pxgJwjFtUs3V01Nn5YdpdoVoHBsu1XPzsYPgCdeRsFd/K0ShDEX//GYjuYCFZ3ajAK
         PlBQ==
X-Gm-Message-State: AJIora8Xndd7AZAAZpXntmdmnobsyUvBi8z63P5k3u1+CjsJzosWOxZ/
        2Za3BhI6Lfe7NGM1dRbOfWRgDSCmEMg=
X-Google-Smtp-Source: AGRyM1tzk6wayamWd5i/xECWhFqfdUvhKFBBEx/tRWTUVbHY4q3k39jevf7kWFvplXJyzIcz3OW91Q==
X-Received: by 2002:ac2:5d70:0:b0:48a:23fd:6f7f with SMTP id h16-20020ac25d70000000b0048a23fd6f7fmr8033153lft.54.1658142820964;
        Mon, 18 Jul 2022 04:13:40 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 ([89.229.21.119])
        by smtp.gmail.com with ESMTPSA id a25-20020a194f59000000b004896b58f2fasm2550548lfk.270.2022.07.18.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 04:13:40 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
Date:   Mon, 18 Jul 2022 13:13:37 +0200
In-Reply-To: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
        (Abhradeep Chakraborty's message of "Sat, 16 Jul 2022 19:20:14 +0530")
Message-ID: <85r12iu10e.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Hello,
>
> I need the CRoaring[1] library to use roaring bitmaps. But it has
> Apache license v2 which is not compatible with GPLv2[2].

Actually Apache License v2.0 *is* compatibile with GPLv2 and GPLv3
in the sense that you can include the Apache licensed code (like the
CRoaring library) in the GPLv2 project (like Git).

Quote from the cited "Apache License V2.0 and GPL Compatibility"[2]:

  The Free Software Foundation considers the Apache License, Version 2.0
  to be a free software license, compatible with version 3 of the GPL.
  The Software Freedom Law Center provides practical advice for
  developers about including permissively licensed source.

  Apache 2 software can therefore be included in GPLv3 projects, because
  the GPLv3 license accepts our software into GPLv3 works. However,
  GPLv3 software cannot be included in Apache projects. The licenses are
  incompatible in one direction only, and it is a result of ASF's
  licensing philosophy and the GPLv3 authors' interpretation of
  copyright law.

License compatibility is directional.

See also "The Free-Libre / Open Source Software (FLOSS) License Slide"[3]
by David A. Wheeler which shows which licenses are compatibile with
which, as a directed graph

[3] https://dwheeler.com/essays/floss-license-slide.html

>
> Is there a way to use the CRoaring library in Git? Taylor told me that
> contrib/persistent-https tree is also licensed under Apache License
> version 2.
>
> [1] https://github.com/RoaringBitmap/CRoaring
> [2] https://www.apache.org/licenses/GPL-compatibility.html
