Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 05:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F923EB3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 05:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395273AbgLKFsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 00:48:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395262AbgLKFrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 00:47:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C38095BEB;
        Fri, 11 Dec 2020 00:47:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9puWjYrPcQWt5XZ0/uRz7aL9KFc=; b=V498+UMEFIhs45xpXtUc
        8W8+nzrCZst7cx3wHyRpU4/VGBHrk8wKcVRG9B776s7X5Zf11LIPIlGy89042PKR
        NbSvwLvcD3eMu5FbARJb5WnburHPAVEgvoHbwylH7MBKpvCZCM+QTNUjmLvQrEQk
        jAyGmSVMLSTnu4BBie6r7DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=HLl8aOBFUyFHrm4Tzm9V8igoB8A9K9nFX+1GTg5UYEiqef
        jaRzbvn2c3deD4nQcM8+WNg+KrbA2MhBIMJhAo7eHqGVlwy13NEkiMAdMMoo1vYj
        gDHJW5+3sFjRkdXSxedxpbCBujNUQwNEvVaZn9845pf4CBz4cB3bEZB7U5aFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8289995BEA;
        Fri, 11 Dec 2020 00:47:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA36595BE9;
        Fri, 11 Dec 2020 00:47:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/4] init: document `init.defaultBranch` better
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
        <CAMP44s3mtCd9RnZdW7-HLcKVG13UW8u_1VNC0_7jByQRv61+vw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 21:47:04 -0800
Message-ID: <xmqqblf0opwn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C725130-3B74-11EB-8E0E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> -`refs/tags`, and template files.  An initial `HEAD` file that
>> -references the HEAD of the master branch is also created.
>> +`refs/tags`, and template files.  An initial branch without any
>> +commits will be created (see the `--initial-branch` option below
>> +for its name).
>
> The current sentence: "An initial `HEAD` file that references the HEAD
> of the master branch is also created." is still true. There's no need
> to change that (yet).

The change updates the description for readability, lowering the
technical level of description, and correcting inaccuracies.

 - The readers in the context of understanding what "git init"
   performs does not have to know nor care that HEAD is implemented
   as a file.  In fact, there is an effort to introduce HEAD and
   other refs that are implemented as individual files under
   $GIT_DIR/.  Dropping the word "file" is to correct these.

 - Also we no longer say "the HEAD of" a branch, even if we used to
   use that expression.  When we really need to refer to the commit
   directly pointed at by a branch ref, we say "the tip of" instead
   there days.

 - It used to be left unsaid that the initial branch begins its life
   without any commit.  Now it does.

None of these is about "'master' or any other name?" issue.

> Perhaps: (see the `--initial-branch` option below to choose another name).

That changes the meaning of the explanation.  It is compensating for
not saying what the name of the initial branch is, and is not trying
to teach that the name can be changed.  The text in the patch is good
as-is.
