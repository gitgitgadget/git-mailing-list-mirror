Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA5920281
	for <e@80x24.org>; Thu,  2 Nov 2017 18:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933742AbdKBSu4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 14:50:56 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:44655 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbdKBSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 14:50:55 -0400
Received: by mail-io0-f181.google.com with SMTP id m16so1214052iod.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jkHsKuX8S67OH29jaM3aHD5AKOh3oaHtVTKopuV26sU=;
        b=exm2Pthns+Q6WitYnjV+jYQ2vbl44ou9dbpXWkyK9VdpE9xHVZ3PP/sq64rfHr6qvq
         gsq52aMwUrR0DzI6wqskQAeMK3yuVVGeLbCatNiiobV6XO308Q+3zjG85kSyxB9hXYUd
         fmjbJpGz9nshkeuBa1fxPyvbAiM8ke9SiaRf4oJTPPaQLk721VG1R3xBy++C+SYK4ana
         ixO1NOUtR4TZYmVUUChAHgKsSeYgsByiIGPIPbXGfgb6DxW2CWCAjYq/70/9WLWKojDB
         lFASKzjPoa71YxAh0SULGMgRKu4ojxSwXhKSNu6O2JYK/opLriYBcFPZVBh04lx6AfcI
         RcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jkHsKuX8S67OH29jaM3aHD5AKOh3oaHtVTKopuV26sU=;
        b=QNcDQxB0xhi5c/6oaXYPEmmhq0wjMRU2D3IFmSUcNTDHEXuC9HXW4z+oUa8JQXSxhd
         3pBlZSQtn/vd4OFFpzqFBYSKYDGX+jHSpsJQJqQH9AThTnfPnj/rvg8DcM8H25JPVRdc
         Jwp/BAUYmLtUqJEIWM7ZBxqUzLaiHhfrRgDECcmw1Fi5WJSP2kjynVT65dMr/QxLfZdb
         7daQ2h1FPKWWG2FO8wyxyHMT5ajoGAEWtqSss6xMpgw6Z8sME038huiMEY0QLtA6Y35E
         8g9k0olsCAacqtFYc4VhoIUVjpwRf9LR+Vn/Hw1/93e+iJ+2QKqrLQOCBbmAZjwEe+Rq
         2Zqw==
X-Gm-Message-State: AJaThX4HFNb60hKUUHR9aO4bs9Zt2QoXcqAc999fLye4Yd9xnIwFbyM/
        UUaDhdKH55KAKflCktU8q23h2YhNHRdmT2ftLhY4eQ==
X-Google-Smtp-Source: ABhQp+Tsy2n6V5fGqVO0ywGQmq0a7IL0jlE+W63y7RcMU6vT6r9jvrtXjj6QQEe/XlvUg8/IGTEYGWqXF+GERIuE3RY=
X-Received: by 10.107.162.7 with SMTP id l7mr5580556ioe.135.1509648654571;
 Thu, 02 Nov 2017 11:50:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.22.15 with HTTP; Thu, 2 Nov 2017 11:50:34 -0700 (PDT)
In-Reply-To: <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
References: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
 <CAGZ79kaDB+nnTZVw-7msVa12RQa3sHn_zFKQ2-5i2eosuHutxQ@mail.gmail.com>
From:   Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Date:   Thu, 2 Nov 2017 14:50:34 -0400
Message-ID: <CAOAxMp9RGq-=QowPytsvE+Z5CgNW72FUhbtdCS35fBCMEvYYoA@mail.gmail.com>
Subject: Re: Git libsecret No Unlock Dialog Issue
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, should have mentioned that. It's packaged by Fedora - 2.13.6.

Yaroslav

On Thu, Nov 2, 2017 at 2:35 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Nov 2, 2017 at 9:00 AM, Yaroslav Sapozhnyk
> <yaroslav.sapozhnik@gmail.com> wrote:
>> When using Git on Fedora with locked password store
>> credential-libsecret asks for username/password instead of displaying
>> the unlock dialog.
>
> Git as packaged by Fedora or upstream Git (which version)?
>
>> If the store is unlocked credential helper gets the credentials from
>> the store though.
>>
>> --
>> Regards,
>> Yaroslav Sapozhnyk



-- 
Regards,
Yaroslav Sapozhnyk
