Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C821F453
	for <e@80x24.org>; Thu, 14 Feb 2019 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbfBNRlw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 12:41:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41358 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393345AbfBNRlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 12:41:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so7406602wrs.8
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=76bdxgMOcqVqiMbPA89CjK3OOPDke6gL2eD+1W5F6n4=;
        b=B/BxejZaNFTDTIV7dGJr6sWxK1wPTQkcXfQoY37vwa4o9G8nUhSWc4D/vI2QowAJ4V
         BBUpJUdxCFgw/HlXKR9ZNH8z9LCWeYUJnBb9TPrLxqSTLsZylgkATH4TgIIwjIh9d1wE
         xj0lKPwJ5MimdOugI7HQT8t/U5vP5sQ2u1Z71/5oLgcvyRatSL+s7Moa+9nyN/yDpc1L
         IkOC+oqtJzHXRKgAB1SQIj0ILxXOeoReBl/Wwb0B30C0uNNQrPGmi++cUKxBXCJm3MYN
         H+Xd4+Wza03yP4aXfjbTtLne0sRo6Kd9akktLrFeS/9RZJKfUwAy/qBXLBAsbAcR8JjF
         Kwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=76bdxgMOcqVqiMbPA89CjK3OOPDke6gL2eD+1W5F6n4=;
        b=s7XBaA7jXOo6SdBGxKBIrJvvaJuHhAUTkT8PHz4OR4xrw4VIGon/Rcy8r/VQbXvSqA
         3qBAL2SQ6DKmr8WJYMiAF0IDy+P7NPG4EQM6qwmxCXUGaRc8BMfO/9R4x2utxPfv0IM7
         zEmTYil13toHPExHCNKiGXgswik00qxYuh7aT6ng1jSK1WYstSsRPXiQ+Tn1Y/sYSMnp
         SrQFgr84z5eMm5dkNezN6q9NCTBbZikKkV3WyzTgFoU9qHO64sq3W3xsjMSDUFxcJea8
         //SG6pr72goueF5/YD+ZIp0633OwS9j25As2vbPj+8d9SP/XOXtXeigx+ct7GMV2FVI0
         h9lg==
X-Gm-Message-State: AHQUAuZVDIALiSJUHAttGPEmMKLU3xPzpRz2XDv2Aa1R/U12VWFoo907
        nEBA7stR3T6YevqswhgALbk=
X-Google-Smtp-Source: AHgI3IYdVdYFLXP0cFcYvZyAXHyX6qbxB+krEyo7PhQGmId6WYRNQ6sKiMyS21E4GZLqyrZ29flIrw==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr3561808wrs.209.1550166110194;
        Thu, 14 Feb 2019 09:41:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v9sm2879402wru.83.2019.02.14.09.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 09:41:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 3/3] submodule: document default behavior
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
        <cover.1549965172.git.liu.denton@gmail.com>
        <d8785cdd01503f2a7b9a6fbc19105c41a9a04046.1549965172.git.liu.denton@gmail.com>
        <xmqqzhqzbki3.fsf@gitster-ct.c.googlers.com>
        <20190214072405.GA24259@archbookpro.localdomain>
Date:   Thu, 14 Feb 2019 09:41:48 -0800
In-Reply-To: <20190214072405.GA24259@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 13 Feb 2019 23:24:05 -0800")
Message-ID: <xmqqsgwq8dyb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > +With no arguments, the default command is 'status'.  Several subcommands are
>> > +available to perform operations on the submodules.
>>
>> I am not sure if "default is status" is really true.
>>
>>    $ git submodule status --recursive
>>    $ git submodule --recursive
>>    usage: git submodule [--quiet] ...
>>       or: ...
>>    $ git submodule -- sha1collisiondetection
>>    usage: git submodule [--quiet] ...
>>       or: ...
>>
>> If 'status' were truly the default, wouldn't the form without any
>> subcommand take any option and parameter the 'status' subcommand
>> would accept?
>
> This is very similar to git-remote. Its default command is 'show' but
> doing something like 'git remote -n' fails, even though
> 'git remote show -n' succeeds.
>
> Would it make sense to revise this back to
>
> 	With no arguments, shows the status of existing submodules.
>
> which was the phrasing I used in v1? (If this is the case, I'd also like
> to drop the first patch of this series.)

It certainly would avoid spreading misinformation to the readers by
technically more correct ;-).  I wasn't paying close attention to
the earlier round's review, but was there something specific that we
wanted to achieve by mentioning "by default we do this"?  If not,
the "with no arguments ..." you have in your response is concise,
readable, and informative and is a good description, I think.

Thanks.
