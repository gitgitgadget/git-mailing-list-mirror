Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53B620248
	for <e@80x24.org>; Mon,  8 Apr 2019 11:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDHLGy (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 07:06:54 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35063 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHLGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 07:06:54 -0400
Received: by mail-wr1-f47.google.com with SMTP id w1so15885646wrp.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OZrPaapTglowGGnjM0ZScR5GdY01yaKHs+ZE/LJYBIA=;
        b=bx+KqpVMysnXKpprIXzAwSLvhdKlbwBvCejmdrjbFmYEyRMvYbEbfSndnOdYHGh1vu
         zq53rT0OKR3hv1L9XnS86b5oyeu5n7u8ROHH2vGS5Tn904iqU5XrQT23mWjOp8pEVZjB
         vsYN5PxK95qNPtnv9rJUZfcBRe2D/1ke1ME8r//iN7lUOMAyyBmIaJqTCul0W3rjj+tr
         35wiqAQOwdpy3fi3o8y/H3r7TsGUS44UsocoRBlh52N0N73VwaH6d3YyijtIQ9k8GXx9
         vCVo2hmeQOq+jdtjv6NVaJA4DTHObIr7MePcHmCkzyl5wrYJgmV3mlghdCrYJNWCd9Zm
         T57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=OZrPaapTglowGGnjM0ZScR5GdY01yaKHs+ZE/LJYBIA=;
        b=QqZCyuU+i47/x6Ph+Th8SMoWv3JvAhlrp8YGN8BEtNd8rC+R3mxk/tiABsJDsWzLd/
         D0ljgmVrWGJEbe80llJFysKR+OhwTJBPI4UXePIpmhiTYNE1WTKnQBB8Y50xxDmdvXC6
         vfTSdxR4/tLXfjXW3/n/jfTNF6h0dirqzjGRArcfhzF9+nJawHBaDwPqph20bkZsAFxE
         uyFQCgU9U7sdgwr8Pqx6bnwaJjCCDBqTE9RsqokGjBeY6ODW9VGEGffLepPTTM6IT2vh
         noLKwZaY7OnBKIe2o89lEvg3nJQjoBHTnz/IKNL6f0E9bDfqnVspFjJ487FC4szzvpw5
         gXUA==
X-Gm-Message-State: APjAAAUiQl5GXoJFEl/V1ssIEvRewVOzsUiILjXnGLGr082bTbhuxB3g
        5YNRxz1dbrcdQBap1zmvxhhDd7Q5DEw=
X-Google-Smtp-Source: APXvYqxETVFb9RmGbtWJZDffxhcuIOzn79DKZFjZza/clcrXC/yd3JwBiv/krtU4quivEfph6Ta83g==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr17507144wrp.31.1554721612043;
        Mon, 08 Apr 2019 04:06:52 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egg215.neoplus.adsl.tpnet.pl. [83.21.70.215])
        by smtp.gmail.com with ESMTPSA id b3sm31946341wrx.57.2019.04.08.04.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 04:06:50 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: "commit --author=..." does not work if global email and name is not set
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
        <8636mvng8n.fsf@gmail.com>
        <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
        <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
Date:   Mon, 08 Apr 2019 13:06:47 +0200
In-Reply-To: <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
        (Piotr Krukowiecki's message of "Mon, 8 Apr 2019 11:54:29 +0200")
Message-ID: <86y34kn4c8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>> On Sat, Apr 6, 2019 at 8:25 PM Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> Better though is to focus on what you want, namely to prevent accidental
>>> commits without specified author, instead of how you want to achieve it,
>>> i.e. using --author to provide both author and committer identity (the
>>> XY problem).  On that machine with "automatic test account" set up
>>> pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
>>> environment variable is not the "automatic test account".
>
> I'm not sure if I follow you. I want to be able to make both "real
> user" and "automatic test account user" commits from that machine. I
> want to make sure that:
> - automatic commits (scripts) use their own account
> - real person making commit uses their own account
>
> IMO the only way this can be achieved is by not having any default
> account setup, so that both the scripts and the real users need to
> specify it "by hand".

If a real person making commits uses their own account (just on that
machine), he or she can set up `user.name` and `user.email` settings in
the per-user Git configuration file with

  $ git config --global user.name  "My Name"
  $ git config --global user.email me@my.email.com

If however one is doing commits from the "automatic test user" account,
then the `pre-commit` or `commit-msg` hook configured for that specific
repository for that automatic account would be run, which can detect
that the commit was not done with

  $ git commit --author=3D"My Name <me@my.email.com>"

The additional advantage is that you can examine committer data to
detect such cases of committing out of automatic account.

I hope that helps,
--
Jakub Nar=C4=99bski
