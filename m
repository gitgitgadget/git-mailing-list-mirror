Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8301F453
	for <e@80x24.org>; Tue,  5 Feb 2019 18:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBESDB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 13:03:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43901 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfBESDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 13:03:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so4639291wrv.10
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nWX7T952ciK7qfPG/argMLzJAJeV4+wF6TP24ujJZbA=;
        b=ozdRPhBSdRaHe1s6AE206d5ePZgiUlnwAm7cHb+e8WpCZzXZ7JWH7EdVxnnavTnus2
         hMHJMpRSgsCIuAeyebJOOUPboslO1lwRcs18VkDA4rXOlPRAKSQNCTnEzeylwEf0pbLT
         tNJ2ppT9lJzqx14qjajHW21tB64UwOj2SwBMmIKxHfnYv0MMTmVrUlNUALHmRqyUuyYS
         dOlTWxaHiJT13It5YQrF5N4CRv+N54xLsAtvW3RdhK68AErEVuogSC+xBzHqP65ZQWwF
         1W2yo0YZxAtEGKWfWMsLuxk/+11+zzX2OvcXhB4UTSuhfsn6EHoPpHApZUfpYn/z/Qmj
         SfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nWX7T952ciK7qfPG/argMLzJAJeV4+wF6TP24ujJZbA=;
        b=YKmg+ntP4bvW/KDVTCSXVvJ5w00D8vbQwcAHMe42unM8WgiMNiWH6+P2JK/LyiW36f
         r1Fhoo+P8q36UIPepZ8wh6IGYS1I4gLNURRQEs/+PZnZK0YS4tK9ELmw7+SwvWEVxY86
         QfYs3gTvSwuZy67l/8lAfI9nvoQm357ZYddYUjc47GfLVe6qaJtOtuKXI+ZZH4wIsBRk
         lPqbCLXuGgEkxqZLGxywQrkVojuHChNQiFU2mIFKlIJ3P2s7HF7iEXxQBAMv/CYEuDUq
         p9ilsB1dovzKbvwJqagUeP8xY8sX425ByexdSy1/Myeg/LUA8xQzBBVvyWsShpnsjU1H
         +dSQ==
X-Gm-Message-State: AHQUAuY6pvoWpJq1NcblG3fd635luHvxcg2rr5dGJ3InuCpwdYjJ7JYi
        gcEvHnirocjm0h0JNf/o2sY=
X-Google-Smtp-Source: AHgI3IakaYQh4+gU7i+yeS+whAKIz9YA+c8nSUasefx3YwBOXNWf+H9aZ3758a2wbc1/1/CYqsaTAA==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr4823430wrv.66.1549389779167;
        Tue, 05 Feb 2019 10:02:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k23sm12005933wmj.32.2019.02.05.10.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:02:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     William Hubbs <williamh@gentoo.org>, git@vger.kernel.org,
        chutzpah@gentoo.org
Subject: Re: [PATCH v5 1/1] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org>
        <20190204184850.10040-2-williamh@gentoo.org>
        <nycvar.QRO.7.76.6.1902051016190.41@tvgsbejvaqbjf.bet>
Date:   Tue, 05 Feb 2019 10:02:58 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902051016190.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 5 Feb 2019 10:16:48 +0100 (STD)")
Message-ID: <xmqqva1yru3x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	objects.
>> +	If you need the `author` or `committer` to be different, the
>> +	`author.name`, `author.email`, `committer.name` or
>> +	`committer.email` variables can be set.
>> +	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
>> +	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
>> +	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
>> +	See linkgit:git-commit-tree[1] for more information.
>
> Thank you, this looks good to me.

Thanks, both.  Queued.
