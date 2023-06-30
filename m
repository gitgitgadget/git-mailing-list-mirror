Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B463EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjF3Wtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3Wtx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 18:49:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58B35AF
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:49:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF2F71A58A9;
        Fri, 30 Jun 2023 18:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0TmHR6rujOFw587TI4eQcyTbOtkrw/TVBpbzo1
        hM3pY=; b=xHF4M4nlv8iYu/14pccL9gyoyI2vsJ/i4q0+yA9GddqzWO/LJzixGJ
        PPw8h1zAfnp93rpAZGJb8UlXqet5a0eqkBrHCUCdTT4ltjKWzbDGUOow/w46H/jG
        muhCFJmPRBTZTvS38k6xv39pZ8lrLq6/ubYXg0YhTd+uzNWa188n8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B50601A58A8;
        Fri, 30 Jun 2023 18:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1687C1A58A7;
        Fri, 30 Jun 2023 18:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 6/6] common: move alloc macros to common.h
References: <20230630202237.3069327-1-calvinwan@google.com>
        <20230630202346.3069950-6-calvinwan@google.com>
Date:   Fri, 30 Jun 2023 15:49:50 -0700
In-Reply-To: <20230630202346.3069950-6-calvinwan@google.com> (Calvin Wan's
        message of "Fri, 30 Jun 2023 20:23:46 +0000")
Message-ID: <xmqqfs685zw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C18E866-1798-11EE-9ABE-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> alloc_nr, ALLOC_GROW, and ALLOC_GROW_BY are commonly used macros for
> dynamic array allocation. Moving these macros to git-compat-util.h with
> the other alloc macros focuses alloc.[ch] to allocation for Git objects
> and additionally allows us to remove inclusions to alloc.h from files
> that solely used the above macros.

Is this step mistitled?  There is no "common.h" in this round.

For that matter, when the series makes a big change like this round,
please update the cover letter so that those who are reading it
without having seen the prior rounds can understand what the series
is about.  It will equally help those who have seen prior rounds,
too. what is going on.  E.g. The cover letter of v1 emphasized why
moving many things to common.h was a great thing (and promised to
talk about it more in patch 3), but that focus certainly has shifted
in this iteration that no longer even creates "common.h", right?

Thanks.
