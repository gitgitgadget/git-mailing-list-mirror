Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE42EC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 23:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbiEPXTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiEPXTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 19:19:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DAC35851
        for <git@vger.kernel.org>; Mon, 16 May 2022 16:19:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E0DC1940FB;
        Mon, 16 May 2022 19:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gRVy6j71D1f2vYUyvw603YQZtttyZ4iCTfPCiT
        zK7FI=; b=Wevw/+rcbh2aCwoZK/t/ssZ8UbqvbPE8engdqTi6VzpG57BFWAfIO8
        o4mngzkO+EurcHhuzjT+a2Dpg7aPLIM5wfKoi4WgagAROxutNzUnTaxjLwucAmJ1
        WS88muM+JGhDtmYA1FDgnNDYSZu85A0gTpAPuJWc63kVMepLGk2Ro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5629C1940FA;
        Mon, 16 May 2022 19:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DE4A1940F9;
        Mon, 16 May 2022 19:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
Date:   Mon, 16 May 2022 16:19:37 -0700
In-Reply-To: <5b969c5e-e802-c447-ad25-6acc0b784582@github.com> (Derrick
        Stolee's message of "Mon, 16 May 2022 15:07:35 -0400")
Message-ID: <xmqq4k1p12wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A88E9F06-D56E-11EC-8170-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> * 'no-embedded' allows non-embedded bare repositories. An
>   _embedded bare repository_ is a bare repository whose parent
>   directory is contained in the worktree of a non-bare Git
>   repository. When in this mode, embedded bare repositories are
>   not allowed unless the parent non-bare Git repository has a
>   'safe.embedded' config value storing the path to the current
>   embedded bare repository.

Sounds sensible.  I wonder how expensive this will be in practice,
but the behaviour seems well thought out.
