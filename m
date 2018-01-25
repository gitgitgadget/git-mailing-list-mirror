Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B01C1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeAYXBh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:01:37 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44233 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeAYXBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:01:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id m26so6896684pfj.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MyaNNHhYnndbyjHGJ5Fh1drx5g6a9QJ3fUqjgBxru1c=;
        b=qYoVF1Zj3hRharKlBfhCk+LELmgmbZSS1dsFs+tBbNs03vKVsdQZu/ISbZMJgNYVaa
         d42pEsWBLxXV4fUwF2hByXOKmYFwTm+7GcgsFprMrC0wur835H1ShA9ndw9cPyRoeo2H
         BVR5+bRhGNxIxQ/noug7HYvmmx5PnIX2NlL4pFjXK8Ba48QRpQ+hPmAkWtjXt27Baywx
         3d6oCwdxOOsBOCpDIfnzzYg6BUmdghN0dZt5WQqJpJlXd7ynxg7PZS37+9gtOs4QZBG5
         jkKXCznc28S7VwBx8XDEZNbWKr5G2ONv3/Tq0Vgg7VWFLG6smZuwJVU4L0bypqm+/qg+
         M6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MyaNNHhYnndbyjHGJ5Fh1drx5g6a9QJ3fUqjgBxru1c=;
        b=aSmOOTUHTmT62WqkGpcqjfvZ043a8ShyHWYHY0URCmVzU4jf5hIwgxSzxh+bVDjFTq
         OxhtWZi9aBrLk/b9TJoNbjGri+j+mikbH62SV4IDzWQC1bdgZ7LWLiSa4tjZvfNs59s1
         ZdSvsoBOWUpdG/4m4pbuf8YNmNXvEp9L9Dl9g4QTZY4l1eyR8efV9t5zNHdFt8oTMA3G
         gS+jIPjW+A+1/qpAx4DtYpsgdeHWzsnQW4hea1R9f6ovNRsIHHOOJHdN9drLIYYHXBhu
         uXw660qErCUY3OyuUyIhF//DAn6uJq1y8RucpfWl5byyxVgQ3S1GJK5tYPMda1xu92ES
         C+VQ==
X-Gm-Message-State: AKwxytey6gkHksaRp7edAdtpA2PuuIfPURYvO0mLvqWy8rxkpRW1PYSY
        /BXohHInV7v9CZuYpAQOD5k=
X-Google-Smtp-Source: AH8x22757BlFguBJSpsm2Cs+EqiDJOvUgezWgrjDyYzMIiXCxFaLMl64FI5ZFqf9giFIdWxd9QHe8g==
X-Received: by 10.98.64.9 with SMTP id n9mr17648028pfa.194.1516921295352;
        Thu, 25 Jan 2018 15:01:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id q10sm15967370pfh.178.2018.01.25.15.01.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 15:01:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 03/14] packed-graph: create git-graph builtin
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-4-dstolee@microsoft.com>
Date:   Thu, 25 Jan 2018 15:01:32 -0800
In-Reply-To: <20180125140231.65604-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 25 Jan 2018 09:02:20 -0500")
Message-ID: <xmqqinbp8rw3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Teach Git the 'graph' builtin that will be used for writing and
> reading packed graph files. The current implementation is mostly
> empty, except for a check that the core.graph setting is enabled
> and a '--pack-dir' option.

Just to set my expectation straight.

Is it fair to say that in the ideal endgame state, this will be like
"git pack-objects" in that end users won't have to know about it,
but would serve as a crucial building block that is invoked by other
front-end commands that are more familiar to end users (just like
pack-objects are used behind the scenes by repack, push, etc.)?
