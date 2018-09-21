Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44311F453
	for <e@80x24.org>; Fri, 21 Sep 2018 12:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbeIUSfF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 14:35:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:37055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeIUSfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 14:35:05 -0400
Received: from [192.168.43.121] ([89.204.135.156]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCggg-1fv3MU1Zly-009Ol9; Fri, 21
 Sep 2018 14:45:56 +0200
Subject: Re: [RFC PATCH v4 1/3] Add support for nested aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180907224430.23859-1-timschumi@gmx.de>
 <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
 <aede75a5-d2ba-5a95-434d-aa70f7270fd7@gmx.de>
 <xmqqva7487a2.fsf@gitster-ct.c.googlers.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <9f7aa1f1-2493-42f3-19b7-cfa2efadbb14@gmx.de>
Date:   Fri, 21 Sep 2018 14:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqva7487a2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:c1UNPtCxAGzPJcXebVvTU3RKhlyH0Q5u0u1ebMZy/9MtH5Kf/4h
 x18uv3epXZ/v+r1EgCASF2A+viW0Xv0vArUG2aHqys+O9aktWiCz/9MtBNdkx3e6YGBzVNi
 tf+XieabJbked14qK+aO3af/cYEkyaP4mPWCilr116mk8SGnONuINGUtEJrpBZW9qanHoml
 fbBYXLIP9LJvni2Z+YMBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DdHxGJDTOIs=:GIGnupl6yWpYBz/zkyn8Fs
 78QzZ9oxQCkGKFfFufnouJSAHULcjqV2gkJGaaFloieNzTGYTtBsdLiaXdI3g9bZVMbaGwmsJ
 gnJSRVXGhHAPw4E5AWDqKdqlrFGKJdY4/Gk8KRvSdVn24jlRvK6SHryd4bovF5Ukk+tjm4hk5
 rPW7IXq9vKujnvRwsnU4psAq5gfg6RKBsI4jzjzQdKfY6abtDBfTEv8My+b4Yq1sJHFTPttvK
 i8A+hR47n+GVUURKOlqPBFsbsvj2fYDlRNFU5tOrOxRKOaq55GJ2hFk6k0ijTI6+3KqPSKrp+
 E3xXaMXqnPrxLmF0rWbHZEPhdIwYAJvIgd28WlJl2VTpr4Nlts+6x/ZOOGgHhBRjdXBJ5W9t4
 y1kPih/4rKyPgqIRQ1wL6/8aXKzJb+S3VFnijwrTUjfiH+tmNtsTA297tmjs+RjfGc1Isg2KO
 A0CmdfEnJT+UJM+MMxyo24P0me/b1M2YYKpOLUkGGUpE/q66Js9Azkc9TIiHAILWkeKpXTUfq
 EWfBsl+pkr3MutfI6q6Uqxc1pzHaKD9d265S9hxXZ7Ki+VT6NhSXNuET/tow3GLawIeagP/wm
 BhQqaKgqlCAKNfhZmg02KXXENG1GvvQP8JbuEiGedsOSMPP22c76i0BB1GP6AnTJkMXW94IvQ
 jUvHVrwyiPpnzKMiveaIo3EB8NLt8SwUlS1DLNhotFsdUMGTZxX7fB3MzfAl5xVJcIkkwStG9
 caF3UAxaYucB6Tp1qzVGpEl0gw+sLG2bzhfZZTVGar9IaJuFGgYP2QBWpauwjvqe9PoYb/fL8
 emUb16bhFSZbiPHIL7v40LvpsvqfmgLaz2SwU1M/wS1tYo4+jk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.09.18 17:37, Junio C Hamano wrote:
> Tim Schumacher <timschumi@gmx.de> writes:
> 
>> On 08.09.18 15:28, Duy Nguyen wrote:
>>> On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
>>>> +               /*
>>>> +                * It could be an alias -- this works around the insanity
>>>>                    * of overriding "git log" with "git show" by having
>>>>                    * alias.log = show
>>>>                    */
>>>
>>> I think this comment block is about the next two lines you just
>>> deleted. So delete it to instead of fixing style.
>>
>> I think that comment is talking about the code that is handing the alias,
>> so it still would be valid.
> 
> "this" in "this works around" refers to the fact that we first check
> the builtins and on-GIT_EXEC_PATH commands before trying an alias,
> which is an effective way to forbid an alias from taking over
> existing command names.  So it is not about a particular code but is
> about how the two sections of code are laid out.
> 
> It probably will make it clear if we reworded and made it a comment
> about the whole while() loop may make sense, i.e.
> 
> 	/*
> 	 * Check if av[0] is a command before seeing if it is an
> 	 * alias to avoid the insanity of overriding ...
> 	 */
> 	while (1) {
> 		...
> 

Imho, the "insanity" part makes the intention of that comment unclear, even if
it is located at the top of the while() loop. Giving an example is nice, but wouldn't
it be better to say something like the following?

	/*
	 * Check if av[0] is a command before seeing if it is an
	 * alias to avoid taking over existing commands
	 */

> but that can be done after the dust settles as a clean-up, I would
> think.
> 

I'll keep the changed comment in my local repository for now and publish it together
with other changes in v6, but I assume there won't be much additional feedback.
