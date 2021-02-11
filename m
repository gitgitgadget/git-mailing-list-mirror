Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114A161490
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBKHfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:35:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62863 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBKHfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:35:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 021799E27A;
        Thu, 11 Feb 2021 02:34:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=161u4qS32z38BiKPWKZC+9y1PTs=; b=Tk5wPF
        3cNuWKsg0vuD8Nd79vDiSSOLxOJO9yVXQCX67x262YzD6AHrDUe2FBWkFD5CQ1+4
        ZOcyD4GYhiE/kKmBE3Jpsi2QgAJnoFA2mPz+98uCApGVhckXGLWaYlqQy5yTuI3k
        9yT46oJHRIXi3y59jHnAd5ZAjxHFbpdlijTTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kbYhh1Kt8EOAVWxgjFCsLR0JKhqocBAs
        pzQFg/1GngOPLcDdbh56NV/7ud9RijKnY6sn+lY4qE5KE+xzsv0mUUngMpaKVGGc
        9o3dlpFnyIePrvAFawSw6GxMSS1fHoCxx/wtI+/HE/RCigI2wEaE0gwBcSclpgE6
        7bvHMBjifmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE3F09E278;
        Thu, 11 Feb 2021 02:34:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 784599E276;
        Thu, 11 Feb 2021 02:34:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] docs: clarify that refs/notes/ do not keep the
 attached objects alive
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
        <0bdc333b25aca1de82fea3a1f290fe30ee3ebf51.1613027889.git.martinvonz@google.com>
Date:   Wed, 10 Feb 2021 23:34:14 -0800
In-Reply-To: <0bdc333b25aca1de82fea3a1f290fe30ee3ebf51.1613027889.git.martinvonz@google.com>
        (Martin von Zweigbergk's message of "Wed, 10 Feb 2021 23:18:45 -0800")
Message-ID: <xmqq7dnfys5l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AF557A2-6C3B-11EB-936A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@google.com> writes:

> `git help gc` contains this snippet:
>
>   "[...] it will keep [..] objects referenced by the index,
>   remote-tracking branches, notes saved by git notes under refs/notes/"
>
> I had interpreted that as saying that the objects that notes were
> attached to are kept, but that is not the case. Let's clarify the
> documentation by moving out the part about git notes to a separate
> sentence.
>
> Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> ---

This looks the same as the one in
<e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>

which was v1, except that this one has your sign-off.  Sent a wrong
version?

>  Documentation/git-gc.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 0c114ad1ca..52824269a8 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -117,12 +117,14 @@ NOTES
>  'git gc' tries very hard not to delete objects that are referenced
>  anywhere in your repository. In particular, it will keep not only
>  objects referenced by your current set of branches and tags, but also
> -objects referenced by the index, remote-tracking branches, notes saved
> -by 'git notes' under refs/notes/, reflogs (which may reference commits
> -in branches that were later amended or rewound), and anything else in
> -the refs/* namespace.  If you are expecting some objects to be deleted
> -and they aren't, check all of those locations and decide whether it
> -makes sense in your case to remove those references.
> +objects referenced by the index, remote-tracking branches, reflogs
> +(which may reference commits in branches that were later amended or
> +rewound), and anything else in the refs/* namespace. Notes saved by
> +'git notes' under refs/notes/ will be kept, but the objects (typically
> +commits) they are attached to will not be. If you are expecting some
> +objects to be deleted and they aren't, check all of those locations
> +and decide whether it makes sense in your case to remove those
> +references.
>  
>  On the other hand, when 'git gc' runs concurrently with another process,
>  there is a risk of it deleting an object that the other process is using
