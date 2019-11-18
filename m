Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202F61F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 07:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRHMH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 02:12:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfKRHMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 02:12:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C9E82E9E8;
        Mon, 18 Nov 2019 02:12:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vi08Atm24BrfqnXW/kzFJgAhAlE=; b=gWDXAR
        cr/KtbPwxYlLh1D4hazsctIMD1kEL9v06gzNcVJ8bghSEx82g7j3HZXNR7fYaKh+
        euVMpWdKAL7ZmRA8vIuuFFr5Y/QAwS9eHMApf5eau4LxZ1JhEFXug6cLFqKruSxi
        GGarWwDAtWLhC8aH8x0n5Fb8xViBDpUWUrZlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YnWHZyuGyt9qRgikfbm5ANYzWnOT7shk
        zolmYGYzOhCOQ89SQD81vD22OxJeZg8ILDIQ9ldbDOSBF5Hk6FHfbFl1dXhXN/vX
        6bK5E5xLx2f8qNupYjqGxUnvRMXvD00b+TVHKZFQ96LJBZ8KbRrMunwyESM1xBEh
        XV5hOKhro7s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88E932E9E7;
        Mon, 18 Nov 2019 02:12:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 937CE2E9E5;
        Mon, 18 Nov 2019 02:12:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: working directory status
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
        <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
        <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
        <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
        <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
        <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org>
Date:   Mon, 18 Nov 2019 16:12:02 +0900
In-Reply-To: <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org> (Johannes Sixt's
        message of "Sun, 17 Nov 2019 23:26:14 +0100")
Message-ID: <xmqqk17x1wvx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8C95858-09D2-11EA-B05D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> ...
> Do not set GIT_DIR if you do not understand the consequences.

I think the explanation in your earlier message was probably a bit
more helpful.  If they want to use GIT_DIR, they need to also set
and export GIT_WORK_TREE.

Of course, with both exported, asking "git branch" for which branch
is checked out would ask about the working tree that GIT_WORK_TREE
points at without consulting $(pwd), so it is rather pointless.
When the user switches to another worktree, both GIT_DIR and
GIT_WORK_TREE need to be updated to point at appropriate places, so
it sort of defeats the purpose.

>
>> C:\test\Local_Newfeature>git worktree list
>> C:\GitRepo                (bare)
>> C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
>> C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
>> C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]
>
> I do not know whether it is a sane use-case to have a bare repository
> and separate worktrees.
>
> Do not do that. Make a regular clone with a worktree and create
> secondary worktrees from there.

As long as GIT_DIR/GIT_WORK_TREE are both set and exported (or both
unset, a new worktree made out of a bare clone should work just
fine.  At least that is one of the use case I recall the feature was
designed to be used in.

Thanks.

