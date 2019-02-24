Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCCC20248
	for <e@80x24.org>; Sun, 24 Feb 2019 08:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfBXIiu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 03:38:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40072 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXIiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 03:38:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id 10so5114986eds.7
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izzBg+tswjCOJTko9w4VYUBbICeCjuYklmpihNvWnhQ=;
        b=onW+7PEwYzm6DreHZCYUMAVPwsTF6L5YDNwqVKfyUUQnJfwhE5Cf38Ll06TH55zA/I
         kw0RN4KQlFr1XgffkCc4XQ8HZCvJzS0NlRebtCVFO/fMIINyUtXJp7J84wXoAtYIeLdH
         LDowNQZ1rX7H53T32BULtoaPVPlTmyBNYiFqUgDaOcx266z2qwzqsxcIXUnQnf6lRVrD
         GGdcoowUs3DMmeihJzy4m2/FFEkieYkFTo1V4/DR6momjxQZamUaxOdBmQoa3+Fk+i75
         c/s5JyBQUzD53L4UuQPxgFCRgUxfHjmIKLeLH3nIcbLJ99KHWl2+or2qnpLUOODYvoVG
         y1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izzBg+tswjCOJTko9w4VYUBbICeCjuYklmpihNvWnhQ=;
        b=kKXQ33Ds8dMH0a/rVj9ITP0czEazxB8GOsX++Vmzp3TFvRJKlzUSy2NAEY/mQpqCY9
         XvATVkn88Mivvq9Oc90TSKIdBRLjjaU+rGikAweLFHVgVsOGutd6BMth7ne4EwrYGeMV
         dVaPPTDSE2rk0QHD/8+nZoveHdkoNsebFrwRro83ZVqwbYcNH7ylb8+/qSMM+NDox+b4
         yy3h0zr0pbd7UXG0BcK3yh9ubVSJV70u7UYV/R0Mbs1IOsHfF+BsEzBC8J2l5NTbObox
         fYVdzPcWh+7bPgp1/tREVYgAQY1K0XHHJ+FFHU0ZsNKgM1SGgOypJ2LWaVbmafyae/yT
         KNRA==
X-Gm-Message-State: AHQUAua6F7+H136zBg82CgCM4QMhObfaMYf16TeBBQi6P6gRsDO4rMMf
        pjg3YnG+J6mhiuNnggxPyb470vKvmGr6nhw4ErQ=
X-Google-Smtp-Source: AHgI3IbBWlIk0grVMFTlqhK80QRuRj1QzNcuRf5fpyjP1Bwgs0hHl6uZi2y8k1Mhtlki7sHC/Tz/nroVTGKs3L0RyGw=
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr1339110ejz.158.1550997528729;
 Sun, 24 Feb 2019 00:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br> <20190223190309.6728-3-matheus.bernardino@usp.br>
In-Reply-To: <20190223190309.6728-3-matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 24 Feb 2019 09:38:37 +0100
Message-ID: <CAP8UFD0cDMr4jnjmveb10PK+xAoEEhKUgcaqbeDEktG2QuQoqQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/3] clone: extract function from copy_or_link_directory
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 8:06 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Extract dir creation code snippet from copy_or_link_directory to its own
> function named mkdir_if_missing. This change will help removing
> copy_or_link_directory's explicit recursion, which will be done in a
> following patch. Also makes code more readable.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> Changes in v2:
>  - Replaced explicit reference to a following patch at patch message to
>    a more generic reference.
>  - Changed struct stat variable name to st, which is the most common
>    name for such variables in git's code.

Nice!
