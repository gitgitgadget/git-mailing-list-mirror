Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC45820281
	for <e@80x24.org>; Wed, 24 May 2017 01:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758578AbdEXB5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 21:57:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33079 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756740AbdEXB5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 21:57:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so31144492pfe.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=65lV323DjCDaaq6Xcwom8GPh7YT/GFXWQ1ERaWJF4xk=;
        b=ZoUo0bY59icexA2NS0UW8OEaBHxAP0/x7UfSWczBjk2V9+VmONzIFOobijbU4Jcjq6
         8bUDKPdYF34nJRLYVX+fyBdQwUtSKVjq1KFcmcmQcnNA3n+c6fTbR2Vbw4lGcAsxU0X9
         CoQWG8tPOK6/wbZeNMpec7bxdaK0Y+ikSqP2cvvN4qZRS7F4hYotijMFdgcV2+Z3Ugqv
         bVFRiurk58FzHYwf3EyQ4QdFtYZ6/VKpWph8Ig6xp6Te4QpYUnSuwWB+mW7A/EzvIkEE
         cWFJK0PLHeC8JwHXUq5cMeXqiU85iEGdHaBkngDPfdRBBEoQHSjBhI3UP38eblZXtd++
         VZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=65lV323DjCDaaq6Xcwom8GPh7YT/GFXWQ1ERaWJF4xk=;
        b=Rh9Nnf6td7G4QVj9KmHePO0ZLAaUTl6FGShvw1fXbh+9DDD7B+WOlaOhJvZ8iZYlUf
         R+ZTx85G9pF0rKLdy+I/S1IZugyxv+DrqT3Q3yK9p2+fRaMvaE39lZokqNVYCqUp8Zx2
         k3SIzOd969EQLpsQhlSSdfSJylvA/HQ4HTz5GMY/uO9LRKCn4QUMH97q5VZo6KofBpQj
         MGrnsvB4biAm78+HTY1rY1D34Bqd40MM1VCmQ7IRW3BOmyYXQ5MzJDwn53f4Qu6Z7g5Q
         3vc+P/cJxNXeMstPp69xFLwTQWYBAzEcGfjTnECyfoJ4s7jCv7II3VJs10bjSmgxavt2
         eO5Q==
X-Gm-Message-State: AODbwcDYP1ZOC7kgPAh/R5Sm2VrRHpdi5zZuXHhKQa5xVp3gGbqCJF4Z
        ndb4KmqII/KSwg==
X-Received: by 10.98.14.131 with SMTP id 3mr35515987pfo.23.1495591037024;
        Tue, 23 May 2017 18:57:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id u194sm3328375pgc.2.2017.05.23.18.57.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 18:57:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, sbeller@google.com, jrnieder@gmail.com,
        pclouds@gmail.com
Subject: Re: [WIP/RFC 00/23] repository object
References: <20170518232134.163059-1-bmwill@google.com>
        <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
        <20170523172634.GA115919@google.com>
Date:   Wed, 24 May 2017 10:57:15 +0900
In-Reply-To: <20170523172634.GA115919@google.com> (Brandon Williams's message
        of "Tue, 23 May 2017 10:26:34 -0700")
Message-ID: <xmqqshjvhv9g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 05/22, Jeff King wrote:
>> That said, even if we never reached the point where we could handle all
>> submodule requests in-process, I think sticking the repo-related global
>> state in a struct certainly could not hurt general readability. So it's
>> a good direction regardless of whether we take it all the way.
>
> Glad you think so!

Yup, what Jeff said ;-)
