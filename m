Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8476D20248
	for <e@80x24.org>; Sun, 14 Apr 2019 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfDNNYg (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 09:24:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36297 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNNYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 09:24:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so18220794wrd.3
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x+Q1qdXJ6jujMw1CiJpPb/s9fWJDLcY9DJ8llAFxNq0=;
        b=oK5R52mkpGyhbGBKl+kcCOL6YkdepUu0VtU0xUJh4HdN6z3AnnMxIPA1fMYIxgoQ0j
         2FwNpaa/oLuUAf1lUQ8mJ7cm2QtqTDDFiNebIR+/A5oj+tMWV6UFTp5PUzIj4rTqlhVC
         iAVKhdIufiEdZx2qKT2sslLgBEHHm1hR8ORry3kpHHmH/qznAkuOTX43TpAvYFYTuevX
         l4OCYocvdZdcxS0NzhI38Cs4LPbMCSHpqBdmdAUohAZr3jb4CO+q+YC6H289PYPPQZDI
         8F/e/qlfQyQTzejvaD8lxAZuivwZUbggA0WWGAQNsQ5LU+Vn2D3LhSReCfF1a2onBKkO
         WgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x+Q1qdXJ6jujMw1CiJpPb/s9fWJDLcY9DJ8llAFxNq0=;
        b=lXjvJu8IGf4pI4Epzs9Xch4Ami0XmlLJ93JdqbMbLJUu/U2P0UBnec4IWopP6akmmf
         a/f5+TARD7itI5gnaFwAbOVmS8vuB2hel2VoMYqFfrWV5ajgDQOBDtRVxtfRE3vRxxOc
         zS0qEMCeTzpfflJZ8SGs9C3sc7fjRdPgLNchTVUxYqSraSYdZuL5wifvHOZ5zILDTF8y
         yi5I1jIXO/1HUFZOolX1YvIh6pO/bxPb1xmeP68lV4rQyo4lfjLNQGHTpGvFwaQmPmnX
         Hbkk6o49977JHOoWgdjzhzLBebLVI7IvqpSbJh9nlGcwA8/AJGyaSANDe7T5kboFc+xv
         35tg==
X-Gm-Message-State: APjAAAXtjl2VaRgF7M5h6HBkZIPGUNB96jFKA6EF8e5tRXJ9DAzm81Qh
        HgwykL+RhdW98dTSeXDomUlGknRi
X-Google-Smtp-Source: APXvYqzL8P1uBbGt0ubLiUv7ewKQoXAKsj5mGEzSFqx6UI0AHL7WBTbIWV7zQvmQ0MXsvy83ffvvsQ==
X-Received: by 2002:adf:e443:: with SMTP id t3mr16601321wrm.257.1555248273875;
        Sun, 14 Apr 2019 06:24:33 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id g10sm40552336wrq.2.2019.04.14.06.24.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 06:24:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     wh <microrffr@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
 <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
 <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a3c544e2-2087-1877-38e3-c85651db32f5@gmail.com>
Date:   Sun, 14 Apr 2019 14:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/04/2019 02:59, wh wrote:
> Thanks for the info about the upcoming "precious" attribute. Looks useful.

Hmm, unfortunately it's not looking so hopeful now [1]

> I didn't get the impression that Git normally overwrites ignored
> files. I ran some more experiments:
> 
> git rebase FETCH_HEAD        # bails
> git rebase -i FETCH_HEAD     # overwrites
> git merge FETCH_HEAD         # bails
> git reset --keep FETCH_HEAD  # bails
> git reset --merge FETCH_HEAD # bails
> git checkout FETCH_HEAD      # overwrites
> # without feature 2 locally:
> git merge FETCH_HEAD         # overwrites, fast-forwards
> git merge --no-ff FETCH_HEAD # bails

Thanks for sharing that, I was assuming the other commands behaved like 
checkout, I'm intrigued that merge behaves differently to rebase -i as 
they use the same underlying machinery, I'm a bit snowed under at the 
moment but I'll try and take a look at what's going sometime in the not 
too distant future.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie2xtfc9w@mail.gmail.com/T/#u
> On Fri, Apr 12, 2019 at 9:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi
>>
>> On 12/04/2019 00:56, wh wrote:
>>> I'm using git 2.20.1 from Debian. Git is usually careful not to
>>> overwrite untracked files, including ignored files.
>>
>> Git normally overwrites ignored files, so I think in your example rebase
>> -i is working as expected, I'm surprised that the am based rebase does
>> not overwrite the ignored file. There has been some discussion about
>> introducing 'precious' files that are ignored but protected in the same
>> way as untracked files [1].
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] https://public-inbox.org/git/20190409102649.22115-1-pclouds@gmail.com/
>>
>>    But interactive
>>> rebase doesn't detect this (non-interactive rebase works fine).
>>>
>>> Reproduction:
>>> -----
>>>
>>> #!/bin/sh
>>> mkdir upstream
>>> cd upstream
>>> git init
>>> echo 1 >feature-1
>>> git add feature-1
>>> git commit -m "feature 1"
>>>
>>> cd ..
>>> git clone upstream local
>>> cd local
>>> # write some tools for our own convenience
>>> echo ours >tools
>>> echo /tools >>.git/info/exclude
>>> # start working on a feature
>>> git checkout -b f2
>>> echo wip >feature-2
>>> git add feature-2
>>> git commit -m "wip"
>>>
>>> cd ../upstream
>>> # official tools are available
>>> echo theirs >tools
>>> git add tools
>>> git commit -m "tools"
>>>
>>> cd ../local
>>> git fetch ../upstream master
>>>
>>> # this would be okay
>>> #git rebase FETCH_HEAD
>>>
>>> # problem: overwrites tools silently
>>> GIT_EDITOR=true git rebase -i FETCH_HEAD
>>>
>>> cat tools
>>>
>>> -----
>>>
>>> Expected: `git rebase -i` fails because it would have to overwrite the
>>> untracked "tools" file. Contents of tools file remains `ours`.
>>>
>>> Actual: Contents of tools file becomes `theirs`.
>>>
