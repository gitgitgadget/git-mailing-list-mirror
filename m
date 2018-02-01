Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532E81F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeBAK4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:56:36 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:41569 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeBAK4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:56:35 -0500
Received: by mail-qk0-f177.google.com with SMTP id l29so18778318qkj.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tdq3MW9dChuD7aOcSzv1XQrTBe3mHEYHyGo7kuNV4fM=;
        b=jM35Ly7WkbfYZNjUbNszVDdekGwAGYzXin6zBHh3d2Cr07b6k8Jiq0yZdspM7mwqcU
         SWlLnugc//skZVOnt504jsi5ZpnqvDX9IbsPbONLKISh22Jfqx7Mfk6YLU0XKWgoUTyk
         grnSiWl5COBhyXQQwHNObkXqFBKecxaY4Qjbz258dwedk5ZSBWEU5kgZ9QdL3DdLhXvn
         CszghaoQJKt7CqsDaTeBCQG5q5ySUmvQjjnrEvdvNuCQAunY2F6q8fb3oXOql2FZdHH0
         8xuLoeGpxSssI/JOvY2rPH/E5loCFVCcfQR6VBtFLJzn9pRioQRANyO4VsJ5p4B6HQLU
         346Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tdq3MW9dChuD7aOcSzv1XQrTBe3mHEYHyGo7kuNV4fM=;
        b=SMEqqylf+PjlmSwVEMs5az/zId/Juo54QQrsLrUwV4X0zzRblQqNddbrA8orrQAWZx
         Vji+rhuTPa9PJwYN+/gur8S+gQZkCjg/f+s0nDGeu+fz1jDQfYz30nnAcKPKsGQDgCGp
         qYpr7XMTlOiCKD5JZRZWvBhKyErpsFATZDmj3R7azpfdKPIB4vnEefrYJsuKAGh84E7V
         oLtjijFgzgfjyT2XtzL4qRLJqnRnMVNxTNv0GpXvXfDqrXOgnQ3C/J9WuVHBezGXo3UV
         gtbHLnowiJwpK/jb4Y6Cs4NvS1pq3PDV8MLkPQCQ81ZB+vp1g3tpHu2EBVAZ84/rAVRK
         hxVQ==
X-Gm-Message-State: AKwxytdTFh17DaKJE8ULJ8/uUupqZIF9ra/WEhWyx4aDcOq02TrxeATA
        pQbV/GNP9SCy1RTgBqxxGaN0lOcuRecLl2CLUIk=
X-Google-Smtp-Source: AH8x2271NIt5eI6kCOoS10v9KyUvJ4hnNgBQyuIDXR2d8pKm5nkhTGdgcIUoK15EbwGMFADXdL1zxdXFHhKuBg/WvHg=
X-Received: by 10.55.143.193 with SMTP id r184mr50503385qkd.164.1517482594891;
 Thu, 01 Feb 2018 02:56:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 1 Feb 2018 02:56:34 -0800 (PST)
In-Reply-To: <bbc03595-cb31-63b8-3f4c-cfa04bb9ff27@suse.de>
References: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
 <CAPig+cTFsp60KB+quuytW_nV2crLcjRV-PYN-3bO7tRY0_xu6w@mail.gmail.com>
 <fb3387f9-a341-c4dc-fa37-581229fb2c1d@suse.de> <bbc03595-cb31-63b8-3f4c-cfa04bb9ff27@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Feb 2018 05:56:34 -0500
X-Google-Sender-Auth: NLJ6yLKlg5nmL789LYfT-w7fJgg
Message-ID: <CAPig+cTEoM3qYRN6j=zSVv1LPx_ggVuxqTMMK0SpjtYEqOiBMA@mail.gmail.com>
Subject: Re: [PATCH] tag: add --edit option
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 5:43 AM, Nicolas Morey-Chaisemartin
<NMoreyChaisemartin@suse.de> wrote:
> Le 01/02/2018 =C3=A0 11:34, Nicolas Morey-Chaisemartin a =C3=A9crit :
>> Le 01/02/2018 =C3=A0 11:16, Eric Sunshine a =C3=A9crit :
>>> A little below this change is where launch_editor() is actually
>>> invoked. If it fails for some reason, it prints:
>>>
>>>     Please supply the message using either -m or -F option.
>>>
>>> which seems a bit counterintuitive if the user *did* specify one of
>>> those options along with --edit. I wonder if that message needs to be
>>> adjusted.
>>>
>> Yes I'll fix this.
> I just checked what commit.c does and it seems to behave as my patch:
>         if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
>             fprintf(stderr,
>             _("Please supply the message using either -m or -F option.\n"=
));
>
> To be honest the message is not that clear either.
> If I'm reading launch_editor right most (or all) its falire are du to a f=
ailure to launch the editor or the editor crashed/exited with an error.
> In this case, I wouldn't advise the user to use -m or -F but to fix its e=
ditor.

Indeed, I also looked at the implementation of launch_editor(), and my
"wondering" about whether the message needed adjustment was just that.
The message seems somewhat counterintuitive in this case, but I didn't
necessarily have a better suggestion. A valid response, therefore,
might be to punt on it and leave that change for the future, or
perhaps take it on as a second patch which adjusts the message in both
commands. I don't have strong feelings about it at this time.
