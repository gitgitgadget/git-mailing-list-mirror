Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F191F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeJQFMc (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 01:12:32 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46436 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 01:12:32 -0400
Received: by mail-pl1-f172.google.com with SMTP id v5-v6so11592949plz.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5QuHY9E3wCE+Q06xhM8bHcf0jdsnz93H49/HfFIkLc=;
        b=r3Tq+eBC7KqYkCYMD0kH85YasIMhyQjsY9o/fgiv1EgQpQHV5HoFk02QUeQeycGmIW
         kEVh2AoeU8bIC8lKngle4TAlSWZ8Phvdm0JnZ1LkYZ5d04itv+bYm4bLyuR81Ir7GxH/
         r/JEIoneVe4dK8mJPMDrI1nSbWCL3EAu70kFBgsdyGTFNvA2ySU7ZUHxwWIWEIfymo4c
         ugNN/RJ1HRzjiJ8Q5GLQIqHGG8ti7eWDseZHu2E7k2MfZIgocE5pWCtMLzP7dXaaWuba
         MTX19hXLAdSVKrbmnBFMwhvdg0qkg83MmL+aluwnf8C7N2hlydVVRaQ1LRe9tQxFc9wB
         6nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5QuHY9E3wCE+Q06xhM8bHcf0jdsnz93H49/HfFIkLc=;
        b=g8D8nJcaXOzmWf6lvV8FVSoVSQ5b4IsseHxluMYlEhvgoXfc8mY1p/DCTkqDQKASiS
         25tpoD5jnorExv1WI/I1AFcA1ygmSgr/zkspe1q1fA6/0dWsgM0Bhym+FRB1x4UZO3tB
         ZfUPkGmBRKlbcttTK93+nRNlzG1zBvWzqHfRudsxDSA4tPLk554EfGSMFn8LT8uzvLge
         DJPyLAb4ZXutNqIa5tHs7EzzFCjuIEh4kQAV1/T8L1vTNnfudDscXvwKnKC+CzWzwQ79
         DIi+UAFA0UKz7jzydZXG7P9enz3HWygIrThmkEgOd5iRhhx0WAEOzppy4Mz/pvx4MVdO
         7uCA==
X-Gm-Message-State: ABuFfojawlDS1IU24k/ElvTJMWMu6p8Oh9bk90d2mZTA6bWryYA9I5Xy
        uqmT8NMwoZoOd2EO7Gh4TVYG9UdBTzb2YQ==
X-Google-Smtp-Source: ACcGV63yt/LkU0jp0FAqWUSHr8wosUG8iICGY7NweP6DvyyQsenqtGkCzYbH/Z4nK4QHbFd3uLZP7A==
X-Received: by 2002:a17:902:369:: with SMTP id 96-v6mr22912695pld.36.1539724815299;
        Tue, 16 Oct 2018 14:20:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id h77-v6sm30293668pfh.13.2018.10.16.14.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:20:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:20:08 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
Message-ID: <20181016212008.GA249669@google.com>
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.12 23:53, Junio C Hamano wrote:
> * js/remote-archive-v2 (2018-09-28) 4 commits
>   (merged to 'next' on 2018-10-12 at 5f34377f60)
>  + archive: allow archive over HTTP(S) with proto v2
>  + archive: implement protocol v2 archive command
>  + archive: use packet_reader for communications
>  + archive: follow test standards around assertions
> 
>  The original implementation of "git archive --remote" more or less
>  bypassed the transport layer and did not work over http(s).  The
>  version 2 of the protocol is defined to allow going over http(s) as
>  well as Git native transport.
> 
>  Will merge to 'master'.

The first two patches (test cleanup and packet_reader refactor) are OK,
but the latter two will break the archive command when an old client
attempts to talk to a new server (due to the version advertisement
problem noted in [1]). Sorry that I didn't catch that these had made it
into next.

[1]: https://public-inbox.org/git/20180927223314.GA230445@google.com/#t
