Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA4C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DC92076F
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CQOWKcLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCSV6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:58:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55812 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSV63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 17:58:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80C485549B;
        Thu, 19 Mar 2020 17:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nh1vpefJq7BAd4oMNiJoXmt/UH4=; b=CQOWKc
        LKj9hmN2wfW7CkCgQC9U0i1NnyJNVu/wTu51ZyOcBtmNXGfFI1Cfxf+vjVvmlNlj
        TthUUXUgZIRYTKZRyLqczHWDXsYHIUfyYqMLUdKj0cx14OgeTPO1IT2440c4kXeD
        /xJwH8OAysQXRolbtvXDkFts9Als8lAMfew5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aUIm6w0kA7KSWjzu1QjVqC/HWB/P8bOw
        TBWMwf/WSgcT/f6LDfnHBK7RSdZWDr9KgpG59uXkvFp0MvBXuCCjb14fpvyibMpC
        Yd3QyN61roayJoJpo1VyTSbs2jow8789mjCKB/cXJbB/smvbOYzv3lpFssne6xg/
        3uxpBRaSqU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 788735549A;
        Thu, 19 Mar 2020 17:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDF7455499;
        Thu, 19 Mar 2020 17:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     harshitjain1371999@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>
References: <20200319132957.17813-3-harshitjain1371999@gmail.com>
        <20200319164234.4441-1-shouryashukla.oo@gmail.com>
Date:   Thu, 19 Mar 2020 14:58:26 -0700
In-Reply-To: <20200319164234.4441-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Thu, 19 Mar 2020 22:12:34 +0530")
Message-ID: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F19664-6A2C-11EA-88A0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Hello Harshit,
>
>> Replace 'test -f' with the helper function 'test_path_is_file' as the helper function improves the code readability and also gives better error messages.
>
> Again the same thing, you may follow what I stated before regarding commit messages.
>
> The commit title can be of the form:
>
> t4131: use helpers to replace test -f <path>
>
> <<commit description>>

I think Harshit is writing the title of the commit in the right
place.  Format-wise, the only thing that is wrong is that each
paragraph is too long without line wrapping.

What is wrong in these two e-mail thread is that you are not reading
the log message correctly.  When made into a piece of e-mail, the
title goes to the "Subject:" field in the header and there is no
need to repeat it in the body of the e-mail.
