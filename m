Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0F9202A0
	for <e@80x24.org>; Tue, 14 Nov 2017 03:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdKNDKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:10:32 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:51934 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdKNDKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:10:30 -0500
Received: by mail-qk0-f178.google.com with SMTP id f63so7945161qke.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 19:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucHAUvbjH9B8kdmWtVNe65XD4Q6TPlZgNpcIFYeJS4E=;
        b=RxwDOvZp4A/QF0iIBCtk9I3LjPj9vKMcyl+OeuJdx+E9pgDzWBgl3QixbseEQNBA7+
         HF7vqqk8L7sb+sdVjMkbb6IfNeY1/9RCNnXrmVgwRAxPS/UvNgkEu0m1oIxJOMAag0nH
         1AqUPnQCKgcDJIUQIF/+0A2s7nZiF+Lu3n8z2ElUp0ccWQlVY+YdeJ6Ex8Cy9hp13Zku
         plVCxPEbCXKTObSnIZJe9JSNq22g/CZv+dDaYsp/9rq0NC2FYy4AbnUdq2SfoFYBBbe1
         JycwTGdyFVSwQD3CN1jn78JiH4DaOr11vm/Fo32+9+2Mp/92WpcSWOfF3gTiZjhK/b8y
         i1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucHAUvbjH9B8kdmWtVNe65XD4Q6TPlZgNpcIFYeJS4E=;
        b=eklMd08Euc+ewyUzIJeEJlbgPwszEETcZtp7l2FGAomCMQmhj2g3GMbZhd/1d/9vV/
         PrO/CNyHP7StdUcIHQueR3KQC1SWNEvEKeoR4ncGGwP7DVBAdEET9VJ8nsbpZ2UvAefU
         x9uAQzNbH+eJ4QnTLz1vzMGAsjfWUxjjuTcUBxsyI7t68Rr6g6B2TTjlubJOGL571/6V
         spxbiAYLGXZCme+ayJy0MCU7d21ffxd7DAFgj7mIY6Mx3jTLH7CYTYPmJts9oj30qpqA
         6M7+LFfiEYZU/wj7tDQzaDvq3hx4iYQjfpMNCwfvG+t60mxFyASowhXLwYiPzQOsmiej
         ILBw==
X-Gm-Message-State: AJaThX5zKJr+3Z6mdPBh3u+CiP1hHxqpB1H3TVa4fFH4iHepUksr2Lbb
        FPfwdguKtUh5RIr+tTARTK4=
X-Google-Smtp-Source: AGs4zMbIXMWQ8NwPD5S4b1/Yx+VdqaltX0f1pnx9hKZ9B5nDEOaJ17XCQKebFNnu02wjN+zVlSHxPA==
X-Received: by 10.55.201.11 with SMTP id q11mr16484266qki.303.1510629029507;
        Mon, 13 Nov 2017 19:10:29 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id l50sm12153223qtl.33.2017.11.13.19.10.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Nov 2017 19:10:28 -0800 (PST)
Date:   Mon, 13 Nov 2017 22:10:27 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171114031026.GT5144@zaya.teonanacatl.net>
References: <20171113210745.24638-1-tmz@pobox.com>
 <20171113221823.jzt7jfhxeuyivbcn@LykOS.localdomain>
 <20171113224323.GR5144@zaya.teonanacatl.net>
 <20171113230201.3gyqh2oknic2o6mg@LykOS.localdomain>
 <20171113230612.nyygui2ahuqzrjsr@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171113230612.nyygui2ahuqzrjsr@LykOS.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres wrote:
> Quick followup.
>
> The version that triggers this is at least 2.1.21[1]. I recall there 
> was some wiggle room on minor versions before it.

Thanks for digging that up!  I had 2.1.13 at hand in a fedora-25 
chroot which I used to build git recently, but I've not been able to 
coax the test failures from it, yet.  I'll try a little more and with 
some different gnupg versions before I punt.

If it's a small range of gnupg versions which fail badly when the 
GNUPGHOME dir is removed, then there's far less reason for git to do 
much more than make an effort to kill the agent.

It seems like all the gnupg versions which may suffer from the bug 
also support gpgconf --kill, which would make any further change in 
the test to handle versions which lack the --kill option moot.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Our task must be to free ourselves from this prison by widening our
circle of compassion to embrace all living creatures and the whole of
nature in its beauty.
    -- Albert Einstein

