Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiFPQmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiFPQmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 12:42:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE0340EE
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 09:42:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso1980438pja.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WjFiqrPRBpBK64gXXd7HZNvVHWlWWko1yu4lcTrQwyo=;
        b=FdJEH2w0ZQIjsv1Q+bid5Fw5KtzoDcTNC8leMvfdzDMf/17Kd0azSSA4nYRu5ZIg0f
         3NAymtTsoEj61F7SxpXdpHKNWXq0rV/dEmMmwQnQMxT55F3gmDXt5cFSR+lB8hkA8zfh
         GftvcBZqbXGSNwpdTLWyaHO1RirRZTY1cplx0Ok4LDpZSQdKDkrlqkv3LvWjUCfuYWs1
         DEIucgAwmxSLk2EJvDjXxDJdma0EVl9XOOT1hqjMm7XkAJ10cFuSFt7CQI4SrxXr95bD
         FHWOHSHWz4w5KInGSJxVJFKOVMo4HmYwfgslMBYCH/aCyldubde9DLmm7XOVNpwaP8Wb
         5lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WjFiqrPRBpBK64gXXd7HZNvVHWlWWko1yu4lcTrQwyo=;
        b=L+Ys7HpHy9kgL2hD+ggHy9cstlNfeFYRAWagxFJsm+au8qQoRPhudZ1TV16yalpxml
         /VSsevzKtRm/IOmTK/0L+asWP2X+nPfXCNaBVbv03yYSVE2QFiFBl39I2AWAP54xrOIX
         wxxRF4yAB4ZgNn4BvltONhsfncuzXrmMGjdIW8YTyC+rTEHvOpV8xQ7MMA6Gv8r2aROQ
         M2BnGX4V0CI5p7ghm1ESAALyl2AUTcQKX0jymawesz42a/+6flZURZHmClVneMi8UybN
         4SQN3gqaC/P+CLbGeMOyFeyNP3W97bIWmM7MTuw6ZHGMH34AxreCu+meEflx9DO59jfw
         JJvQ==
X-Gm-Message-State: AJIora+NMPk4KLlZ3sveucPaKBZMsU2RoglbOAPLPMdVRBHtZIwcSTK+
        DkE7InpFjaIgB5YKVziH3jna9wwwZ8pv
X-Google-Smtp-Source: AGRyM1ve5d6SGu1CkR/Y8KC+yGoMKIXApLqS8pfl1Blq+vvak+EGOYXil0qEsMtvcQHAtAGc7+xpBg==
X-Received: by 2002:a17:902:d904:b0:163:dd91:87 with SMTP id c4-20020a170902d90400b00163dd910087mr5362320plz.34.1655397732070;
        Thu, 16 Jun 2022 09:42:12 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id l198-20020a633ecf000000b003fdef4f7447sm2056182pga.6.2022.06.16.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:42:11 -0700 (PDT)
Message-ID: <6375c172-82cb-dffc-875f-e5e742d5e49e@github.com>
Date:   Thu, 16 Jun 2022 09:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse
 contents
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
 <077a0579-903e-32ad-029c-48572d471c84@github.com>
 <xmqq8rqm3fxa.fsf@gitster.g>
 <d0ac1bea-6d98-140c-0e46-d7569e80b29d@github.com>
 <CAJyCBOQGAL9aGW+Gxv8sZH9T_tB6_pdeLNwmNgqPhz7cMdZrbA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAJyCBOQGAL9aGW+Gxv8sZH9T_tB6_pdeLNwmNgqPhz7cMdZrbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> On Sat, May 28, 2022 at 5:24 AM Victoria Dye <vdye@github.com> wrote:
