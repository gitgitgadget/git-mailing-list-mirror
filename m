Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616761FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 10:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdIJKhU (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 06:37:20 -0400
Received: from mout.web.de ([212.227.17.12]:60239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdIJKhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 06:37:20 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MV4bp-1dwJ3Z0X41-00YOnj; Sun, 10
 Sep 2017 12:37:08 +0200
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
 <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
 <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7a30c171-22c8-4ae3-3e15-3f4eea893127@web.de>
Date:   Sun, 10 Sep 2017 12:37:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:N/W6K4/a8+OzEs7Bn6OWHgd97xQlTMF4Z8gAYv0VeM4yTCEZIRH
 a3vWb6Q+z3J+ebhw6Pp+uNZnUrrP76gn6U+kDaBCmDLzZ6USxi1kqYrK1nWOX+hHS/FHU6I
 2BF0LU29r/IjS6efxlhAIoDDKr6uhGMGgX6EdOrnC/7rPmKXdl2G7vIAPucDwcn4VrMWumq
 piVEdFGtwVDiBvOPdEnlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TzBrUpVTGIY=:yWSq/8rBCFNnSd0gR6N87P
 FOo+kia4BoEXnQAywMnoSzWqfrvNZe+ZctNJbmKt2iE0n+KDb6ci7XNV+3oa2evROsdm3Wshi
 TW7esmlKX55uoMpAVWmYM4BRfwB9XLQDORR/aGxmsMX0hJr9A440ICv1BjbtrTYkz53DbAwHk
 UWYAArOWdb5eNxLaFcGTQXbqxjks+rmAleCAucGvqOL0Kw5Tr3rtpQfbkc6DQ2U8hRaVu5AzM
 gceYQTET1tDWhOdd5btJmlnNRd/T8Z/3fJ1HHmiiyVd9FAOBIfVHY2fhTHyaiXCPhLnrKndH7
 RBqcymsuJxdGwK8XWy0c2yTL0EeeNv3TNcinh7TZ1ObB0jQmRakWYX37f5/Ot5dkM91RzHaI9
 JXVrYly0lAWzEhVYJKPeLKE3osEg4JEPxKnGAw4gXYVZbp4TSvKUPxmjcIBZYIP00m1bIDBcT
 13E1R1LnCwvjznznpzqWFpv5h2eK339H6aKhVIARRNO/t3tXZx5GFRJywRLJGjiw50Qu6XIAp
 5RFjdet3W1LehnOhYOKfF9qUBhDqJy+lcXEI7KtmxUUO7XyrU5swCBaTJt5ZtcBVrNeSYNUji
 +ZyVifxZ5AcOi8+lHrN4ubnVOVYSXOo3X7XkSJqtFz5fg4c5o6Z2uqT+nTvS2zZi7xuXrmP4s
 lUVc6g8GvJ4HZY3PamPlkR81EkxGZ6LsfXMnWKzoU/EfjJd3WLq43Szo454i7I4/nGAgZSH5e
 k3f7oP+BMpJhenbXnh4zcxOVfE3f0tXIbdO5TmkDvC7QIqCIVdjpBkIwYx8blZYTwK/PRg9ZR
 mj0l9gJ9S/5wlB1qMcABMpKvzyWnS12kV8CBv5eRGfUQb/Mx5o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.2017 um 09:30 schrieb Jeff King:
> On Sun, Sep 10, 2017 at 08:27:40AM +0200, René Scharfe wrote:
> 
>>>>    	if (junk_work_tree) {
>>>>    		strbuf_addstr(&sb, junk_work_tree);
>>>>    		remove_dir_recursively(&sb, 0);
>>>> -		strbuf_reset(&sb);
>>>>    	}
>>>> +	strbuf_release(&sb);
>>>>    }
>>>
>>> The code definitely needs a _release() at the end, but I feel
>>> lukewarm about the "if we are about to _release(), do not bother to
>>> _reset()" micro-optimization.  Keeping the existing two users that
>>> use sb as a (shared and reused) temporary similar would help those
>>> who add the third one or reuse the pattern in their code elsewhere.
>>
>> That's not intended as an optimization, but as a promotion -- the reset
>> is moved to the outer block and upgraded to a release.  The result is
>> consistent with builtin/worktree.c::remove_junk().
> 
> Hmm. This is a cleanup function called only from signal and atexit
> handlers. I don't think we actually do need to clean up, and this might
> be a good candidate for UNLEAK().
> 
> And in fact, being called from a signal handler means we should
> generally avoid touching malloc or free (which could be holding locks).
> That would mean preferring a leak to strbuf_release(). Of course that is
> the tip of the iceberg. We call strbuf_addstr() here, and
> remove_dir_recursively() will grow our buffer.

And we call opendir(3), readdir(3), and closedir(3), which are also not
listed as async-safe functions by POSIX [1].

> So I actually wonder if junk_git_dir and junk_work_tree should be
> pre-sized strbufs themselves. And that makes the leak "go away" in the
> eyes of leak-checkers because we hold onto the static strbufs until
> program exit.

We could start with a small buffer and expand it to match the path
length of written files as we go.

Deletion without readdir(3) requires us to keep a list of all written
files and directories, though.  Perhaps in the form of an append-only
log; the signal handler could then go through them in reverse order
and remove them.  Or is there a better way?

René


[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_04_03_03
