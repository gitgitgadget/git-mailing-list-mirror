Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3FA1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161093AbcHaQmn (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 12:42:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161082AbcHaQmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 12:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD99338ABC;
        Wed, 31 Aug 2016 12:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gGaXIjdXMlymNsjbCD3AJnD6Pjc=; b=EhqqMp
        OphwRi2Y1xWrEju0mfSCG4Mh3dkT7w4bCC6hdgE1G4QFTmotafGIS8+saztUgwcs
        NPXeln05BDnUfe17YXGkJhwBKFy6x/3BlSPahew0XcQFVBiftkokHM4xZd6nj62e
        dDYF5D2XgzjA9//li01wGocQw29N/XNtOKVio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmqfmdZ6tyFi/iYkiEtDh4qiTfa1KZpp
        aIORfcGsThh5gA5UWYC73nQgKuOvJuhLPj25zG/hmpCfDqIA02JguEcoX2TwfLR0
        kDzDegmLkXlCzojFtAaLLQY7nWKWxauag7uuNnpt/YjPhpx5t4M7KbK0PF+ZjJRm
        4KoLJq0ax8s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A676B38ABB;
        Wed, 31 Aug 2016 12:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B5EE38AB7;
        Wed, 31 Aug 2016 12:42:37 -0400 (EDT)
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
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
Date:   Wed, 31 Aug 2016 09:42:35 -0700
In-Reply-To: <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        (Uma Srinivasan's message of "Tue, 30 Aug 2016 19:54:12 -0700")
Message-ID: <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC9F560E-6F99-11E6-B797-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

>> I might suggest to update prepare_submodule_repo_env() so that the
>> spawned process will *NOT* have to guess where the working tree and
>> repository by exporting GIT_DIR (set to "git_dir" we discover above)
>> and GIT_WORK_TREE (set to "." as cp.dir is set to the path to the
>> working tree of the submodule).  That would stop the "git status" to
>> guess (and fooled by a corrupted dir/.git that is not a git
>> repository).
>
> Here's where I am struggling with my lack of knowledge of git
> internals and the implementation particularly in the context of how
> environment variables are passed from the parent to the child process.

Ah, I was primarily addressing Jacob in the latter part of my
message, as he's looked at similar things in his recent topic.

> Are you suggesting that we set up the child process environment array
> (the "out" argument) in prepare_submodule_repo_env() to include
> GIT_DIR_ENVIRONMENT and GIT_WORK_TREE_ENVIRONMENT in addition to
> CONFIG_DATA_ENVIRONMENT that is there now?

I was wondering if we should unconditionally stuff GIT_DIR=<the
repository location for the submodule> in the cp.env_array passed to
the function prepare_submodule_repo_env().  As cp.dir will be set to
the submodule's working tree, there is no need to set GIT_WORK_TREE
and export it, I think, although it would not hurt.

After all, we _are_ going into a separate and different project's
repository (that is what a submodule is), and we _know_ where its
repository data (i.e. GIT_DIR) and the location of its working tree
(i.e. GIT_WORK_TREE).  There is no reason for the process that will
work in the submodule to go through the usual "do we have .git in
our $cwd that is a repository?  if not how about the parent directory
of $cwd?  go up until we find one and that directory is the top of
the working tree" discovery.

More importantly, this matters when your GIT_DIR for the submodule
is somehow corrupt.  The discovery process would say "there is .git
in $cwd but that is not a repository" and continue upwards, which
likely would find the repository for the top-level superproject,
which definitely is _not_ want you want to happen.  And one way to
avoid it is to tell the setup.c code that it should not do the
discovery by being explicit.

