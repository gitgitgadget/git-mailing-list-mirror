Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B85AC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIGLwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGLwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 07:52:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0866117
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 04:52:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b19so15641715ljf.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=RiuoAfZ1QilPlt3aiUs5UoS82NZ/IdGIXVRXZv1E/JM=;
        b=TEitLy7NasB77pNADR7efoUHGJp9ukm6slkP1LVjlqvPHvu5EJG0lQFjm9lh5Ehb7l
         BBuhh+2NYTob/DUb3SGFDymRo2dJm3VEvz+Ceo4nnK/clBz+psG5xmPTbLnKQ6jUI/rs
         PGf/MV3l6RSK70GkoQ3vx5KTVoAmjXjuUvT49IhEz9t3XJ5ofiAsGNn7MnQfr+ejqtAo
         XTyZlGtRxdm5lSkeshFiGfdQ/wPwzOc3mfUIXZ//kmtMdz24CFb8IbSVgBGq1Hj3rYEH
         1Cqh/QiSOcSC+fgK5+bkZbmcoRr9Mfy7vwQES40+cUXklLbYsoBD/uSdaW0Z3KOhwJvz
         CLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RiuoAfZ1QilPlt3aiUs5UoS82NZ/IdGIXVRXZv1E/JM=;
        b=TCdqNG5BUH9VVfQaz7RwL46ho85HaVBrzWWvEWoXq6Oh+s/bfUGC6/5JzXbgqA9ogX
         5CezcNW5bl4/2wcy1PaUBIE7uZ56aWszO5F8Yxx2uV80iMD6a8yFdPZOMb+qvP1fgH1b
         XrtMPb3TQevYHNGm9A8z90AWjn/xe+tO7X0Xv7inaoWU9DQrxk4TOJp3OUxEmeLmNHyW
         MiQmjvxsDNP08KDJA00CPtvECOPEwKSbUX2C/WVex8z3eB9zyRKLTr4BJPoiFVePCP4p
         ZvT4SIF+13wiV2LgUkC/x4zZRJGnfi+zn1RRnlm08qwIoToDCqFNaj938HErdOUhg/Py
         0dTA==
X-Gm-Message-State: ACgBeo38oqbR4K7xbTd7QIKCAc3A4bzN+k1pyXqXO6qAdW09+y8S2nK8
        eoAOy2L3v3mqkWOmMaYrOeH+7/2LxU4CDnzvhHaFaw==
X-Google-Smtp-Source: AA6agR6y6ATvGT6bBmcwDFnr92v1mHi4OgtE0wiByJC4THk/2YJ66eH66UnUu665Wj8ldw2g64zwons94WwtWtjF1+I=
X-Received: by 2002:a2e:9e50:0:b0:261:bbc4:249e with SMTP id
 g16-20020a2e9e50000000b00261bbc4249emr832954ljk.265.1662551519473; Wed, 07
 Sep 2022 04:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Wed, 7 Sep 2022 08:51:48 -0300
Message-ID: <CAHd-oW71qvhG16YtMweA26SDCLKn+LHZe13njn18CD==9Ewbnw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] docs: de-duplicate sections, add more
 CONFIGURATION sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2022 at 5:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This series:
>
>  * De-duplicates and combines configuration discussion that was split
>    or spread across Documentation/config/*.txt and
>    Documentation/git-*.txt, moving it to Documentation/config/*.txt.
>
>  * Includes that relevant Documentation/config/*.txt in the
>    Documentation/git-*.txt files.
>
>  * Introduces and uses included prose for those "CONFIGURATION"
>    sections in various Documentation/git-*.txt files, informing the
>    reader that what they see there is included from "git-config(1)".
>
> This v4 addresses the feedback from Matheus Tavares on v3 (thanks for
> the review!): A hunk belonged in 9/9, not 8/9 (init's config is used
> by e.g. "clone" too). The end-state at the end of this series is
> exactly the same.

This version LGTM. Thanks!
