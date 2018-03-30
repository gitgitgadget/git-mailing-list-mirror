Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8188F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 00:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeC3AQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 20:16:54 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:42415 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeC3AQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 20:16:51 -0400
Received: by mail-qt0-f174.google.com with SMTP id j3so8047763qtn.9
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 17:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9UCBtyLslrZcIjbuOic6hw6cqayhqnaDxb1Pl4vuRFA=;
        b=FZ7Lvb4DheavQunLkGw/l6jUcIHM7FcGVaN8vMCMxFbjgfzbbY+jIZUTICJK8rBNK3
         115dSbGCPt5AzDHnkIXFeMNeQLUk2VtD51/tsw4TzClrm0x7rf42xSMDbH3sgsgSbVrT
         qbn+kSc7ne6q6rhncN6I3CQJRYWeNrxpfNAm0oPwqOKUAGoSCpY8ybkWxFtML2tFFYoQ
         DIoff7GYKBPd59BgAzve1LhqdHQ3xWoQJoZqMadkLdVswJKEbu9GaGW/7v52sTex1RAM
         uNlKN8xOnv3Y1spPwQlMMU+sNj1oRPDk0LJMqxVwtXJg63ASds5odDURR3afUAm3wpRf
         Oglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9UCBtyLslrZcIjbuOic6hw6cqayhqnaDxb1Pl4vuRFA=;
        b=H4a8FnIXLwc8zOe4AeDKjpkp7VQH4bFwTu5cChiyoc1wjNWSUCFoPqj2lIboHojIXO
         5QC6CP1rrp0s/6yLe0bDT3MJbjfBrMvMyxEXJlD92Ho3LJBotgLzIap0zdq2o+/Q/7I/
         myEBdD5+QiYE3GCDducvdi/HKCiJwO/UKK8AQg191s7jb+Bcbzidf0NgETbJYwfopC8r
         YrrUv5wf//SDXyfE18OoDppy1G6b7C6yZYSz5OXgNy3c0KNCeHq90WZzL5VLOoJs6aaz
         K68zDNiDUHZGPWf9LKnFnDEGXsgchx+5CgvECN3sYYreVDXJgjWLvS3R/Rpyyb2wUgmd
         rYmg==
X-Gm-Message-State: AElRT7EjPq10VNdwXEfzyQXdH18jA71MTgxFyxihhbuGW3X4BvDRzGIu
        2rmXVwK5b7tEtNEqQhnCX/weaIhbOGTJgxnvdXA=
X-Google-Smtp-Source: AIpwx4+80y469CzlyUvcq+EqJ2BBxJHBamgVitoG5zaglzWr6C8RKC6kgx9cNimaYOUFQ/cP01mKvRkFQvtJlkH7h7M=
X-Received: by 10.200.80.78 with SMTP id h14mr15247623qtm.154.1522369011256;
 Thu, 29 Mar 2018 17:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 29 Mar 2018 17:16:50 -0700 (PDT)
In-Reply-To: <CAP8UFD2EjZ9-qeS-3oWWS8O8ayP92aXAxAb1qK9qjKKqDh7y2g@mail.gmail.com>
References: <CAL21Bm=U=p+tw5FSXXBU01Bm=YCS6oQQSseB-Xv758onmxszwA@mail.gmail.com>
 <CAP8UFD2EjZ9-qeS-3oWWS8O8ayP92aXAxAb1qK9qjKKqDh7y2g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Mar 2018 20:16:50 -0400
X-Google-Sender-Auth: L7_XHNlXwt-LMguhToAK4xRBOUk
Message-ID: <CAPig+cTWKXrWggWO5EXA9dvpgW8rzZs=+XN3TK2GN4dM_gPiKg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ref-filter: remove die() calls from formatting logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 10:41 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Mar 29, 2018 at 2:52 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> Move helper function from strbuf to ref-filter.
>> Get rid of some memory leaks.
>
> The above seems to be the changes since v5. Usually in a cover letter
> (patch 0/X) there is both information about the goal of the patch
> series and the changes since last version.
>
> Repeating the goal in each version is useful for reviewers who might
> not have time to look at the patch series before, or who might have
> forgotten about it.

Another important way to help both returning and new reviewers is to
provide a link to the previous iteration (or iterations), like
this[1].

Thanks.

[1]: https://public-inbox.org/git/0102016249d21c40-0edf6647-4d26-46fc-8cfd-=
5a446b93a5e2-000000@eu-west-1.amazonses.com/
