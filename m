Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679561F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbeFAJoI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:44:08 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:26842 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFAJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:44:07 -0400
Received: from [192.168.2.240] ([92.22.30.137])
        by smtp.talktalk.net with SMTP
        id OgbNfTKcJoI6LOgbNfr0J4; Fri, 01 Jun 2018 10:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1527846246;
        bh=O6OgRmwIA44uDoE4eKjOi1K3D+fPUmaTbQNmekfje10=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mXKaeoU3MmJPN26fz6grbN6jqYmu8SBvEFpDYu/gk/MmFv0JnDUr9vSMEkZIEJx3u
         T8pWGxYMjYzgWhP52/OdVHk95ifQCaRYC1JACN+MWigNWQ6SWrFEH/lS1UsSf8W7Al
         DwAkRcUUVyqAMuw/rwb57U4tPgHlOGNr4sBy1R1Y=
X-Originating-IP: [92.22.30.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=2E67H+H4u1YVIwSqTyRiqw==:117
 a=2E67H+H4u1YVIwSqTyRiqw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=vJk4UQTCGuZNAsvI6JQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
 <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
 <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <061ebcf7-f88e-4d4d-da73-f81e9251ee3b@talktalk.net>
Date:   Fri, 1 Jun 2018 10:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ7HiyZTS40XPwpjN3PBbdW0ETN=dfzeE-90Rp+irXnSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMIB/835kZ8NjArdN+LPmJ9SQ4UyW9u5GVBOFHJChCMyHwQW71ERf8Wa0BozkTbMODNDclDmIBmLLhXJ2wUvHit6nATKQW0Xwh1SCEgeVI6s5qrp19tA
 i/Fn03s8XIDAQDo/c8IepnEtKdCuotTiefkZU13l3M8ZkW0CjPO2weYk/R3/1rB9gHQdwTpfjqk19Z8eKOQBr3MfyMA0SWMVQ28jN9S7GQrM99DRJ47FGGKs
 fWJ4nwKAHPAnCaQEjNdm8a7UoXkRgFKN1z/ag7B1ejAVIrfNW7NvlC5bi1p/ih+v0iGLGdjwDlcf/ldOfjSlARSBH9VhX8WvB2zFt1Vs5jF19pnD9HDvM6z0
 Co7s8n3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/18 19:44, Stefan Beller wrote:
> On Thu, May 31, 2018 at 10:48 AM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> Hi Alban, it's great to see you working on this
>>
>> On 31/05/18 12:01, Alban Gruin wrote:
>>> This series rewrites append_todo_help() from shell to C. This is part
>>> of the effort to rewrite interactive rebase in C.
>>>
>>> The first commit rewrites append_todo_help() in C (the C version
>>> covers a bit more than the old shell version), adds some parameters to
>>> rebase--helper, etc.
>>
>> I've had a read of the first patch and I think it looks fine, my only
>> comment would be that the help for '--edit-todo' is a bit misleading at
>> the moment as currently it's just a flag to tell rebase-helper that the
>> todo list is being edited rather than actually implementing the
>> functionality to edit the list (but hopefully that will follow in the
>> future).
> 
> Would you have better suggestions for the name of the flag?
> Of the top of my head:
>    --write-edit-todo
>    --hint-todo-edit
>    --include-todo-edit-hint
> not sure I like these names, though they seem to reflect the
> nature of that flag a little bit better.
> 
>>> The second one strips newlines from append_todo_help() messages, which
>>> require to update the translations. This change was advised to me by
>>> Stefan Beller, but Johannes Schindelin voiced concerns. I don’t really
>>> have a strong opinion about it, so feel free to give yours.
>>
>> I'm not sure I understand what the point of this patch is, if the
>> newlines are unnecessary then I'd just omit them from the first patch -
>> am I missing something?
>>
> 
> The new lines are part of the output and are currently in the part to
> be translated:
> For example from the German translation file:
> 
> #: git-rebase--interactive.sh:171
> msgid ""
> "\n"
> "Do not remove any line. Use 'drop' explicitly to remove a commit.\n"
> msgstr ""
> "\n"
> "Keine Zeile entfernen. Benutzen Sie 'drop', um explizit einen Commit zu\n"
> "entfernen.\n"
> 
> After patch 2 is applied, the translators only see
> "Do not remove any line. Use 'drop' explicitly to remove a commit."
> as a need to translate, and the two additional new lines (one in front
> and one after the string) are just put in place autormatically.
> 
> Usually we do not want to play sentence lego, but this is a whole
> sentence for translation; it is rather about formatting the output for
> the terminal, adding new lines to separate some messages.
> 
> I thought this patch would just show goodwill towards translators
> that do not need to replicate the formatting exactly.
> 
> If you feel strongly, I'd rather see Alban drop this second patch and
> move on instead of waiting for our argument to settle. ( I do not feel
> strongly about it, but put it out as a suggestion as that seemed like
> it would lead to a better end state for the project).

Thanks for the explanation, I see what you're trying to do. I don't have 
a strong feeling either way, I can see the potential advantage but as it 
changes strings that are currently translated I'm not sure it is cost 
free. Do you know how the translators feel about the change as they're 
the ones it is aimed at?

Best Wishes

Phillip

> 
> Thanks,
> Stefan
> 

