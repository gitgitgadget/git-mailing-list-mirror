Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB141FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbcLIMQj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:16:39 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:32786 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbcLIMQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:16:38 -0500
Received: by mail-io0-f193.google.com with SMTP id p13so6387511ioi.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vAU/Bt4W4j1186pfy8ujpP1qm4pnEfmX/Xor5xXu8d8=;
        b=CrJAqS2CRVr2w+iraT9xOpomTI4cauOf0D/duPL0qGCAwoQvyIHFe6P4wTa9NmECMx
         /3XBbAd3Nr7ijIF/ikZwNTaLUm3MzboPz9Oa2mZ33NwHmuOBqNJqXMQIa3zSlPwKeOfB
         Q1szu6IxKthLax6XV6yw8CjDAzubox8gZt12ugvqUOPx9DFKuS6DTdrWUFqOGtO6l3R8
         FN6DNibc6Nqju7bDL6C2Voz40TMtBqMjPkqiiS8VlrPcV7Au7zkay1jShH5rReqvew4N
         OuNu+yPcfjsXRIT03BLB9cq7m7R43M2hyXhVXCdOHrsAovWeO6DFCzt2BCM+K4tDoIDw
         LXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vAU/Bt4W4j1186pfy8ujpP1qm4pnEfmX/Xor5xXu8d8=;
        b=CVpe225i9BBTExMbHBAJ1X9J7m+MKcPnn4oeCj5J/LX0Hw63Vk1SobOkURlKQfhYMK
         Hfn4dN674P9dbTz6k+X+9q0ybWWJuFuepMG8CY7JeIQtx+OzyBBiCpmGzp6YN4SSK/4H
         iLAX6CAihqqYphGs++a/ALPylOMnq77Qt/Kt8vQE2+i3cy3dsKSEEr/Uez0kstV66v1B
         i5ijdW0coU3j4vhFkN10m43wBh1DjbBPEz9+GJO5FIMSdhGTIPeK0Z7YxK2hscZGJNsD
         HQs06INq6rM4BwEGMkX/os/94Q+t7NsH6Hf1TkKzE1XtrYRSgOBXqJ36NhXcIHwZ9XVY
         J6RA==
X-Gm-Message-State: AKaTC02+eAP/bUR+2Q/dupgY2QfvImjkN9joNe++WU2WRtYEm6o5dVozwzwMrzv5Yz2/1Hlzu8vsLaIP+YYnlw==
X-Received: by 10.107.132.74 with SMTP id g71mr69466429iod.19.1481285797490;
 Fri, 09 Dec 2016 04:16:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 04:16:06 -0800 (PST)
In-Reply-To: <xmqqfulyrlmf.fsf@gitster.mtv.corp.google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com> <1481223550-65277-15-git-send-email-bmwill@google.com>
 <xmqqfulyrlmf.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 19:16:06 +0700
Message-ID: <CACsJy8AX6C8Tux9_8ZynBMNS2EW2pKQOGK8k0hVmbWvbZ8pa=Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] pathspec: create strip submodule slash helpers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 7:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> +static void strip_submodule_slash_cheap(struct pathspec_item *item)
>> +{
>> +     int i;
>> +
>> +     if ((item->len >= 1 && item->match[item->len - 1] == '/') &&
>> +         (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
>> +         S_ISGITLINK(active_cache[i]->ce_mode)) {
>> +             item->len--;
>> +             item->match[item->len] = '\0';
>> +     }
>> +}
>
> I know that this is merely a moved code, but while I was reading
> this, it triggered "Do not make an assignment inside if condition"
> check.

Yeah with a function of its own, it's probably better to separate that
assignment.

> But more importantly, is the code even correct?  If the path
> for the submodule is unmerged, we would get a negative i that points
> at the conflicting entry; don't we want to do something about it, at
> least when we have a submodule entry at stage #2 (i.e. ours)?

In my defense I was simply moving (again!) the code from
strip_trailing_slash_from_submodules() in b69bb3f:builtin/ls-files.c.
Could be an improvement point for submodule people, I guess.
-- 
Duy
