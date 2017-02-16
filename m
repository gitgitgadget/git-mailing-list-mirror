Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F99C1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbdBPStd (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:49:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33944 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933293AbdBPStc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:49:32 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so2187285pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=KVXUo7RS0KWCcqCvJbcVI9Ah0NUU1KkqZCsWtoiUd+c=;
        b=WIFnTXTSiTnf5JmuwwKGDWi+J209gEUI/4jjOR3zskS+jPEPmXxfXgmsru8bhsVW/A
         /BY7uOQeC5MGlkHBF92h44hDFwXMM+Ii2azAZlKspUm4Y8FiJkHplbbH1FKqBao38ENy
         n87WH1hpe1QJjn8nbgpUh/7NddNrHMb+HPhfwXKsmtEHeiCRSj76zDVaAKNtqhTVnNqJ
         UaJ84UUPVaQQSaEnnt5tNjP/emWvMuslp7GG7dFFzZg14couj7qxO29rCQzOKXXZJX0j
         Z7ypkuNtnmDMM2Tm79lnXcSSdE5J4r7aRvDmF106tsWzTtbJRYZ4jJMOeLzVHFs67nlR
         KEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=KVXUo7RS0KWCcqCvJbcVI9Ah0NUU1KkqZCsWtoiUd+c=;
        b=WUFnpkWWwT4I7cz+r0ojKLg+VYOIExFze+mOY/zLIJkef23Xik6UUoa5OFeMBnJ0mf
         cvj0PtXdV1oFWl/b1Wscyngw9w59T73joGE5nOrlsRUP14qBh4YRFeZWGE4uUrxURsKI
         MJOie/Xf+yJ+yWs9jEwpIQm7k7pUF0MsvHtICQEssfk3ySJadJRceD935CK1u2/48m8V
         rWwaAfjYtLLfJi5dpM5C31Io5zG9hGrQRBqPCWQKsQ8jfPXVsuS2A3O17hJADtkHXLF4
         DZgSxCw7sTjiRhUPSotmw1TGQsm4slxoOjZVVCDHT/T7A1WroioFWcw3YLqTHWhp+gFt
         4B4Q==
X-Gm-Message-State: AMke39lKLS/DB409ofqaOPzktlqB/KVOwprsgChBtNBOa+DGM4DJ3TKsPlsDiDR7X8DLpw==
X-Received: by 10.84.139.195 with SMTP id 61mr5266144plr.116.1487270971889;
        Thu, 16 Feb 2017 10:49:31 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id z70sm15075468pff.26.2017.02.16.10.49.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 10:49:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org, pranit.bauva@gmail.com, peff@peff.net,
        pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 0/4 v4] WIP: allow "-" as a shorthand for "previous branch"
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <vpqa89mnl4z.fsf@anie.imag.fr>
Date:   Thu, 16 Feb 2017 10:49:29 -0800
Message-ID: <xmqqinoax96u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>
>> This is as per our discussion[1]. The patches and commit messages are based on
>> Junio's patches that were posted as a reply to
>> <20170212184132.12375-1-gitster@pobox.com>.
>>
>> As per Matthieu's comments, I have updated the tests, but there is still one
>> thing that is not working: log -@{yesterday} or log -@{2.days.ago}
>
> Note that I did not request that these things work, just that they seem
> to be relevant tests: IMHO it's OK to reject them, but for example we
> don't want them to segfault. And having a test is a good hint that you
> thought about what could happen and to document it.

The branch we were on before would be a ref, and the ref may know
where it was yesterday?  If @{-1}@{1.day} works it would be natural
to expect -@{1.day} to, too, but there probably is some disambiguity
or other reasons that they cannot or should not work that way I am
missing, in which case it is fine ("too much work for too obscure
feature that is not expected to be used often" is also an acceptable
reason) to punt or deliberately not support it, as long as it is
explained in the log and/or doc (future developers need to know if
we are simply punting, or if we found a case where it would hurt end
user experience if we supported the feature), and as long as it does
not do a wrong thing (dying with "we do not support it" is OK,
segfaulting or doing random other things is not).

Thanks.
