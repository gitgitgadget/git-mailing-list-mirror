Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215C7C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 13:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiKWNKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiKWNKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 08:10:14 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572CA8517B
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 04:52:13 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g7so8477686ile.0
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 04:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=cVzeKu/iwhsrrFJnmNVK91k4+E+ljNIlazWRPZ6vQm4=;
        b=PvVUAT1Pn1ClU0kJQhk5Nm4v01Ypq2hJZG0djpj6F0rKnK+ouD67T5ZSw7FFWNIare
         131Xm8+9fNQYVwyA0fhvm6WXayTr6JeugCyYyCrJ8i/2sCOhkQXMjDZe8tqTzeOU3WOP
         p5EqJyeYdTKM7Pc7tkCyl8A47m2oJZ/5IrsIvV2f6oGTr91jyIB3ldSy0fZ9aouuEx6q
         Blnx7fy0094mnAzA9K0Lu06s5s3A8pSCyS2VHy+DxZ7lfir7A0tsOlihNoiTecSz+Wbg
         wxa5vssVaSBDge4aVxH2DIZfUyvN34exoNGaBng3SHOYXGqRfZICgLc88Fzq9hcQLSvP
         0Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVzeKu/iwhsrrFJnmNVK91k4+E+ljNIlazWRPZ6vQm4=;
        b=VJ6dOqhCen99jRWAcNsCYrdS8KCn3Z89KI79yoWZoipHyRV47IIXQEcBqn90RoGlt3
         lerr3/eRoQP64MhTQbWgKxovG7u8w2YRot/dYA4jz1sBTbuQaf7DtxxZcGyzKl8Ng2w1
         cszi/UibMi2TDbPq25RlfmFZysY9dCZRajBpZZpSO/4ul8fjLK1k/zKfrsph+PO8us6B
         9vu9CYZhtO9Jy8b02gDs6u2fTFPYhJ2F0kQcQuPYc8kfwmnLMf3vnqAtyMCo4JTBmvuQ
         QsXkRaPUrdjl+nPCARn4XsbkFiRGnrXoIIPuYsFV8fOluAkx6Q50dCQWyi6dpmjcmP2c
         nvcw==
X-Gm-Message-State: ANoB5plH3hgPzUmPBzZirQEmhCtHiTFw0qwO7VRkOscNJMAgDUkp1Lyb
        AT5ksQYy6/leMoWrBQ8jpGg=
X-Google-Smtp-Source: AA0mqf7djC/GtXbLFw2q6bxrplh+t4hqtYpOmGUp87y8/OTVQlDTnyRnn0CUORsAr9s+OcAdK5508g==
X-Received: by 2002:a05:6e02:4ad:b0:302:a706:1fd2 with SMTP id e13-20020a056e0204ad00b00302a7061fd2mr7830603ils.46.1669207932515;
        Wed, 23 Nov 2022 04:52:12 -0800 (PST)
Received: from stargate ([2620:72:0:a40:d75e:9820:e8e0:410c])
        by smtp.gmail.com with ESMTPSA id m5-20020a056e020de500b00302a1848485sm5595742ilj.63.2022.11.23.04.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:52:11 -0800 (PST)
References: <pull.1424.git.1668972017089.gitgitgadget@gmail.com>
 <xmqq1qpwwwxg.fsf@gitster.g>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <code@seanallred.com>
Subject: Re: [PATCH] var: add GIT_SEQUENCE_EDITOR variable
Date:   Wed, 23 Nov 2022 06:21:47 -0600
In-reply-to: <xmqq1qpwwwxg.fsf@gitster.g>
Message-ID: <87cz9dq1dx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:
>> Provides the same benefits to scripts as exposing GIT_EDITOR, but
>> allows distinguishing the 'sequence' editor from the 'core' editor.
>>
>> See also 44fcb4977cbae67f4698306ccfe982420ceebcbf.
>
> Why should we ;-)?

I must admit I struggled quite a bit with a useful commit message, so I
greatly appreciate the suggestion :-) I've incorporated your suggestion
for a future v2.

>> +GIT_SEQUENCE_EDITOR::
>> +    Text editor for use by Git sequencer commands. Like `GIT_EDITOR`,
>
> Do our readers know what "Git sequencer commands" are?  "rebase -i"
> of course is the primary one, but "cherry-pick" and "revert" that
> deals with multiple commits are technically "sequencer commands", as
> they also use the sequencer machinery.  But for them, the users do
> not get a chance to edit the "todo" list with their sequence editor,
> unlike "rebase -i".

That's a good point; I hadn't considered that as a potential source of
confusion -- prefering instead to future-proof the docs at the cost of
understandability :-)

> I am wondering if it is easier to understand, without losing
> technical correctness, to exactly name the command, without
> pretending as if the sequence editor is used in situations wider
> than where "rebase -i" is used, e.g.
>
> 	The text editor program used to edit the 'todo' file while
> 	running "git rebase -i".

I've incorporated your suggestion. It's possibly worth noting that I had
wanted to prefer prose ('interactive rebase') over a specific invocation
('git rebase -i'), but I see existing precedent for referring to it as
the latter in documentation (and release notes especially). I suppose
this practice is intended (either consciously or otherwise) to make it
more straightforward to cross-reference different pieces of the
documentation?

>> diff --git a/builtin/var.c b/builtin/var.c
>> index 491db274292..9a2d31dc4aa 100644
>> --- a/builtin/var.c
>> +++ b/builtin/var.c
>> @@ -19,6 +19,16 @@ static const char *editor(int flag)
>>  	return pgm;
>>  }
>>
>> +static const char *sequence_editor(int flag)
>> +{
>> +	const char *pgm = git_sequence_editor();
>> +
>> +	if (!pgm && flag & IDENT_STRICT)
>> +		die("Terminal is dumb, but EDITOR unset");
>
> I know this was copied from editor(), but the message does not make
> much sense.  It's not like the caller of read_var() is not prepared
> to see a NULL returned, so letting it return NULL would make more
> sense.  Since the ancient past back when editor() function was
> written, launch_editor() and the logic to die with "on dumb terminal
> you must specify an EDITOR" have migrated to editor.c and there is
> no strong reason to keep the corresponding die() even in editor()
> function (I do not recommend removing it as part of this topic,
> though), and adding a new one makes even less sense.

I'm glad you brought this up. To be perfectly honest, I'm not confident
I know what IDENT_STRICT is even supposed to mean -- it looks to be
undocumented in cache.h. Here's what I *think* I've been able to piece
together based on what you've said and some commit history:

    f9bc573fdaeaf8621008f3f49aaaa64869791691 suggests that setting
    IDENT_STRICT is intended to be 'more upset' about 'things' (the
    commit I mention is specifically talking about identities -- which
    explains the IDENT_* prefix) that aren't well-defined. In porcelain
    code, we want to quit immediately if there's nothing available since
    you can't really open up COMMIT_MSG, e.g., without a well-defined
    editor. Better to die early with a semi-useful message than to let
    the issue propagate downstream.

    This does not apply to git-var since the purpose of this command is
    not to invoke an editor, but to inspect configuration state via
    well-defined API. In this context, it's not necessary/appropriate to
    die early since, for the purposes of git-var, 'no configuration' is
    a perfectly valid (albeit confusing) state to be in.

I'd like to confirm this / understand more about what's going on here
before making the code change on this one. If I can understand what's
going on here well enough to write an informed commit message, I can
remove this vestigial code from editor() in a separate patch.

--
Sean Allred
