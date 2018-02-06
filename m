Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8420B1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 10:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeBFKBW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 05:01:22 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34120 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 05:01:20 -0500
Received: by mail-lf0-f52.google.com with SMTP id k19so1877719lfj.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YxXYcax/oxgZ/L94ydTluRDNSBXs9iCpLhQaIKHFQkM=;
        b=b6drlXIANsghdJN/P/1N/S6kxJbgLkqA0fGbpn2d1nEwEYki4uu4qKbzVPtd3HUpTx
         RntVH45WhROYCHSYdw9fjGEDD+dWBnOGY0Yb7Yk71t8aKCZJeOhIeQcLs87MRDtvGb+s
         MSuqL2/Q9moKocH8OUl219+eab0hlaafuwOU9VjMwnjoHXiIien5zxKeT21NZ8U/pHyU
         xiqd3JOr8iQhXqScfj9ApPbH13nV/4xXVt+QlzEOv8tq+81twLtBDPpCtY130ADF16l0
         j29tvXNEyZfmXhu2stwQ535j1RhOKXu9KiPdzgYs/rMwjzDhM/6r328n2LZBJqLfPlAy
         8qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YxXYcax/oxgZ/L94ydTluRDNSBXs9iCpLhQaIKHFQkM=;
        b=JK18Ei1i/kV6LhIn2ZStSSRoLWFf8DvH/PboQPd9vJLJSBMLo//OKUjWNfCT9rw4Xm
         gW/o2dK8+SRLqK2VWTnsuHbXS2GdrxrPb8qp8HiGrD+FKUxyStDhnVn3acft2+RPIoij
         JuJ2ybJS2hAl+6lqxntHlFB7pYCWD14rm3FFaQJkBEAmKCab4tWf88SG3K5G7Z3ufH70
         TdClRYXk6Hp0ACB4WYBiL/Kj4pEwd8T0nD+i7vD4CvJ32HLVlPriWW4apZbR4Rov0+/v
         HktvQAmx7Hd4acyeeDMiP0/uX1v4INnrEq1IfK1jMtOm/TqwLM3a82qj8/ByY3VXOItA
         W8CA==
X-Gm-Message-State: APf1xPA/jNZpaj7CS2NtaLa27PJfYwcRYBZvVW6gk5xmLdxBI4yRf7gM
        WaC8S0CtvBCU2aaW6xjQ+XAYW4SZkWialFJ26ro=
X-Google-Smtp-Source: AH8x227KMjAiE2yuru6nTtsbj2DE+ylwNbRaL9X870awxJxqvK9GuhYbWMUMBxncLzYEN1kNjaj0yh3b+C2hLHaIJEI=
X-Received: by 10.46.82.220 with SMTP id n89mr1261401lje.145.1517911278802;
 Tue, 06 Feb 2018 02:01:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.181.210 with HTTP; Tue, 6 Feb 2018 02:01:17 -0800 (PST)
In-Reply-To: <CAGyf7-Fy_APBx8aK2_L5nQN5NfLSxh+qy12Sd8QmLh3LP4KRkQ@mail.gmail.com>
References: <CAOKXNqBSqEP7aikjM1GE=p7jWBsN13Xy3qVL-on7RnrUrwi+bg@mail.gmail.com>
 <CAGyf7-Fy_APBx8aK2_L5nQN5NfLSxh+qy12Sd8QmLh3LP4KRkQ@mail.gmail.com>
From:   Zsolt SZALAI <zs.szalai@gmail.com>
Date:   Tue, 6 Feb 2018 11:01:17 +0100
Message-ID: <CAOKXNqBbZKm7hXPPVGab4f6tvmJOLYiPFNQkFVShv_a-gJwFzA@mail.gmail.com>
Subject: Re: repository history?
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nice, thanks.
For what I needed now, it helps.

Thanks,
Zsolt
SZALAI Zsolt


On Tue, Feb 6, 2018 at 10:48 AM, Bryan Turner <bturner@atlassian.com> wrote:
> On Tue, Feb 6, 2018 at 1:41 AM, Zsolt SZALAI <zs.szalai@gmail.com> wrote:
>> Hi,
>>
>> I wonder if there is a feature with which the history of the
>> repository can be listed?
>> i am interested in especially the usecases of pull and push, i.e. to
>> query when the a branch was refreshed with remote changes and which
>> commits were pulled, things like that.
>> Is this possible?
>
> Have you looked at the "git reflog"[1] command? That can show the old
> and new SHAs when a ref changes, and you can use "git log" to
> determine which commits were added. That said, it's most useful for
> fetch/pull; push information won't be as easily derived from your
> local reflogs.
>
> [1] https://git-scm.com/docs/git-reflog
>
> Hope this helps!
> Bryan
