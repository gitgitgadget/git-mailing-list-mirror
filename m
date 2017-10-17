Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3241FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758660AbdJQVPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:15:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:48181 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755818AbdJQVPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:15:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so6289962wmf.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiozp9XEUHOVgN11jLYn8sEMyLkCMXWZwgNpwxbUHJY=;
        b=Vck21Rw8VfINLj1FiAAEJ61jQqGkQQsJTFzobVkdsZxmMMvzZlAfcJK0u1CvEUipTU
         gRHk7qQJs4qljQ3iK/MzxuUvH/goSvUHxesvDFN8koGn8qCizsjHxW2Nyx6vQMQgXFAK
         cKU+W4gI1bJ5oj6WHOafsPYQ3YHc+mYO+gm/UhrnzCyMIyc6zm07e0OJGe01KOScgsz2
         fv/uhq64x47lHr/KRvU7CnCLfI7iL43MFL6slPOiAHah0i2SjsUx2KVgzqso2vKGg4Ly
         iyggq4KDdkhKgEed24r0pLf3Nn92CuIVbfLzaL+LECa+JxG0EGAgubQA38nK5XSqTyRw
         v1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiozp9XEUHOVgN11jLYn8sEMyLkCMXWZwgNpwxbUHJY=;
        b=damgdqRHDKjTJOWzxIrXqOd+wh2/+7Gl5YY+ES/2/qjL77xzInBie73MmgI6IvDBdr
         XYk1qi0T6nOAZdW/kGwyN23Gsh0kbm9hzQBgxIBsRNvrc7SCUFWqe+WWuPU5SFxk66Ei
         HUCgOGXyW9sGR7dRab6x/rTmWhfCNka2dEhakqvJITWVXzOwsyHzDiREhpZswaA58rYd
         0u5fHZZ/omv6WNQjMmH6NIdyr+ubasWRgEmY3zbY2Ip+Fo/rroa0cnWKdJxgtaphq4nN
         C3IveD7E6iJc+3XYa+Cn6f9l74uNOjojNCkMP7kRVVJ321fcizxKjiOqcaMh12Ol3Gca
         6qnw==
X-Gm-Message-State: AMCzsaVOgzUJkzH6U+llQTtQlEc4EO9njoziG7HoOiU/iCwf6z/Vv99X
        XNS+xkmI+qkksG1XU3JEDGr4f/4i
X-Google-Smtp-Source: ABhQp+Tosob3S3YR6N1nitmiMeiHFXQKIeRgLq7P2gp/2sg/uAM7P7yFmC0cmaioAVb883clwBVX3g==
X-Received: by 10.28.28.201 with SMTP id c192mr5074990wmc.71.1508274933867;
        Tue, 17 Oct 2017 14:15:33 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id x15sm11242487wma.32.2017.10.17.14.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 14:15:33 -0700 (PDT)
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     Johannes Sixt <j6t@kdbg.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
 <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
 <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
 <87wp3zs4la.fsf@evledraar.booking.com>
 <33f7d379-126d-e27e-7dbf-616f5dfbc98a@kdbg.org>
 <CACUQV593kzMrtc4ENgD=6bBQcn0DXGRcyB7teCvGWk_QNtS98Q@mail.gmail.com>
 <d3ccfb02-004a-bbc3-af33-967db280c940@kdbg.org>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <dcddb20d-b838-0131-ea31-4ab7186dd088@gmail.com>
Date:   Tue, 17 Oct 2017 23:15:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <d3ccfb02-004a-bbc3-af33-967db280c940@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/2017 19:30, Johannes Sixt wrote:
> Am 17.10.2017 um 01:01 schrieb Rafael Ascensao:
>>> This is worth discussing, though not my preference. The picture to "pick
>>> cherries" has become quite common, and now that we use it for the name of
>>> the command, "cherry-pick", the direction of flow is quite obvious and
>>> strongly implied: from somewhere else to me (and not to somebody else).
>>
>> What if we borrow '--onto' from rebase and make it cherry-pick --onto
>> <destination>?
> 
> I actually like this. Although I would miss the convenience that the 
> source defaults to HEAD. Unless we make a special case for --onto, 
> that is, of course.

I second this.

From my point of view, I would say that "cherry-pick" in general 
seems to just imply "taking" commits (picking "cherries"), where 
direction flow is irrelevant, or at least not strongly implied. For 
me, it`s more "from somewhere else to somebody else", indeed.

The fact that it currently "posts" its picks "to me" (on top of 
current HEAD) could very well be justified/explained as the most 
obvious case (at time of implementation, at least), where usually one 
does work "here" (HEAD), thus cares to have commits picked over 
"here" as well - but it doesn`t have to be a restriction, where other 
destination besides HEAD could/should be allowed.

Anyway, I`d say current behaviour without "--onto" should stay, 
indeed, where HEAD destination is implied if not otherwise specified 
(and that seems to align well with some other Git commands, too). 
Also, in case "--onto" _is_ provided, maybe commit to be picked could 
be allowed to be omitted, defaulting to HEAD again, but as source 
this time.

That said, might be 'git commit' looks like a nice candidate for 
being taught this new trick as well (optionally commit to a revision 
other than HEAD, what Ævar already mentioned), following the same 
logic... ;) It would even be a better (more straightforward) fit for 
one of your previous examples:

> Another use case is when you receive a patch to be applied on a 
> different branch while you are in the middle of some work. If it can be 
> applied on the current branch, then you can post it to the destination, 
> rewind, and continue with your work.

p.s. I`m very interested in this functionality, and more - I have a 
beginner`s attempt in addressing a similar use-case this topic is 
concerned with (symptomatically using a variation of "--onto" as well 
:P), hopefully I`ll sent out something soon, for the sake of 
discussion/opinion, at least :(

Regards,
Buga
