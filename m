Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358CE201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbdEQVsa (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:48:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33171 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbdEQVs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:48:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so6743779wmh.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fM5Fpv1jjC9BrLLY60a0adTX9DyBekMFBpILseIZ1A4=;
        b=ADhUMVGZEAIF9DpqSHcuWjmcIVzTgtDSi7n41mbZ5MhEvmk+1Ri+PNVPJcQFPf3DG6
         VseOljXQ2SCSzKEAl7Crxz+sTPeUikOw/my3LCj9MWAYwSS2DmnNnynzlFioySAzf3Sf
         aFPa6kbtA0fDWWzSfyRyaqPbyf17ochkqabN6/rKQLqyj/JOyBEO05hcLCtqZYL0J0ko
         YCQJ42I0D2RENURgrbI4SA4GDBPodA6cewj6jfmRPtruT4WuuBdAGVOrJGj3kWk1ZRde
         XDlMFFd1AmRSCbYbjqTGuxSlCyfLh0Zo1tRNlkuoYsSJJ/IrgWncz6Wp9V9aw0XSxNjO
         Nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fM5Fpv1jjC9BrLLY60a0adTX9DyBekMFBpILseIZ1A4=;
        b=aDbDIoekRp2WKqcD1hs44+fNIfATIJ402KjS1C3QlkLLUpCQaA52cHLspkfUN7KOev
         ILl5cTJk2qVUoqIHLdn8Omzqiw5sb3FHBUcaXb1WsHFsvM/IKIrS25T1SKXicRt+tue6
         819oKQzThQuSLdYvdOSW1T5/bLBBmFnq2/hStSzkUuRH43ub0Ylr2IWUZSDjYmmonp64
         htPA8dSl5qM1hLavR1OdmOfQRyO52E9nq2L4XqaQrJ1/nPCFS4CRHimxA4yF682m8j3Z
         lM93Cl3PsI5G9PtQftCSS0JM1exCNi+41vCLpX8KCtl/sFwEIqAKVw+Sdu8iV4JZvYyD
         sIGA==
X-Gm-Message-State: AODbwcDQPf4kpu9OXC1CUhOjWZjHl1sm/Tm6ej/kJV7uMBhkMxkOaw5j
        4oOK0JgBiU24d4CI+EWORwg7Idk1xQ==
X-Received: by 10.25.16.96 with SMTP id f93mr64414lfi.37.1495057707938; Wed,
 17 May 2017 14:48:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.71.69 with HTTP; Wed, 17 May 2017 14:48:07 -0700 (PDT)
In-Reply-To: <CAM2h-yfRc69W8f=inRRjtyBh4EZWJk6W2gCTM=S=ifJn3g8auA@mail.gmail.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com>
 <20170517005041.46310-1-manishearth@gmail.com> <CAM2h-yfRc69W8f=inRRjtyBh4EZWJk6W2gCTM=S=ifJn3g8auA@mail.gmail.com>
From:   Manish Goregaokar <manishearth@gmail.com>
Date:   Wed, 17 May 2017 14:48:07 -0700
X-Google-Sender-Auth: SwGecSDMOKQhfD-V-JptHZb3N08
Message-ID: <CACpkpx=usSnEBPPPppdeaM+HUNc06ZuN3mrfN4Nemspn96K9dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, btw, refs.c needs an #include "worktree.h" to work; I didn't get a
chance to test this after rebasing onto the maint branch.

(There's also another fix it needs to have no warnings, but that's not
going to affect building). I have this fixed locally, but I'll wait
for the rest of the review before pushing them up.
-Manish Goregaokar


On Tue, May 16, 2017 at 5:55 PM, Manish Goregaokar
<manish.earth@gmail.com> wrote:
> I *think* I got send-email to work but I can't be certain :) The tabs
> seem to be back!
>
> It didn't thread correctly, unsure why.
>
> Sorry about the patch problems,
>
> On Tue, May 16, 2017 at 5:50 PM,  <manish.earth@gmail.com> wrote:
>> From: Manish Goregaokar <manishearth@gmail.com>
>>
>> To ensure that `git prune` does not remove refs checked out
>> in other worktrees, we need to include these HEADs in the
>> set of roots. This adds the iteration function necessary
>> to do this.
>>
>> Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
>> ---
>>  refs.c | 16 ++++++++++++++++
>>  refs.h |  1 +
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/refs.c b/refs.c
>> index 2d71774..27e0b60 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3,6 +3,7 @@
>>   */
>>
>>  #include "cache.h"
>> +#include "commit.h"
>>  #include "lockfile.h"
>>  #include "refs.h"
>>  #include "refs/refs-internal.h"
>> @@ -1157,6 +1158,21 @@ int head_ref(each_ref_fn fn, void *cb_data)
>>         return head_ref_submodule(NULL, fn, cb_data);
>>  }
>>
>> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data)
>> +{
>> +       int i, flag, retval;
>> +       struct object_id oid;
>> +       struct worktree **worktrees = get_worktrees(GWT_SORT_LINKED);
>> +       for (i = 0; worktrees[i]; i++) {
>> +               struct commit* commit = lookup_commit_reference(worktrees[i]->head_sha1);
>> +               oid = commit->object.oid;
>> +               if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag)) {
>> +                       if (retval = fn("HEAD", &oid, flag, cb_data))
>> +                               return retval;
>> +               }
>> +       }
>> +}
>> +
>>  /*
>>   * Call fn for each reference in the specified submodule for which the
>>   * refname begins with prefix. If trim is non-zero, then trim that
>> diff --git a/refs.h b/refs.h
>> index 9fbff90..425a853 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -192,6 +192,7 @@ typedef int each_ref_fn(const char *refname,
>>   * stop the iteration.
>>   */
>>  int head_ref(each_ref_fn fn, void *cb_data);
>> +int for_each_worktree_ref(each_ref_fn fn, void *cb_data);
>>  int for_each_ref(each_ref_fn fn, void *cb_data);
>>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
>>  int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
>> --
>> 2.10.1
>>
