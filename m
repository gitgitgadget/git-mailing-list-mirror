Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C20B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 15:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeFGPLm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 11:11:42 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:47014 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935640AbeFGPLj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 11:11:39 -0400
Received: by mail-ot0-f194.google.com with SMTP id q1-v6so11914737oth.13
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oYL5aovK3lgVTT1OOg74SzDLUl26MeFVnliKj9F9Y5g=;
        b=ULMf/l9TxksCvFm+BFXKhdQkz/08OW6hlT1URaqAEe8OjWYd1G0pRKvX6RqPK3Lro+
         atzuThmV1wdyV92NxBosSBuHwzlheZZD4Pdmpxw+ixX3/FIwEe2BgF6A3TU8GBM+S1Wt
         rnufTlROd71u9NIe9OrVby93i0trmLRs3ZQwuLOai3VnL3IxQUxJMWuO/ci2ejWpNFYp
         vjyIBe92FMT24Dzkj1nqoELGj86QUUqmMSNwdm/Ut9oaYJ8jcYjp8M1OoExEzoYUopNc
         nkv7hPlyTS6f2URSursrFd24cosVgGxIptSglmsdHH76jtj8Zd27N1dLJl9q5stw7XKp
         GZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oYL5aovK3lgVTT1OOg74SzDLUl26MeFVnliKj9F9Y5g=;
        b=NjY3XjJ/3VH6w2+N62hSR5b5LKnrdrZkxcdzydaelrgnv0Ei/wOeZACaqXEa/o6r4A
         7t8xdkZM0uyOWq3XwoOHkWkMQTmLxhyD7PsKRMR4SPMpvws4rjl0zOFtOM3+eig5WJXb
         1uPLqPaNfl7Ei5c1sQYhGwxvhskSD7AsGhE1fTMKGyL2WbpdbAlTuLMcaqZxHjxBQF0N
         z7ZJGpoVF2KVkFmeOKjeSCq7qO93kC2yL/kJ5gRHvoWv6JvuPZlqtkz2bi/VQwSXz5G5
         yQlPTkSZDbEOqirEtf6QmJk2pwx0K1h75N3VbhUudx/NHWOaOBuTNTEEGl1LEjbmUvVs
         tZuw==
X-Gm-Message-State: APt69E1epbCtEe2V1bn3uStMZS5cfljKlTeskqrJkUfXKck1ON5XAkjQ
        CYP3koT80fXe1CRyDLq0kut9q1WLYVqHG/isJAY=
X-Google-Smtp-Source: ADUXVKKRbESUFRtW35XVBEK4JHkORk6EBijKu1HMBt1ZDF65MlIxXx6/zx/+BXIStGLnVOmpPqXeno6LOQmE6MJHk8U=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr1319407otb.14.1528384299420;
 Thu, 07 Jun 2018 08:11:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 08:11:08 -0700 (PDT)
In-Reply-To: <CABPp-BFzOkX_uSyiVH-S8mqxeOin0xcYR-EzXUtvcdN7dGhidQ@mail.gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <20180606165016.3285-5-pclouds@gmail.com> <CABPp-BFzOkX_uSyiVH-S8mqxeOin0xcYR-EzXUtvcdN7dGhidQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 17:11:08 +0200
Message-ID: <CACsJy8AwjMsCR=gbT1ZLbEwve7hzuPBF7tT7m+P1DJ4rRx_jrw@mail.gmail.com>
Subject: Re: [PATCH v4 04/23] unpack-tress: convert clear_ce_flags* to avoid the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 9:41 AM, Elijah Newren <newren@gmail.com> wrote:
> Subject line: unpack-trees rather than unpack-tress.
>
>
>
> On Wed, Jun 6, 2018 at 9:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
>> the_index when running the exclude machinery. fba92be8f7 helps show
>> this problem clearer because unpack-trees operation is supposed to
>> work on whatever index the caller specifies... not specifically
>> the_index.
>>
>> Update the code to use "istate" argument that's originally from
>> mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
>> you can see that this function works on two separate indexes:
>> o->src_index and o->result. The second mark_new_skip_worktree() so far
>> has incorecctly applied exclude rules on o->src_index instead of
>> o->result. It's unclear what is the consequences of this, but it's
>> definitely wrong.
>>
>> [1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
>>     2017-05-05)
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>
> A somewhat curious finding: when I was rebuilding and re-testing all
> 23 patches, I got a failure on this patch in test 31 of
> t7063-status-untracked-cache.sh. I did not get any test failures with
> any of the other patches.  However, after re-running that test or the
> whole suite half a dozen times with just up to this patch applied, I
> was not able to trigger the failure again.  Is there a rare race in
> that testcase?

Untracked cache tests are very time-sensitive. I'll try to run and
re-run them a couple times to understand more. Thanks for pointing it
out.
--=20
Duy
