Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFWK4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFWK4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:56:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074944B85D
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:56:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q6so3250387eji.13
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1vVbOrB8C1B+iNkR4lQcmHHGT+1bxrG2Y5aTxsD3NNk=;
        b=poJjoEwfZeiPy9D/Y2uH8dPK62+kd1XacpOTAF25qal1QM3Lbqw3AYs8/gOAgKJoJs
         4WpsQbn2xWn0zkgH4am2I+aB0ff/iBw8O70HoMjr+LJE0Ap9u1Yp0PVNMC0VNzRUCetU
         tUKGrmyN8DxFop2yOVGwLFVJL3ghWOop9PomsUwJMKS8Mx2nqSai4+uvEg3HNUwVl8W7
         IhZtE0OGMHEmogXJwkrep7W38KH0jL0vKJ5j11zXMfFpJc9FFYKeN+wGrfIMmANac9tI
         F4T8R/I2LdOiD/c3ScbIEyi0vPPlK6MFpS0ndEHVlf6sfQNMzJcU0ZTAMR7bb1oymjST
         bKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1vVbOrB8C1B+iNkR4lQcmHHGT+1bxrG2Y5aTxsD3NNk=;
        b=FR0r0Z0M7M+iA21Fv//mV9Ze+PCHMqetq6EZPjy5gOnmK3T4UbQtrwQ2/VGdZGO+W/
         f/Y1yu64HCLPmQAAI/1LqbvxZomuMc4URlHNqXXDlZJf5ytAlokcNss+7KNaf2439EzV
         nHOmixsCuwOPIocP6+dOXJY/TnYjOiwbRQ4KiOZSSNazc0FjAlqM2lT8rj6hszwWBOt5
         6nM4IsAItsM/d90qXYjQciHJWLljKwPCLQeDscngPDIo1sr/EmVJtqhgs6pQ1GvNjgzE
         o3Pa1L/qfHgnofbVQefCXAoEvgMH2post27QT96uZlyuVyaso6cfqmGqDUJMtcgPmkeY
         yI1Q==
X-Gm-Message-State: AJIora+CgSDExsrUVkz1pUxFtiLVJ8ixsPHixOOUveMtsp3IaysKBjtx
        6/py1RaXqg7Mk0fQo0OP/oQ=
X-Google-Smtp-Source: AGRyM1sUEdj4BjdKlU7Ac5QqN9lwIItyOepgaq2NTdwFEUKVI9NjLrM10kChbkxmd9as5nNqSqpK9A==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr7268665ejj.278.1655981764502;
        Thu, 23 Jun 2022 03:56:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u6-20020a05640207c600b004355cb1e77esm14847409edy.91.2022.06.23.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:56:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4KVH-000sDN-EU;
        Thu, 23 Jun 2022 12:56:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/test-without-templates (was: What's cooking in git.git (Jun
 2022, #07; Wed, 22))
Date:   Thu, 23 Jun 2022 12:55:07 +0200
References: <xmqq7d584hqb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d584hqb.fsf@gitster.g>
Message-ID: <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Junio C Hamano wrote:

> * ab/test-without-templates (2022-06-06) 7 commits
>  - tests: don't assume a .git/info for .git/info/sparse-checkout
>  - tests: don't assume a .git/info for .git/info/exclude
>  - tests: don't assume a .git/info for .git/info/refs
>  - tests: don't assume a .git/info for .git/info/attributes
>  - tests: don't assume a .git/info for .git/info/grafts
>  - tests: don't depend on template-created .git/branches
>  - t0008: don't rely on default ".git/info/exclude"
>
>  Tweak tests so that they still work when the "git init" template
>  did not create .git/info directory.
>
>  Will merge to 'next'?
>  source: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>

Presumably the submitters vote doesn't count for much, but FWIW I think
it's ready & that there's nothing outstanding left to address.
