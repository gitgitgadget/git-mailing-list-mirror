Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5401F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeJKHFN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:05:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38177 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:05:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so7570058wrt.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UVAXGGx2Loo9vu0LI5qNsNeAd+xz1hOmolrlEoYQ7wU=;
        b=vOBw8OB8iKI5dlZNQivwmFLKUp38zJkLo6dBJz+8Kts0WMSQYzlzZsy5/wM+bpzf81
         7aPxBKeenFs0RHD9f7Ks7Yqi7SUVJHj+vJqtAq4xVb9lP9KUdnaXffPW2xGQeVZUlBaI
         ep/vNAaCYRWKzBHHIrkQ8/EwiiYWOLmP/dnGCopiJNeXKqzcKqAUAW/p+fZtXZlvvlGX
         m7x6FYQk5XSushrBOsWcqaEQ6omGTLKZMbbL8ivGwTZiB6OH2Tg1g714xmJyMGTeXqQ4
         psBouM5gXXtVNSuyzga/dDeM4veGXzUZFHsosBIjBrkQHDE7lbbBGdCNCdRqpo+wHhtb
         FpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UVAXGGx2Loo9vu0LI5qNsNeAd+xz1hOmolrlEoYQ7wU=;
        b=kbn0I7snsZ9TeFfw7QzNk5LieWCFl8eWu3gb+s0doOD5xLk17/wFSleqNF9kg4JSFi
         wFf4bVZ18bnk6zSAjaVZ1F59DrzdQu/M/2PgRvKt7cCj2jpGZGvXa+9usedg/tfGoodr
         W94r/R8/1dZiRRItBfvv9Y59kqJYaEpIJnpJ2ytXzGkH29DsO+4Y6/rK5YTRlXJYwgg6
         z7AvphpUcJLak8xToQivfhbewB2Ul52N5sp8qo+gt+icx/MZzMhtlNiiC2EjXSfS4nYQ
         uKlC2CM008zicSGPRmjGflb4IB7IIKlYe5RQ0U6OamDh7J+BbAUqrRxmieZ2l8jBfGgQ
         R2XA==
X-Gm-Message-State: ABuFfojosqHnyc9hZWHNiMT7VgK7PmOXDKsz2Qmqb6tsOC6bZSpo1Gpn
        VOsX8NjgphibZVugcfvsEY1Ql6f4b+I=
X-Google-Smtp-Source: ACcGV61LDhych3jPj4c+CMqG8IcBIAtC0JQXiURaZxTeQn+7rEoTAT38WRTBW3kyGvYzaaszfLesjQ==
X-Received: by 2002:adf:e94b:: with SMTP id m11-v6mr25791943wrn.126.1539214844082;
        Wed, 10 Oct 2018 16:40:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e133-v6sm24220250wma.42.2018.10.10.16.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:40:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: move git-rev-parse from porcelain to plumbing
References: <20181010213726.26111-1-daniels@umanovskis.se>
        <xmqqy3b5jv5p.fsf@gitster-ct.c.googlers.com>
        <7c08fd68-9a0a-ab2a-0667-f51726fa691b@umanovskis.se>
Date:   Thu, 11 Oct 2018 08:40:42 +0900
In-Reply-To: <7c08fd68-9a0a-ab2a-0667-f51726fa691b@umanovskis.se> (Daniels
        Umanovskis's message of "Thu, 11 Oct 2018 00:56:08 +0200")
Message-ID: <xmqqftxdjrph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> On 10/11/18 12:26 AM, Junio C Hamano wrote:
>> Among the remaining ones in the list, cherry and get-tar-commit-id
>> are probably better classified as plumbing.  I do not know why
>> cherry is marked for completion; perhaps some crazy people use that
>> on the command line?
>
> I think cherry could go either way, get-tar-commit-id is definitely
> plumbing. Would you like me to fix those two on the same patch then?

No, what you sent for rev-parse is already good.  A separate patch
that addresses other ones can be discussed as an orthogonal matter.
It even may deserve to make them two separate patches, as I
anticipate that some people would resist marking "cherry" as
plumbing, so that only one can be applied while dropping the other
as/if needed.

Thanks.

