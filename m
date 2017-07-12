Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2D91F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdGLUou (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:44:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34914 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdGLUot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:44:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id q85so4494257pfq.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8rT6p94AaYufmljRbRtKYUhL75ez+VId/SLThJbNJ5U=;
        b=SilIhF48QPa9wuaSYlDXtxX/jcg1XaP5vmm3EzkKFAIbPTS3wDVxqySW9eXfnxqX51
         YthYjKTztkPM5LZczjxGgLjdg8RVE8JGSbX4/vFYiQnDxZoXWNT18tB4LW1YRouM9r9r
         WUCXRFxHf69puJu3N08sVwGZAEP1Ckf//MzEahTdLNyeWKT73GiBeMvGxM1iQ0YMyyXx
         Q16X5fhvFG6/EjRLtH/gT+v9JYYFR+7h8pyl4bgWxn6+XWKwF1sniHwhGy9w8iHB3ugN
         5z9G78I4L8//8q8z5JoOsrCWUcEKqfaQjznfwdYsIVZ/90nf2s1q3lhiVNhIoM0B1i1W
         stnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8rT6p94AaYufmljRbRtKYUhL75ez+VId/SLThJbNJ5U=;
        b=Uxnhjrm9cRAVTTwxX5FFRLFD5gEDTbVaqGGJvG/E4RK36HU4G9tf7UAmnR7sXfsIRj
         xyENRWjCl8gLdyvpyE9JgQ2Yxi9evtynuXmoqSXiZP12I74kQaJinNtvYWa9rTk59Alt
         tN8MhOqA+HgdgsFUmL7WNsfanVvQ6rbk/ZiBAa/D9ZZWJphnExt4wSh9zaHGWoYG5MzM
         j//fQSJZJP9DKiq3XFpdv2MENCtghnajhkgxxJ+9EMp1Qi1g4yO70xtDGZLhzah3FzQ7
         Ptu3nnm9CjF7Ac5iHNkimT2XgcpJVAgkeNkOOV5jWSBkKPuNs0IBc0Ji/XKhrRaHYxsC
         PoIQ==
X-Gm-Message-State: AIVw112Mdk53EFd3P9QsWaMgmz6ViWos5o7swiQ7tzkJ7hR2hnGF5ioE
        SpqkEeMGXjzI0A==
X-Received: by 10.84.231.131 with SMTP id g3mr6239703plk.176.1499892288712;
        Wed, 12 Jul 2017 13:44:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id m79sm7158415pfk.35.2017.07.12.13.44.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 13:44:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
References: <20170711233827.23486-1-sbeller@google.com>
Date:   Wed, 12 Jul 2017 13:44:46 -0700
In-Reply-To: <20170711233827.23486-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Jul 2017 16:38:27 -0700")
Message-ID: <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>   I want to force myself to think about the design before pointing out
>   memory leaks and coding style, so the least I would wish for is:
>     *.h
>     *.c
>   but as we have more to look at, I would want to have the most abstract
>   thing to come first. And most abstract from the actual code is the
>   user interaction, the documentation.

This is exactly why I invented the orderfile in the first place.
But such a "policy" is not something a project would want to enforce
its users all the time; it is left to personal preference of the
participants.

Just set diff.orderFile to suit your taste without bothering other
people, I would say.
