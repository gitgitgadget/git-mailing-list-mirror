Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3548C1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 05:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeDIFMg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 01:12:36 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33173 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeDIFMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 01:12:35 -0400
Received: by mail-qt0-f171.google.com with SMTP id d50so7890387qtc.0
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UeKNux78f75+7pZLGrjPGyWGcSJyk4d5Uql7IkS6528=;
        b=FSDzUwoF8qo9ac9tAowETVSkdXPWWXTmnLVOM4TAxrXGhG/w/7wi8CRYJ4jLPXBoMA
         XdKrfvINzFchBeXleT/lVfAl0KFhl2Uz8IP7+OSVcIL2jqjORAbaAGAmstuzmC6YA7P9
         WZvHkEEvG7GSdGbLd7+uVhYv9qD/PrU/ZvCh2AMALahnq0T4mrO8j/0duqpOBLiX+Y44
         s+QL+Z0vUnqqqRWXGmJ0tGZtFppaA7M3tnM79M/FpCJ94ttqIraB18pY1TV+OvFpf61d
         PyFpckke4cIu32K5Sgacubn2P53fDNX65ugqDq0cZMjpkaPUQ/sV1hXFMBoivQ4GGDHe
         t7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UeKNux78f75+7pZLGrjPGyWGcSJyk4d5Uql7IkS6528=;
        b=EMTej4gjjXVpMsZbboY3T8FEtTi6IEItyelbXhqcxsNb4RW0o66pOqh46UbGF/D8Zc
         ynmM3gy8jbl7uE+/fxr5PPyrVpDeF7BtFqshNpZGdqcPV+7NlrGwrN6axg8j0Bz88y4E
         GOdv+9ppncpt2yqWf5rJMunt5eSEi0/G2+cXxcUndz7yG9ymemF0ERQOje3aE4f2ysbG
         4IKWzQB2+zZcbWm32GYZZb7yo7H0BZH3YxLJDwrpesTWCpTgKTX1Kj6Ax0i/OBR229AG
         obr+kFyP+Bk077S5HW5gC/74taHOrg1TEMBjArAHdrpi27nucYrCbrc3PX4dEQIj3qUE
         S2Eg==
X-Gm-Message-State: ALQs6tBaGEkmSaf82d+oQ2HVQs1jbidfSYttvLrtYYvyuH5bh3FI7TC9
        onU9o51A+H6DOf0IgEVgpXXcgpNbyRnd+HNKctE=
X-Google-Smtp-Source: AIpwx4/vkxnohupM33S4YumbWC4fJzLDFln1m4vElG6ItGXFto42F8M2icDAitMj4riwN/tGKgGJBy6OdZknJ74B5wk=
X-Received: by 10.237.57.166 with SMTP id m35mr48309765qte.220.1523250754705;
 Sun, 08 Apr 2018 22:12:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 22:12:34 -0700 (PDT)
In-Reply-To: <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-4-pclouds@gmail.com>
 <CAPig+cQHzB3zLqhRmDKuYk_w8283202x80BcuH7Mu3NqL95cZQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 01:12:34 -0400
X-Google-Sender-Auth: jHy4mf6t7R-FOOXLSgL_M3cKpjY
Message-ID: <CAPig+cRvL7-QSx=Ab+pqiSbqBoE0L7JhytpCWFPa8EgkAMe4fA@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/5] generate-cmdlist.sh: keep all information in common-cmds.h
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 12:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> However, I'm concerned that this change may be going in the wrong
> direction. A line in "### command list" section looks like this:
>
>     command-name  category [deprecated] [common]
>
> Although we don't currently have any commands marked with tag
> "deprecated", we very well may have some day. More generally, new
> optional or required tags may be added in the future. As such, the
> line format is relatively free-form. Current clients don't even care
> in what order the tags appears (following 'category') nor how many
> tags there are. The new code added by this patch, however, is far less
> flexible and accommodating since it assumes hard-coded columns for the
> tags (and doesn't even take 'deprecated' into account).
>
> The point of the $match file was to be able to extract only lines
> which mentioned one of the "common groups", and the point of the
> 'substnum' transformation was to transform the group name into a group
> number -- both of these operations were done without caring about the
> exact column the "common group" tag occupied.
>
> Obviously, one option for addressing this concern would be to change
> the definition to make the tag columns fixed and non-optional, which
> would allow the simpler implementation used by this patch. Doing so
> may require fixing other consumers of command-list.txt (though, I'm
> pretty sure existing consumers wouldn't be bothered).

I should follow up by saying that, although the current relatively
free-form line definition is nice due to its flexibility, considering
how infrequently command-list.txt is edited and how much more complex
the script is to support that flexibility, changing to a definition in
which tags are required and at fixed columns seems like the pragmatic
thing to do.
