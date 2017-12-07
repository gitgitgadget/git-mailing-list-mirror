Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8124620C33
	for <e@80x24.org>; Thu,  7 Dec 2017 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755617AbdLGRDG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 12:03:06 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:44255 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755488AbdLGRDD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 12:03:03 -0500
Received: by mail-it0-f52.google.com with SMTP id b5so16380912itc.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcegraph.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q7E6t28yYFwNWQn6DNdlFd+KeZmFGcLmDN6AWlSIPLk=;
        b=cXvwqLuiPr1tS1SbDTWirlqOJOn2PpJcF08eAPdF1UDGXvaNRB8UtACByLLR7pVB05
         WLNH7h3A5J3RaMo/vnrskis96HJ7RRWKGayS3+Aii4wvU1sMnh4n9MtsMIDQPJUbPjAM
         cmYz5SxTbCt48jlsmRNEXVyLiNv16gY8nLDVbns+Qlrl0gaiLylgSlmVv0oLU+F4DZtd
         fmvpC2KqwLrqpx9xUjaZI/yUMmdFZjMMvB2qxbBFwsp0p89TeLfBhWr6d6m/DqM99z68
         eRKtvj9yayRIZBv7acpFT4UYl7GqQhWWSpTTM+7C4k9Hy8+BAvGyZhf+p5L0C3dDl8oM
         NeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q7E6t28yYFwNWQn6DNdlFd+KeZmFGcLmDN6AWlSIPLk=;
        b=NbJf6veJU9OM6n6drj5hwI1dC45pUDqQzsOXp30n1aodPB3VHM7SkFSpXgM2P94sA1
         cYLPMNfNcufDYBcjbzj+TF+KO9n1ESQZX2by0UJ0D8sve9E6JLq+vQpK06jGJaUzeew0
         Ur8bXHnAoXrw1j9PP+w5h3QfCiFqb2shd2hy5wUM8UQImfDlBoZWmyuuhvtffC4e6p39
         GpFcfv6umPR7q09i9OEdXQSTjJGHnn2Axw0J2owlmAzZAD85spqyeKZea5DEHSHVjydE
         Gwnnj+vXErfkj58gGbvWJgYB7OujAo7nkGUWC79DTGCbPvUtXQMclNVg92681yJ/tRA0
         QzMA==
X-Gm-Message-State: AKGB3mIdm+QfnnKlhDA6NFmH+jyxFlVdPFUFWsecKRego9Xml/4KRVZ5
        DSELcnZoU0dpbsuOKiqxoQUPXdCy6qMDJLAuw7XexA==
X-Google-Smtp-Source: AGs4zMZMhIPiaT6Wcxt+82uTcifyrF96LFFPYNa0aRuF3/QTCZeybnr0YyvceAaN6AyZoj4nw+z1bDKGpjtEZsQIvUU=
X-Received: by 10.36.7.12 with SMTP id f12mr2043277itf.86.1512666182977; Thu,
 07 Dec 2017 09:03:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.7 with HTTP; Thu, 7 Dec 2017 09:02:42 -0800 (PST)
In-Reply-To: <CA+SQVf14g4zBP14BHEZQkyeqUE5Oqif3bUVADEwBZQTSwE=bKA@mail.gmail.com>
References: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
 <CA+SQVf24rcQ1iKAQBW0Ky7Qm8zuF3Esw8qMKvG+KCbCA-mCcfA@mail.gmail.com>
 <xmqqh8t3hiuq.fsf@gitster.mtv.corp.google.com> <CA+SQVf14g4zBP14BHEZQkyeqUE5Oqif3bUVADEwBZQTSwE=bKA@mail.gmail.com>
From:   Nick Snyder <nick@sourcegraph.com>
Date:   Thu, 7 Dec 2017 09:02:42 -0800
Message-ID: <CA+SQVf3LuYj-N9NaDPxRcADjgWK5DFbF8LM=6VhY9N0GnbxyyA@mail.gmail.com>
Subject: Re: git blame --reverse doesn't find line in HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I built from source and was unable to find a git version where this
has ever worked correctly.

I wasn't able to compile and test versions older than 1.6.1.

Confirmed not working:
2.15.1
2.13.6 (Apple Git-96)
2.0.0
1.7.0
1.6.3
1.6.2
1.6.1

I updated the https://github.com/nicksnyder/git-blame-bug with a
script to easily reproduce.

On Wed, Dec 6, 2017 at 10:00 AM, Nick Snyder <nick@sourcegraph.com> wrote:
>> Can you bisect to see when the feature stopped working as you expect?
>
> I will see if I can do that but might take some time.
>
>> It finds up to which commit each line survived without getting touched since the oldest commit in the range.
>
> Right, this is where it is failing in my case.
>
> With a history like this:
> A <- B <- C <- HEAD
>
> I have a particular line in C (HEAD) that blames to commit A.
> If I run a git blame --reverse starting at commit A for that line, it
> doesn't give me back C, it gives me back B instead.
> The line is not added/deleted/moved between B and C.
>
>
>
> On Wed, Dec 6, 2017 at 9:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nick Snyder <nick@sourcegraph.com> writes:
>>
>>> This can be reproduced on Linux and Mac. This behavior seems to be a bug.
>>
>> Can you bisect to see when the feature stopped working as you expect?
>>
>> Unlike a forward blame, where the command tries to find a commit
>> that is responsible for a line being in the final result (i.e.
>> typically, HEAD), a reverse blame is not about finding a commit
>> that is responsible for a line (that used to be in the oldest
>> commit) not being in a more recent codebase.  It finds up to which
>> commit each line survived without getting touched since the oldest
>> commit in the range.
>>
