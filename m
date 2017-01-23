Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203DB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbdAWWgB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:36:01 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38758 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdAWWgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:36:00 -0500
Received: by mail-wm0-f49.google.com with SMTP id r144so179895202wme.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/QVtThw94LX0WNCXpG0Vpc9RL7FQkUa2OjgGnbfr3a8=;
        b=QnQW2XM/p7qB+TWcVrS4gSeUgBj0GqIUsSm7+NAMOZ6Sji7WeLOQvYzWRyHiZDOL8J
         qVxFLIleY1or1AOccpMnM1gUxidd8InzHLLzoy6bDAjfN5RMwCk4iGz9uOmTDkuq08kV
         ywq5iEtShi/mUCCdRUcaodcrigAFUFynFjT4dcM+JVrx0gDafai2SKlzlK7xDiI59fN+
         YG2DGHBNtAxa4KcmpNoQJ8Noe6v/gEH2LOzoHwrUqVgzWIB9KL8oRuxl3ZuVP0y9HlbH
         +MAKZ9kt2YM4+fJTibyjoEU7E6UXuTv7Ci0JLLgxucyPUopnKLTYlEr3SZXfAep2EBE0
         9gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/QVtThw94LX0WNCXpG0Vpc9RL7FQkUa2OjgGnbfr3a8=;
        b=bAXgtsTyRiF1AgDpyAOKGd0KuTeUNHp3xD/3o3fcC430eozet+pJ4pTdTlSmknsNxE
         1jUtMR4luR/IxAgfUcLoJivSTseE3LGI8d0zTcWZHHp8FOT9jQGeD3eKJG2s85zWSai0
         hFVuZSLhITrexuFFAvxOT8m+JVVgY4R22GQBC+Nx61KkAlng+8m4KKwhj1uowCdDks+x
         phQEinaIFvskEhmBShZ1wjZzVcNgxchOlB5//un5lrMjG5+O7qyCyYzE+PhZ6/mBfVzj
         QRL4b/R912YG5mcXu2dZgAsWAWX80HTONZtkphCRoMlWsj2fh5FZUtBU0B4iAMpIv9pH
         JTKQ==
X-Gm-Message-State: AIkVDXIBFA7twTC/RN1B+z7y6hX1SeS8RjkZJeZu33FscnIq4ELDcMBqhjN6daaMeczHAXrmaGiuuIkGrOjFuQ==
X-Received: by 10.223.155.221 with SMTP id e29mr25967550wrc.107.1485210958789;
 Mon, 23 Jan 2017 14:35:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 14:35:38 -0800 (PST)
In-Reply-To: <xmqqbmuxr0pd.fsf@gitster.mtv.corp.google.com>
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
 <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com> <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
 <xmqqbmuxr0pd.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 23:35:38 +0100
Message-ID: <CAOxFTczrLmWZg3720HMUA-13q9ADi_rK5k0x+TEYyKR=xR5b_w@mail.gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> On Mon, Jan 23, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Should we plan to extend this to the interactive backend that is
>>> shared between rebase -i and rebase -m, too?  Or is this patch
>>> already sufficient to cover them?
>>
>> AFAIK this is sufficient for both, in the sense that I've used it with
>> git rebase -i and it works.
>
> That is a good news and at the same time a bit awkard one ;-)
>
> The mention of "passed to 'git am'" twice in the documentation and
> help text would lead people to think "rebase -i" would not be
> affected and (1) would need more work to do so, or (2) the user does
> not want "rebase -i" to be unaffected for whatever reason, and gets
> surprised to see that it actually does get affected.

I'm not sure I follow. If the user doesn't want to signoff during a
rebase, they can simply not pass --signoff. If they do, they can not
pass it. Am I missing something?

> In any case, will queue as-is so that we won't lose the patch while
> waiting for people to raise their opinions.

Thanks.

-- 
Giuseppe "Oblomov" Bilotta
