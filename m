Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4631F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeHEISl (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:18:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35400 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeHEISl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:18:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so10826474wmc.0
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+BGE9FZ3deewvIy/UmF4KxAWQzriZULzjsikSAwv6nQ=;
        b=kpfd1+1Mwe5ewINdeYx/aao4qprQdK8D7ENs24LKiLj7HUIPoW2hozsa5dtZTI2JsS
         MKB2vpsxRo1rvsVY8hSmUhust4lVOu4rd8mYTlh5tcNC86sngRIpBafTGi5aY5Covrni
         ljoillcRJZKUsxn9Y+qRbaPgxp8SCzDX++FYzdhqilqZqLKXC19/luVPqKZ8MNX65Wx4
         uliAqngNJ/lEkMlICQKh9dKI3NMNFofM+yQtX8GNurSjmge9/e+aYZ53XWR+KpXVYtpL
         wG6pXN+WXvDEpuHJm37cjEUo3WHxhhCq4EeoV7Nm258Zs17cAvNppi7FnUyi6SrPsM46
         R+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+BGE9FZ3deewvIy/UmF4KxAWQzriZULzjsikSAwv6nQ=;
        b=Al9qsI9OyA8FW90RMWIYecccQCydpA/kDtH/LZ2EGBzaQsJqBqb+MhtUX6o160wMDj
         5vTu3JNgFDtfjoZLyqa7aQSoYm+07kHQFOwesZFnpg6KIKmis1NuyWTmsptYPSYitglH
         V16d0BCOTt+ni0VqOSdMsgR6gTDdA8rqkHfgAC8pWsY+0Pwemo5JZeRAf7Quza7VEcLK
         WlF0ov4Z1YUL+acoCoM8u5kJaTRTRfqgEwYIgoXekDJnrhJBCQw5nut/cmf+c019+jZQ
         tXHWenmPDDOQX6YrwYKH3CJYF7Changlvnt319gQFM+Ear5ASlJRyPH1X5/N8zt9OGNg
         s6WA==
X-Gm-Message-State: AOUpUlF3McVLh2riPlhfnV24z52QNKgtqYv+MFHokLqptEAofOG8jTla
        Q9mLI1vj0E/1SwkbYi/k+mI=
X-Google-Smtp-Source: AAOMgpfh+LB7/TdCagk+RwjLkE2Bl45mKcK0omDbBQvxOW4XOash+cwiqK8Id5bPiXJ11Yfg1/awZg==
X-Received: by 2002:a1c:9acf:: with SMTP id c198-v6mr8880235wme.131.1533449713517;
        Sat, 04 Aug 2018 23:15:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t25-v6sm2698008wmh.15.2018.08.04.23.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:15:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
        <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
        <20180803184508.GE106068@genre.crustytoothpaste.net>
        <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
        <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
        <20180803193256.GA164578@google.com>
        <xmqqftzvw6xi.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZdPP+q9iuQioUU+2JkfH4n1mkkHrXaJzxGVwhxvbKZ1Q@mail.gmail.com>
Date:   Sat, 04 Aug 2018 23:15:12 -0700
In-Reply-To: <CAGZ79kZdPP+q9iuQioUU+2JkfH4n1mkkHrXaJzxGVwhxvbKZ1Q@mail.gmail.com>
        (Stefan Beller's message of "Fri, 3 Aug 2018 13:43:07 -0700")
Message-ID: <xmqq36vts5jj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> You are the second one who were negatively affected by Stefan's
>> "summary" that reads a lot more in what I said than what actually
>> was said by me.  Stop paying attention to that message, but do go to
>> the original if you want to hear what I actually said.
>
> Please note that I put that one out to "in a deliberatly
> outrageous way"[1] so that I get more arguments on why
> this workflow is the best we have.

There is a big difference between appearing deliberately outrageous
oneself under one's own responsibility, and cowardily making other
people appear outrageous by twisting other's words.  Don't be the
latter and pretend to be trying to be similar to the former.

I am quite disgusted.
