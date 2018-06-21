Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1EE1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeFUQj0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 12:39:26 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39421 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933471AbeFUQjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 12:39:25 -0400
Received: by mail-wr0-f180.google.com with SMTP id w7-v6so3875473wrn.6
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lrm0PKWDzPmyJcxeu0YUBip2OAOYqsOae2AT1/NUdZ8=;
        b=rSktdUtbSvsn/wODxskd7yT6cXKahl5OLyRlZRCt1gxBmdylnlw2krrS/WAJmvz1vP
         jypBbXSeTl2I0NVx6OcMUZOhPVQtYaEbkuE9tg8hEh+dxCqy57iTdgwzIQ72jlmaQznT
         rFkGnX57IU4kEkK3weXt0nKYQhhh41w/KCOLTbQthjJqOHzT/rl/eZjKGl+kd3Z9Mh8c
         /fJGMaiHfdaE0AuVJ+7+GI0gZKbPFAdIDKj0End/AUbnk/kesu0YDUns1RsYRMzdox3b
         lswqn5Kp+OYmGYU7/ekifx8u6Lxt+fp2rX8UG80NwP1Ux/9VAwk5XMQJj6qgGAUuV/Sp
         +q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lrm0PKWDzPmyJcxeu0YUBip2OAOYqsOae2AT1/NUdZ8=;
        b=gEJ75E/Q6al2uNLXvc8lYZ8RBp4YNCRhJvLOwjJfZlcuwYikCSqwKeZlrvX1EQRc9O
         vzF8hCKWusMgTEYF+o7ppnq3zEa7gkI6c4nUyIHJGYgWY9vc0f/n7cbtiMOQBGj9Pb5J
         pPpI3+7QryonEketye3Exl9Zl/sDgjmQGO6hni3E3FEjsxUQEpc1jRMJxJdJnb3bEg8K
         1CkYXqFgEGovU1Rmz6vsF+F7ZmJ92igxNc1eszRI6mxj0hJR2PgJ2Yy9xEwa3cuSwZy0
         N9PGR3Sn6vTRA5uefeOWoPwwFa8ah3K/rL6f7RhwJIhvwLvfS12jeZHIEYPTL9M07udI
         YwXQ==
X-Gm-Message-State: APt69E3W8wJ6FZyhCwJeUTScnS0jnBD1tZhlSGOSq+PyHF3kuF0LYmrl
        4HA0/HayKROG7i0fE/ezCIw=
X-Google-Smtp-Source: ADUXVKI+JXxVQSKNTWZVid6UfB07Wxkhnro0GSYt1fUQAs8Zh1Ef2qD8rT6abiq6bRRfG9vSoPm/+A==
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr21785953wrd.67.1529599163880;
        Thu, 21 Jun 2018 09:39:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w126-v6sm6775924wmw.29.2018.06.21.09.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 09:39:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] ewah: delete unused 'rlwit_discharge_empty()'
References: <7bfb528f-ef65-4de6-7d01-6ca91f0072e7@ramsayjones.plus.com>
        <795ca948-1633-a1f7-1d7c-88ace8361445@gmail.com>
Date:   Thu, 21 Jun 2018 09:39:22 -0700
In-Reply-To: <795ca948-1633-a1f7-1d7c-88ace8361445@gmail.com> (Derrick
        Stolee's message of "Tue, 19 Jun 2018 19:49:00 -0400")
Message-ID: <xmqqk1qst7ph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/19/2018 5:51 PM, Ramsay Jones wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> Complete the removal of unused 'ewah bitmap' code by removing the now
>> unused 'rlwit_discharge_empty()' function. Also, the 'ewah_clear()'
>> function can now be made a file-scope static symbol.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> Can you please add this to the 'ds/ewah-cleanup' branch, before
>> we forget to do so! ;-)
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
>
>
> Looks good to me! Thanks!

Will do; thanks.
