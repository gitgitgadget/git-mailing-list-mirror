Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB841F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeFKQPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:15:10 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45399 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbeFKQPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:15:07 -0400
Received: by mail-vk0-f66.google.com with SMTP id l64-v6so5034682vkl.12
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=czfTY5/poyFG77YZ339/2oi5ej/hF6f9P2noHD6aP10=;
        b=NnD6lsccJ5AVDNjvwWKZ5fAc5AWMgrinZjwqqWPW8AzPLIbjyLM2JiUvatTRb5FoMg
         SvLPWkwFDBT/zeUjp8vJGOqAj7iAsh9aHR0FXOQwEz+1YzNfW/b81lPRSIDdA1ECx+34
         JK4zSBeoZs7vHCL/lAefHBC6kOyMRvk7G8fJJqjK9sKd0/aytTC7ahTS3GKbf5g83nSa
         JaaHD3W8CvdCPsBIsHLsLyee/vIjHVEM6sL0kKGZtE2quE/ZNnJuJmdsY050cfMi/e26
         8IC5wiJtw+BIVgkeZ4YuCFF/6I8pNK257PAp9nCs5gpQt7w8WuFk3anjtrEI4R/Iu9eh
         PEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=czfTY5/poyFG77YZ339/2oi5ej/hF6f9P2noHD6aP10=;
        b=GOxEGxg+g152CO1PwkjngJ3B5iSCtyPsskMPL0LuelLcZrcYXkgw+vZipc58R/RvHy
         SHwnI52E95OCS2Pya1KJyeIknqWN3MSC0AnlJ6XpwpleMqWrdJ4/lXDc0K1gYjEWUiDT
         iE5ZoBhPRHPpvq23GFFNHkhjZYPcdWm/+0zSMfY1ZNX7Ur8RakvOyIbSSoiCcR2cINEI
         dlZMOdI8PVdT3MONAH7Ko8kaT016acF6sbWmNPUTUZXX/NCeJPizcCDjvAimG5czHIXr
         KR3zSK58B431TW3/k0vYNtt4hqqIpJw10fI6Kx3A6wZ+LGSe22h6LoZUlkFknUaMDnRz
         wbKA==
X-Gm-Message-State: APt69E0mu3bAvH0A0o5+2YMEIR8OjhE71O36htz6/rJIoW8lvvNOQGUx
        nGfpjOYvl5CoMIR+MnSxKZ1WoqgS2thKEypZBSMlTw==
X-Google-Smtp-Source: ADUXVKIi/QIRvVgs/XW37MhxsTBzKbNX+0LKR6GCBC/Qlk3m3pBIFgjGDrJ96DFV5IAShzek1NlSPYgJcY1vxIz1wyc=
X-Received: by 2002:a1f:a102:: with SMTP id k2-v6mr10854671vke.118.1528733707041;
 Mon, 11 Jun 2018 09:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:15:06
 -0700 (PDT)
In-Reply-To: <CABPp-BERW3VtKxwKZ=-K6=pdVZydHRRKKGce2S=sttqfcDeRDA@mail.gmail.com>
References: <20180603065810.23841-1-newren@gmail.com> <20180603065810.23841-5-newren@gmail.com>
 <xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com> <CABPp-BERW3VtKxwKZ=-K6=pdVZydHRRKKGce2S=sttqfcDeRDA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 09:15:06 -0700
Message-ID: <CABPp-BFhneCqGBRT3qtS_d2eUdjgj+5PWsyWJ7XGHBD6dxunqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree
 being merged is HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 12:14 AM, Elijah Newren <newren@gmail.com> wrote:
> On Sun, Jun 3, 2018 at 8:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> `git merge-recursive` does a three-way merge between user-specified trees
>>> base, head, and remote.  Since the user is allowed to specify head, we can
>>> not necesarily assume that head == HEAD.
>>>
>>> We modify index_has_changes() to take an extra argument specifying the
>>> tree to compare the index to.  If NULL, it will compare to HEAD.  We then
>>> use this from merge-recursive to make sure we compare to the
>>> user-specified head.
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>
>>> I'm really unsure where the index_has_changes() declaration should go;
>>> I stuck it in tree.h, but is there a better spot?
>>
>> I think I saw you tried to lift an assumption that we're always
>> working on the_index in a separate patch recently.  Should that
>> logic apply also to this part of the codebase?  IOW, shouldn't
>> index_has_changes() take a pointer to istate (as opposed to a
>> function that uses the implicit the_index that should be named as
>> "cache_has_changes()" or something?)
>>
>> I tend to think this function as part of the larger read-cache.c
>> family whose definitions are in cache.h and accompanied by macros
>> that are protected by NO_THE_INDEX_COMPATIBILITY_MACROS so if we
>> were to move it elsewhere, I'd keep the header part as-is and
>> implementation to read-cache.c to keep it together with the family,
>> but I do not see a huge issue with the current placement, either.
>
> That's good point; the goal to lift assumptions on the_index should
> probably also apply here.  I'll make the change.
> (And it was actually Duy's patch that I was reviewing, but close
> enough.)   I'll take a look at moving it to read-cache.c as well.

Making it not depend on the_index will require changes to make
diff-lib.c not depend on the_index first, so this is going to have to
wait for Duy's changes mentioned at
https://public-inbox.org/git/CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com/.
I'll re-roll this series on top of Duy's when it comes out.
