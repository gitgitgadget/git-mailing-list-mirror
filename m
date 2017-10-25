Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47E31FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 06:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdJYGWt (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 02:22:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50021 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751162AbdJYGWs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 02:22:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89BBBAD8E0;
        Wed, 25 Oct 2017 02:22:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7fdx41t7mSh4+dHb7q6CcIBfTXg=; b=hXYdPP
        tsyzwB74OKYGWU16VsTfGOP7xHFO0JEeg0mXS/6HCbemrS2f6IX5FYiLueZm6SI8
        88kzUVTCgpQtm5cQc1XEA+vXi90w9PHp0UBkhSazCAjbhMDc6vUYXFQ/qkrZismx
        Ed5zqQm1k+c2+/GxUCnDU/YEV7Z9Z5yr/bmQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1iluNscYntQiFADAVXgdqdAhXUE4GGL
        14bpk5n75L8xxQg58yH8cmaTVItr3dgfkbVCHA4JuhvmlKeqNiC5tvs76LM0nsl+
        0v3mkS+7O37SonHyV124f/u0fbkgU55urOp1vun3A2wZggJT+qap+ebiaCxuxbmn
        5NfoJ1vdQSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82315AD8DF;
        Wed, 25 Oct 2017 02:22:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBCA1AD8DE;
        Wed, 25 Oct 2017 02:22:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: add remaining flags to checkout
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
        <20171024131931.18221-1-thomas.braun@virtuell-zuhause.de>
        <be2e0547-5ef7-c9d9-baad-44f5fa9d3c31@kdbg.org>
        <xmqqefprix2c.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 25 Oct 2017 15:22:45 +0900
In-Reply-To: <xmqqefprix2c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 25 Oct 2017 15:03:07 +0900")
Message-ID: <xmqqa80fiw5m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB064BA6-B94C-11E7-81E4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> The flags --force and --ignore-other-worktrees are not added as they are
>>> potentially dangerous.
>>>
>>> The flags --progress and --no-progress are only useful for scripting and are
>>> therefore also not included.
>>>
>>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>>> ---
>>>   contrib/completion/git-completion.bash | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>> index d934417475..eb6ade6974 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -1250,7 +1250,8 @@ _git_checkout ()
>>>   	--*)
>>>   		__gitcomp "
>>>   			--quiet --ours --theirs --track --no-track --merge
>>> -			--conflict= --orphan --patch
>>> +			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
>>> +			--recurse-submodules --no-recurse-submodules
>>>   			"
>>>   		;;
>>>   	*)
>>>
>>
>> Looks good to me. Thanks,
>> -- Hannes
>
> Doesn't quite.  This breaks t9902, doesn't it?

I've queued it with the following squashed in.

 t/t9902-completion.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2cb999ecfa..fc614dcbfa 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1245,6 +1245,10 @@ test_expect_success 'double dash "git checkout"' '
 	--conflict=
 	--orphan Z
 	--patch Z
+	--detach Z
+	--ignore-skip-worktree-bits Z
+	--recurse-submodules Z
+	--no-recurse-submodules Z
 	EOF
 '
 
