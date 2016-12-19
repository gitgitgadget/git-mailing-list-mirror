Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F3B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762835AbcLSSXt (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:23:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59274 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762620AbcLSSXs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:23:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15CD25995F;
        Mon, 19 Dec 2016 13:23:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gF6Kcx/n9t7jn0GN/m8Y4iwBhTU=; b=DmNBQs
        YlH/LCxUpcFwKJRMYafQ77nWl+tI5lvjVcjYqYoxII6mnCHL2l1yV9yZ7a+LhHBM
        Sp8KY/GhVXh9+4lsUYNtalbejtz5Cnxre7YDl8VVsQK8j9hQuL/Au0o8S0+2BPwj
        mLSAzUwIU6zBpLl0YPP13pP283qfSbUZM1qy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IUI6Ehn+EShx5LM+jFx/yjJFuwb0zT06
        wa5mCc4TtE+OEgVnDIhCuCWOAho3U6qs1nSH0nEuM8QxYcJE4X+wGkG49n0urGbz
        goI9X8TENpEPAygnde21jF30W6avbgksK5uOb9YA2LUQmjoDrN31fvNPB113yhTM
        9kyaMc8RWUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A18C5995E;
        Mon, 19 Dec 2016 13:23:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 829365995C;
        Mon, 19 Dec 2016 13:23:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] git check-ref-format --stdin --report-errors
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
        <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu>
Date:   Mon, 19 Dec 2016 10:23:45 -0800
In-Reply-To: <561c0338-66cd-f806-7b3b-b422f98a1564@alum.mit.edu> (Michael
        Haggerty's message of "Mon, 19 Dec 2016 12:29:40 +0100")
Message-ID: <xmqqlgvbpyku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47AE17F4-C618-11E6-BD92-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Especially given that the output is not especially machine-readable, it
> might be more consistent with other commands to call the new feature
> `--verbose` rather than `--report-errors`.

Don't we instead want to structure the output to be machine-readable
instead, given that check-ref-format is a very low level plumbing
command that is primarily meant for scriptors?
