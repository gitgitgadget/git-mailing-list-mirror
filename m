Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156D6203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbdGXUer (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:34:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35785 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbdGXUeq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:34:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so14765369wra.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:mime-version:in-reply-to:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=NpODg3B2ZbYPWvdLxezpB4zZwz62Pzo8NfPWblsNtYo=;
        b=ZUBHrUBb8JkOBTn02qxJa5L3+a2v57rpNlkoVIex1SLir5SXZxwOASi+GY2rzoSOWZ
         n1aHVX1HDdTDa0e10UgIsiwUxtnXqGAWmBJCBBihEbKIRxDhyhpIfmjNR56CzHqbg8lB
         cWQVGFy0FAbb+i1E7dBog/4GnUMNNc6G+24wIJRPzO+gfV4Og75YhNqoRiw2MWInlxmV
         MnRFsgSau1csR4SpTVb1x/MaYWkp6ir9D4ijJgJge4b7t4XI64CP/Vh/MhjwMgE5wH3M
         JzlllvlOx7EOBjOfAvXbHXC07PR/Ql3hUvMRAT9luENFz8C1umgURDR24b5MdNceYAau
         oQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:mime-version:in-reply-to
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=NpODg3B2ZbYPWvdLxezpB4zZwz62Pzo8NfPWblsNtYo=;
        b=J5NPetdpg0EAbsJZ3O+KM0S4og4lbZUfpAIRcZTfFNEp6cprS/bZbWTahy0ww/et1x
         1flft65kuYKECZjqyxj5x8p1rnEL5PnqCvweWc85F/5V7VkB1hyW6+zMjxUVcNNqtOCV
         4EWQjZijJFQyKZUBYtSr++mQZ0cVktRg5h0w1y69CHuzJ5+ZxozlIjf2hEm9TDEqCnVZ
         v8+2yEWH29KC5fbCUDxooiq6gZBy5KthvyP11JRKc33jL0Qx2TYUe7ImKPqDlYIJzF4z
         s1nKJCfOMHXAfHUnR4lwPvwHx/yAhHXnYwoGvOLQPTq2utjsE5ySUjzBgcJ0zq4yNqA9
         w3bg==
X-Gm-Message-State: AIVw112QfPrgzEGedkaBTY3PkzaLY89jnJmmoQw1cdII3a1db3VrYU17
        +zMjeNYyW76CryIorfY=
X-Received: by 10.223.150.200 with SMTP id u66mr15268024wrb.216.1500928484779;
        Mon, 24 Jul 2017 13:34:44 -0700 (PDT)
Received: from [192.168.0.8] (h081217003026.dyn.cm.kabsi.at. [81.217.3.26])
        by smtp.gmail.com with ESMTPSA id g93sm255369wrd.11.2017.07.24.13.34.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:34:44 -0700 (PDT)
References: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com> <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net> <7DE91669-D603-4C83-9151-78F2D5676E36@gmail.com> <20170724192357.y3oj5urfuie7ffjr@sigill.intra.peff.net> <DBBA7352-5276-4972-A437-F27F5F4C2641@gmail.com> <20170724203215.nnktj55xyvqfmcvj@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20170724203215.nnktj55xyvqfmcvj@sigill.intra.peff.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <1C78174C-36D7-44B6-92A9-8A77D12AC6D2@gmail.com>
Cc:     git@vger.kernel.org
X-Mailer: iPad Mail (13G36)
From:   "tonka3100@gmail.com" <tonka3100@gmail.com>
Subject: Re: change the filetype from binary to text after the file is commited to a git repo
Date:   Mon, 24 Jul 2017 22:34:43 +0200
To:     Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx jeff, i will try it tomorrow.

> Am 24.07.2017 um 22:32 schrieb Jeff King <peff@peff.net>:
> 
> On Mon, Jul 24, 2017 at 10:26:22PM +0200, tonka3100@gmail.com wrote:
> 
>>> I'm not sure exactly what you're trying to accomplish. If you're unhappy
>>> with the file as utf-16, then you should probably convert to utf-8 as a
>>> single commit (since the diff will otherwise be unreadable) and then
>>> make further changes in utf-8.
> 
>> That was exactly what i'm searching for. The utf-16 back in the days
>> was by accident (thx to visual studio). So if the last commit and the
>> acutal change are both utf-8 the diff should work again.  Just for my
>> understanding. Git just take the bytes of the whole file on every
>> commit, so there is no general problem with that, the size of the
>> utf-16 is just twice as big as the utf-8 one, is that correct?
> 
> Right. The diff switching the encodings will be listed as "binary" (and
> you should write a good commit message explaining what's going on!), but
> then after that the changes to the utf-8 version will display as normal
> text.  Git only looks at the actual bytes being diffed, not older
> versions of the file.
> 
> -Peff
