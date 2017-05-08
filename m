Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB6720188
	for <e@80x24.org>; Mon,  8 May 2017 04:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdEHEUB (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:20:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33091 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdEHEUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:20:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id b23so8236581pfc.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LdV2F6+2+4uu7HsGHO5Vfq9ZWF8dicQMxZgNHDfoX6E=;
        b=SraxQTw+CzaAeStrk2S3GF+2HtpChY+5m9ojdir2lldJpROZiiN9uO16tBbGSX5oHR
         goe6v1l+OV87xoE5/CsPm+XoLMBv20F9efE2zHdwq1BUxZ0Ui1JW8794UOo6hw5e2VV8
         UYM3RFEtGSOlfgG1iwyO2wort+s6tE8sKWAXSXdoNPu1d6JnR9m1CFh64dy0dLeQdtuo
         wy0XetxptzcNKXjYqFmYjUHtGzsxX4GDl/91rHBU66PRwQsbLfB1eau4Pj/VGEkSqT1H
         JNfDw5xA1vBcED5/u5DBxUyqVJosS0eHckSZ27bLqtAOZqpBPu/+7X0kUz2btVxTmXmF
         Fo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LdV2F6+2+4uu7HsGHO5Vfq9ZWF8dicQMxZgNHDfoX6E=;
        b=e5eXwo/Z0czLuRM2RnY5ylWp1XWw2GqoIQ6+2vbJVcpiQvNCyNqOo+Yen3Jkf47vTB
         q1ge1sP+IFBYtqFOaKxkTlOJ8V0uYBKTykTMr+UqC0XKfu1oZd+p3kbTtorr3fRmSQyA
         dfUJWo/fcowMmiknxiHAPIZEz9/goHQRzcvSvJGgLhv4ZB3XjAb6alhxI88Nv+LVS6RD
         nqLtky8z/1rPVZWjtLq9FlYJxqn0h/ga8RkgyTamssAmmP4h5WGqCGF+437WwqNP/oEg
         qTfecKwHx0evzBmERkFsLz3dgYxqqm12gmtL0ZmT5vAWbW1VbkEswLA/FLxxt7I1kGei
         wjYQ==
X-Gm-Message-State: AN3rC/7o0p2AALfgVPg7PulrBdevfH+FBtsikUyDiTzLTuxS8CRgcSLi
        SooG7sWtl/drDg==
X-Received: by 10.99.95.138 with SMTP id t132mr16342911pgb.212.1494217199719;
        Sun, 07 May 2017 21:19:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id j125sm15420072pgc.53.2017.05.07.21.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:19:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
References: <20170507233512.GA9332@HP>
        <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
        <20170508111836.GB3014@HP>
        <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 08 May 2017 13:19:58 +0900
In-Reply-To: <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 08 May 2017 12:41:03 +0900")
Message-ID: <xmqqlgq89dzl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But to help "some users are not aware of this" situation, an opt-in
> "feature" would not help all that much.  The same number of lines in
> the documentation to tell end-users how to toggle on such a "safety"
> feature can be spent to teach them that their local changes in the
> working tree do *not* belong to any particular branch, and as soon
> as it is understood, the user would be OK.
>
> So...

It might help if we treat this similarly to how we treat the
"detached HEAD" state.  By default when you do "git checkout HEAD^0"
(not "git checkout --detach HEAD"), you would get a large warning,
which you can silence by the advice.detachedhead configuration.  In
addition to the list of "these paths have local modifications" that
we show as a reminder, perhaps you want to show a warning that tells
the user that the local modifications in these paths are not
recorded anywhere else, or somesuch, and silence it with a new
advice.* variable?
