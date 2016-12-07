Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0ED1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbcLGWJp (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:09:45 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34057 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbcLGWJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:09:44 -0500
Received: by mail-qk0-f176.google.com with SMTP id q130so244098716qke.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R03FYhGfgUfkTq9OcqyCW98gN8Ke8UQ13XKlJ82tlNg=;
        b=c9plFdA+/mnCKHQ0w8b1gffG8WuQqEB9sIqbZe6nLw/C7hREAIChZ84PngzHppAUGV
         RBMBYwpiixUxgz5E7gmGr2PHf8Sn4U9jy05cW4rj81Z4krXbkgIA0620ND7JL5FuAhCW
         bT1uj3qqJo8cEjTt8G/dEfeycE0LgEJc0EnqviMna4+Q9USnOPustfWN46a3mCFGLH1H
         /2hTqewGgTrlAtHtVOAQjCUHpcSXmSjrIEQpNnY6wpCQQM9NhpTsFeRO1P5Px9rnTaEy
         Nevw8X7fPq+yDCgy6Kuzyfmt4czcNrFMdhF43ZZtAZQIWYaHwXf2zYYEOhW+C9HCRyHV
         dkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R03FYhGfgUfkTq9OcqyCW98gN8Ke8UQ13XKlJ82tlNg=;
        b=M7f5PXBthpbXNTxXzskDuXwzBTdc4biEQGdJCNL+R/mBVT6By9HkWZnZMfZ9IoXVbP
         abEGjVQlt/GFd84emibY0thhj/hZUEmoCQtLe2NlhvehM5NFFkirsXWteT6XdFyQaWCD
         UjWRuQyM8x+VP3LmF12x5fKX9Xls3of+eOKcYIS7j+ahCtnki2ESTNnPK0Plj+qSz95p
         h6VAeW4/idgJZGRHqOeH154WRpoeD/44amNJ8Q1EhUbwLkUZVjfdom/kZap7vITlx9uX
         vIuM1ZPVJeS9OPax2sjL1DsJb5Cn7lC3CEJOg7XA94R80wtSLF3U2Oykxsnz/75M8Ugr
         Czyw==
X-Gm-Message-State: AKaTC01MUG3txEygi7UFtpOGzhdLa427Qa96bSMvXRj0XxvASb9365N6X+G2/4rOlCz+0TkE38bBfYJXgIUkCLyk
X-Received: by 10.55.16.147 with SMTP id 19mr61211781qkq.255.1481148582976;
 Wed, 07 Dec 2016 14:09:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 14:09:42 -0800 (PST)
In-Reply-To: <9493435c-16e5-d8af-9455-ec3f3cba390d@gmail.com>
References: <20161207184248.6130-1-vi0oss@gmail.com> <CAGZ79kY3LR2KA69b4iDJb164EhJLb3JuVSRRcN0-4-kp-eryog@mail.gmail.com>
 <9493435c-16e5-d8af-9455-ec3f3cba390d@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 14:09:42 -0800
Message-ID: <CAGZ79kYuNri2aVtvRESxA9=E5OuBBqVkU_TcekxdyNJobFn5Mg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss <vi0oss@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 1:24 PM, vi0oss <vi0oss@gmail.com> wrote:
> On 12/07/2016 11:09 PM, Stefan Beller wrote:
>>>
>>> As submodule's alternate target does not end in .git/objects
>>> (rather .git/modules/qqqqqq/objects), this alternate target
>>> path restriction for in add_possible_reference_from_superproject
>>> relates from "*.git/objects" to just */objects".
>>
>> I wonder if this check is too weak and we actually have to check for
>> either .git/objects or modules/<name/possibly/having/slashes>/objects.
>> When writing the referenced commit I assumed we'd need a stronger check
>> to be safer and not add some random location as a possible alternate.
>>
> 1. Do we really need to check that it is named ".git"? Although
> "git clone --mirror --recursive" is not (directly) supported
> now, user may create one bare repository with [remnants of]
> submodules by converting reqular repository into bare one.
> Why not take advantage of additional information available locally
> in this case?

Oh, great point.

>
> 2. Is the check need to be strict because of we need to traverse
> one directory level up? Normally this "/objects" part is added by
> Git, so just one "../" seems to be OK. User can't specify "--reference
> somerepo/.git/objects", a strange reference can appear only if user
> manually creates alternates. Maybe better to document this case
> instead of restricting the feature?

Not sure I understand what needs better documentation here?

>
> 3. If nonetheless check for ".git/*/objects", then
> a. What functions should be used in Git codebase for such checks?
> b. Should we handle tricks like "smth/.git/../../objects" and so on?

I see we're getting into problems here.

>
> 4. Should we print (or print in verbose mode) each used alternate,
> to inform operator what his or her new clone will depend on?
>
> P.S. Actually I discovered the --recursive --reference feature when tried to
> put reference to a mega-repo with all possible submodules added as remotes.
> I expected --reference to just get though across all submodules, but it
> complained
> to missing "/modules/..." instead (the check went though becase the
> repository
> was named like "megarepo.git", so it did ended in ".git/objects").

Oh :(

With that said, I think the original patch is a sensible approach.

Thanks,
Stefan
