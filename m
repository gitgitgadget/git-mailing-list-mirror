Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A27C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 22:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJEWW5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 Oct 2022 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJEWW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 18:22:56 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EAA1E3F5
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 15:22:54 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id j8so117047qvt.13
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 15:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lZLKpXXManfhXgv7es7LjIeUELRp89F0xjV4w62H5w=;
        b=xDTRkYP7VRbt/HvpS+qJqEN7+naLhEiLtF/+4G99mPiNKL094zXrswTEET3x7FsVkc
         LnPBeaxSj2belzjqw4RqW7z5nfGq5Ww4OUo7RDZKdRp6BwnuDrvfj0X/pO6Pca8rU4+b
         lrj5+MveRHfwWelmXlGeF+xtfFSgF07B5aCyvYUx8uQY6XuNvH1g753EVgQXTYlb91kv
         PfleQx3E+qdKzTpbvPUbiOUlQsgPWpAq+H+EDz1eUsawBrRUFa2FbIKpQfPG3dDr7u+p
         As8PLI5EkbcDJrH7JjO4BPVp6bDd/XyfRCaVSSAqf2gSmonBI/POSNOHaqWZmbsNAdq2
         h04g==
X-Gm-Message-State: ACrzQf2TfDTkPbXkRJDtNBMxKbSWdg6EHkicQFBLLoHhW3FeXqWAFD01
        6AKxad4EDHR5tZW/SSnBlgh3khdXnGI9rHkrcEk=
X-Google-Smtp-Source: AMsMyM7BVZaYxnrt5s/jeMBqOxF/mrRCrPck5hiB4hwbkletAnQACcWXMpfX4xmt+eGPKK7oNF79EMQgesXAyfAPPx4=
X-Received: by 2002:a05:6214:d8b:b0:4ad:26cf:3d0b with SMTP id
 e11-20020a0562140d8b00b004ad26cf3d0bmr1497814qve.74.1665008573865; Wed, 05
 Oct 2022 15:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221003212318.3092010-1-asedeno@google.com> <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <xmqqilkynd91.fsf@gitster.g>
In-Reply-To: <xmqqilkynd91.fsf@gitster.g>
From:   =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Date:   Wed, 5 Oct 2022 18:22:38 -0400
Message-ID: <CAOO-Oz1gQJJDiweWjeJAKq1ooVDwH629sXUAGPRd=efxJHK6yA@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message in
 GCC 4.5+
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Aleajndro_R_Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the subject line change; I had hoped that --in-reply-to
would get it threaded properly and wanted to trim it down a bit.

-> "[PATCH] git-compat-util.h: GCC deprecated message arg only in GCC 4.5+"

-Alejandro

On Wed, Oct 5, 2022 at 5:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On 2022-10-03 at 21:23:18, Aleajndro R Sedeño wrote:
> >> From: Alejandro R. Sedeño <asedeno@mit.edu>
> >>
> >> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> >> Signed-off-by: Alejandro R Sedeño <asedeno@google.com>
> >
> > It might be helpful to explain what system you're targeting when you see
> > this.  CentOS 7 has GCC 4.8, and I'm not aware of any systems with an
> > older compiler receiving publicly available updates still.  We've fairly
> > recently only been testing and targeting GCC 4.8 for that reason.
>
> I do agree with you that an update to give "why" in the proposed log
> message would be very welcome, e.g. "Even though such an ancient
> compiler may not matter much in real life, a workaround is simple
> enough." or something along that line.
>
> As to the change in the patch, I think it is good.
>
> Thanks, all.  Expecting an updated version which hopefully would
> become the final version ;-)
>
>
