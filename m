Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230202098B
	for <e@80x24.org>; Wed, 19 Oct 2016 14:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942078AbcJSOeQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:34:16 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:32915 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942094AbcJSOeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:34:14 -0400
Received: by mail-ua0-f177.google.com with SMTP id p25so10905150uaa.0
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1jj0oSjdamVVyTvV1k7xkUDSRDmFErx5LYKd+gtbpGk=;
        b=o4k7XkBBynWeC00SxpM8d0wkT2z7H4qH9weq2liaBYrC/4iRTnGjeAGCk/WOUfzOgg
         hNWW5KaGjHlAXSw29M+6EzmmbfmQdxfv/+j91ZERLagxCTe0TqJMzFgpe724C2TE33bp
         0i1c8y9anvGYB4MNxHFCjjs48jPRSIsqDg/HpNnw+mKP2aDTCwRG4wJPXbMNPleusgWY
         BHsx9F2Q7VnMeFD3GezJErrB4ZXfxXVfl55Mqy4iPp7R4ENCRe9uFdXelQdj3iP6oPkX
         frGC9WQhS49LDD+HUPms8MGjGhFA/wxAzahAO545W6FfSdUPPL8WXPMYrkTN/zC00BN1
         pZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1jj0oSjdamVVyTvV1k7xkUDSRDmFErx5LYKd+gtbpGk=;
        b=jtSJnVCz7s/FzBI17nAu2BEFY29dwV27nheyDrd/9ltsaUPUivJmJa+/DYRzGMzFhO
         oaXVwRN96RdRD+xvEZ3QkAKJo3e1Y7JYLoOvuhnYxVzGpZdUgX/KZ5m2Or5IL1GPj08U
         gDbkHk9ZD8eAs+pmrhBCbgau9X/WayOBb6ywzDQT3+woLrGQ9lSHyO1Bukwg+gXVkoqz
         FSVF/Kvqa49JKGg6iJhrLxkj9AmMhRSLvRRP3CnSy8/lVdNCx9gaPh0MOwR0gx6BtXCF
         KM2GSZIhSTnCnVYhbG3UcCYPZWooKpZ5RLRNR0ATImM0SCu5jIt23S7az7/GlJl+E4wc
         sKWQ==
X-Gm-Message-State: AA6/9Rl0jRKlbNRET3IJIWgq7/+4QfgqHmLu2i8uIQDHYTBBLnAWmmFJP2KQZqj21dqzafImw+mpPZSU2SZztQ==
X-Received: by 10.159.48.22 with SMTP id h22mr1887895uab.45.1476883662187;
 Wed, 19 Oct 2016 06:27:42 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Wed, 19 Oct 2016 06:27:41 -0700 (PDT)
In-Reply-To: <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 19 Oct 2016 08:27:41 -0500
X-Google-Sender-Auth: jUSAEZwCDLbE5ZWAezriynFvz4g
Message-ID: <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Stefan Beller <sbeller@google.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 4:17 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Oct 18, 2016 at 12:35 PM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
>> Hello git experts,
>>
>> I have in the past attempted to integrate submodules into my primary
>> repository using the same directory name. However, this has always
>> caused headache when going to and from branches that take you between
>> when this integration occurred and when it didn't. It's a bit hard to
>> explain. Basically, if I have a submodule "foo", and I delete that
>> submodule and physically add its files under the same directory "foo",
>> when I do a pull to get this change from another clone, it fails
>> saying:
>>
>> error: The following untracked working tree files would be overwritten
>> by checkout:
>>         foo/somefile.txt
>> Please move or remove them before you switch branches.
>> Aborting
>> could not detach HEAD
>>
>>
>> Obviously, git can't delete the submodule because the files have also
>> been added directly. I don't think it is built to handle this
>> scenario. Here is the series of commands I ran to "integrate" the
>> submodule (replace the submodule with a directory containing the exact
>> contents of the submodule itself):
>>
>> #!/usr/bin/env bash
>> mv "$1" "${1}_"
>> git submodule deinit "$1"
>
> This removes the submodule entries from .git/config
> (and it would remove the contents of that submodule, but they are moved)
>
>> git rm "$1"
>
> Removing the git link here.
>
> So we still have the entries in the .gitmodules file there.
> Maybe add:
>
>     name=$(git submodule-helper name $1)
>     git config -f .gitmodules --unset submodule.$name.*
>     git add .gitmodules
>
> ? (Could be optional)

Actually I verified that it seems `git rm` is specialized for
submodules somewhere, because when I run that command on a submodule
the relevant entries in the .gitmodules file are removed. I did not
have to do this as a separate step.

>> mv "${1}_" "$1"
>> git add "$1/**"
>
> Moving back into place and adding all files in there.
>
>>
>> The above script is named git-integrate-submodule, I run it like so:
>>
>> $ git integrate-submodule foo
>>
>> Then I do:
>>
>> $ git commit -m 'Integrated foo submodule'
>>
>> Is there any way to make this work nicely?
>
> I think you can just remove the gitlink from the index and not from the working
> tree ("git rm --cached $1")

What is the goal of doing it this way? What does this simplify?

>> The only solution I've
>> found is to obviously rename the directory before adding the physical
>> files, for example name it foo1. Because they're different, they never
>> "clash".
>
> Also look at the difference between plumbing and porcelain commands[1],
> as plumbing is more stable than the porcelain, so it will be easier to maintain
> this script.

Which plumbing commands did you have in mind?

> I think this would be an actually reasonable feature, which Git itself
> could support via "git submodule [de]integrate", but then we'd also want
> to see the reverse, i.e. take a sub directory and make it a submodule.

Integrating this as a feature might be fine, I think when you bring up
the question of retaining history makes things much harder.
Fortunately for me that is not a requirement in this case, so I'm able
to do things with much less effort.

However the primary purpose of my post was to find out how to
integrate the submodule without the error on next pull by other
collaborators of my repository. It's a real pain to recover your
working copy when going inbetween commits where the submodule
integration happened inbetween them. I did quote the exact error
message I got in my original post.

Do you have any info on how I can prevent that error? Ideally I want
the integration to go smoothly and transparently, not just for the
person doing the actual transition (me) but for everyone else that
gets those changes from upstream. They should not even notice that it
happened (i.e. no failed commands, awkward behavior, or manual steps).
