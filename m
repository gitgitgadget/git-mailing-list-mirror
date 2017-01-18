Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12AF20756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdARAVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:21:40 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34960 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdARAVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:21:39 -0500
Received: by mail-io0-f177.google.com with SMTP id j18so151571ioe.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 16:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sixvC2l1dzKg6hx907YuYKZKw37b7TI7ruN4PnMnGYg=;
        b=iVmmFIx/OasHTcta9HHHh3XHP4GpBnOT33ayPC9HLpZCfekXoxEPZ6JdstCmj0B9bP
         GmnYA0CwwISKTV0o4P7p/uwpPT8Bfrsqx7gqnTP95mhjY5klZ7oULMAzV/d8bBshn1Le
         oTE4VoUXPI3oSe30uCj6FMUZlCjpl5lDZMqSwBPhj+I6dWHKR6GL+r1zu8Cp9tORubdC
         GB+3OOaiTsmr3/JwzYbBv8IRw1YA3h4I2r3AuVrEM/NeXs0ujHFgNRvSDFp+GlaCYRoT
         09CrOHnMS4h90B3OXrJjPyQjskk9gv3mTggreDDuDPEQZxvD4yPVIJ1m0m/aKOEjcSkX
         oAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sixvC2l1dzKg6hx907YuYKZKw37b7TI7ruN4PnMnGYg=;
        b=rTEaWvId2xo95cPsGE+GgcpUXxXHttTnVkv+CQnK1cbLA+vQ0b0eM3vsqh26QtN4/t
         IHQZOa39J+VM7TkR3ta8jKwcc3EARB5vPeOnb8RULc6albvwHcLYG6kDiu1PY5THHqMF
         KX5KHEE4klFWHf0LNP8W1hukVaQQDPLNtnn5SfmqWLspqCj/jTlkiJpLGdyQTqh9OKHG
         ES2W94iMkleg01X+4mdnDjilZvvI2GKhHgKJ2XkTUAnWJjZQv3erVmVqau+eLiQCc0KE
         ZIEm+yZQqd937zG0t2Fb24GNByLwrNu07Ex7UQ6fjyBfih4Wykq4wYpE0tJk2yyfy6+5
         fF8A==
X-Gm-Message-State: AIkVDXIvM8jB1H4j4Tp2wYDrKeSljwEM8QeW9ilx3WhnIZ8IiRSxpTur8gnySu7CN3wQIdo4VB1+8nNFMTwAEZ59
X-Received: by 10.107.37.148 with SMTP id l142mr903412iol.159.1484698897765;
 Tue, 17 Jan 2017 16:21:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 17 Jan 2017 16:21:37 -0800 (PST)
In-Reply-To: <xmqqr341b4vm.fsf@gitster.mtv.corp.google.com>
References: <20170113235427.5768-1-sbeller@google.com> <xmqq8tq9ckxo.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYu1Y2pwk9+kbSrMxwP3S0n8FMW6f4wdEE0mrACqrOPNA@mail.gmail.com> <xmqqr341b4vm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jan 2017 16:21:37 -0800
Message-ID: <CAGZ79kaQOrOAnoa9w++wz2aEhwAc1x0bSTCbeXUPedqV7cW06g@mail.gmail.com>
Subject: Re: [PATCH] transport submodules: correct error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Jan 17, 2017 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Trying to push with --recurse-submodules=on-demand would run into
>>>> the same problem. To fix this issue
>>>>     1) specifically mention that we looked for branches on the remote.
>>>
>>> That makes an incorrect statement ("not found on any remote"---we
>>> did not inspect all of the said remote, only heads and tags) into an
>>> irrelevant statement ("not found on any remote branch"---the end
>>> user would say "so what?  I know it exists there, it's just that not
>>> all remote refs have corresponding tracking ref locally on our side").
>>
>> eh. So to be correct we need to tell the user we did not find any match on
>> a "remote-tracking branch" as the gitglossary puts it.
>
> I think the updated text is already "correct".  I am pointing out
> that it may be correct but not very helpful to the users.
>
>>> where remote tracking information is
>>> incomplete if you only look at heads and refs, in the sense that we
>>> no longer suggest ineffective workaround.
>>
>> s/ineffective/an effective/ ?
>
> Even though I make many typoes, I meant ineffective in this case.
> "The old message suggested workaround that would not help.  You no
> longer give that workaround that does not work."

Oh, I misunderstood the original as I lumped on-demand and check
together mentally, because in the Gerrit world they behave similar.
(Both error out; in the on-demand case the server produces the failure
message, though)

>
>>> If that is the case, perhaps configuring push.recurseSubmodules to
>>> turn this off (especially because you plan to turn the defaul to
>>> "check") and not giving the command line option would give a more
>>> pleasant end-user experience, I suspect.
>>
>> I though about going another way and adding another new value
>> to the enum, such that
>>
>>     git push --recurse-submodules=sameRefSpecButNoCheck \
>>         origin HEAD:refs/for/master
>>
>> works for Gerrit users.
>
> It is unclear what that enum tells Git to do.  Care to explain?  How
> is it different from "no"?

In those submodules, that are checked positively, blindly run
git -C ${sub} push ${ref_spec} and do not double check again,
which we currently do in the on-demand case.
