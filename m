Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6051F404
	for <e@80x24.org>; Tue, 24 Apr 2018 09:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDXJjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:39:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37532 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeDXJjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:39:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id p6so11783857pfn.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CPEJhifRXCAY+2Moi0SkR5diSqwqIKVTO6A1S95Wokk=;
        b=iUef2OUUYlbbgiPZFwAcWuxr5vrmvZEsLb5WB2JKqa2XzD0/lE6PYv0sOesQSsnNsw
         SHjVflHfG+7XBZuYHXUZsKWA/p5PmaaU+5L0s7fzZZoYLODoJiVdkGSKvD4GyyKhZ7GV
         AALhvtbIH7Wv657PV48uSwjMXWWXUjGUvCQwPMAddZjVimEVar/uRh/BViIyijG/DugQ
         x0IIebcK8K41Cjw6rDZJmXIlr5he4iuzdSl+wwlYjQPOq7NAbOWsPraLqYT0mdkiMPsa
         0axyPbGWnCBbE/AJSDqwHQuSJd7ZN9/1cKKvXClAqiVI2DTJUfD+pbtXAsLTXsSMvQhp
         z+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CPEJhifRXCAY+2Moi0SkR5diSqwqIKVTO6A1S95Wokk=;
        b=nSj9gh7qRttAPpCQjCJufPeYVoJqz6ZKVFyJJhIKCem4AOagETKD4Jb3ctS+cx60sE
         aEtaWt1J/wDCQaNHSiJt6Kvf/i56MymeGJ6jOn7Xx9Kr8Kbs42/OTvbKx7qyPUzNH+e/
         YBEcstdM2o50POoV3IDaHGrVGZ6lPHhoAJ0BHftpOgKzBWln69YbyTuYcTy8aefTU5Wl
         iJ71or/anJgTO3JyAKam6zlC5D9ZvgAgCwVztYzD27v4nFCe/bQp1ltusnxbIAYmaEZ0
         aE1UOTP+Zy5De5fKTfRsbNyD2xaQ5rARzXjwlz4vSTg/PLJFKbBiiOB2/l8TsEBwqB+H
         un6A==
X-Gm-Message-State: ALQs6tD6m4iFng9/totn8acE9jXqMcN6Jq4ZzYlDayeRLl+DT1a67neD
        bftotHn1H/nBvFQMctlmhiNHM00bP/G8/GBCC/w=
X-Google-Smtp-Source: AB8JxZpp0Py6hOWUtSsjtKeLdEnh1m1gENdypTNHZnANGxF3roSHkGUqBbsBrAsfpSNtsHKlQa0yolV9JtQeFkA/vZo=
X-Received: by 2002:a17:902:74c6:: with SMTP id f6-v6mr1015330plt.7.1524562791662;
 Tue, 24 Apr 2018 02:39:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:39:50 -0700 (PDT)
In-Reply-To: <20180423233951.276447-2-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:39:50 +0200
Message-ID: <CAN0heSqvKbSiuNWhHte_HHT-wcewEjm1qVvSoYbZcUKMLT74ig@mail.gmail.com>
Subject: Re: [PATCH 01/41] cache: add a function to read an object ID from a buffer
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 01:39, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In various places throughout the codebase, we need to read data into a
> struct object_id from a pack or other unsigned char buffer.  Add an
> inline function that does this based on the current hash algorithm in
> use, and use it in several places.

Makes sense. Grepping for "memcpy.*hash" turns up a few instances that
look similar, but not quite, so we would *not* want to do this
conversion there, e.g., hashmap.h and notes.c.

Martin
