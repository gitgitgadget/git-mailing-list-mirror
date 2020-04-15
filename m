Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A34C2BA2B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 05:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9675E206A2
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 05:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ghXYHTmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393434AbgDOFpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:45:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65262 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393395AbgDOFpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 01:45:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F7855E750;
        Wed, 15 Apr 2020 01:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rMFbsOzdafSHuQjD3Ok3BbTeC1E=; b=ghXYHT
        mHKJDgp1kD4O4l9kecRFe0IYtvEI6f3soiNZlYYecIujFF7u0YRPyZHm1DGPoHPA
        0Fzc9v6nkTE2JP4G2JVNQg55pswdDbX8eEfffwPbQFBgiQ5RyRp9x/vnrQig484m
        1cOvh5GF7Ecf0Uf1vAiTf8JqGPcG2LgMx3zOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CXB57SMSWloekhqJFY6rM5/Lr7yg6mYI
        H39nLddBca8Joh4p0J63s+loCKM8sBk9FGLgnAno0K97mt6WWbd9GDw2WnKt1mGY
        gb5C8jpynSeu//sElSnml6eTJybZYqRdfLBWXAvl9F6pc2xa2FQL89pR0PS4n0kr
        5xRECIOPo0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A52F5E74F;
        Wed, 15 Apr 2020 01:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF1C65E74D;
        Wed, 15 Apr 2020 01:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kazuo Yagi via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kazuo Yagi <kazuo.yagi@gmail.com>,
        emilyshaffer@google.com
Subject: Re: [PATCH] doc: fix the stale link to api-builtin.txt
References: <pull.647.git.git.1586882575822.gitgitgadget@gmail.com>
        <20200415031429.GA36683@google.com>
Date:   Tue, 14 Apr 2020 22:45:03 -0700
In-Reply-To: <20200415031429.GA36683@google.com> (Jonathan Nieder's message of
        "Tue, 14 Apr 2020 20:14:29 -0700")
Message-ID: <xmqqimi18fq8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41150044-7EDC-11EA-AADB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> + * Changeset History
>> + * -----------------
>> + *
>> + * The following describes how the documentation has finally been placed
>> + * in this file, over the related changesets.
>
> *puzzled* Why is this information being added to the builtin.h file?
> What is the reader trying to do when they read it?

Thanks for an excellent review, but you are being a bit too subtle
and/or diplomatic here.

A good rule of thumb to use when judging if a comment is appropriate
to have in the tracked data is if it talks about what used to be the
case in order to explain why it is in the current shape.  Often,
such description is useless for people going forward starting from
the current codebase, and is better described in the log message,
and I think that this is a prime example.  As an explanation to
justify why it is good to refer to builtin.h from the current
documentation that teaches what needs to be done to add a new
command, instead of api-builtin.txt, it is valuable to know how the
description of the API used to support builtin commands moved over
time from place to place (preferrably with references to the commits
that did so), and it belongs to the log message of this commit that
updates the reference to api-builtin.txt to builtin.h.

