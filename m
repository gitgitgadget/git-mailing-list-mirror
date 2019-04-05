Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E98B20248
	for <e@80x24.org>; Fri,  5 Apr 2019 05:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDEFlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 01:41:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50349 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDEFlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 01:41:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so5393051wmi.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zdojt/SKXHkEnqN4oNHcyB7e7pOLZX++sxdvmwxDdUk=;
        b=RBldTQND82uNa4vycExlEXhkJ9+tnjH0aQCY9HN0z/T6XLAt0mm3Allk64Q5+HwDXc
         Cquxa+QpRH+FZd5l4i2EvrnUKJeTTJyCPnzxEyJZ1hFzlMwNAfxJGYsTQErqfY4ndJpf
         5txZW+fCJKXX4bMBRDJBPx/7Iqgo9qyODDltbcW0E8vax22WGXDgmbQCgzqZlLILBi0C
         0rXxYyR2dI+StrJGYfbjpWJCMQioapNrREnsqvXN3Zn3Y0gqgNqRAliu/iOqF6Ok6+EC
         6mIPgW8sUSSVtC/rVuxWnxJyjeuer58ihcmP62jUkeKeMpYHYUECxKoSD9qFJIEZncAv
         AgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zdojt/SKXHkEnqN4oNHcyB7e7pOLZX++sxdvmwxDdUk=;
        b=SBNOoPWt5q9kvkI1n2YP+D4bK737VmuLKLuzMaVNo+VzKilOtfqZ3LvzwtTA5GIw5P
         ZG2Jm1NRxdIhAz5FlHalc2ZfWkgPqNEgFr9x6v84IUYUUhNlyJ6C3Z1Q6zK83DLR26Fb
         OIpzuCAWFylHN/g73F3hnX8gLKiexkMcL02b4BbWf0pQ9hUiqRp4UefQY/YXx7l1n5ji
         RRcRK1pQqNlJSOsVYS1DtkZNG01CBLSP/C6zLh0i/yWF8tKuuCo/U88VVzA9J0pLr9JV
         zqkEm/mEsPVeBR+ZKz2Zsq1L0lEA/AL1cZig2XjMMXhd264FrXC57LuU+1Uhsi2mOXf0
         jX4A==
X-Gm-Message-State: APjAAAUC8sjIXPaFJoT9nu3Oa8KyxBqAqNg+8NrJPQDoQXJd3memRuAy
        gLVOA2vnoMqTsFpCWyVIKH0=
X-Google-Smtp-Source: APXvYqzsEAUE52I2KQ0+rGmIGxpiDhalOy4Cd5FJT/ZVQgzlTdB094LWSHlcFS6yBlgO9T/QwrCtSw==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr6712092wmc.68.1554442908705;
        Thu, 04 Apr 2019 22:41:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n6sm869181wmn.48.2019.04.04.22.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:41:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
        <20190405010556.GN4047@pobox.com>
Date:   Fri, 05 Apr 2019 14:41:47 +0900
In-Reply-To: <20190405010556.GN4047@pobox.com> (Todd Zullinger's message of
        "Thu, 4 Apr 2019 21:05:56 -0400")
Message-ID: <xmqqy34pc8kk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Martin mentioned this in reply to the patch thread¹ but it
> looks like it slipped by unnoticed.  There's some extraneous
> comments in 28216d13f4 ("ci: stick with Asciidoctor v1.5.8
> for now", 2019-03-29) which would be good to trim before
> this hits next.

Thanks.
