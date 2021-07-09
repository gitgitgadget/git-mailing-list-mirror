Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A6C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62577613B5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhGIQB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:01:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62967 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGIQB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:01:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 679BA14716C;
        Fri,  9 Jul 2021 11:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qUnJn3cjqlUY0+Yx+lRqj1VtefjxFsgLU1yKro
        g1z9E=; b=xLAz2o5lXJPXlcow3R6yAbO/nalFj5+P1ooLSLjORiRztt93PRjlH9
        yipRncNpTD0dU8MDIEcXOUu2OC54v+Mzzv0ydfQahvOYBXpdexoQQ0tdk/DFEiE6
        6ZBQQWlBzO3ynVovN0KuUBeEjwid8HErkzPSsytUD+sOpIyG8tl74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53C3814716B;
        Fri,  9 Jul 2021 11:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87FD8147169;
        Fri,  9 Jul 2021 11:58:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Subject: Re: [PATCH v2 2/3] worktree: default lock string should be marked
 with `_()` for translation
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
        <30196cc93697cd4a6a6881dcbb1073d19e96d8a0.1625759443.git.gitgitgadget@gmail.com>
        <CAPig+cRiEYcz8-F0FzQRetF9UoN1Di099JVgCz0920kQ3a+BwQ@mail.gmail.com>
Date:   Fri, 09 Jul 2021 08:58:39 -0700
In-Reply-To: <CAPig+cRiEYcz8-F0FzQRetF9UoN1Di099JVgCz0920kQ3a+BwQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 9 Jul 2021 02:19:50 -0400")
Message-ID: <xmqqzguv7a34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88127C24-E0CE-11EB-A95D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 8, 2021 at 11:50 AM Stephen Manz via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -305,7 +305,7 @@ static int add_worktree(const char *path, const char *refname,
>>         if (!opts->keep_locked)
>>                 write_file(sb.buf, "initializing");
>>         else
>> -               write_file(sb.buf, "added with --lock");
>> +               write_file(sb.buf, _("added with --lock"));
>
> Makes perfect sense, though the "initializing" string in the `then`
> arm probably deserves the same treatment:
>
>     write_file(sb.buf, _("initializing"));

Good eyes.
