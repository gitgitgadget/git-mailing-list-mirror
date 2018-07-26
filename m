Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93641F597
	for <e@80x24.org>; Thu, 26 Jul 2018 21:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbeGZW1v (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 18:27:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45606 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeGZW1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 18:27:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id y5-v6so3043345qti.12
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QBHsQ5cyVroXRqdJJ28+8+X6M+f+Yo6wsAsc1SQMIvE=;
        b=HBwPcZNokjZBrye23Cy8WITEm8Mtp2GZzMNgl2p//1wg+SxXq4SAHuzLAKrrzbm6UU
         vvGkBJibDXpeLHRXsGg1e11cocvSFiOR1rjAmSf644cz0FOeG8ZN+ckTA1sbfXtEEmVS
         7SR0JxVa0emxUFi0D0l3dj75g1AHL7ceaHugw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QBHsQ5cyVroXRqdJJ28+8+X6M+f+Yo6wsAsc1SQMIvE=;
        b=Nsvf+OESwVQmWbdiI363TEPAE4PvX1HyFqR9M57+D6UwAxQZp/3ja6T/sa81adapXb
         o7nedrPMUOURLG8eOShxZQ6YdbymlkI6ZvqDcn6gMWPJTS6JQywbs2jQuL32l6upiAbZ
         cDW6opVbvEYrjevSRszqHic4pyO2wZYuvMxoiwfQnG74K+Fq3tQSXAKlFJmspDbdOD/9
         0w2+huzmgRcpfw8smf27f5Uv5eoHgsE8hLXBwD9y8Rf9JOl623ksmzIV0M1prqPJifkA
         C+w/8iDffIMXYoHHnzmoMLnh2GImPXXRdMGE9ZmqV6GoNFb5Saq4DiJUM3CIdHyDkWsb
         hqfA==
X-Gm-Message-State: AOUpUlE0tMW8MbpLQYAekz7BgsEstOHgpxbS6wSL6sL7Mq/7NaOmESDw
        TROxh+d5QeOpmsC40IIcqTxxUqdqHCyeswBcJEfMdpq/twMULA==
X-Google-Smtp-Source: AAOMgpffAHUgzNjo2048AbN3jHPS3EEf9BHHedlX4938PYX8elc3V5uT+z80+elW7yFndmHGzf2OJcWUeyUOJ5S+ZCg=
X-Received: by 2002:ac8:37b4:: with SMTP id d49-v6mr3633247qtc.369.1532639354061;
 Thu, 26 Jul 2018 14:09:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3763:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 14:09:13
 -0700 (PDT)
In-Reply-To: <CAPig+cQ80DrYJjYgJEvfcpeNEscgNBvj7ydwxMMVRf6kBfpaqQ@mail.gmail.com>
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <20180725134345.8631-1-chenbin.sh@gmail.com> <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
 <CAAE-R+_BWJAB3zsZUZ+=Zn6SiSkzrWG0EYwBF_OcX_V+2idCww@mail.gmail.com> <CAPig+cQ80DrYJjYgJEvfcpeNEscgNBvj7ydwxMMVRf6kBfpaqQ@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 26 Jul 2018 22:09:13 +0100
Message-ID: <CAE5ih7-DatojdaOYZSEKfgG+FeR9+CWiEcf0veHfz89W7Vhx=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     bin chen <chenbin.sh@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 July 2018 at 10:21, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 25, 2018 at 10:08 PM chen bin <chenbin.sh@gmail.com> wrote:
>> The hook does not receive any information or input from git. The
>> original requirement
>> comes from my colleague. He want to run unit test automatically before
>> submitting code
>> to remote repository. Or else CI server will send the blame mail to the manager.
>
> Okay, that seems in line with a hook such as pre-commit. Please do
> update the documentation to mention that the hook takes no arguments
> and nothing on standard input, and perhaps describe in the
> documentation an example use-case (as you did here).
>
> I'm not a p4 or git-p4 user, but, out of curiosity, would there be any
> information which could be supplied to the hook as arguments or
> standard input (or both) which would help the hook author implement
> the hook more easily? Perhaps such information would be fodder for a
> future enhancement (not necessarily needed for this patch).


I tried to think of a use-case for a hook requiring any more
information, but I can't think of any. You're already chdir()'d to the
P4 shadow repo which is what you really need.

Anything where you just need the commit hash (e.g. checking the commit
message) can already be done with one of the existing git hooks; I
don't think git-p4 needs to duplicate that.

And we can't write a commit hook that can know about the Perforce
changelist, because we don't know what it is yet.

However, looking at the code, it runs the hook at the point just
*before* the changes are applied to the P4 shadow repo. Would it make
more sense to run the hook *after* they have been applied (but before
being P4 submitted) ?

That way you can run your tests on the checked-out P4 shadow directory
with your changes - as it stands, you can only run them on your git
repo at this point, which might not be in sync with Perforce (and
could be quite a long way out in fact).

Luke


>
>> The hook actually stops the submit process from start instead of abort
>> submit in midway.
>> So nothing is touched when hook exits with status 1.
>
> This might be a good thing to add to the documentation, as well.
>
>> I'm not sure whether `git-p4` should print some "hook rejection" message.
>> Current implementation is same as other hooks (`pre-commit`, for example).
>> Only hook itself is responsible to print error messages.
>>
>> Personally I don't have opinion whether we should print out hook
>> related message inside
>> `git-p4.py`. I just try to following existing convention of git.
>>
>> What you guys think?
>
> Following existing practice makes sense. It can always be revisited
> later if needed.
>
> Thanks.
