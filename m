Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7699FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 23:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbiCJXX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiCJXXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 18:23:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A51201A3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:22:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bt26so12175083lfb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh7ixpYIc6SYvIdrAmQ5Dpy3ACdbaw2V3YSap1/Sk48=;
        b=l14qlI8VSUhgRmDh00XD2N0Ofrro570TgUa9pO+2Qu90w3WJz7u1Rccic54soztH4U
         rK/+XRpZjQ+kvNQXE7TS+jrRExxHdI8w260JC+tGbFI70w3S0fi2EomlUU01bRqbwEtw
         0RUL64hJKsFkjKIQzJl6LwylPLWw8jc1KsRb/82JMGct/meFGtui5MOS81zfYGyWniDq
         JFjOxuiE2lHo6QvUK+Q2zsz7CbswK2JB8gRFctYKyP57TOgVZzKfTEctCBF7HSNu/5BW
         bp16KK8/BVTmbr7ICoEFdU1Yb1aOT4c3jsoLlQzoWL5K66163LDA38qRcjtPWauE6oJa
         v8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh7ixpYIc6SYvIdrAmQ5Dpy3ACdbaw2V3YSap1/Sk48=;
        b=xPOVf709DXWkM+eim72ig3YJd/pDn2IXQgxUuqxcZEZAF/LKqRwX3T+QhwsD2HfhFC
         Ebcq8C3l0j4zqecU410VL6bPjHpz1uJpbeiwlpCIf8RwoKdFeW7d7TDqvSlmzXLnP8rq
         CSEcWJe7FvRJh5D/4C5Vq4O2GtuWXXuptlUq3tQhu/QeRwvx7tP0yalrukFVubJ2wLKK
         YdRh7MWZBd9LtL5ObaTrHN7wQihmGjhsIPmP1Hscamybii8Xt48vNCInpMBOeQhXl6Tc
         Ov7FDQ4Dk6eR8/y/b6/N7UY++PHFLNuXrPeeCiNGY0Sey/4Nj+B9AMJTh9MD2GzgUTSp
         8DDw==
X-Gm-Message-State: AOAM532G5DFYYWd0qjos9baxb/F5n3Oad6z7f4LGGjJCN9EjRRYUhFRc
        8oWpVp7VVK1OhHRTtCTlF05JqaXRqrcbvo4L+b20Xxxl
X-Google-Smtp-Source: ABdhPJwvW3rCq/BrdWGExnez4mwr6jEVU34EZOaqX3/tdIWfe4c7wRD1IwDrol4so//qH1/YC+lgPOwCw/O34+niXOk=
X-Received: by 2002:ac2:5e9b:0:b0:448:2821:36cc with SMTP id
 b27-20020ac25e9b000000b00448282136ccmr4454251lfq.93.1646954570240; Thu, 10
 Mar 2022 15:22:50 -0800 (PST)
MIME-Version: 1.0
References: <CANsrJQd1H-NXVA69HxkzH1ZODTKaLzp-P7B7x+Qpbm5wyJFeDg@mail.gmail.com>
In-Reply-To: <CANsrJQd1H-NXVA69HxkzH1ZODTKaLzp-P7B7x+Qpbm5wyJFeDg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 11 Mar 2022 04:52:38 +0530
Message-ID: <CA+CkUQ9gVQ3dxhNpFiA74kx0g5wZg5t1xDfrFzp3Ht6k2oarJw@mail.gmail.com>
Subject: Re: [GSOC] Interested in the project 'Unify ref-filter formats with
 other pretty formats'
To:     Jayati Shrivastava <gaurijove@gmail.com>
Cc:     christian.couder@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jayati,

Welcome to Git.

On Fri, Mar 11, 2022 at 12:52 AM Jayati Shrivastava <gaurijove@gmail.com> wrote:
>
> Hi,
>
> I am Jayati Shrivastava, a senior undergrad at Indian Institute of
> Technology Roorkee where I am majoring in Electrical Engineering with
> minors in Computer Science. I am interested in working on the project
> 'Unify ref-filter formats with other pretty formats' under GSOC'22 and
> have been exploring Hariom's and Olga's prior work on it. I have
> previously contributed to open-source communities like Mozilla
> Firefox, Facebook's Jest, phpMyAdmin and Apache Airflow. I am very
> enthusiastic about joining the Git community and would love to
> contribute to this project under your mentorship.

Great.

> If the microproject 'Use test_path_is_* functions in test scripts' is available,
> I would like to submit a patch for it. Please let me know what you think.

Sure. You can pick this up.

> Regards,
> Jayati

Thanks,
Hariom
