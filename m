Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152A41FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbdAIXD6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:03:58 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:38512 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdAIXD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:03:57 -0500
Received: by mail-it0-f43.google.com with SMTP id x2so75295203itf.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 15:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrqI0wBIxYjfRvksOqSimSUFP4ZhSkr9zfktAwfod9o=;
        b=PRiPcZ03X7lc6BASc/AlM7c0wjn4FkZMIsAXx9y2j6FEVfkyfJH4nJFQkbIBrdooeq
         mX+2fo1H6kUWdFkZ2Z73C0F9M09xTaB8wCLPoDcO2VVniq9DiWi+n77ajviWbLYHsJbp
         jUXZHxZ01RUiJ/d0SK8MuKodwOyKGIThVHfjBRphnxew6OL3+E8/PlJ3LMfX8esfbZB4
         wnqXLjU8yl7/IvXo3m+0vxLWyGvDi8C5HiexkeiHt4JodcMdE5fuH3qIB6df/2Cww5J9
         XK+TStD2V/IlWq6Q0ediVtVzZEmQBtEVpws4Bck52xF2ZDn8nxVWMI4hwJD8xXwru+RC
         zIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrqI0wBIxYjfRvksOqSimSUFP4ZhSkr9zfktAwfod9o=;
        b=QezcQsyP+YX+ftssOkjDbsvkeiNfP403EZWFcfHsuk9uHBuP985WFRvlG6ZYyJkYo/
         vcs7oouB0ssPpcer5O1pkaLVe/nqk0KK+SmA0DSVSZm/JSa72zxijpqPATjROlDDwNWH
         WoX0K3fl812YLhwkQmCKIozp6Ov0xC7ik+2KRM0Ag+qFf6RYN2qhf2NKljKVKLulRxOW
         dAvc+hgyZTEtB/yBSdRBFWxOlyN9xTmA7hNzadi1+MhME7v/fxP9jqG7Rhp1w9MXxQtJ
         MfdpgdMBSb6S4f8/htcOD2b8THjusQs1OZ6tA3mt0bupxmUC2R5NEsqjeXsGUjrVa9He
         MUxA==
X-Gm-Message-State: AIkVDXIUOPYytKyiFqQkWPk4hsumbiGX1dBnexiLQXN3PBT43Q8mce/DiRxbgJYP4Z4Kzx2fqkkyHArNm1zJC/Ck
X-Received: by 10.36.6.5 with SMTP id 5mr10706183itv.116.1484003036300; Mon,
 09 Jan 2017 15:03:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 15:03:55 -0800 (PST)
In-Reply-To: <xmqqeg0bu9oq.fsf@gitster.mtv.corp.google.com>
References: <20170109224330.28405-1-sbeller@google.com> <xmqqeg0bu9oq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 15:03:55 -0800
Message-ID: <CAGZ79kZVKFvijfwEfmiaahz2VYgaa=m2m-ty2tbOXh2toO_muQ@mail.gmail.com>
Subject: Re: [PATCHv7] pathspec: give better message for submodule related
 pathspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 2:53 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Is it only me who sees funny black rectangles in front of these four
> lines instead of blanks, by the way?

I copied this part literally from Jeff. My mail display-client (gmail
at the time)
did mangle it apparently, (it inserted some non-breaking white space characters
as well as a character that I can not really identify, as it is no
valid UTF8 and bogus
ASCII)


>> +TEST_CREATE_SUBMODULE=yes
>
> Did you mean to keep this?

No.


> because use of touch, when you do not care about the file timestamp,
> is misleading.

makes sense.

I'll reroll again.

>
> Thanks.
