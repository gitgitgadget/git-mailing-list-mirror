Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC66C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 06:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiGAG1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 02:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiGAG11 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 02:27:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F948829
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 23:27:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d5so2396118yba.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OJ7d36tZ6AQ67uy3/s4QjNYjtio/GYJNpr0Y8Z1NKMI=;
        b=mOGjZjSRQoSkCMx1nx3wDa82nfvVG3n1BiijJx57qJw/F/fZkdvV6u5WcuVu5sAoC0
         wp6tSv5nBMHPn/aJWooDBr0p1oOrxIg8DgATSTPPtyrS8+BqrrFmxM76uA/spV+68yqZ
         VAcjZDb530Pp1OBRaHTTLAKDs+OrSVlObhPgGTC9bZMxmAjQm6krnRHiBNxNLGRYLm4y
         4JX9do3B5/htWYXrhxprqWCxzyGn9YxDXqTsOpeDIu39strcMlO+LrV5ERG2AnE27Ksg
         00t0h1FoJ6SdOtmu8elyVavbKLNmfyymQHCK0tlDd5GajMIul7bA11ZLSzXJd2aViYpg
         ajiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OJ7d36tZ6AQ67uy3/s4QjNYjtio/GYJNpr0Y8Z1NKMI=;
        b=b0KL58W30P8R6vsKtbT/uRU8JQ9P8jSWRXKwamj31fVo+qN1eVxrdE5eYex21rubeS
         /xkEaRy7R7H84ram7XIuXgeLvfEOrBYOzs3fu5w4LfsT0Ie18RdopYAwTtiHx8b3KnyN
         6NFymvIASY/+yHuPMSxsirK1aJS/Tu/Qej4KjsU+8UDLNzdwroErkpLhgh6U0gEowrOq
         TWurfS/PKGXaZeuWIqmoJ9sUpyqwZurwjSSj4YraiaPSfPgz8+dbhkB6x7w+4+qFz5vE
         7PA0WJBNalYrfirEuGB2IiEo/Mjp2sQTfbKS44h+df+Fnunb0YkuNuAL99PpFMdfRfoP
         CaZg==
X-Gm-Message-State: AJIora9o35RghjJNJtq+bbeFJAJFW29WU2jrPoUWowNyUdNch2ownpMj
        +fGIB/NPaUCvZ5tnJjUCqYpHHJK5XDDezJpARfg2aH8KskM=
X-Google-Smtp-Source: AGRyM1sVw4j5Ahi2b+w7NS19GAffSWX0GXgqawQKevN/0Nklba9muC9uZpfj/gx+MH6QuwOW9uVGP0CqNoocafiqsYg=
X-Received: by 2002:a05:6902:729:b0:66d:c02e:db8a with SMTP id
 l9-20020a056902072900b0066dc02edb8amr5896514ybt.13.1656656845108; Thu, 30 Jun
 2022 23:27:25 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 1 Jul 2022 08:27:14 +0200
Message-ID: <CAP8UFD0y77A=cc-PDY7MWFrfFBT8Q0mea+K7h3-n54LvCuWD+w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 88
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Elijah Newren <newren@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 88th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/06/30/edition-88/

Thanks a lot to Bruno Brito, Elijah Newren, Matheus Tavares and
Johannes Schindelin  who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/589