>>
>> Junio C Hamano wrote:
>>> Victoria Dye <vdye@github.com> writes:
>>>
>>>> Note that you'll also probably need to check out the file(s) (if moving into
>>>> the cone) or remove them from disk (if moving out of cone). If you don't,
>>>> files moved into cone will appear "deleted" on-disk, and files moved
>>>> out-of-cone that still appear on disk will have 'SKIP_WORKTREE'
>>>> automatically disabled (see [1]).
>>>
>>> Does it also imply that we should forbid "git mv" of a dirty path
>>> out of the cone?  Or is that too draconian and it suffices to tweak
>>> the rule slightly to "remove from the worktree when moving a clean
>>> path out of cone", perhaps?  When a dirty path is moved out of cone,
>>> we would trigger the "SKIP_WORKTREE automatically disabled" behaviour
>>> and that would be a good thing, I imagine?
>>>
>>
>> I like the idea of the modified rule as an option since it *does* complete
>> the move in accordance with '--force', but doesn't result in silently lost
>> information.
>>
>> An alternative might be 'mv' refusing to move a modified file out-of-cone
>> (despite '--force'), printing something like
>> 'WARNING_SPARSE_NOT_UPTODATE_FILE' ("Path 'x' not uptodate; will not remove
>> from working tree").
>>
>> I'm not sure which would provide a more vs. less frustrating experience, but
>> both are at least safe in terms of preserving unstaged changes.
> 
> For me, the alternative provides a less frustrating experience.
> 
> Since it is more explicit (giving a message and directly saying NO).
>> Also, the `sparse-checkout` users should expect the moved file to be
> missing in the working tree, as opposed to being present.
> 

Good point, since the sparseness of the destination file would be different
depending on whether it had local modifications or not (with no indication
from 'mv' of the different treatment).

If you're interested, maybe there's a middle-ground option? Suppose you want
to move a file 'file1' to an out-of-cone location:

1. If 'file1' is clean, regardless of use of '--force', move the file & make
   it sparse.
2. If 'file1' is *not* clean and '--force' is *not* used, refuse to move the
   file (with a "Path 'file1' not uptodate; will not move. Use '--force' to
   override." type of error).
3. If 'file1' is *not* clean and '--force' is used, move the file but do not
   make it sparse.

That way, '--force' really does force the move to happen, but users are
generally warned against it. I'm still not sure what the "right" approach
is, but to your point I think it should err on the side of not surprising
the user.

> And the tweaked rule suggested by Junio [1] might need an extra
>  `git sparse-checkout reapply` to re-sparsify the file that moved out-of-cone
> after staging its change?
> 

Just so I understand correctly, do you mean 'git sparse-checkout reapply'
*as part of* the 'mv' operation? Or are you thinking that a user might want
to manually run 'git sparse-checkout reapply' after running 'mv'? 

If it's the former (internally calling 'git sparse-checkout reapply' in
'mv'), then no, you wouldn't want to do that. In Junio's suggestion, he said
(emphasis mine):

> When a dirty path is moved out of cone, we would trigger the
> "SKIP_WORKTREE automatically disabled" behaviour" *and that would be a
> good thing, I imagine?*

We don't want the file moved out-of-cone to be sparse again because it has
local (on-disk) modifications that would disappear (since a file needs to be
removed from disk to be "sparse" in the eyes of 'sparse-checkout'). It's
*completely valid* behavior to have an out-of-cone file become non-sparse if
a user does something to cause that; it doesn't cause any bugs/corruption
with the repo. And, even if you did want to make the file sparse, it should
be done by manually setting 'SKIP_WORKTREE' and individually removing the
file from disk (for all the reasons I mentioned in my upthread comment [1]).

On the other hand, if you're talking about a user manually running 'git
sparse-checkout reapply' after the fact, that wouldn't work either - they'd
get an error:

warning: The following paths are not up to date and were left despite sparse patterns:
        <out-of-cone modified file>

[1] https://lore.kernel.org/git/077a0579-903e-32ad-029c-48572d471c84@github.com/

> [1] https://lore.kernel.org/git/xmqq8rqm3fxa.fsf@gitster.g/
> 
