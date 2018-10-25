Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2461F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeJYNP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 09:15:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39520 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJYNP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 09:15:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so6869891wrv.6
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JUnJ76AI59evh0xTMYRTfxBoemU43mmMADUhCPPoQYo=;
        b=Fc9nm15z0PL27GiC77Z2ccdp4X10nMocnjJF1arlwgETBbigOIU0FJI5e6uI51o+jZ
         5gdppIMTXAx1HoacPH1Revhh+ozwzDyfwatE0jUIK62kjxYYWTG7LWL2L1Dhlxl5QhBY
         ireNjXpwdseig/bjuciW8ge2kQnkTyC3OLGrHKHP0/Oo4Q4Ky0di9oWyxruiQl1GVLZ9
         lUgUy2/EJkMRnKetr4lSJJh3ULg0T9lq07NbnTD2i+q90Qc7VLcWdJkaFOQqmr8ruuBQ
         g5OXzU3Hyf1hofXDT4YVRVMtgb7XzO7em7vG096XK6N7IT5vFNipphoepG9x8lFTieMs
         SCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JUnJ76AI59evh0xTMYRTfxBoemU43mmMADUhCPPoQYo=;
        b=RoeVFBZvA/GecXRTeP7EU/lCCfcmeczxRbitWs7hQBkzEhTJUX6rUNKs7b7BRCQXr+
         ytpX6O+Wwcb75JbA/NBUDug2YmdMfPtnLXMNq2DH2Cw8Vc9kQIF7q5+H7xbeKWUPPTtA
         R+lci79xswz1AjWzWI9FbUwNf1Ikjd3YKovj/6Mjf+CohCGOo4t9thpmvIteKbMabfaN
         BKD1vJrSxC/8j9xftPRVw7cmR+Xu5go1nrEGQcV+XZQimbvujpI0AKxQz4+0vvIXVtrL
         ZXXEMKhE15muHsjSc7T6CFjrrS4pZsafo0XZxXZwxIssVNyx9t2ljyWsO2iSzF0znaKx
         wT7A==
X-Gm-Message-State: AGRZ1gJW+ct4xiy7e4SIZip1XceHIMQNCHAYSHlCJ931IR2Vh1+1+s0G
        sw3i4abnWbRAOjjv/IY8+fs=
X-Google-Smtp-Source: AJdET5cCkZ9UgGeLSeeCD7bxjDBFi6BdwfTsaZVeqr6Hs3A0mIv+ql5w5Yq9jI8M0EP2c3YbHupUCg==
X-Received: by 2002:a5d:608e:: with SMTP id w14-v6mr29806wrt.193.1540442665780;
        Wed, 24 Oct 2018 21:44:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o17-v6sm7078385wro.2.2018.10.24.21.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:44:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica <slavicadj.ip2018@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        slawica92@hotmail.com
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
References: <20181023162941.3840-1-slawica92@hotmail.com>
        <CAP8UFD35aOb5weDcDVFth96e+H-as_Q9bLPuCpSDReKJERnM7Q@mail.gmail.com>
        <45cf8bf9-adfa-655e-0ded-fdb71707f7ad@gmail.com>
Date:   Thu, 25 Oct 2018 13:44:23 +0900
In-Reply-To: <45cf8bf9-adfa-655e-0ded-fdb71707f7ad@gmail.com> (Slavica's
        message of "Wed, 24 Oct 2018 15:56:06 +0200")
Message-ID: <xmqqy3amk53s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica <slavicadj.ip2018@gmail.com> writes:

> On 23-Oct-18 8:52 PM, Christian Couder wrote:
>> On Tue, Oct 23, 2018 at 6:35 PM Slavica <slavicadj.ip2018@gmail.com> wrote:
>>> This is part of enhancement request that ask for `git stash` to work even if `user.name` is not configured.
>>> The issue is discussed here: https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.
>> We prefer commit messages that contain as much as possible all the
>> information necessary to understand the patch without links to other
>> places.
>>
>> It seems that only this email from you reached me. Did you send other
>> emails for patches 2/3 and 3/3?
>>
>> [...]
>
> Okay, I will change that. This is my first patch and I am still adapting.
>
> Emails for patches 2/3 and 3/3 because aren't there because I am still
> preparing them.
>
> (I didn't know if I had 3 patches in plan that they should be sent at
> almost the same time.)

It is more efficient for everybody involved.

 - You may discover that 1/3 you just (thought) finished was not
   sufficient while working on 2/3 and 3/3, and by the time you are
   pretty close to finishing 2/3 and 3/3, you may want to update 1/3
   in a big way.  Sending a premature version and having others to
   review is wasting everbody's time.

 - Your 1/3 might become perfect alone with help from others'
   reviews and your updates, but after that everybody may forget
   about it when you are ready to send out 2/3 and 3/3; if these
   three are truly related patches in a single topic, you would want
   to have what 1/3 did fresh in your reviewers' minds.  You'd have
   to find the old message of 1/3 and make 2/3 and 3/3 responses to
   it to keep them properly threaded (which may take your time), and
   reviewers need to refresh their memory by going back to 1/3
   before reviewing 2/3 and 3/3

One thing I learned twice while working in this project is that open
source development is not a race to produce and show your product as
quickly as possible.

When I was an individual contributor, the project was young and
there were many people with good and competing ideas working to
achieve more-or-less the same goal.  It felt like a competition
to get *MY* version of the vision, design and implementation over
others' adopted and one way to stay in the competition was to send
things as quickly as possible.  I didn't know better, and I think I
ended up wasting many people's time that way.

That changed when I became the maintainer, as (1) I no longer had to
race with anybody ;-), and (2) I introduced the 'pu' (proposed
update) system so that anything that was queued early can be
discarded and replaced when a better thing come within a reasonable
timeframe.

And then I re-learned the same "this is not a race" lesson a couple
of years ago, when I started working in a timezone several hours
away from the most active participants for a few months at a time.
I do not have to respond to a message I see on the list immediately,
as it is too late to catch the sender who is already in bed ;-)


So take your time and make sure what you are sending out can be
reviewed the most efficiently.  Completing 2/3 and 3/3 before
sending 1/3 out to avoid having to redo 1/3 and avoid having
reviewers to spend their time piecemeal is one thing.  Making sure
that the patch does not have style issues that distract reviewers'
attention is another.

Sitting on what you think you have completed for a few days allows
you to review your product with fresh eyes before sending them out,
which is another benefit of trying not to rush.


