Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B211F406
	for <e@80x24.org>; Mon, 14 May 2018 19:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeENT60 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 15:58:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39581 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENT6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 15:58:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id f8-v6so17401795wmc.4
        for <git@vger.kernel.org>; Mon, 14 May 2018 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0lxB+Xew3/gidDMt6d9Z6ul9Rv1JJ55+hfrK6zsiFl8=;
        b=d9p8I0rD10msbvk7JldnLLdNYYikFlyvMfybZ/pjtw/f2i1m6ZIcHDrGPfIRRyJJc5
         csxk91fBIyCuZgTBZ5s13ge6cB8UzviTisdsVFUKxLIrnKjDpA9GSbVLU7AChxyIpFRJ
         kSplnrxav0qmDHUG1vFyKnralRo3H66dSbqy3CTiPeJJ1SAtC1VVQQakLAKnp3wk9ViH
         dCot+Fj4gML0WRSRl3ljIlcjSBj+FgA4g7MFVPkwQ4RjF4HDIjmNvVKuAiQVDfK3dIhf
         LWsCsrSYaGT/AG3gGEgqCCrx5rR0Lyh8xNTTtYMK9oliUWYloBSpYBddixcSLScPFYWx
         O9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0lxB+Xew3/gidDMt6d9Z6ul9Rv1JJ55+hfrK6zsiFl8=;
        b=nL6ecXPZn4jdl+zd8qz7Myyp9+mwrjmCxZ85K/jxiQVu/q4HUeu4AyM58MCEgvjHcb
         zf2hS8aY77alR6PdjSPBe6RPMyO2x5tBb29QUMZk4OLHGRQvfpADWK+/yHEg+quFu33c
         Y6GW84Q8Z2R4Tff/Sq34FmPR7vKH81jnV07lcuV1qp5Og+nV/FF5BoYgnkEVLTzvu7xX
         1yDqh5DRAyEe4Gv+f0HXgGgNdOSz+kA5uIU2nWd87KBSiELZhZt/xkVwA+Aq5OFVP6PR
         IRr/qEqXd6newZD2AcmQPeyQpuSBUKZVE2RmNlRaISpq3t2HIiIu9VLqBcdeLvG3He3t
         zl3w==
X-Gm-Message-State: ALKqPwfFFMfit/PuPnLKVY7Z5bI3b5qF9bhXbvidQVFwUpvjcfkharTE
        whSU/He1ghxyKxCY2h/fzr6Sow==
X-Google-Smtp-Source: AB8JxZr6br6XdLWKSBHgR4+ExnbSJhDg00/OXUyvjuIqQUuNHJYRv2I+Pg0wQm4eXD5Pwmxo8pRmRw==
X-Received: by 2002:a1c:16ca:: with SMTP id 193-v6mr5806021wmw.37.1526327903377;
        Mon, 14 May 2018 12:58:23 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:6c22:aed3:f6e9:6f89? ([2001:a62:81d:ab01:6c22:aed3:f6e9:6f89])
        by smtp.googlemail.com with ESMTPSA id a13-v6sm11036404wrn.6.2018.05.14.12.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 12:58:22 -0700 (PDT)
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
 <ef3709f1-d9c2-860a-23d3-8d496294e1ac@gmail.com>
 <CACsJy8CwwseqL9M=-ML6hwgHG_GSK6pfeQU+MGWsx6=WCCZtmQ@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <bda62b25-a569-9199-5973-2ea7b223ed5d@gmail.com>
Date:   Mon, 14 May 2018 21:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CwwseqL9M=-ML6hwgHG_GSK6pfeQU+MGWsx6=WCCZtmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.05.2018 um 19:26 schrieb Duy Nguyen:
> On Mon, May 14, 2018 at 7:03 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Am 08.05.2018 um 17:24 schrieb Duy Nguyen:
>>> On Mon, Apr 23, 2018 at 7:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> I haven't looked at the implementation, so this may be an entirely
>>>> stupid suggestion, but would it be possible to instead render the
>>>> completions as?
>>>>
>>>>     % git checkout --<tab>
>>>>     --[no-]conflict=                   --[no-]patch
>>>>     --[no-]detach                      --[no-]progress
>>>>     --[no-]ignore-other-worktrees      --[no-]quiet
>>>>     --[no-]ignore-skip-worktree-bits   --[no-]recurse-submodules
>>>>     --[no-]merge                       --theirs
>>>>     --[no-]orphan=                     --[no-]track
>>>>     --ours
>>>>
>>>> This would address the problem of the --no-* options taking double the
>>>> screen space.
>>>
>>> It took me so long to reply partly because I remember seeing some guy
>>> doing clever trick with tab completion that also shows a short help
>>> text in addition to the complete words. I could not find that again
>>> and from my reading (also internet searching) it's probably not
>>> possible to do this without trickery.
>>
>> The fish-shell does something like that.
>>
>>     > git status --<tab here>
>>     --branch  (Show the branch and tracking info even in short-format)
>>     --help                       (Display the manual of a git command)
>>     --ignore-submodules                 (Ignore changes to submodules)
>>     --porcelain    (Give the output in a stable, easy-to-parse format)
>>     --short                      (Give the output in the short-format)
>>     --untracked-files              (The untracked files handling mode)
>>
>> Another tab will put a selection-cursor on the displayed list - you can
>> navigate that list with Cursor-Up/Cursor-Down, select an entry and that
>> entry will be inserted into the commandline. That selection process
>> would be useless if the options are presented as "--[no-]x" because THAT
>> cannot be inserted into the commandline without manual editing. And
>> that's the point of the fast option selection process.
> 
> Good to know.
> 
> BTW I looked at the git.fish completion script [1] and see that recent
> effort to help automate more in git-completion.bash might help there
> too. I notice a lot of options and help text hard coded there, if
> someone can explain to me how git.fish uses those, maybe I can change
> git to export something suitable for git.fish to use too [2].

I'm no expert, but some additional things required by fish (and I
suppose zsh too) but not by bash:

- grouping of long and short options
- help text
- argument types for options

Help text and long/short option grouping look like this:

    > git rebase -<tab>
    --force-rebase  -f                                (Force the rebase)
    --merge  -m                       (Use merging strategies to rebase)

All these infos seem to be available in `struct option` (for C stuff
at least). So I guess It would be easiest for Fish & Co if git just
exports the complete info in some stable format.

> 
> For example with latest git (in 'master') doing this
> 
>     ./git add --git-completion-helper
> 
> gives you the list of all options of "git add". Giving the help text
> for each option is definitely possible (I just didn't see any use for
> it until I looked at zsh/fish completion scripts) and maybe more in
> the future.
> 
> [1] https://github.com/fish-shell/fish-shell/blob/master/share/completions/git.fish
> [2] But then if your script has to work with old git versions too then
> this is a moot point.

Well, sooner or later those old git versions might not be supported by
those shells exactly due to the involved maintenance overhead. So
providing some helper is a step in the right direction. Not providing
only fossilizes the current state.
