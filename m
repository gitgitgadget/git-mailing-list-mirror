Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8F31F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbcH3Rxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:53:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758444AbcH3Rxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:53:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E291A3A980;
        Tue, 30 Aug 2016 13:53:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nmvVLqrFsEbX1oYbZUI+KjLuAiI=; b=DWFqOT
        /M1Hbt2Ws8e/0nOdnDTLMSeUsVcfDKWs9Pr39rSYxVWch0li9aASfIK/LTUIC6BG
        I0ao5pWAZeMqPVdQ28wgI2D6ozwb1qaYrV5EUNYXJdWgoESm9WL1LLb8kGukJgFY
        Ra8kzFNMB36H7yCu4bN0NmTTnWuFxjLhoDTkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xp/6joo8XcrM9L4GLdneH2BCTLQ+EsT+
        BrvQYyhfZN7bTU1HAnyIs42s5I1NblVZxI+U53UzIe896RSjJ+CgwEaR7P0T3eDs
        dOECnUbaFEJGTElX5NByiUOkCT7K0HOheDA56HPS5L4ZRfbRdShqUBAemyvqUGgC
        9lRJC63IL1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6013A97F;
        Tue, 30 Aug 2016 13:53:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FDFA3A97E;
        Tue, 30 Aug 2016 13:53:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
Date:   Tue, 30 Aug 2016 10:53:43 -0700
In-Reply-To: <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        (Uma Srinivasan's message of "Tue, 30 Aug 2016 10:40:36 -0700")
Message-ID: <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24CD41E-6EDA-11E6-A7B5-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

> I think the following fix is still needed to is_submodule_modified():
>
>         strbuf_addf(&buf, "%s/.git", path);
>         git_dir = read_gitfile(buf.buf);
>         if (!git_dir) {
>                 git_dir = buf.buf;
>  ==>               if (!is_git_directory(git_dir)) {
>  ==>                     die("Corrupted .git dir in submodule %s", path);
>  ==>               }
>         }

If it is so important that git_dir is a valid Git
repository after

	git_dir = read_gitfile(buf.buf);
        if (!git_dir)
        	git_dir = buf.buf;

is done to determine what "git_dir" to use, it seems to me that it
does not make much sense to check ONLY dir/.git that is a directory
and leave .git/modules/$name that dir/.git file points at unchecked.

But there is much bigger problem with the above addition, I think.
There also can be a case where dir/ does not even have ".git" in it.
A submodule the user is not interested in will just have an empty
directory there, and immediately after the above three lines I
reproduced above, we have this

	if (!is_directory(git_dir)) {
        	strbuf_release(&buf);
                return 0;
	}

The added check will break the use case.  If anything, that check,
if this code needs to verify that "git_dir" points at a valid Git
repository, should come _after_ that.

Shouldn't "git-status --porcelain" run in the submodule notice that
it is not a valid repository and quickly die anyway?  Why should we
even check before spawning that process in the first place?

I might suggest to update prepare_submodule_repo_env() so that the
spawned process will *NOT* have to guess where the working tree and
repository by exporting GIT_DIR (set to "git_dir" we discover above)
and GIT_WORK_TREE (set to "." as cp.dir is set to the path to the
working tree of the submodule).  That would stop the "git status" to
guess (and fooled by a corrupted dir/.git that is not a git
repository).

