Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D40A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 23:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbcJDXL7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 19:11:59 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33055 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753980AbcJDXL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 19:11:58 -0400
Received: by mail-qt0-f178.google.com with SMTP id s49so30451755qta.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CWKIOR/nnfzIzR2ky20LCHGFt60H7J89cI/8vEGJgCU=;
        b=RE9zUVKEtCx9HxQisvezGmyJxUYFaDLbQL+nNjxlnraBbragHO8qCwB5RyR2J5Rq5j
         +dbiNanUwPkq4qDni+e0wQStQCAvIW+JjAKDHGxWM+nfBYu+GKaiP3eXk80SKzvqLCa0
         TIkpFUbW8xoGZlx/7+XMOV/uQJEbySHc6xMXQBQ1v4JIrVRKSMm3YzVQd1s+qljU6RTV
         +foc3H31mesnz8eRv0DshVuQQi1aNV7g/sZw9eAFvMBSI5VknwpcUFAS2lcVO1y+vV6h
         nKLnjUsinX8phk5Aipefvhtc2vuXnLpwv49yE62fD7w/b+mHquuVwPUzVzkBPe8v1gAI
         XmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CWKIOR/nnfzIzR2ky20LCHGFt60H7J89cI/8vEGJgCU=;
        b=h2fT6v3+iweSMCwLRjLu7+3sL6JRlB4kJD0/2VDzFyeBw746jalN91QnlZPPcS/f48
         E8+/L2QTZhF2RzsS5QQg3cU7BjstsjOK/wm6u+L7ELry1VHr9sVW8nQZ1FhCVxnckDwu
         V/+yNATz10CQzPj2+b4muZB87FFA025HTRxv6/8rqVw7OyCjvWFbp2fwtIwqbwRDvdIg
         saC5XnVhiADsaAFmBKyTiAwv/5runqgPe0FR/YJwrSfTWDX1a4gPhTR+OXa3LoNqqfRu
         i1HXmwHSJYTpRu2g9Wzn2ajrFjU+zLqVz+ZjUMkj+DoQjpxt2tzdVJYWBXqR4rhbAJZl
         JKEw==
X-Gm-Message-State: AA6/9Rl+O/3/myDeLE2hwNElDBeqad84BZ2CZ5g5bQNsK0HVVw+GLBsYIalrVnnjSuN/QE4WH0YY8cJJotbqUIjc
X-Received: by 10.200.51.240 with SMTP id d45mr2149640qtb.18.1475622327259;
 Tue, 04 Oct 2016 16:05:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 16:05:26 -0700 (PDT)
In-Reply-To: <xmqqy423rabi.fsf@gitster.mtv.corp.google.com>
References: <CALhephTkohVhEjdP7TwQAcBrEBiHGtp0Hd+UxPUiJHtubMWKGA@mail.gmail.com>
 <xmqqy423rabi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 16:05:26 -0700
Message-ID: <CAGZ79ka=0H-tanoN8_O06p=4PNm-8AvKFU_dAwUOkgocm+TV0Q@mail.gmail.com>
Subject: Re: GL bug: can not commit, reports error on changed submodule directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ern0 <ern0@linkbroker.hu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ern0 <ern0@linkbroker.hu> writes:
>
>> When I say:
>>  $ gl commit -m "blah blah"
>> It reports:
>>  =E2=9C=98 Failed to read file into stream: Is a directory
>
> Not that I am interested in learning the answer to the question, but
> what the h*ck is "gl"?

http://gitless.com/

See 20160930191413.002049b94b3908b15881b77f@domain007.com
"Purposes, Concepts,Misfits, and a Redesign of Git" (a research paper)
