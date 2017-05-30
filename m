Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A1320D0A
	for <e@80x24.org>; Tue, 30 May 2017 01:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdE3BDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 21:03:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35208 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdE3BDj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 21:03:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so14178322pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pQ0WS0bBfYaoU/hFOpiMpY7x/GE3erRxepiUvJxSAVU=;
        b=IdQ/SGucMRmEquxiEcn3ZYQvYmA39UVJlC9LEi4rurhSOg4y03JzLrdU/lNKm3boxQ
         zO0Vo/CfDP58LjTys+HAvxaTj2qfORIU5KLTV0PG00TPHpzRpHlnbybYi9TDRd1gtpOn
         DOAd1kqA4SEgoC6v1bIQG1BiuVymW+7NOy/ribz+Ny827dNTSaoERbRrc1Fx2o00BW+q
         JgyAsQ++EcAKWBGQllfG+TUAtpnnZl5oI/TQ88gddlKzq53FaXu7k73F7T1F9bjA7blc
         zLzzNMxW14HVY/AVQ+cxOYbZoVhtCEWbPbUynOYw5yWjL8qxUPAhvSRdR0ecXx29z3tv
         fyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pQ0WS0bBfYaoU/hFOpiMpY7x/GE3erRxepiUvJxSAVU=;
        b=GvSGwwFGgFW0kApqP5LNSo6YHcU2ynU0dekpcGf6YiIUmCmuq3Lwlqwx2WWCoZuynk
         rx0msJQFXoUAdPnAaI+xrzBFJBLORDYVBwdwCa8J071srY6ALC9BgUwIKXgCnGaXLbu3
         BzvQxvweXxv7Yyr+VTVN/Aw9jVTMnVBDrjUr40pVgit+lwLZ3yR5dfYfV4E/NKgCdvsz
         1oPtO+kYJAOfTm7ka1SU6bElwBy42Er8g9dSXM7x3W4BCN0OthsyRdOdgasFS1E+Dsbk
         TW0Ojhde13FzQpw1ngHHvqyjTxvC7NySuvLvfs2WG7IVykN2HEvfdnFc3yxQp6NLOGyZ
         hYAg==
X-Gm-Message-State: AODbwcA3gJHVBz+LIC1wP/V/3n8JCaWgLg0xZUO7F3gewgY69ul/s3sm
        /uisgoeJ2HMuyQ==
X-Received: by 10.98.63.14 with SMTP id m14mr21042151pfa.143.1496106218712;
        Mon, 29 May 2017 18:03:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id s82sm21869730pfe.57.2017.05.29.18.03.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 18:03:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
References: <20170522135001.54506-1-larsxschneider@gmail.com>
        <20170522135001.54506-5-larsxschneider@gmail.com>
        <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
        <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com>
        <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com>
        <DB31E695-B7D5-4337-BACD-5191EB642F40@gmail.com>
        <832A4D04-F32F-4D1F-A5CE-3514F8469E63@gmail.com>
Date:   Tue, 30 May 2017 10:03:37 +0900
In-Reply-To: <832A4D04-F32F-4D1F-A5CE-3514F8469E63@gmail.com> (Lars
        Schneider's message of "Mon, 29 May 2017 13:11:55 +0200")
Message-ID: <xmqqshjndul2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> That's right. There might be some code sharing opportunity with Ben's
>> code that is already in "next":
>> https://github.com/git/git/blob/next/convert.c#L660-L677
>> 
>> Would it be useful for you if I send v5 with the changes rebased 
>> onto "next"?
>
> Hi Junio,
>
> sorry for bugging you again, but Ben's topic did not make it to "master"
> today. Is it OK if I rebase my topic onto "next" and resend?

Sorry, your earlier question was lost in the noise and I should have
picked it up during my last sweep of leftover bits.

If you are depending on a single topic in 'next', it is better to
build on the tip of that topic, not on 'next', if you can figure out
where the tip is.  In practice, while we are exchanging patches via
e-mail, there should be no noticeable difference either way [*1*],
but once you start throwing a complex and long series, you may want
to publish it to a public repository for reviewers and the
maintainer to pull, and that workflow might give us an easier way to
review, but a topic based on 'next' will never have a chance to be
pulled to be merged for real, as merging its tip to 'master' means
it will bring all other junk that may not ready.  So if you anticipate
that to happen someday, practicing to build on things that are only
needed (e.g. if you depend on two topics, you may start by merging
them on top of 'master' and then building your change on top) is a
good idea.

No matter what you do, please mention on top of what you built your
work.

Thanks.
