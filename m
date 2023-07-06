Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FDAEB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGFTCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 15:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjGFTCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 15:02:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8931FD9
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 12:02:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F83E194991;
        Thu,  6 Jul 2023 15:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dq3eKgblwd/fjcLZEevXLQhQuJXugPcOQHsuUj
        elXDQ=; b=tOCxp4XLU0BSCD7812dyaPh5QJcv9n6KZPckQG1V8aYdu0B2c0defH
        nqc2Km9TOFL3IaGFVakEkGRNTgihFeM05Za9mGtRgja7sGUyGQMhQKlSDV2JKPcp
        kX6tQt+KXc8fP5ixkCdNOwkuU4OS0YATq2Bj9Q7LSc+zHNkRT4G7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76CCE19498F;
        Thu,  6 Jul 2023 15:02:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D33A119498E;
        Thu,  6 Jul 2023 15:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Linus Arver <linusa@google.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
        <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
        <owlybkgy837j.fsf@fine.c.googlers.com> <ZJ3uGBEEvYmbPnoQ@google.com>
        <owlywmzk7nnb.fsf@fine.c.googlers.com>
        <kl6l1qhkrj83.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 06 Jul 2023 12:02:29 -0700
In-Reply-To: <kl6l1qhkrj83.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 06 Jul 2023 11:24:44 -0700")
Message-ID: <xmqqzg48dfsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A85DAA5A-1C2F-11EE-AC4E-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> - Inline tests are, by nature, non-production 'noise' in the source
>   file, and can hamper readability of the file. This will probably be
>   exaggerated in Git because our interfaces weren't designed with unit
>   tests in mind, so tests may be extremley noisy to set up.

I do agree with the first sentence, but I am not sure what you mean
by "our interfaces weren't designed with unit tests in mind".  Do
you mean that in the longer term it would be good to tweak the
interfaces with "unit tests in mind" (and add new interfaces that
way?  Or do you mean interfaces that are written with "unit tests
in mind" inherently becomes noisy when inline non-production tests
are mixed in?
