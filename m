Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A4C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKIXSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKIXSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:18:11 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B22CDFE
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:18:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a17090341c800b0018731b83fe4so69201ple.16
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD8wvr2IIH2sxkLT28C3mnEO9/p8TW2eCgApOUu+DtU=;
        b=Sgi/LpG7iKRLfqu+mw8g8udiLA6X2cdyVsJ6Aww8f1zHmttCXwE/4mSJF/BwaDzOpO
         q5xPD2DHQD+57mPCCvcaneYPysjBCKnL+9aYcR6ARXEfam1kQtapogv6ev0aLkU6Rl06
         n5Y19POUp8M8bcDjQNQ0Hn2HBCkUrolTyUvVEo8w7eikFJsqKRLk3mxNI6m2OSe8Xrzb
         o+FrqV6v/GoD6PGi2n40lUWudjWqoi+R9vWTgNeQ/6N1Gn6NIaZbrCVLLn6L4+GwR9Jy
         ourbpA1vJ1Gb2N95gzEf/BYdSKBI/PKIS5a4djtn4rrIter+ut2IlxFUY8K0H+tSC5wE
         4Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD8wvr2IIH2sxkLT28C3mnEO9/p8TW2eCgApOUu+DtU=;
        b=CcyQKImz+J3oK3V/9Gr/oa+l8OWYee30nUOU6nM4j7AHnaEcHzi02kurfUyVOxkLcB
         BeKTpw32OA2gHTt2Z02r4BNVFMooTZAjEo8AxM3Zkut1k/TYMp5et3uWutQhjlbeJUwl
         tfHnEKXGuA4YVi+uZGq+3E4HHBIMJFiW7PjEueQvzvD96P7oHX+vMYURjnDnsgkud7nK
         IO6Hyv4b4NQtwq7sqmYHCxsU3TgOWOO8X5DBhKahhieFrV01gk4nI2C6pxKQecYgUF23
         OJojNEu+cLXq7Qd8PtuIvDP1kgx5vhoajvSiGibyuXARR0tNsQnHoLaAwL4AezOL0aWe
         UGfw==
X-Gm-Message-State: ACrzQf2/ZRu2lxAOVab3ZTAGTLKOYkLo+Xizixx9l1g5QeHsdTDAjnzq
        kk7AD41gyUdRwE1qPARUBTteCEr7To8o6g==
X-Google-Smtp-Source: AMsMyM79s+WPpSvmGuZlC2J3aTZ8YGO+VHwk3kXi5UwreVxYcmYB/FKs/BI0hVSKFh9FyclByQd6mor654yvMw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:394a:b0:213:1143:9886 with SMTP
 id oe10-20020a17090b394a00b0021311439886mr1258534pjb.236.1668035889792; Wed,
 09 Nov 2022 15:18:09 -0800 (PST)
Date:   Wed, 09 Nov 2022 15:18:08 -0800
In-Reply-To: <65ac638b8a077c04687d9cf3d33c7480024034ea.1667426970.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com> <65ac638b8a077c04687d9cf3d33c7480024034ea.1667426970.git.gitgitgadget@gmail.com>
Message-ID: <kl6l35ar4szz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 03/11] http: store all request headers on active_request_slot
From:   Glen Choo <chooglen@google.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Once a list of headers has been set on the curl handle, it is not
> possible to recover that `struct curl_slist` instance to add or modify
> headers.
>
> In future commits we will want to modify the set of request headers in
> response to an authentication challenge/401 response from the server,
> with information provided by a credential helper.
>
> There are a number of different places where curl is used for an HTTP
> request, and they do not have a common handling of request headers.
> However, given that they all do call the `start_active_slot()` function,
> either directly or indirectly via `run_slot()` or `run_one_slot()`, we
> use this as the point to set the `CURLOPT_HTTPHEADER` option just
> before the request is made.
>
> We collect all request headers in a `struct curl_slist` on the
> `struct active_request_slot` that is obtained from a call to
> `get_active_slot(int)`. This function now takes a single argument to
> define if the initial set of headers on the slot should include the
> "Pragma: no-cache" header, along with all extra headers specified via
> `http.extraHeader` config values.

I admit that I'm not that familiar with the http subsystem, so I'll
focus on the style.

If I'm reading this patch correctly, there are two related, but distinct
changes:

- store and modify the headers on the slot
- change how headers are initialized and remove now-unncessary libcurl
  calls that set headers

Both are simple, but given the number of LoCs changed, I found it quite
difficult to track which LoCs were part of which work. Could this be
broken up into two patches instead, i.e.:

- store headers on the slot without changing how they are initialized
- add extra header initialization logic to get_active_slot() and remove
  the unnecessary libcurl calls

