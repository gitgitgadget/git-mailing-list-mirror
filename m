Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E371F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeCMUjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:39:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36164 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeCMUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:39:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i194so378930wmg.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGiU2uBj/E1RaG/FXnOagbf2MZOHP6oyGsa0yNV0MMs=;
        b=b5sEV4luhsiidFDX17YzZcejogmj7ENjNWD8o9O1ypCuqaeY3J0e96GyTxyh1ZL8xB
         EWO8ymUvJiYSH+7c3lQfl9LNybtMRbhlwRWE4aoiajSTW7FKYxvSrwE+ycnD1Vnv7i6Q
         VqKdrC2opXLpz+XbFdlTT48+qmBTnfM5T/YBCTqc/lTErUDfV8vd5eHIhtI829FnHUsX
         fGgzv2WWJlXxuuBSgUmiJkyY8smH2O/0xy8nI2V6FZbA0Eq64I3lmsAymGtKajUc5oeT
         Sl6z+4KrYdpi2a1eAhNZ1ziVUrKu+Zg53Xa30O4pt5lF0l1ALjeQdoHBzHKii2JY4wuv
         ToZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGiU2uBj/E1RaG/FXnOagbf2MZOHP6oyGsa0yNV0MMs=;
        b=cCw60ajghkDiQYHK3XPILeuNpTVebMvGJSBSEOUDKqbN40FDY6KFkdh8rvH4eTjDVu
         cMwsG43FoP2ezIALpLHnoeA2rLmYaqtAcyVJOUFuf+TVAh9hCksxN9n9tJD4L4HTnK56
         oPh2rlItZft9tC2INezDhoUouCKoc1MF/rZJyUtLdkcnoz4UXFVsfs0z6PwkPcQGyIFn
         USG/tk+UFOq+/rV+87N3EWxTFOhdmrQlomck5+MaXImqjC/nHNvUE2PoYGfaViRPSejr
         GgHI0lZBAq6DohU24Vkk6WyxmFHNKQ/Yea8bfyH2IPFKpYIW/WEVN44hucJR5L7K8hM7
         8oZw==
X-Gm-Message-State: AElRT7ERUqZzxODpoFNqdgUTfe8vygdaTNS7twzhMVoRt7/C5vQmALpK
        tpWfTTGzw3eCgDLRlO5stCuiOaya
X-Google-Smtp-Source: AG47ELvoduY8qK2F0iEOzlB0rGwrRmVILzcJgHh1Ra83ZS0W89QTiW7tpB9Z9A4dZOBVUPJ1rmbouQ==
X-Received: by 10.28.191.138 with SMTP id o10mr1838008wmi.26.1520973590247;
        Tue, 13 Mar 2018 13:39:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m9sm1424203wrf.13.2018.03.13.13.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 13:39:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Makefile: add a INSTALL_SYMLINKS option
Date:   Tue, 13 Mar 2018 20:39:32 +0000
Message-Id: <20180313203935.5084-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
References: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Related to this, I came across this bug report
>> https://gitlab.com/gitlab-org/omnibus-gitlab/issues/3265 which is
>> wondering why we're installing N copies of the git binary, presumably
>> they're building with NO_INSTALL_HARDLINKS.
>> ...
>> But is there any reason anyone can think of for why we shouldn't be
>> figuring out the relative path and symlinking the two?
>
>
> There is no fundamental reason not to offer such an "install" method
> as an option; unless you count a more philosophical aversion to use
> symlinks due to (perceived) additional fragility, that is.
>
> The resulting code may become messier than without, but as long as
> it is without the reasonable range for usual price we would pay for
> a new "feature", that would be tolerable, I guess.

Cool. I think it makes sense for us to have this. Here's an
implementation of it. The 3/3 patch looks a bit scary, but "git show"
with --word-diff will show that the change is minimal.

This steals a small piece from Daniel's relocatable series, and
doesn't in any way conflict with it. None of this will need to be
fixed up to make git relocatable since all the symlinks are relative
already.

Ævar Arnfjörð Bjarmason (3):
  Makefile: fix broken bindir_relative variable
  Makefile: add a gitexecdir_relative variable
  Makefile: optionally symlink libexec/git-core binaries to bin/git

 Makefile | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

-- 
2.15.1.424.g9478a66081

