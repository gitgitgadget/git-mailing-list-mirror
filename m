Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE0C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 04:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929FA2072E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DjAwngx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgAIEof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 23:44:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIEof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 23:44:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CCDFA5920;
        Wed,  8 Jan 2020 23:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vgt4gMwVa0kmv9RxVcjcoMgX+40=; b=DjAwng
        x9Aml5RJ/xIEtDT1ADYc5rfND1qj38FElrDDqyMQTwSCL0TWfyRqfa708nsCg3lj
        Fgltjb+C7M1FxY/lR/tdItJ0OWx6M7g0VzTeyy+mJIxqwWlLMxQajsEyojFQRTOA
        IEE/Q6yYbl64b2bk4oNInkvEeEdohycbOIm2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IfKWYJ6obJmsu+ZAzsizoBVfY8T867Tq
        U/GC8NTrLPh8a//klnVrIMtXzGCUn7XraKOs09/29DnyM8ZKpRCOaXAkG4qCH4zI
        oBQpyxyinorDIa1fw4+OQV4Ei3QV2XIBxkFNc+qElqruZftEb/h2qIFtuNhjtUL+
        LRSkqL4ms3A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93C5BA591F;
        Wed,  8 Jan 2020 23:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD611A591E;
        Wed,  8 Jan 2020 23:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tymek Majewski <tmaj@pm.me>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How log log a feaure request
References: <l0W9VY7TaoqT51RecilbNNTaX35RiCNlJtZKcz04cyKexuG06-bZMlwfor5kCvnIHRRWE7s8TSJLwvA-w4-1poMV_gle8iOzd3-wzFVDUh0=@pm.me>
Date:   Wed, 08 Jan 2020 20:44:29 -0800
In-Reply-To: <l0W9VY7TaoqT51RecilbNNTaX35RiCNlJtZKcz04cyKexuG06-bZMlwfor5kCvnIHRRWE7s8TSJLwvA-w4-1poMV_gle8iOzd3-wzFVDUh0=@pm.me>
        (Tymek Majewski's message of "Thu, 09 Jan 2020 02:06:41 +0000")
Message-ID: <xmqq1rs91bo2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA2A4BB2-329A-11EA-9C9F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tymek Majewski <tmaj@pm.me> writes:

> Hello gurus!
>
> I looked at https://git-scm.com/community but I failed to find a
> place to send feature requests to.
>
> Q: How to submit a feature request (rather than a bug)?

Sending it here, which you did, is how ;-)

> Reasoning:
>
> I believe that if the git checkout message
> "Your branch is up to date with 'origin/branch_name_here'"
> was
> "Your branch is up to date with the *local* branch 'origin/branch_name_here'"
> it would make it clearer to new users what is happening.

I would be sympathetic to the above, if you did not say "local" and
instead say "remote-tracking".  A local branch is what you can check
out and grow its history by making a commit while it is checked out.
Those refs that are updated when you fetch and/or pull from the
remote repository in order to keep track of the branches they have
are called remote-tracking branches.

Because this message is something people see every day when they run
"git checkout", I am not sure if the extra explanation is warranted
or merely annoying, as "origin/branch" notation is used sufficiently
often for the users to grow accustomed to seeing it and knowing what
it is, and after all no user will stay to be a newbie forever.

Another reason why I am somewhat hesitant to endorse the rephrasing
is because the name of a remote-tracking branch in the real life
tends to be longer than just 'origin/master'.  We must keep the
message that comes before the name of the remote-tracking branch
short in order to make it easier to read the message for the users.

So... I dunno.
