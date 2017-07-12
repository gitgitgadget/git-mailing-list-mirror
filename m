Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C3F2035E
	for <e@80x24.org>; Wed, 12 Jul 2017 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbdGLU6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:58:54 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35932 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdGLU6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:58:53 -0400
Received: by mail-pf0-f174.google.com with SMTP id q86so18516004pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ez/gVwqTFJIhMGkl+MONS2iBVOBCd0BBOsQE3gy580Q=;
        b=VwKczNblTfvtF28P0PuGAqRB1zG5Sod4isUvugjYYrhs9lRCMqZS50AnSfqmxeM9rc
         4tMnGKuleQcVXe+BgP6zN6ujKUPWLYDO35RrzgSM2IrwaQivPmee0sR9SaJbeEJDLvdN
         NonfHJVc7TbT2IhR532MSjDNf3k4EtOoJnmuEnbf2pvSgcjCK3JIwdFgLO20CsSBF2N6
         BNy3meLRYtLZALNXhwO/iy4hLMckpbrLEjLYnjNSngvXrMK5NFetJ5XQ6wC2aB9aXHBQ
         DySUvyPz/byOyLya4q4Wsde8VewyaxB7avlZEbOCmCIdT9mstJV31c/7wWgN2tMPILt/
         dkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ez/gVwqTFJIhMGkl+MONS2iBVOBCd0BBOsQE3gy580Q=;
        b=DuvPQxeJwIW0ssc1vb0UMt8YYxpwk6kt+8tfmMkwGDFAUrWfRKV05SHxKh/hUZRd+o
         C3d0/gb85LyVLT+9YiwnePQXQUVu9ZOCKK5JdgSvT6s6CJP4MQ0N027+s/63UumcKFCP
         yGH/Xt2Y4ao52LV5L8agH9uffE0D8+7AVsakH7H78lDPt8bbfJlWn+LRrC+v8Q4o8rVo
         SEwCUKn5oMNe7zbczyRiv0lxbKASuMTolfH8HKGKnkq2tdlr5UKGPxyGEFWrtjlg8n4l
         MQlX6197AcHlrOjiyoT3NWjiS4MMSHV/5jPUOqVv/WUZItV6J3iryeX24vnxKJkzhD+0
         158A==
X-Gm-Message-State: AIVw111zlCZij2/1g1y+p7jtisw5vZZLRc8W/732uLRyTEaiTu167+HT
        WHNR6nsAhy7Sw/9ZbmTabHWVP2eZyCdN
X-Received: by 10.98.85.131 with SMTP id j125mr34764344pfb.48.1499893132647;
 Wed, 12 Jul 2017 13:58:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 13:58:52 -0700 (PDT)
In-Reply-To: <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 13:58:52 -0700
Message-ID: <CAGZ79kYftkxbDY2E_=2w0VYx8COF_yc61h78gs2qaraK9HRSuA@mail.gmail.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:


>
> Just set diff.orderFile to suit your taste without bothering other
> people, I would say.

I must have explained it very badly, I'll try again:

There are 2 different use cases to use diffs.
1. my personal use case to look at logs, diffs.
    I'll just set diff.orderFile and I'll be fine.
2. collaboration.
    When I want to review a patch from the mailing list,
    I could (a) download the patch, apply locally, see the diff
    formatted nicely according to diff.orderFile. Go back to my
    mail client, type an answer, quoting the patch out of order.
    This is very much work for me, so ...

    Alternatively (b) I could ask anyone who wants me to review
    patches to set diff.orderFile to my liking. Then I can stay in
    my mail client and have the diff hunks presented in an order
    that is most effective for review.   (This is nuts, because
    the author would just ask someone else to review their code.
    "Who am I to suggest obscure rules in collaboration?")

    Another alternative (c) is to have this 'suggested' order file
    in place. Anyone that does not care about an order would use
    the suggested order, that coincidentally matches what reviewers
    in this project think is best for review.

    With that, the author has no additional burden and the reviewers
    get better patch presentations by default.


>
>>   I want to force myself to think about the design before pointing out
>>   memory leaks and coding style, so the least I would wish for is:
>>     *.h
>>     *.c
>>   but as we have more to look at, I would want to have the most abstract
>>   thing to come first. And most abstract from the actual code is the
>>   user interaction, the documentation.
>
> This is exactly why I invented the orderfile in the first place.

This is my personal use case.

> But such a "policy" is not something a project would want to enforce
> its users all the time; it is left to personal preference of the
> participants.

I kindly ask that we enforce a policy on people sending patches.
And to do that I would not want to bloat SubmittingPatches, but
rather give a good default, so that people not thinking about this
detail, still get it right.

Thanks,
Stefan
