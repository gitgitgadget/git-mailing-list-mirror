Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED7B1F462
	for <e@80x24.org>; Tue, 28 May 2019 15:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfE1Pvh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 11:51:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64915 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfE1Pvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 11:51:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38E566B759;
        Tue, 28 May 2019 11:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NVlZEpyxmMJwxDgDI9vymIc22vE=; b=xQh68i
        d3REtHEvbO4PqmHm+eKAG9F2fC/C1ENepEzPclKVi1DjR+/q6Br2APbLjs8igbVj
        EtwrxgxyZvPq6qWPrKEugC9lQxov28i9MIWV0WV0RcUpUl4EQfFqZECtb+bOCLfW
        xd+LMKCy+pcKFJWITziDOarGm8ksxXjjHidaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Bvxqz/F4KcK8KB3O7Hb84+g+pm4aP4lw
        0h7eNPkXe2q7/DzCqlW3RE3Q4LpF0guzz90ZgESreoHxMI3gq7oICo42foq6ktfO
        zXLtNbf4zJFnDnumzpKQFhwCreDbiYFTFEmq1g6JJbG7XwJNzVE3hLs3+DAbQsTv
        WOiYai7K3YY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31B816B758;
        Tue, 28 May 2019 11:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 601666B757;
        Tue, 28 May 2019 11:51:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc branch: provide examples for listing remote tracking branches
References: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
        <20190528121315.2604-1-philipoakley@iee.org>
        <xmqq5zpuel4m.fsf@gitster-ct.c.googlers.com>
        <d44cbf49-dea9-c518-17e3-f9b252f2dd06@iee.org>
        <48b03739-b8f7-4d94-15dd-cf7936215a0e@iee.org>
Date:   Tue, 28 May 2019 08:51:29 -0700
In-Reply-To: <48b03739-b8f7-4d94-15dd-cf7936215a0e@iee.org> (Philip Oakley's
        message of "Tue, 28 May 2019 15:51:21 +0100")
Message-ID: <xmqqftoy60hq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76F481DC-8160-11E9-B2E3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> However, isn't `-r <pattern>` broken?

No.

> phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git (branch-patterns)
> $ git branch -a -l 'junio/*'

You are asking "branch --all --list" here.

> $ git branch -a -r 'junio/*'
> fatal: -a and -r options to 'git branch' do not make sense with a
> branch name

You wanted to ask "branch --remote --list" instead of "branch --all
--remote", no?

