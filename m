Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B687C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiBJTRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:17:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiBJTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:17:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72D9D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:17:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0464197841;
        Thu, 10 Feb 2022 14:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BCz5AUE8FdF0heYgLCptuLA64WYt4lNz85sHSa
        w69+A=; b=Iye+zOIOVhXlOXpXFtGHxbnB2UJVWxhyHli6wdTv/WU5nSv0nvQ0k4
        u6nbNdc/GXSt2fcCyvR6GKtJvr1L8VVccYB8f+W4yOOZwWOUlTu9TBQdcVtirfJk
        zZy7S4rJSHWm5SgJgiXqlQoRqfxxQ5cJMgYmfuqyi0fWZK5A1Q7GE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 972C5197840;
        Thu, 10 Feb 2022 14:17:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BBE9919783F;
        Thu, 10 Feb 2022 14:17:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        <xmqqiltmwufw.fsf@gitster.g>
        <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
        <xmqqh796tw34.fsf@gitster.g>
        <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
Date:   Thu, 10 Feb 2022 11:17:40 -0800
In-Reply-To: <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 10 Feb 2022 19:36:49 +0100")
Message-ID: <xmqq7da2ttt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E37DA24-8AA6-11EC-9810-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> > Is this glossary the official definition of what things are? If so,
>> > the source code should refer to there. If not -except for confusion-
>> > how bad is it if the info in the glossary is inaccurate?
>>
>> Developer and end-user confusion ensues.
>
> that's why I said: "except for confusion" :-)
>
> I'm asking to understand if there is anything stopping us from
> changing the glossary to match the current code.

I do not think so.  It will give us a chance to rethink what we have
in the code, too.  It is possible that we may end up concluding that
it is better to leave a "pseudoref" always as a file inside $GIT_DIR
regardless of what ref backend is in use, for example.

