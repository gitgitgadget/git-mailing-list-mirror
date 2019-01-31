Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25491F453
	for <e@80x24.org>; Thu, 31 Jan 2019 17:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAaRtu (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 12:49:50 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43515 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfAaRtu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 12:49:50 -0500
Received: by mail-wr1-f54.google.com with SMTP id r10so4262267wrs.10
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oLhYQ0KY7hoMY7uNOeIcd6eKsw53Mz+p1yQLn8wz1G8=;
        b=puYCNh07IH7RqpWRpg2OA0ESSiwSlQw1SO0gACV35DMC8y1NVar7NmSdRwjJuV+spw
         /d2QKcia7sDxSoKY1uDdJvY3G8hZd8J0E32NtgtuXeVnpk+jkIYurRVa8IOYVJn7hFtC
         w6emD8sSUFJi//Y8cHhgpUduyflruyPZ9+hz6D0aS3AN60SDu0wWCMLnMs6+CR2dN46x
         dQAsFTQ3iFtz11tALjzljnfNOzfOnjUyNiOD3elR4S/pWVkzmEfOY61kRpd/bzg091Su
         Ff2vADLSpEbQp5IRjgnPsKSHnG/Txb/PhN2BreycdlqZkPVR3POPNWwytXcKCgJD00Ma
         1hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oLhYQ0KY7hoMY7uNOeIcd6eKsw53Mz+p1yQLn8wz1G8=;
        b=ODem3gSnhiz++0YW7YNSI1ncs162jQsvdxcEtq+krWT11x10ZySVljLzgpu7bJjRCM
         V0LVGC7AH7+9/zQUDT7SZj7ypAqW3wN+b0hXG219cxOYtDkFQvy9lV+gE1Un727wb7iS
         3suvKtG5Hqk097pel5ZUT6rk9jihA8u1fA+r4Mp3xOQhdMKxZGx74EJ5ernrJUmvkw0H
         v2ozMbfEfk3Fpp6BJQ17boEZstIlQ0xapAngjmbyPEk/FQTBfQ9o+d93nbiF53dch82+
         tUK51dfepXqEf6xc1nayFt2CJMtvkZvqDFYNoy9BQWXuR3+GPd6dW6kCRTmv0udmdIsI
         i3iQ==
X-Gm-Message-State: AJcUukf1wx+sL4MI3OP3nXnwIJsvX6PvuRwRzHCIkrLDR7Tnz1gDyhj3
        nllM/1Kz8NphyavK4Zjftj/XT1DH
X-Google-Smtp-Source: ALg8bN6yU7CO8jwXpNvPqmPk7P2RvvqvEjUOePPMbNkE7I+LAB1waaVWTpH8yBicX2qHTAUcy8k7kw==
X-Received: by 2002:a5d:42ce:: with SMTP id t14mr35734980wrr.51.1548956988320;
        Thu, 31 Jan 2019 09:49:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a18sm5827668wrp.13.2019.01.31.09.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 09:49:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
        <20190131074353.GA2647@archbookpro.localdomain>
Date:   Thu, 31 Jan 2019 09:49:47 -0800
In-Reply-To: <20190131074353.GA2647@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 30 Jan 2019 23:43:53 -0800")
Message-ID: <xmqqbm3w4szo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Jan 29, 2019 at 02:15:36PM -0800, Junio C Hamano wrote:
>> * dl/merge-cleanup-scissors-fix (2019-01-27) 5 commits
>>  - init docs: correct a punctuation typo
>>  - merge: add scissors line on merge conflict
>>  - merge: cleanup messages like commit
>>  - t7600: clean up 'merge --squash c3 with c7' test
>>  - commit: extract cleanup_mode functions to sequencer
>> 
>>  The list of conflicted paths shown in the editor while concluding a
>>  conflicted merge was shown above the scissors line when the
>>  clean-up mode is set to "scissors", even though it was commented
>>  out just like the list of updated paths and other information to
>>  help the user explain the merge better.
>> 
>>  Comments?
>
> Not a code review comment but I believe that you mistakenly included the
> "init docs" patch in the branch. That commit wasn't part of my patchset.

Thank you, thank you, thank you, for saving me from an
embarrassment.

Eh, now I am already embarrassed, but at least we won't see the
embarrassment cast in stone on 'next' and 'master' ;-)

