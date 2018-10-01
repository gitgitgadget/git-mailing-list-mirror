Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445B01F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeJBCWT (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:22:19 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33273 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBCWS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:22:18 -0400
Received: by mail-yw1-f67.google.com with SMTP id m127-v6so2419160ywb.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dRZiYAzrIqSLuXb5p+9g5gUBJWOqL08zfAw6z5p8maw=;
        b=rUhMG6dyawMn4KgcC05JNXuGGpPl9dKHxFuS046HhMFEpU1nXLXaYhwseGvUXg/IS4
         yN2kJuhiCdsEHB+LVGMV7WHRsWlNFIMAEXwxthvu7akJg3be8Cvy+WeRDX/k/zMBferD
         njbZH5Cs6TQ5hD2+jGHqJzn20Xvq0gwuqLoG29B28ejSKUs0uNTl5OdAe4qgNmHSl8Ss
         WupomOjuEW8jvdeq5FwA7AQZ7L426vGJh3g04xZl+xK2hCUeFGsMrVjLhXc1amVPtW3/
         d4mBSEMsSB7eJT4gghhQhmNZ8TAVOLU5G/gg2bi8qved0bzmN0WzV69oXfBO6nAUlbR1
         AXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dRZiYAzrIqSLuXb5p+9g5gUBJWOqL08zfAw6z5p8maw=;
        b=uP2auK0ngoWunQk8GUBrWCXoPB/vodfnYiz5Ys/KgheMBV+ONbayik27cVsF6JPI2J
         wY4S47ocj8w3wmUpRmZ8KIpszFEFQElYBjT7jc/BzN0gGEKqucOhXdgaee8kYXk+Qj3a
         s+fSQq8u5OZI+NdF6IjmTjLLunlVeZ9ckk8bCqB8TDsy/bav2aUKiEyVt77GgbCf/CJv
         ILM33RyiDrQK8vaXM5/jj6DXhfJbT6z2JLCp/kIBpzTtgQwoh+RGyIv8XRqcmJkgVlRE
         Yb2tQ1lRhXvyWMSgxgMfAGnXjXT7dilqp2hCCy5w9OZyQ9W0P8vsU1HBkQKzDGP+y6nA
         gKnw==
X-Gm-Message-State: ABuFfojYIsQUStdhZbiyRudFiBn903rr2pKsqVJwaDmgPJ7y+dV7euXT
        b1riwZMcPHi4Gbhz+l7/e4kD9Oqn8gyy0XDWepoK5A==
X-Google-Smtp-Source: ACcGV60LkMbv8yY1q5Bo8+3JYNxDozhXaFIesSlbdi11PqFsP8fzuJlrOsifgzn14Ltj38z7JbAth7Qs3MeJb2JDM4A=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr6595384ywb.370.1538422976749;
 Mon, 01 Oct 2018 12:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180917140940.3839-1-ao2@ao2.it> <20180917140940.3839-10-ao2@ao2.it>
 <20180918171257.GC27036@localhost> <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
 <CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com>
 <20180927164415.44b1d00ee5f8e582afdaa933@ao2.it> <CAGZ79kYHLF0TVfVuVfKfe_A4D2QGziRCsrYpyh7wuHjdpPEkDA@mail.gmail.com>
 <20181001174504.684457e627ed76abee5e19b8@ao2.it>
In-Reply-To: <20181001174504.684457e627ed76abee5e19b8@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 Oct 2018 12:42:45 -0700
Message-ID: <CAGZ79kanvDJcCQom6-w-LBUW7ST9Nmfs9ysAjBYBy2GTAzgx7A@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
To:     Antonio Ospite <ao2@ao2.it>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 8:45 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> On Thu, 27 Sep 2018 11:00:52 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
> > On Thu, Sep 27, 2018 at 7:44 AM Antonio Ospite <ao2@ao2.it> wrote:
> [...]
> > > OK, so the plan for v6 is:
> > >
> > >   - avoid the corruption issues spotted by G=C3=A1bor by removing the=
 call
> > >     to repo_read_gitmodules in builtin/grep.c (this still does not fi=
x
> > >     the potential problem with nested submodules).
> > >
>
> Actually that is not enough to fix the inconsistent access to the
> object store: the functions is_submodule_active() and
> repo_submodule_init() too end up calling config_from_gitmodules() and
> need protecting as well, so I am going to put them under the git read
> lock and leave repo_read_gitmodules() in place for now.
>

>
> I am asking because the whole point of this patchset is to *enable* the
> use of submodules without .gitmodules in the working tree of the
> superproject. :)

I was imprecise and meant to
s/.gitmodules/mechanism to configure the name <-> path mapping/

In this series, the .gitmodules may not be present in the working tree,
but it is still there in the repo. Later we may want to rename that file
or put it into a magic branch, and I'd still find it a good idea.
What I find a bad idea is to have only a gitlink and a repo put
into that path and expect that it magically works as then it is not
a submodule, but some "halfway there thing". We need to have
an explicit "yes this is a submodule" statement, (which currently
comes from the .gitmodules file in the working tree), and I am not
attached to where it comes from, but that it exists.
