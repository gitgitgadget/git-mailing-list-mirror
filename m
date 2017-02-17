Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0DC201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbdBQX7v (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:59:51 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33945 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdBQX7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:59:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so5016854pfb.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nZ9mLuJ5e3q3IYkWx3v+D219yAxHO7oJLacnzH6QDJY=;
        b=f58zDnEhsZWrJU7MBJHlci6zt8lPRGN3EDYlcOpN5jUBUxsb/byiF8TeA8/RhN3chb
         7zNkhjs4m5zYJc37d4uNbht3PYHZyeot++cdoyuSNtDf7FADBDk1HPhpi8ZcZzwJEe/2
         CURFUwlTkGJvbBbBfXiza44LV42fXBe0rYLULgDB5MiP17ksLM1Rc5i21grbirZLLLoj
         qsXabOKrxOMg5XetstZZzO2mLBgYpyj0BsadtrmhMUENWV3T1+2H+h4yQvENGDYjZKuB
         cT4pXjmWkB5wm28AE8hhROKz0XELRfHbwVxaLtg2h9WenttgvRbEmLBTktmCOWpxBxcj
         j5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nZ9mLuJ5e3q3IYkWx3v+D219yAxHO7oJLacnzH6QDJY=;
        b=kmBRZ8l8zKW/UU5S6ROlY3NrCzYQ1byy/lxG21ZKXBerZ96PN7euvXjWvFOU2CxDT/
         jDL2vdr2QvV4BgmZCZ01n1kyFoNYtUTGN9TP2dUTyxdSYT5rp3l6LC3X44xP0ffblHxa
         SVRd+SZU96YwDdtMbIoF9QNrA9u+jhAKD1dVsf0224sIzI+35cjO0P5uZ9XXccGjkhVg
         7/L6jniKA+FiQFMzK0FV9BfUsvipWRtFJD3sHoFsROYiFZnA3RKUI2pQNIdtwALyz9pe
         aeyCWVcH6y+cP1aRL/Bc/wNMQeWqAJUAq0/wJDKu8WGZ/b/YtuZ3v2tZgzoezXyrlNV+
         QtQA==
X-Gm-Message-State: AMke39mFeoC4lhUXT98XOHE0BdNwoe4Jw6x6GH7/57PNQq/iFDNYzszKU2OyYJHYdlALlQ==
X-Received: by 10.98.133.202 with SMTP id m71mr12453400pfk.102.1487375989972;
        Fri, 17 Feb 2017 15:59:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id y201sm11383976pfb.16.2017.02.17.15.59.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:59:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Gr=C3=A9goire_Paris?= <gregoire.paris.greg0ire@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Gr=C3=A9goire?= Paris <postmaster@greg0ire.fr>
Subject: Re: [PATCH] Document dotfiles exclusion on template copy
References: <20170217233700.14643-1-postmaster@greg0ire.fr>
Date:   Fri, 17 Feb 2017 15:59:48 -0800
In-Reply-To: <20170217233700.14643-1-postmaster@greg0ire.fr>
 (=?utf-8?Q?=22Gr=C3=A9goire?=
        Paris"'s message of "Sat, 18 Feb 2017 00:37:00 +0100")
Message-ID: <xmqqino8nzbf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, will queue.
