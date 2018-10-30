Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC631F453
	for <e@80x24.org>; Tue, 30 Oct 2018 10:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJ3TEA (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:04:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50540 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJ3TD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:03:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2-v6so7292134wmb.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gEPVC1pdP7TZCYL+Au+9Rd84o2o59A4p7w6XM/58fjA=;
        b=j6o8Su660QXOVJ4JjX9Oaezu49RDDAX0UDZEFPWVWQqEDwyTB77bb4tLuiyhdA6Wm+
         3x5vbNBJJY2xAKgZz5ol97jTgDaiYjt/dL+jsh5CKOwsU9uzrWAxHg+rxnSVPVbMxXsQ
         ohEO4KokGfoouVuZJJQ0+rqGJXSM+EkXlkQ2Dmh74pxeXGyvbc45BzA6XyftI6jWW/TA
         yR9yXE180qMOllGcJlAYfJYsQ/+wRvtwmB6VwXJBW/JmKU73A6hvP3ya60k0A9xM+9W1
         dtiLeO9f/iCanwtipIFNMIV/a5ImVOKh+qjHuBed6VxT2aQF5q9VNRJcvOJU6QKyUOL4
         Gs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gEPVC1pdP7TZCYL+Au+9Rd84o2o59A4p7w6XM/58fjA=;
        b=p8sEhcG3ugy2vRCXGiwtDMEMzOEJKD3CQlAEnfh3CHWZNh08Up5ZSjmu40+x2f/I/F
         ERsdc05xCiXLH4qSlzdJEBKGeJiZ5ZkHg/oQCIqeldpj9nM+hAWFUYzhySY2TG+p3nw7
         ALmckKildAS44HFWqiF0/Zrst4oxGN9dzRflFN179Nfx1YQhkZbpivvHhyvJkh13jM+i
         o/a5nRxTWX0/XouEZkUadZUo6dCjZOTGKJpJLW0AILiDSEAgnfHma0vj0MOHUYMUvCau
         yVQVv5IoTFtUG3jPr2Pu5BfJUZtIkE8sUa6yr4eIhlvDor2yED5nnehgzY0ivaaJaIGt
         x6ow==
X-Gm-Message-State: AGRZ1gLCEu9Jz4Drloen6DQJITQcnhx6ZlA0dh3HK9seqcFwIYPqLNFD
        LuOHbTnRwNr3curfOk9gRRY=
X-Google-Smtp-Source: AJdET5emqcodM1pkg3UIIe7pycA2lapQJQ0bMpQT/cpbNeplKNxH0D7enT00VPTb8ncM3mRLz43YkQ==
X-Received: by 2002:a1c:c40a:: with SMTP id u10-v6mr1191891wmf.30.1540894268749;
        Tue, 30 Oct 2018 03:11:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n1-v6sm5736542wra.59.2018.10.30.03.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:11:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com,
        f.francet@hotmail.com
Subject: Re: [RFC PATCH] remote: add --fetch option to git remote set-url
References: <1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com>
        <xmqqftwp47nb.fsf@gitster-ct.c.googlers.com>
        <20181030075653.GA4114@archbookpro.localdomain>
Date:   Tue, 30 Oct 2018 19:11:06 +0900
In-Reply-To: <20181030075653.GA4114@archbookpro.localdomain> (Denton Liu's
        message of "Tue, 30 Oct 2018 03:56:53 -0400")
Message-ID: <xmqq8t2f218l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Mon, Oct 29, 2018 at 02:57:28PM +0900, Junio C Hamano wrote:
> ...
>> Earlier you had a check like this:
>> 
>> > +	if (push_mode && fetch_mode)
>> > +		die(_("--push --fetch doesn't make sense"));
>> 
>> If a request to "--fetch" is ignored when "--add" is given, for
>> example, shouldn't the combination also be diagnosed as "not making
>> sense, we'd ignore your wish to use the --fetch option"?  Similarly
>> for the case where there already is pushurl defined for the remote.

Clarification.  Here I am suggesting that a part of the logic in the
earlier assignment to move_fetch_to_push should become a similar
call to die(), detecting a competing and unsatisfiable wish, rather
than getting silently ignored.

>> This is a different tangent on the same line, but it could be that
>> the user wants to have two (or more) pushURLs because the user wants
>> to push to two remotes at the same time with "git push this-remote",
>> so silently ignoring "--force" may not be the right thing in the

Correction.  s/--force/--fetch/ was what I meant here.

>> first place.  We may instead need to make the value of URL to an
>> extra pushURL entry (if we had one, we now have two).

Also, additionally, since there is no use to have two or more URL,
because unlike "git push $there" that can push to two places,
fetching from two places into the same set of remote-tracking
branches would not make sense, --move-pushURL-to-URL-and-set-pushURL
operation that is the symmetry of what the patch under discussion
proposes should fail instead of creating an extra URL entry, breaking
an apparent symmetry.

> Perhaps I should motivate the use-case for this option. There have been
> times when I've had the URL set to something but no pushURL. I've
> wanted to only change the fetching URL and keep the pushing URL the same

URL (plus optionally pushURL) split was done because most everybody
were fetching from and pushing to the same place; it would not have
made any sense to have fetchURL and pushURL that are separate, as
that would have forced everybody to have both, when majority of the
users would have to set them to the same value.

Quite honestly, tweaking URL and/or pushURL is not something you'd
do every three months or more frequently, so I do not particularly
feel sympathetic to the cause of this patch, which would allow
setting one to the value that happens to be set to the other one
while setting an arbitrary new value to the other one.  Once the
user's need deviates from that single niche pattern, the user needs
to update both, and setting these two independently is quite simple
and straight-forward in the first place.  And that same simple pattern
to set two independently can be used without learning this new option.

> My implementation of --fetch is supposed to emulate what would happen if
> git were implemented with fetchurl/pushurl instead. Does the patch make
> more sense in this context?

Hmph.  As a system that has fetchURL and pushURL independently and
forces everybody to set both does not make much sense in the first
place, the patch making sense in that context is not a very strong
reason to support it.

> Please let me know if you think that the concept behind this patch is a
> good idea. Thanks!

If I don't then I do not have to let you know, then ;-) 

I do not particularly think it is a horrible idea, but I do not see
that it would be a feature that helps particuarly wide audience.
