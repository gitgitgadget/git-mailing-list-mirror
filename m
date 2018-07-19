Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571CA1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeGSWEl (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:04:41 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:37105 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGSWEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:04:41 -0400
Received: by mail-yw0-f175.google.com with SMTP id w76-v6so3619241ywg.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3alliS26v6ikhK2CB8LK1BGprEscFSUO9YhkWn/iQw=;
        b=sQ3lsRZy7g8/UM3hDAhmXQHi0oTGcUulbatcpamAdIhhqZ0HNNfyOOMfPrKN2T+ixL
         RMxnz/pHjlabfyEtbHeaFuu0QMRynyn9D71z/tyQeAxYCtnA08MtWe1SolG/BxBH0AZo
         TdfdVP2xUskE9OsEPng/oBrFmgZU2RBZhXp7OQPmkonPZatwFDdLh+H++oCoxCa3br5e
         TGLQ2El5IfM8NIS2RKiqzY3ZzT8W25NJKhlOPzG6rDLqZ4xrg1YrbdZrw0sYiZ6m2QUS
         20A+eOKDzjGpfJkySGODTevuGURZy+rkWNM5xJ7X+vdsmv/cNqzTYsto3Vj2wLkG5Nhg
         YYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3alliS26v6ikhK2CB8LK1BGprEscFSUO9YhkWn/iQw=;
        b=FzGtcVer+iLVYgVtQP/J6MVx39gGUkpmFO+/pK0arJxQvc2ox4dX58lb8w1MxG+CnF
         ATO4xm6iA6wnBvMwYC6Mg34nDvw+Wfd3fbBooVxQJtlICLHo7BAd8jKoTPW/3zF95+dv
         A5CpC0D6Ja14x8n36zJQQqSkYUG0/n3SSrzsLrhDMxVeVUOO5gPDPeiQsHnzGM0qzxvy
         q12YuWPkRW59h7oYhkUQQIMKonO4YpETdx+B48CtGQcgfMZOOZ3Pc3dVxbYpAnmaRcdD
         WoVl+lGyc60tXDJ9YOlj4ab4GjnFtFJKEyC/CjR6N3XhlHkJUragCsUkAtWgRiKqb5BG
         7FTA==
X-Gm-Message-State: AOUpUlFaq91qQ/+zHVOaE7lXT8eH4FX/xpkNxkllqCMRtsrd0sMEI8kM
        eYKb/rWbJQ15+1ZH/Xsp4v7klYS4fAGJID/dM7c27Q==
X-Google-Smtp-Source: AAOMgpfBvlxahTY12AriRPF8dFgc6VquSU4kGXqzQ637Du55oJo1nBBzjs911yRAm4g+UKqkXPvVI+fnkH3BTRPcr/M=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr6162241ywj.33.1532035185144;
 Thu, 19 Jul 2018 14:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
In-Reply-To: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 14:19:34 -0700
Message-ID: <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
Subject: Re: Find commit that referenced a blob first
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        primetheus@github.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 2:02 PM Lars Schneider <larsxschneider@gmail.com> wrote:
>
> Hi,
>
> I have a blob hash and I would like to know what commit referenced
> this blob first in a given Git repo.

git describe <blob>

If the given object refers to a blob, it will be described as
<commit-ish>:<path>,
such that the blob can be found at <path> in the <commit-ish>, which itself
describes the first commit in which this blob occurs in a reverse
revision walk from HEAD.

Since
644eb60bd01 (builtin/describe.c: describe a blob, 2017-11-15)
(included first in 2.16.0

You're welcome,
Stefan
