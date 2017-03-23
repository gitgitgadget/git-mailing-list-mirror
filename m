Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E830820958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbdCWSDK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:03:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55624 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753686AbdCWSDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:03:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4443F88BAF;
        Thu, 23 Mar 2017 14:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AasHjaZ9dHAp3LJSoMP5eWmUc0I=; b=J4YSYm
        ULYWmCOH5JT0nlB0xqaxf+qg+UFmOcCLDxaQ0W3+RwGnrABowTdLXYTDRK7WyF47
        EhM6WjOemdsdDKzSt6cX8whI4sof3QARpgzELb+edvC8rY7vTYwru+DF+UljiRaf
        fMys4eCXvNg6uLxmILlPvDUc+fzRexoguuKvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvxr2zmdMoprM9JfrXCjeg5cUF9IuS15
        SOfr5rAYf4KXQWUZsUa7WOVHZyd9OVKWaZalyXx9lKLqP2flMrQSr6deCVYX2TRJ
        QrM3R8q+R/GQ/9XHNnsqsjag3rDZhZulpNfXyD5iDW918uRdrNH0ONYUMf4rPrFA
        L4Zjl91cTNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BD9E88BAE;
        Thu, 23 Mar 2017 14:03:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F64488BAD;
        Thu, 23 Mar 2017 14:03:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
        <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
        <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
        <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
        <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com>
        <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
Date:   Thu, 23 Mar 2017 11:03:04 -0700
In-Reply-To: <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
        (Alex Henrie's message of "Thu, 23 Mar 2017 10:52:34 -0600")
Message-ID: <xmqq8tnveuqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6E3107A-0FF2-11E7-8005-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Yes, that makes sense. I assume that when you talk about 'next', you
> mean 'master'?

No, I do mean 'next'.  See "A note from the maintainer" post that
are sent to the list every once in a while (i.e. after a new release
is tagged) for the project structure.

    https://public-inbox.org/git/xmqqy3vztypi.fsf@gitster.mtv.corp.google.com/

> If we want to use `git -p log` in a test, we'll have to change the
> behavior of pager_in_use(). Alternatively, we could use
> `GIT_PAGER_IN_USE=1 git log` instead.

Testing "git -p" is not the goal; testing that decorate defaults to
auto during an interactive session is.  We could run tests under pty
like t7006 does using lib-terminal.sh if we really want to emulate
an interactive session.  

Exporting GIT_PAGER_IN_USE may be sufficient for the purpose of
convincing the command to be in an interactive session for this
test, even though it feels a bit too brittle to depend on the
internal implementation detail.

Thanks.
