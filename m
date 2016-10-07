Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB96F1F4F8
	for <e@80x24.org>; Fri,  7 Oct 2016 11:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbcJGLpi (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 07:45:38 -0400
Received: from mail.javad.com ([54.86.164.124]:58077 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbcJGLpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 07:45:36 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 7DB52633DB;
        Fri,  7 Oct 2016 11:45:35 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bsTao-0005bx-0l; Fri, 07 Oct 2016 14:45:34 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
        <87shsapjiz.fsf@javad.com>
        <xmqq60p6o4js.fsf@gitster.mtv.corp.google.com>
        <87h98pps7a.fsf@javad.com>
        <xmqqmvihl5df.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 07 Oct 2016 14:45:33 +0300
In-Reply-To: <xmqqmvihl5df.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 06 Oct 2016 11:06:04 -0700")
Message-ID: <87mvigmlgi.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Ah, I now see. I tried to keep the text intact as much as possible, and
>> only split it into description and a note. Well, how about this then:
>
> Much better than your earlier patch, but I am not sure if the
> updated one is that much better compared to the original.

It's not intended to be much better. It is aimed at single simple
target: get rid of git-pull from descriptions of operations of
git-merge.

I'd just remove those git-pull reference, the only one that is left
after the patch, but it looks like git-merge needs an excuse to have
fast-forward on by default, and that excuse is the common git-pull case.

[I'd prefer 'git-merge --ff' were called from 'git-pull' and --no-ff be
the default for git-merge, but that's not the case, so I left the
reference to git-pull intact.]

>
> The pre- and post- state of this "how about this" patch essentially
> say the same thing, and I suspect that the primary reason why you
> think the post- state is easier to read is because you wrote it,
> while the reason why I do not see much difference is because I
> didn't write the updated one ;-).
>
> I do find "In this case, ... store the combined history" in the
> original a bit awkward to read, but most of that awkardness is
> inherited by the updated text.  It may benefit from hinting why a
> new commit is not needed a bit stronger.  Here is my attempt:
>
>     When the commit we are merging is a descendant of the current
>     HEAD, the history leading to the named commit can be, and by
>     default is, taken as the combined history of the two.  Our
>     history is "fast forwarded" to their history by updating `HEAD`
>     along with the index to point at the named commit.
>
>     This often happens when you are following along somebody else's
>     work via "git pull" without doing your own development.
>
> I think the awkwardness I felt in the original and your version is
> gone from the above attempt, but I doubt that it is better over
> either of them in any other way.

This is entirely different matter, and should be a subject of another
patch, if any. My patch meant to only address git-pull references, with
as few changes as possible.

-- Sergey
