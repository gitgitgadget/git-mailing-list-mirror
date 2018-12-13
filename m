Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1774620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLMUsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 15:48:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38639 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 15:48:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so3182526ede.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0z8g1DH+fK4pLCtI/TcbVOohINlwM5K6isabPOkKxU=;
        b=iHOYC3o/bvCcHDaWLUcHOCWFIH7UNQMJ6xrXDCPgz01ARmG2fKnamZFsBVumXluaUQ
         Ew3Cpyn7DzRhqAGvtI1G6ia9Uekf+qy3jJ/7ht+i3GLjQpTqZDLG+ZV8+fV/vJwcCYOm
         0RQIhgqMt98VmmPhtuzNXV1AmUCntS8/8PizyO+ExdqEDjEvxRo8scF0cHwGvJotvDIL
         NT2UX5four39KYGaFAuUtkj6ENqhzCy/9dDsHpnxOANoYI8snJ3FiXSkT+s91bDNzq+4
         o0xlv2fIfDwHdKgAjH+xdgSdh8uGkNyRo0VQ7jTX+8doTOD3BUxJo96rYc241CqXQZHT
         Hpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0z8g1DH+fK4pLCtI/TcbVOohINlwM5K6isabPOkKxU=;
        b=OTyv3A4SHsiM6XUiBRWIr1oP8KnW8cZFGswE8feTEhknEzKAeQ5N6Xtz6pMerS/pQQ
         ilQEVLxKHCeZahiqxVpeerMfD5c9xCI5eTpzsn8YDLAkYV0SQFYy81C1I8wwm/HaIPrV
         RFsBpdN0hZe4orECYjQejrjd1xpXL11NMVE+CqtVK1RwDSaMY3Or37/2FL17TJNAMm7R
         6L6M/rooOycGbG+FvxjTz3S+CQGkASLh+pJleEAnqluvnxfZzdbnufcY8QsZ6uS5QyzT
         MeF0e/mvnYNISpK1JvPwWqJwB3tjiYA+31BbYHXubDP6tCMQHPmWsHviZNKTDic5F8DD
         fLug==
X-Gm-Message-State: AA+aEWYhPuPSHJGq8plM5OEIoeQaQ5RiCk+BBGZlFEzAYsp6AUc8LVU6
        LXk740pcWKqr/0gs+MhSsHXaRK7FYTtn48MuD0T/dw==
X-Google-Smtp-Source: AFSGD/XDfwJ6HZaehk8ESumCRa9vNwFODJNTjR3qTaUMazEnAQ4mMXO9FhgMsMxhShdg8fgAG0pPHlt4oUlNEffTYlI=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr668597edc.76.1544734088040;
 Thu, 13 Dec 2018 12:48:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com> <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
In-Reply-To: <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Dec 2018 12:47:56 -0800
Message-ID: <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The current situation is definitely a problem.  If I am in a worktree,
> > using "head" should be the same as "HEAD".

By any chance, is your file system case insensitive?
That is usually the source of confusion for these discussions.

Maybe in worktree code we have a spillover between path
resolution and ref namespace?
