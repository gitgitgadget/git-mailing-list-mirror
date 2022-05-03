Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF558C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiECJ62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiECJ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 05:58:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355934BA4
        for <git@vger.kernel.org>; Tue,  3 May 2022 02:54:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so9753922pga.12
        for <git@vger.kernel.org>; Tue, 03 May 2022 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95xrxm4MIs7uIG/h8l7BvXvmqbPypsVbMG2Gi7BagpY=;
        b=NrGAOd1dVgJzt3sEJSOJtKkxTL2vCV4aCpjbz7Zc5kckJtRBbXYvXI5sMQxsnEA18/
         tpFIycd5SW9PqiR6HADSe4txeTSg69gWyR/p6jMbyui79LtryyixBPpUTlGCGEj7vyiP
         +MVTo4Zt43G2VOJ+EV4aNQIgfIBJwopNBFxI1Tsc0TKgFF1slU6rjagGHb8yNdIIAEc2
         JfAIV8PgUGCOg8f/LWpYUyaTPrE9o878miOiRwrH6mscgy8uYeDE/TUwoSzg55CNtX5w
         TOA9uzrkcWqA9LfftfTGsH03NXJ8GRvzWFbdLUAFVkYIHYLWE7725nMgnjyT4SR0UiUv
         OggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95xrxm4MIs7uIG/h8l7BvXvmqbPypsVbMG2Gi7BagpY=;
        b=JgiK7nTjmIdkCC/BADwQ+yXm4NVGvdoHtFZ8rUXmbaMOgn04jGHTVhXpRBTnb2ILte
         9b4kSIN0Pps7jmPPHKs1DGUwA2DvQzbatD820BVAK+tRm8EEajwrNt3ZuMbxCoQb/eIY
         Ir6avVeBmdtIR54am5GvfpdbNNEMdcHmaQVRgdCIaQE5xSyok/J+r4JhePGFLLDnO2OM
         ILLmX4PRjiyULXlbtSwzIYYGBjorbBEtf9P5yylcp7m5hHjO+gjEIfR+kYZxpOuIJ88j
         nDNjlPV0XVVbR38ACYFuJn5UR4J6TL3RvkbZC7XsFS/JWEj6mFT/tuuu6ntD8nS2kRiA
         tcNA==
X-Gm-Message-State: AOAM533yuAroNGasfk1VlvpJCK3FfN8uUmMyNA9sL3gJnxaCv14S44Ms
        6/pvcvx51+n3cRTxg+9bJNiOzIukcdWiBgGz9l1/Vxj+4fQ=
X-Google-Smtp-Source: ABdhPJzOrUfoN8od4zFPDoejwhFTIIYvDl034oBlNQyu38O3FZ8EWXdAgLBAzGLjHPp4fhiipadvwj+THL9EWb53+z0=
X-Received: by 2002:a63:4101:0:b0:3aa:6375:e5f4 with SMTP id
 o1-20020a634101000000b003aa6375e5f4mr13108424pga.240.1651571694806; Tue, 03
 May 2022 02:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220430041406.164719-1-gitter.spiros@gmail.com> <20220430041406.164719-7-gitter.spiros@gmail.com>
In-Reply-To: <20220430041406.164719-7-gitter.spiros@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 3 May 2022 11:54:43 +0200
Message-ID: <CAP8UFD2NSEO3qE+wSVdY2=dOrzKaoW5hcwnk04swm8zxuhoxUQ@mail.gmail.com>
Subject: Re: [PATCH 06/23] builtin/bisect--helper.c: Fix coding style
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About the commit subject, I think something like the following would be better:

"bisect--helper: fix comparison with NULL"

This way it doesn't use an uppercase for "fix", the area part is
smaller, it's more specific about what the patch is doing.

On Tue, May 3, 2022 at 3:15 AM Elia Pinto <gitter.spiros@gmail.com> wrote:
>
> Adhere to the git coding style which requires "Do not explicitly compute an
> integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

The actual wording is:

"Do not explicitly compare an integral value with constant 0 or '\0',
or a pointer value with constant NULL."

which is a bit different from what you wrote. (It's "compare" not
"compute" and "'\0'" not "'\ 0'".)

The rest looks fine.
