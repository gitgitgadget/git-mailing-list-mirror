Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C0EC875B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjIGV3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGV3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:29:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2891BCD
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:29:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-570428954b9so1891499a12.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694122169; x=1694726969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CE8n768aPtoVtEnyujglg6b3O+wnbv+i6fIgej1d5m4=;
        b=CVZ5D711xcsF/CTQ3Z/JvEZk66BD7Cg6PyQpiPYGifq3rx9Ph9CFhoAU465ruD1Q9/
         AyYzhFV6m9ASu4uydOcAkx1+iHA90DxqacrfbW+hddVsh2bNgN20AOhj6EhvfZFs0c0k
         VprdDzPuL5rYRUfcRiTGAQQvO9xSKh7YqNrIUhGn3FpjKoJFrhHCnWBXju3eI9dlvyea
         Bg75LIKQtkkYtwgd3Fhgj1jNPR8u9QlvRY5MZxbZI8UpTcUxDeTxjRv6wUQ3G2tufjl3
         sOonIT3wgpxF6Z1P+3Xmgw/8MvKvKtqmeVADTdMKF3ps/tc2wMosf0qxaLgWOisTAsT5
         PF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122169; x=1694726969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE8n768aPtoVtEnyujglg6b3O+wnbv+i6fIgej1d5m4=;
        b=Tv9P/yVqOuamjh0XZ0Jw8B6t06zaO7EEPjWr3UkdIwKr7B4Rwh0JyNYgJhHP7kdieI
         x1x0dkbgaJM7GxlVeSS5GDxw0wcA/WVeC7TDGkvFsjcePhIbjPnXSkVzC3B9Lipl5xs1
         MI4Pljgpnq6ifBp45ViPQ+AA2swDKc2cPCTw510J7r6/8E51f7pIbFnfWJcSzA1obk6V
         3wUsFEOUaHgFB+VOxckUU6XW+6w5mgLoz4gjzLYzgW3qt/8Sm1PZHdcFiczy1XkAzDVH
         LRo/DI6BRkQOc7LlAZROe0R+h8K6/6U4Y540MdytHFtPJ1LkDejpQqiNDCRQHZtE8mN5
         uQQQ==
X-Gm-Message-State: AOJu0Ywo2ik5/1GZdNiO2dnuB0WHs/5o8VcVN0zIgwdDvIEK+o6BQZ2a
        Kd0DhSZRAW9XUKgDT8rEYSVPB5r4A9Y=
X-Google-Smtp-Source: AGHT+IHise8wJfM97LeyI9H8zmyDpDbMkj4HkMpQLK576foI4D4A/KbUp3+myNlVm6v14Ezgf3MHn8Mdbqg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:921e:0:b0:56f:7de9:39f6 with SMTP id
 o30-20020a63921e000000b0056f7de939f6mr83164pgd.11.1694122169021; Thu, 07 Sep
 2023 14:29:29 -0700 (PDT)
Date:   Thu, 07 Sep 2023 14:29:25 -0700
In-Reply-To: <ZNcyhUL89WVXOv3F@ugly>
Mime-Version: 1.0
References: <ZNYuUh27ByphTH04@ugly> <owly350pfal6.fsf@fine.c.googlers.com> <ZNcyhUL89WVXOv3F@ugly>
Message-ID: <owlytts5llje.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
From:   Linus Arver <linusa@google.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, I apologize for the long delay in my response. I only work on Git
20% of the time, and that 20% can become 0% due to factors outside my
control.

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Aug 11, 2023 at 04:00:53PM -0700, Linus Arver wrote:
>>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> On Thu, Aug 10, 2023 at 02:50:59PM -0700, Linus Arver wrote:
>>>>Nit: the "doc: revert: add discussion" subject line should probably be more
>>>>like "revert doc: suggest adding the 'why' behind reverts".
>>>>
>>> this is counter to the prevalent "big endian" prefix style, and is in 
>>> this case really easy to misread.
>>
>>I also learned recently that there should just be one colon ":" in the
>>subject, which is why I suggested "revert doc" as the prefix instead of
>>"doc: revert: ...".
>>
> in what context was this preference expressed?

IIRC, it was from a conversation off-list with the folks at Google's
Git-core team.

> because here, it's rather counter-productive: most commands are verbs 
> for obvious reasons, so using that style sets the reader up for 
> misparsing the subject on first try.

I think the convention for commit titles is

    <prefix>: <action>

so the phrase "revert doc: add discussion", where the <prefix> is
"revert doc" does not parse any worse than "doc: revert: add
discussion". That is, the <prefix> is never confused with the <action>
(they are separated by the colon).

> this could be avoided by quoting 
> the command, but that looks noisy in the subject.
> so rather, i'd follow another precedent, 'git-revert.txt: ', which is 
> unambiguous.

SGTM.

>>> i also intentionally kept the subject generic, because the content 
>>> covers two matters (the reasoning and the subjects, which is also the 
>>> reason why this is a separate patch to start with).
>>
>>I think the phrase "add discussion" in "doc: revert: add discussion"
>>doesn't add much value, because your patch's diff is very easy to read
>>(in that it adds a new DISCUSSION section). I just wanted to replace it
>>with something more useful that gives more information than
>
>>just repeat
>>(somewhat redundantly) what is obvious by looking at the patch.
>>
> but ... that's exactly what a subject is supposed to do!

I think the rule of thumb is to explain the goodness of what a commit
brings, rather than focus on what is literally happening. This is
because the former is more valuable. So instead of

    "git-revert.txt: add discussion"

you could say

    "git-revert.txt: advise against default commit message"

and now you don't have to look at the patch to see (roughly) what kind
of discussion was added.

>>>>Please consider rewording such
>>>>    subject lines to reflect the reason why the original commit is being
>>>>    reapplied again.
>>>>
>>> the reasoning most likely wouldn't fit into the subject.
>>
>>Hence the language "to _reflect_ the reason", because the "reason"
>>should belong in the commit message body text.
>>
> i don't think that's how most people would actually read this.
> and i still don't see how that instruction could be meaningfully 
> followed.

OK, you may be right.

>>> also, the original request to explain the reasoning applies 
>>> transitively, so i don't think it's really necessary to point it out 
>>> explicitly.
>>
>>It may be that a user will think only giving the revert reason in the
>>body text is enough, while leaving the subject line as is. I wanted to
>>break this line of thinking by providing additional instructions.
>>
> yes, that's the whole intention of this patch. but i don't see how 
> making it more convoluted than my proposal helps in any way.

Well, even if a review makes something more convoluted, it may generate
discussion and drive consensus on the better way(s) of doing something.
I see value in that course of events.

Of course you are free to reject review comments that you truly believe
are inferior to the approach you've already taken.

But overall, when I see a reviewer's comment on this mailing list, I
assume they are trying to make my patch better. Similarly when I
reviewed your patch my intent was to provide actionable feedback to try
to make it better. I'm sorry if I did not come across that way.

>>This is definitely better. But others in this thread have already
>>commented that my version looks good (after seeing your version also,
>>presumably).
>>
> well, i'm also an "others" when it comes to your proposal, and i find it 
> confusing.

I think you did the right thing by responding to my comments, and
pointing to things you found confusing.
