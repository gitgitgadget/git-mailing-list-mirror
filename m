Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2FE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdARTni (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:43:38 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32969 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdARTnh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:43:37 -0500
Received: by mail-vk0-f67.google.com with SMTP id t8so1819737vke.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HNY3QqqkXUaUXkHCkL87+doCVqjy/r/jr9ohYaSNciI=;
        b=BCmOM10/HdODLgv0wyYpSsEp6ApGz6VaZ2E3cIOyhRk4+i4B/GIuE21rYD+ANeYcPZ
         hWU9DR1BvYy0DwD3mF3PYXX95HV4AA/NWO7aBTiP2IWPXqFfi7DdAJClkXQQfjXK9cjY
         NUasyWdswnuO2DuH2SI7gMWyLcfu2oihtTHaqkV49XJL47YuKzOjvz4kq3hHHLfL8A5h
         fkKU3dz9t2YeDm3E814U523CVnF07RLaU8i5Y8y3Q6FXp/58uhN5Og4ZQgflI1QgwCM5
         /0jtJ6HfZqJQldnuVljsCxdQJvy9vrVvZXPlHR8AqK4GLyBA0GqLb++1ApCV6vLmF9DK
         gJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HNY3QqqkXUaUXkHCkL87+doCVqjy/r/jr9ohYaSNciI=;
        b=GJ0Bj5Ep5bnpvDVroj8yt+nWxqmNZkzSs6RJ7HAaIyh1HikYx8OTyF1iMIVZXH3mXS
         0oRH+lCeYYy4pWTpNRMlbat+J+5xzUO/FGf0BtNx8RObLpxjRY3Ygs0pPEaD0zlNVApH
         7YNsF8NBHvauccAKD2/x+Y+jxgeQF9UINVt4GfWDbC5Sf+wzXj4Y7eUV40sW48Zj2x0K
         saSm1HJ6f/dNtdBm5JS5O11IumAoj8d3fl6SVm807mPoeAnaq0Jc0n5Tr3Bhx06XKqzF
         Nuh5cS0Khb7XqzymvWjwxe57WzGUqLQTOPWIGE5MODI2IOHdAwvXwcK5mA/zBKQpAPre
         HEHQ==
X-Gm-Message-State: AIkVDXIK7gmdG4ChDxiR3O9IBpnElsOA1eTu7FrRS9635w8TSu22Znlfz9Jvbu5g9j6iS4MGxfTeVt/TJMxAXw==
X-Received: by 10.31.115.142 with SMTP id o136mr2422059vkc.139.1484768157210;
 Wed, 18 Jan 2017 11:35:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Wed, 18 Jan 2017 11:35:16 -0800 (PST)
In-Reply-To: <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net> <alpine.DEB.2.20.1701161153340.3469@virtualbox>
 <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com> <alpine.DEB.2.20.1701181725130.3469@virtualbox>
 <38d592b8-975c-1fd9-4c42-877e34a4ab70@xiplink.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 18 Jan 2017 13:35:16 -0600
Message-ID: <CAJZjrdXwNFaZFP-asVB9kXUFp1TfRr5w1O+opVRFzxV-qQmpRg@mail.gmail.com>
Subject: Re: [RFC] stash --continue
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> At least `git stash pop --continue` would be consistent with all other
>> `--continue` options in Git that I can think of...

> Alas, I disagree!

I'm with Johannes here. "git stash" sans subcommand is pretty
explicitly defined as "git stash save", so by similar logic, "git
stash --continue", if anything, would be "git stash save --continue".

I do agree that there's a slight problem with hunting down consistency
in implementations of --continue since there aren't other usages that
involve subcommands (rebase, cp, merge) but I can't think of "git
stash" as a completely specified command, whereas I do see "git stash
pop" and "git stash apply" as completely specified.

On Wed, Jan 18, 2017 at 12:44 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 2017-01-18 11:34 AM, Johannes Schindelin wrote:
>>
>> Hi Marc,
>>
>> On Wed, 18 Jan 2017, Marc Branchaud wrote:
>>
>>> On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
>>>
>>>> On Mon, 16 Jan 2017, Stephan Beyer wrote:
>>>>
>>>>> a git-newbie-ish co-worker uses git-stash sometimes. Last time he
>>>>> used "git stash pop", he got into a merge conflict. After he
>>>>> resolved the conflict, he did not know what to do to get the
>>>>> repository into the wanted state. In his case, it was only "git add
>>>>> <resolved files>" followed by a "git reset" and a "git stash drop",
>>>>> but there may be more involved cases when your index is not clean
>>>>> before "git stash pop" and you want to have your index as before.
>>>>>
>>>>> This led to the idea to have something like "git stash
>>>>> --continue"[1]
>>>>
>>>>
>>>> More like "git stash pop --continue". Without the "pop" command, it
>>>> does not make too much sense.
>>>
>>>
>>> Why not?  git should be able to remember what stash command created the
>>> conflict.  Why should I have to?  Maybe the fire alarm goes off right
>>> when I
>>> run the stash command, and by the time I get back to it I can't remember
>>> which operation I did.  It would be nice to be able to tell git to "just
>>> finish off (or abort) the stash operation, whatever it was".
>>
>>
>> That reeks of a big potential for confusion.
>>
>> Imagine for example a total Git noob who calls `git stash list`, scrolls
>> two pages down, then hits `q` by mistake. How would you explain to that
>> user that `git stash --continue` does not continue showing the list at the
>> third page?
>
>
> Sorry, but I have trouble taking that example seriously.  It assumes such a
> level of "noobness" that the user doesn't even understand how standard
> command output paging works, not just with git but with any shell command.
>
>> Even worse: `git stash` (without arguments) defaults to the `save`
>> operation, so any user who does not read the documentation (and who does?)
>> would assume that `git stash --continue` *also* implies `save`.
>
>
> Like the first example, your user is trying to "continue" a command that is
> already complete.  It's like try to do "git rebase --continue" when there's
> no rebase operation underway.
>
> Now, maybe there is some way for "git stash save" (implied or explicit) to
> stop partway through the operation.  I can't imagine such a situation (out
> of disk space, maybe?), particularly where the user would expect "git stash
> save" to leave things in a half-finished state.  To me "git stash save"
> should be essentially all-or-nothing.
>
> However, if there were such a partial-failure scenario, then I think it
> would be perfectly reasonable for "git stash --continue" to finish the save
> operation, assuming that the failure condition has been resolved.
>
>> If that was not enough, there would still be the overall design of Git's
>> user interface. You can call it confusing, inconsistent, with a lot of
>> room for improvement, and you would be correct. But none of Git's commands
>> has a `--continue` option that remembers the latest subcommand and
>> continues that. To introduce that behavior in `git stash` would disimprove
>> the situation.
>
>
> I think it's more the case that none of the current continuable commands
> have subcommands (though I can't think of all the continuable or abortable
> operations offhand, so maybe I'm wrong).  I think we're discussing new UI
> ground here.
>
> And since the pattern is already "git foo --continue", it seems more
> consistent to me for it to be "git stash --continue" as well. Especially
> since there can be only one partially-complete stash sub-operation at one
> time (per workdir, at least).  So there's no reason to change the pattern
> just for the stash command.
>
> Think of it this way:  All the currently continuable/abortable commands put
> the repository in a shaky state, where performing certain other operations
> would be ill advised.  Attempting to start a rebase while a merge conflict
> is unresolved, for example.  IIRC, git actually tries to stop users from
> shooting their feet in this way.
>
> And so it should be for the stash operation:  If applying a stash yields a
> conflict, it has to be resolved or aborted before something like a rebase or
> merge is attempted.  It doesn't matter which stash subcommand created the
> shaky situation.
>
> In the long run, I think there's even the possibility of generic "git
> continue" and "git abort" commands, that simply continue or abort the
> current partially-complete operation, whatever it is.  (Isn't that the
> ultimate goal of all the "sequencer" work?  I admit I have not been
> following that effort.)
>
>> With every new feature, it is not enough to consider its benefits. You
>> always have to take the potential fallout into account, too.
>
>
> Agreed.
>
>> At least `git stash pop --continue` would be consistent with all other
>> `--continue` options in Git that I can think of...
>
>
> Alas, I disagree!
>
>                 M.
>
