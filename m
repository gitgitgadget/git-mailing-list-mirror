Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D421D2027B
	for <e@80x24.org>; Sat, 20 May 2017 11:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdETLNU (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 07:13:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35509 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdETLNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 07:13:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so12394296pgd.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ltHMsPw3NKSxTBZBmR9UaadEhj/Rub0S1pq0XesvMmI=;
        b=ZLFs0RUpfPs+MnargNhnH6pq8wPr/jmCV93Yo2Seeq0LL24c3Q4udTnCnEeGiPHW4i
         uXrg1tElIVvzqpbiAUvdxnoJWldB1PZ6sTBeJD2caHp/EZK8kJs3BgjOWykEpCaKjKZH
         uJpn4xdk/OlWp+epX8i8+tJgLXK/2cFL+Zmvha/tdE68a2dwiSd6s4PqlcPIbKxPKQn3
         E7zutBlzaprTpDfAzC4Xyjd4sQ5P5Tah+NV1jvLPAWpH9dntd9tFlXavHjpuCqCtkY90
         Rd8FNzOTVor7vzAGBdU6o+Zk4LNPY8wuoUC45tYSstNouPWDcmyS77zz3o+8wIFkLdqz
         oBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ltHMsPw3NKSxTBZBmR9UaadEhj/Rub0S1pq0XesvMmI=;
        b=DnHEGxcnhqEA8Q05UwKo4tRWDTEoPK8l/E/8O3fca1XQE9/ddfzImUHvj1TY/NbP5j
         EZJPR0M+rsvlShXNlFhq3ayT6DMpzJafehQGs7eDjXbEK1H1NaAt2myrexyZ/pUcffia
         vviZy/FmSaxNrJ6PlcRuWQzwZ0LcHRXQkeeuJ5h0SJzT/OBbvIVySdVoxlk6402LUo7m
         0CyE0V3tdaGIDQxBbR6f8ctK8q/UnNwXgZWTV2A92xdNkDQ7K47yIP1nYD8MiXLTk/TO
         0hTtkFW7vC22ZeSKToL5s9ZO3GMYLlNioP2nz4TQH2I7/ydF+Or694jggwGkM//aw47e
         jUJQ==
X-Gm-Message-State: AODbwcBjq2McLEXagP7d1DN0LPX1cGok4u+FyW/8f+Zd398xflg3tEvZ
        J/NG4sDDOCB9QA==
X-Received: by 10.84.241.206 with SMTP id t14mr16979141plm.48.1495278798426;
        Sat, 20 May 2017 04:13:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id f27sm24187071pga.41.2017.05.20.04.13.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 04:13:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 2/3] sha1dc: use sha1collisiondetection as a submodule
References: <20170518212858.3649-1-avarab@gmail.com>
        <20170518212858.3649-3-avarab@gmail.com>
Date:   Sat, 20 May 2017 20:13:15 +0900
In-Reply-To: <20170518212858.3649-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 May 2017 21:28:57 +0000")
Message-ID: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Replace the forked sha1dc directory with a copy of the upstream code
> imported as a submodule. This is the exact same code as now exists in
> the sha1dc/ directory.
>
> The initial reason for copy/pasting the code into sha1dc and locally
> modifying it was that it needed to be altered to work with the git
> project.
>
> The upstream project has accepted my code changes to allow us to use
> their code as-is, see the preceding commit for details. So import the
> code as a submodule instead, this will make it easier to keep
> up-to-date with any upstream fixes or improvements.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  .gitmodules            | 4 ++++
>  Makefile               | 4 ++--
>  hash.h                 | 2 +-
>  sha1collisiondetection | 1 +
>  4 files changed, 8 insertions(+), 3 deletions(-)
>  create mode 100644 .gitmodules
>  create mode 160000 sha1collisiondetection

I am not sure how prepared our .travis.yml is to deal with a
submodule, I'd prefer to have this step broken down to two step
process.

That is, [PATCH 2.1/3] first adds an otherwise unused submodule, so
that people can optionally do "git submodule init && git submodule
update" so that they can compare the contents of sha1dc/ that has
been updated by [PATCH 1/3] with the up-to-date upstream.  Then
[PATCH 2.2/3] would update the Makefile and hash.h to use the code
in the submodule.

I actually would want to see us proceed even more cautiously---if
the latter-half, i.e. [PATCH 2.2/3], is arranged so that it uses the
new sha1collisiondetection/ only when the submodule is initialized
and populated, and otherwise it uses sha1dc/ as before, I would feel
a lot safer.  I wouldn't be this paranoid if this "let's start using
submodule ourselves" were done to some optional corner (like compat/
or contrib/ somewhere), but this is the default hash function.  I do
want to have something like this to force us (and submodule folks)
to get any kinks out, but I do not want to see many people not even
be able to build while this new arrangement is eased in.  Once
people are comfortable with the new arrangement to use code from
submodule, we can then take [PATCH 3/3] to remove the old sha1dc/
directory and the migration will be complete.

I also am not very happy with .gitmodules pointing at a single point
of failure.  It would be nice if you can arrange a couple of mirrors
and have a comment in .gitmodules file to tell folks that they can
use these alternates by insteadOf or some other mechanism.

Thanks.
