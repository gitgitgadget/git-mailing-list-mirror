Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFBF1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfBSOcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:32:33 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22496 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBSOcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:32:32 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id w6Rggnirb6cDmw6RhgMhTd; Tue, 19 Feb 2019 14:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550586750;
        bh=+gK4E9byYbLnQ+nJfWjNdVBMjF9p9h/ZwK1RgfQTpOI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PX43bU2rRXvkwkPlYJ+tkdPAPVwyFrJM9RbqIFe/1YEURx5bPdpcnLN1DilGLux8+
         Nxeb4zXJdvmIhiqKagO1oybVDK3SiSL3S7UGk0B+/kOuh1LOULwtrkqNq2LeptRAYL
         TA37ImNy6H3WPTcG4YMPli8QyUyRPJeqcd/LypMc=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=Cal2G4jl c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=fIBDzeBUAAAA:8
 a=sJCyrCPIAAAA:20 a=Zeg_oI3sAAAA:8 a=nN7BH9HXAAAA:8 a=pGLkceISAAAA:8
 a=CN18uURzDa5ll03reCcA:9 a=QEXdDO2ut3YA:10 a=NTB7pGE4C5CSKT7LVMj_:22
 a=vNaCMWw18gC7IBXgVNBD:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --continue after solving conflicts doesn't work
 anymore
To:     =?UTF-8?Q?Sebasti=c3=a1n_Mancilla?= <smancill.m@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
 <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net>
 <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d7acf780-522d-84e6-68b8-d8d35a305588@talktalk.net>
Date:   Tue, 19 Feb 2019 14:32:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKSHdWbCmClcjSHhXZ6+mronHbUAiK+sDiNDlU3plbQA3hzN5Q4N+TewhLD8jeNPAKkZu3fJ/iMy2uHZNZZOAU9j5tje8L48Y8ZYitLS185q7+mnYW/U
 RV6yDV7h8I44ru06IPjagIu+5ZPUCVl6/XVuR1hMkr+MJouTEHsz9szY2UgWPqBhOY4GP9oENp2Rc7PPJ+CZdfE3COwb2crD1XGQ4HEUVSFBWQO6I+vA0CSm
 pa39jJUiwd+NLTcoXpybS04QXX9wP2E2msULykJopURs1CuS0N0Jy6oUg8JH7/Oa6Re98blTnpDEJmY5zV8XWC72DW9tH9e7ZctS227CQkh4T4SVBi08NKe3
 pQO5ebmv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastián

On 19/02/2019 14:03, Sebastián Mancilla wrote:
> My system is macOS Mojave 10.14.2. I normally use Git from Homebrew (currently
> Git 2.20.1).
> 
> I investigated this further, and I think I found the problem on my end.
> 
> When I actually run "git rebase --interactive <commit>" from the terminal,
> everything works fine.
> 
> But almost every time I start my rebases from inside "tig" [0], for which I
> have this mapping:
> 
>          bind main R <git rebase -i %(commit)
> 
> tig will exit after running that command, and then I normally continue working
> on the rebase from the shell. And it is when I start the rebase this way that
> "git rebase --continue" fails after solving conflicts.
> 
> Second, I have tig installed with the Nix package manager [1], which shows
> 
>          $ ~/.nix-profile/bin/tig --version
>          tig version 2.4.1
>          ncursesw version 6.1.20180127
>          readline version 6.3
> 
> So, I decided to try with tig from Homebrew, and then the problem
> doesn't happen.
> The Hombrew version of tig shows:
> 
>          $ /usr/local/bin/tig --version
>          tig version 2.4.1
>          ncurses version 5.7.20081102
>          readline version 8.0
> 
> I will keep using tig from Homebrew to avoid issues for now.
> 
> 
> In summary, the problem only happens when I start the rebase from inside tig,
> but only when tig is the version from the Nix package manager, which has
> different dependencies than the Homebrew version of tig.
> And it happens for Git 2.20.x and master. Git <= 2.19.x works fine.
> 
> 
> I also did bisect Git (I never though I would be bisecting Git itself).
> It landed in this commit: 4d010a757c (sequencer: use read_author_script(),
> 2018-10-31).
> 
> And the content of .git/rebase-merge/author-script is always the same:
> 
>          GIT_AUTHOR_NAME='Sebastián Mancilla'
>          GIT_AUTHOR_EMAIL='smancill@jlab.org'
>          GIT_AUTHOR_DATE='@1550530007 -0300
> 

Thanks for all the details, the problem is that the older version of git 
that the Nix tig uses to start the rebase creates author scripts that 
are not correctly quoted (as you can see above) and cannot be read by 
the newer version of git you were using to continue the rebase (it 
should be possible to continue the rebase with the git bundled with Nix 
tig). Anyway I'm glad the Homebrew tig is working for you. When we made 
this change and discussed whether we needed backwards compatibility I 
think we only discussed the possibility of git being upgrading while a 
rebase was stopped for conflict resolution, not the possibility of 
people having two different versions of git installed and using one to 
start a rebase and the other to continue it.

Best Wishes

Phillip

> Regards
> 
> 
> [0]: https://github.com/jonas/tig
> [1]: https://nixos.org/nix/
> 
> El mar., 19 de feb. de 2019 a la(s) 06:59, Phillip Wood
> (phillip.wood@talktalk.net) escribió:
>>
>> Dear Sebastián
>>
>> On 19/02/2019 07:22, Eric Sunshine wrote:
>>> [cc:+phillip.wood@talktalk.net]
>>
>> Thanks Eric
>>
>>> On Tue, Feb 19, 2019 at 1:45 AM Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> On Tue, Feb 19, 2019 at 5:20 AM Sebastián Mancilla <smancill.m@gmail.com> wrote:
>>>>> But since Git 2.20.x it doesn't work anymore. Now after solving the conflicts
>>>>> and running "git rebase --continue" I get this error most of the time:
>>>>>
>>>>>       error: unable to dequote value of 'GIT_AUTHOR_DATE'
>>>>
>>>> It looks like this can happen only when an "author-script" file (most
>>>> likely .git/rebase-merge/author-script)
>>
>> or it could be .git/rebase-apply/author-script depending on the options
>> passed to rebase when it started (the sequencer and am use the same code
>> for reading the author script now)
>>
>>>> is read by the sequencer
>>>> mechanism. Could you show us the content of this file on your machine?
>>>
>>> A very good suggestion considering that there have been changes
>>> recently specifically related to the parsing of GIT_AUTHOR_DATE in C
>>> code.
>>
>> That would be very helpful, without seeing that it's hard to know what
>> the problem is.
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> 

