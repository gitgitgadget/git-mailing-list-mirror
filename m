Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B416F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 01:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfJ1BYi (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 21:24:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51497 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJ1BYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 21:24:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 442479CA26;
        Sun, 27 Oct 2019 21:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+cKjANL71M3W
        jRUjIQ2GGo1dQu4=; b=q4N8XKybDgDX91+pYNZIKJTZaYuXkvJx2zww6QVkqdLY
        UxPe6SIlgEKb+Mv2x8SARZzRZQvsFu8CWCA6BcNzI+5lXhFUgVcwA0cPiJvyerDF
        fG/he9IwupzPtbUYdzXKAxEG2ABR9GWESJhzq79Cc28ghjRC9KvJzYavuwIqlAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h8mbTl
        /ynW+tvwVKgu+oPMAtlnYptBnq8AL7SNpBSgxr0ymIDkbzeplvfLAPfkD3yYXxRA
        TlRLxum2Rb8Qw9VKkshkk/19/QngvQZrgt7SxmOMBM0X4wbSYStBc16P2dFbn8A/
        +gLtoiVHu4UmPr+Zw1h6nO8uoFUrXojV2WoNs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BE519CA25;
        Sun, 27 Oct 2019 21:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69E579CA22;
        Sun, 27 Oct 2019 21:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] myfirstcontrib: add 'psuh' to command-list.txt
References: <20191026005159.98405-1-emilyshaffer@google.com>
        <20191026005159.98405-2-emilyshaffer@google.com>
        <20191026010857.GA39574@google.com> <20191026080057.GP4348@szeder.dev>
Date:   Mon, 28 Oct 2019 10:24:31 +0900
In-Reply-To: <20191026080057.GP4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sat, 26 Oct 2019 10:00:57 +0200")
Message-ID: <xmqqmudlbr1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B270CB38-F921-11E9-AF51-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> See that last "no link: git-bisect" line?  That's what happened to
> catch my eyes when Derrick forgot to add his new 'sparse-checkout'
> builtin to 'command-list.txt'.  I still haven't looked up what that
> 'no link' is supposed to mean, but if it were an error, then we would

Build procedure for the Documentation uses ../command-list.txt as
its input to produce cmds-<class>.txt files, that are included in
git.txt (hence resulting git.1 and git.html).  While it works, it
tries to make sure that a command that has its own documentation
page at Documentation/git-<command>.txt is listed; otherwise we have
a page for <command> to which there is no link from git.{1,html}.

I think "make check-builtins" might also want to sanity check
command-list.txt.


