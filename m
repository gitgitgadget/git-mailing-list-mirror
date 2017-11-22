Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED37720954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdKVQlr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:41:47 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39563 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdKVQlq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:41:46 -0500
Received: by mail-lf0-f68.google.com with SMTP id x76so14328424lfb.6
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ry4qkPDZwULJJyndnWrRK3dN1BxUHejxKV2KGqzTcLY=;
        b=cz6jtOFgBKI2OtQPahWdxdhmfgE+l6b2ipYChemg4yB+sPIWTPH0EN4IuimCkXQSzD
         /jx8vyDC7zzVF2ZOJshPQFzpfWAccOsyGKsNiLmR7OC2Ummox65bpKOnML5Fk7uUwVK3
         2kukd0HdNnLbrYPWa85srRSnWeK8Ncbtsne0FT/nQb35Rud6JdgNzsPAThNRaBacJDxw
         Az7d0FjtNVl1rdvH85PHeuEi2KjlLjLdVVOYh3GfdgvwB6LuO/JYgGN8pWJKGmTYQ0tR
         xGo0WIqHKLz/pqnTLEiq0C3sQPR5hdVBBpXeLfxwOQw+4UfTm43h370ndzczjUNtTzBq
         pDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ry4qkPDZwULJJyndnWrRK3dN1BxUHejxKV2KGqzTcLY=;
        b=mbuA2lyKOf7RB6pJl232Na4GOyMkgyoqvZbAqEdOMeaag7ic9lujvCgYma/J8Ne9r1
         EceC/0VoROwYf9Do7ecy2HEzQgfydQxyu+dyhEjRAwPkgYBiZB0evmPphjN7UN06FsXI
         J/8vDOCkyzZaAmDsF3XOzJmsDs+DmlIjGmqD4XLc4GyVQy7ZgVm0f2MQlondH3UgESWb
         mZwgdzcwXpmE0y8eYRtBELUHSaqJZH72L8+kUVSlKUhcprXZ62QJ/s6KWgkEkWGbAqvp
         9RTNv3NJF0GNYbL9WrHXyTSx12aiUMuFAXyG2DTQhrP1ajSsQf89vd4GqtV5S7RDrG1P
         4fPA==
X-Gm-Message-State: AJaThX6irBLzzvnqAkg3nK8mkWPUQH8MlQHiWhZ2O2b+fOo03FxZH+19
        xYe+tuFRSTLBtIZJexunFzk1OCPxeVR8+d8be3A=
X-Google-Smtp-Source: AGs4zMY4uQd4TVZ/13ttfrX2tMrd1ZBMAopRc+MNfmGjgfBU6yMymbq9+iiIc2tYASV/QxIjqDbWJuMeX39pBn7B9VE=
X-Received: by 10.46.17.70 with SMTP id f67mr7367640lje.160.1511368905309;
 Wed, 22 Nov 2017 08:41:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.179.22.16 with HTTP; Wed, 22 Nov 2017 08:41:24 -0800 (PST)
In-Reply-To: <xmqqlgizudto.fsf@gitster.mtv.corp.google.com>
References: <CABURp0pxYiwrpvT9E_jpvZKDMOUVA9e7dUhARfKEQymWzUwtiw@mail.gmail.com>
 <20171121232113.GK3429@aiede.mtv.corp.google.com> <xmqqlgizudto.fsf@gitster.mtv.corp.google.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Wed, 22 Nov 2017 08:41:24 -0800
Message-ID: <CABURp0r6JQ9ehs+_h4XcNkHmEVogJ7b8UKSte_Ytxe0+ziiA2g@mail.gmail.com>
Subject: Re: doc: prefer 'stash push' over 'stash save'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You probably already noticed this was my fault for filtering the patch
through Gmail's GUI.  I did also push a replacement which hopefully
does apply.

On Tue, Nov 21, 2017 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Phil Hord wrote:
>>
>>> Although `git stash save` was deprecated recently, some parts of the
>>> documentation still refer to it instead of `push`.
>>>
>>> Signed-off-by: Phil Hord <phil.hord@gmail.com>
>>> ---
>>>  Documentation/git-stash.txt | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Thanks.
>
> Heh, this does not even apply to 8be661007 that it claims to apply
> on top of, which is contained in fd2ebf14 ("stash: mark "git stash
> save" deprecated in the man page", 2017-10-22).
>
> I've wiggled it in, so there is no need to resend, but next time
> please be careful when sending the patch and also when sending a
> reviewed-by.
