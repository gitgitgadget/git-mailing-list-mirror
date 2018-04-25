Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33891F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbeDYOk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:40:58 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:37988 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754203AbeDYOk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:40:57 -0400
Received: by mail-ua0-f176.google.com with SMTP id y8so1356753ual.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6GsGi7VfNCCE+L+6fgzcg1QM0FE4QOWQZeA1fGr9ves=;
        b=HUcmBpe9vDfF9YeZmKXhRF3evCHyZI5dXt/2Y8TijACA9OAMca8ezUinnTm+TCLUiT
         /hUe09EMrFuSsTaqfhdr+t6PTTO+YyTVvhupdjD5i1B7UuY8otCzSbDtaSRVbM/E/AVj
         selNz0/ufftzbFBIN8+iPjFIufflVGzCwnjIsU/eerwkr8WDokwuQ98z+qVQsu7MVDbH
         xjaQcHkwm0zPq3Zfs8FxD4wJaYd7IErahdQigF8+08oFGCeHqcQ7zad60jWosqY/IvGk
         HAaEZkb5UPHfQp/U3nGjF9MhCFeF4wDCB/B1cvbtw6Vpc8I5ni/2NnBRqkSGnpKPerd1
         y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6GsGi7VfNCCE+L+6fgzcg1QM0FE4QOWQZeA1fGr9ves=;
        b=qR+DvE2DX5GqUPgs+H651qxmVu2tVaTlsGVBQ9+9M3IE8lOZB3VvG4n/kgOOWo9qNs
         t8e5ES8Sn9W1l56soaBP1p57JcGHuYar3WifDiLCh+76KZFRsCWQMKyWIReKS1Jnjdx6
         V+mkDsg+CqAC0cWZZJQAy8CcjoFAhJ1eN9vZMjRZHF+RnYwELrmHXGHuL+1VVLGEzheX
         kc8QmB6U52hLzVlCyUy9zXojmi5YXMaA0Pz9qbLGEOil41zxSjoTWnK/qFpyum4y8cci
         Xp6fZNTHQnBySMc/nA+jHnoniFHuxaA2wlHQm+02UOzcUvljvWSOr7SJfg655cC8gnZb
         PcZg==
X-Gm-Message-State: ALQs6tAesIHPTzQTYTpWSNxEuhoMoOuOAZS9fshY1yzrUK8OvakYhwqb
        ds9GuX89OC759Hu+cIcNKhyMrsl4ugP2auov4rM=
X-Google-Smtp-Source: AIpwx4+7M+TXdHVzP7B2XH5o66x4eCcVusxW+50DUWeUXXGXRlUt4qyF0GYfEWNffyFK2hE7cbofqWk3MTLvbob5SrU=
X-Received: by 10.176.27.172 with SMTP id k44mr21721897uai.5.1524667256876;
 Wed, 25 Apr 2018 07:40:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Wed, 25 Apr 2018 07:40:56 -0700 (PDT)
In-Reply-To: <CAM0VKjmJBzBFDAi1FQAgytb82-Q7JhO+aOfKi=YBZ3YtNxwPTQ@mail.gmail.com>
References: <CAM0VKj=pDVxfJtUZx7c6uCmPxwQFPBOQYdd7NH=YnVG86iK0Pw@mail.gmail.com>
 <20180419190725.GA8555@furore> <CAM0VKjmJBzBFDAi1FQAgytb82-Q7JhO+aOfKi=YBZ3YtNxwPTQ@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 25 Apr 2018 16:40:56 +0200
Message-ID: <CAM0VKj=MVY15SbRanfhXP3pPjNEuhZ=dbQmhXox6n5AOFyz2oQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external subcommand
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 5:12 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Thu, Apr 19, 2018 at 9:07 PM, Florian Gamb=C3=B6ck <mail@floga.de> wro=
te:
>> On 2018-04-18 21:51, SZEDER G=C3=A1bor wrote:
>>> I believe the main bash-completion repository can be found at:
>>>
>>>  https://github.com/scop/bash-completion.git
>>>
>>> This repository still contains the branch 'dynamic-loading'; for the
>>> record it points to 3b029892f6f9db3b7210a7f66d636be3e5ec5fa2.
>>>
>>> Two commits on that branch are worth mentioning:
>>>
>>>   20c05b43 (Load completions in separate files dynamically, get rid of
>>>             have()., 2011-10-12)
>>>   5baebf81 (Add _xfunc for loading and calling functions on demand,
>>>             use it in apt-get, cvsps, rsync, and sshfs., 2011-10-13)

>>>> I think the easiest method is to use a function that is defined by
>>>> bash-completion v2.0+, namely __load_completion.
>>>
>>> This is wrong, __load_completion() was introduced in cad3abfc
>>> (__load_completion: New function, use in _completion_loader and _xfunc,
>>> 2015-07-15), and the first release tag containg it is '2.2' from 2016-0=
3-03.

>>> Would it be possible to use _xfunc() instead to plug that hole?  It see=
ms
>>> the be tricky, because that function not only sources but also _calls_ =
the
>>> completion function.
>>
>> But isn't this exactly what we want?
>
> No, that's definitely not what we want.

In my previous emails I overlooked the _completion_loader() helper
function.

It seems that this function does almost exactly what we want.  It was
introduced along with dynamic completion loading back in 20c05b43, so
it's available for us even in older LTS/Enterprise releases.  Since
cad3abfc it's a wrapper around __load_completion() and thus benefits
from all the improvements, notably searching for completion scripts in
a user-specified directory ($BASH_COMPLETION_USER_DIR) or in the
user's home directory ($XDG_DATA_HOME or ~/.local/...) as well.  It
loads the matching completion script, but does not call the completion
function unconditionally.

The "almost" refers to he case when _completion_loader() can't find a
completion script with a matching name to load, and then registers the
_minimal() completion function for the given command to do basic path
completion as fallback.  I don't think this matters in practice,
because in this case the given command is a git command in its dashed
form, e.g. 'git-diff-index', and those have been deprecated for a long
time.

I think all you need to do is run a
s/__load_completion/_completion_loader/ on your patch and update the
commit message with relevant bits from the above discussion.
