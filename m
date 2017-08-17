Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459DE208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 07:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdHQHB2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 03:01:28 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:38797 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdHQHB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 03:01:27 -0400
Received: by mail-ua0-f180.google.com with SMTP id y36so21942956uac.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xkf+rG86/0r5BsMUX48WZyFCn6+tH0b/n2wtRdwU1vA=;
        b=FslSvscSjC4kKuL2/z7EG3iYcrzfO/+03n2CzR5uVqtnkR2oOFGUP2434ADTvkF37q
         R7ZDIE1WLnsd3c67HACSQy1IMIR9jJ7s7JWSOnfKkjM2or87B7nIhsVRJq2ZrbwJNCRi
         63Uu2w3aZqil316Vo8kD0wrHCnlfVUfGu1CviI4oK0ygP1zoCLc/RQPvDK+JwIUk6xIM
         j1VPaF3BZ+6VshRcrNOdB1qu+1wtqSluNfpfda5b8KpU/VUBu6V4Gi98hpH7cQdhRSJY
         A4NEroh+HiFZO4OHXS9njzckrPgaujVnSb0L4Ce+FZpZEQ7ur1wPgOJQLEJreCI+0JRi
         Kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xkf+rG86/0r5BsMUX48WZyFCn6+tH0b/n2wtRdwU1vA=;
        b=ba4pjAKSPRfpHHRukWleBDbAquKnymCLUTYdY4NpSFtpb9VbKsF+Inw7elVA2p2IV7
         56YkIEse5IGuVzVJB3c3XP1o8JzZ16OUo+hVdMVqatdC451wKM+lnhpKcIihtpywXwbJ
         0M7sx664AVvAll7KlziyNc4sAlyRzjr8oAfnMshDC5uCXUz+2YwEIyUomzTdB5j7S/ce
         rG9pQ3VrHmdlFTz535RqABho0UYyKa5BDIv3AlY3K9s0VNR7gGq4DNtBN5VTJL5jZpio
         6hFcXFtoN5LWqlqQ+Ra61+XSVJbt0zlHeadOoGUjEk7Bd1drrGvSv0Kb2MIqnUDK4EN4
         q3Zg==
X-Gm-Message-State: AHYfb5i9+I14Tvo2lsUl6G0srXp5JatB3adoFsSYamzhbFU4a3WAS4y5
        TA+8RNKlmkTmTJEnsHm0WPSuBM7G+sOF
X-Received: by 10.176.71.17 with SMTP id h17mr2445440uac.138.1502953287091;
 Thu, 17 Aug 2017 00:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.114 with HTTP; Thu, 17 Aug 2017 00:01:06 -0700 (PDT)
In-Reply-To: <xmqqo9rfi3b2.fsf@gitster.mtv.corp.google.com>
References: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
 <956ccc83-c291-4217-795c-fcef33fac35b@gmail.com> <xmqqo9rfi3b2.fsf@gitster.mtv.corp.google.com>
From:   ryenus <ryenus@gmail.com>
Date:   Thu, 17 Aug 2017 15:01:06 +0800
Message-ID: <CAKkAvay1gJTLJrGLb3aFMJmnyQjPhSD9cx0DRAAN3Mh5NAhfiQ@mail.gmail.com>
Subject: Re: [PATCH] fix revisions doc about quoting for ':/' notation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 August 2017 at 05:57, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Heiduk <asheiduk@gmail.com> writes:
>
>> Am 16.08.2017 um 05:21 schrieb ryenus:
>>> To make sure the `<text>` in `:/<text>` is seen as one search string,
>>> one should quote/escape `<text>` properly.
>>>
>>> Especially, the example given in the manual `:/fix nasty bug` does not
>>> work because of missing quotes. The examples are now corrected, and a
>>> note about quoting/escaping is added as well.
>>
>> Right now the documentation describes the syntax as git sees the
>> parameters. This is agnostic of the shell or other UI with their
>> different quoting rules.  For example users of fish must quote
>> `rev@{2}`. A GUI might require no quoting at all. In that case `:/"fix
>> nasty bugs"` would be given to git verbatim and hence not find the revision.
>
> These are all good points that I didn't consider when responding.
>

Makes sense for me, too. I've just sent a v2 patch, which leaves the original
example as-is, meanwhile added a example inside the explanation.

Thanks!
