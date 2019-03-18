Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B1220248
	for <e@80x24.org>; Mon, 18 Mar 2019 05:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfCRF1d (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 01:27:33 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36041 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRF1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 01:27:33 -0400
Received: by mail-wm1-f53.google.com with SMTP id h18so2873123wml.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0vj8P8bTeFSUjY0OyHy/WEK0sFM/dywMUOHHBQF7Isk=;
        b=vJzyyq7FwIAv2+oNhU0jOpq67+7H+12pbRwGfNv1so+rdYHr49UpfBZ89CTWl5ytPG
         riiNyoGMRHGAW3yyFXKGKYkJIgFUe2uEodF+VLgGYz4euCtrvVxtZV9zMft/rmf7tVXU
         T6wjtUJCCpYMzAdTVG9zLvad54d4sLN47sO83KZvKL9fJLjF57kw3NxavcFE1lsXBBkh
         wRg/kWXPkiOEXJYaugjYSS6v/u7z8QXiTDhT5hGnGJ0XGe/wLzqjDnbRzgrw3406uF6Y
         kYA2/ZDIGuPEKDznyelC+JAnQU7NX9MUxivziIfngDT9nzqQBAWTwQViUpOmz72ZzD8j
         +bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0vj8P8bTeFSUjY0OyHy/WEK0sFM/dywMUOHHBQF7Isk=;
        b=t0OojZLQ0s6V5khPK830FzDCD/pky+TqegVGg/E3vWkKUPwQhbIpEfbWVH0U4lJaWz
         N0/+wjg2Syequ55AWOhBUKu7RX5hLtw8SdIQk9tMmTlUTl9FuRD70zDirrKasvX7A+yW
         bVk+lfdlqCEpJw4uzVjIqid8osAmd4BOb3awZWlstSZat1yROFFbZjbowMas6gRhWOSp
         acmiRAvMeWPYsUAmv47xAgxO24rV+keIMJlnDz1dMjBh6G4LZ3F2l0zfGLVegmqrElKp
         lLFU5oUduO11QdT4n7UB89wEj7KJK17ZSivHu/lZmT9WwRfyarVnTXeDmFN+6vdQs46M
         h5aA==
X-Gm-Message-State: APjAAAXhznrGPDgrsTi5zSzD5dPe0C3NBBOE7JvjG5e9Dxc4zdV9kzNw
        1oOCOAtspJx4J6bqpV52Ke8=
X-Google-Smtp-Source: APXvYqzUkJsBbsN5phT5jNkepcUuldB+d95to3sGqolgMpNbWIyTN6gS9RoFrsKaTHZ3gL1JMio7MQ==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr9229539wmb.48.1552886851141;
        Sun, 17 Mar 2019 22:27:31 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f20sm25086309wrg.91.2019.03.17.22.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 22:27:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Shorthand for "$(git merge-base A B)"
References: <CAJdN7KiS+6y0a3sj0yuGuJ+URJe0SBJJTRg2ZpA2upN2rwZXCA@mail.gmail.com>
        <20190315212312.GA51592@google.com>
Date:   Mon, 18 Mar 2019 14:27:29 +0900
In-Reply-To: <20190315212312.GA51592@google.com> (Jonathan Nieder's message of
        "Fri, 15 Mar 2019 14:23:12 -0700")
Message-ID: <xmqqva0g4uri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> John Passaro wrote:
>
>> I find myself fairly frequently doing something like "git log $(git
>> merge-base A B)..C".
>
> Hm.  Can you tell me more about the workflow / higher-level operation
> where you do this?

Yes indeed, that would be interesting to learn.  I can think of
reasons why "git log ^A ^B C" may be useful, but I do not think of a
case in which "git log --not $(git merge-base A B) --not C" [*1*]
would become useful.

[Footnote]

*1* As there can be more than one merge-base between A and B, the
 right way to write what John wanted to write is to do the above.
 A single "--not" says "until you see another --not, take all the
 positive one from the command line as negative and vice versa".
 You can also write it as "git log C --not $(git merge-base A B)".

