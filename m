Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690CC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiEIQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiEIQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:33:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE316C5E3
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:29:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E6D1133B4D;
        Mon,  9 May 2022 12:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ttu4kjUwG0bKOOulc8vCETuiH9QJJQ5+H675pj
        FeXEk=; b=uOMkaS9WyL2uNGDp38fCicV4D6II1C33SVx8wxlEgcOPG2W3pmYqP+
        yh8C1eOjN5b/iIVT1KvxhZXijeURa6uLI5Brm8xMYC7VrZyNEhILfmKp28qDn8F4
        JSfdNIukgZ1gmp0bPIdjCEMbwvzuomY/BsqUpW9XD013YOKLZDJrY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 935F6133B4C;
        Mon,  9 May 2022 12:29:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5582133B4B;
        Mon,  9 May 2022 12:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
        <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
        <aa9884d5-b69a-bfd2-4235-a30326bd65f6@gmail.com>
Date:   Mon, 09 May 2022 09:29:33 -0700
In-Reply-To: <aa9884d5-b69a-bfd2-4235-a30326bd65f6@gmail.com> (Philippe
        Blain's message of "Sun, 8 May 2022 11:33:51 -0400")
Message-ID: <xmqqilqeekk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36509200-CFB5-11EC-8BD1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>> ---
>>     builtin/remote.c: teach -v to list filters for promisor remotes
>>     
>>     Fixes #1211 [1]
>
> I don't think this matters much, but if Junio is OK with that, it would
> be nice to include the reference to the GitGitGadget issue in the commit
> message itself, though with its full URL, something like:
>
> Closes: https://github.com/gitgitgadget/git/issues/1211
>
> as another trailer before your signed-off-by. By including it in the 
> commit message we allow the issue to be closed automatically when your topic
> branch is merged to 'master'. By using the full link we make sure that GitHub 
> knows we are targetting that issue specifically, not any other issue or PR in 
> any fork of Git with the same number.

Nice to know.  Is there a handy GGG users' guide that mentions these
"magic trailers" (the other one I have seen used is "Cc:")?

> Again, small nit to make it easier for reviewers: usually we prefer to see
> what has changed since the previous version first, and then (if you want, 
> it's not strictly necessary) what changed in the other previous versions. 

Yup.  For a single-patch topic, the following may not apply, but for
a multi-patch topic, a full "topic overview" should also be
available in the cover letter of the latest version.

A reviewer who was absent while older iterations were reviewed
should not have to fish for cover letters of previous iterations to
learn what the topic is about to decide if the topic is worth their
time to review.  Once they get interested enough, they can of course
dig older iterations, but the job of the cover letter in each
iteration is to allow them to become interested with the least
effort.

Thanks.
