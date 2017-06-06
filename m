Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C264020D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 04:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdFFEZA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 00:25:00 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33053 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdFFEY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 00:24:59 -0400
Received: by mail-qt0-f182.google.com with SMTP id u12so91796274qth.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 21:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cam+scjl27M218KXE+UiOwR8pP9bXAWmhOiT7vfKff4=;
        b=dgnMBeVZFLYno8X4nJEVuEit0qKT7qZbwJEaLZerPqkPY77IXTjXAY/XIwVX9+NiWu
         i37+vrXa1bpnmtZaRRDuuNKHMVyDI5Ho4487Syfx6n/oDO7r7nh+2Y841x6sKCH7Y7ri
         ZNeUmJsnxPYHFmg1SLEUF82uqUoWqVZVgJ4djAG+tfTFGCogOt2bx8F5qYZGcHmkkxXj
         P6qT4iE6Q2ZzXha55408b8Zjr0Z2svR1TuNJJo3ASd4HALMuDqn2AsWJr7umKEFCmmm8
         k7jD80Uc2IYZcsUTyzfFIfjTXexKhUwiRGMLImkJTO8AzsBfkdBxTnCnqBdcogQGW7PP
         oySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cam+scjl27M218KXE+UiOwR8pP9bXAWmhOiT7vfKff4=;
        b=by4+m36zDXgiGCrEMYn4A+lP4f0zM3vuVwqGscz/5QZ7cLHuJ36U9u5ShFqRjmYZS0
         WWuFlE8frH14a7s1gBe3ekl30nv49DZDkEH96hsJOonAkQn6tPyY4KjOhAxCjvjikqNo
         9ehraPWc1qfiKpjJd0cdFJkAyJ4vU0VDAZ13JFL82q1qAeCnAv7ZtKr9uGuKkPiQArjX
         UJhFCa03TWBCVAZQtk/DdlWyHEdjRhta3n4HBI3vU6pb/2pQY44n0D0ku5j7M1Mygi/a
         QohoJVfX6eG7JvginPbaQ9kOX43CHZ4Kr7DNrn6SSN7VaPdhLY8vbWtW/tryu21JogkW
         /fog==
X-Gm-Message-State: AKS2vOzIH7HVY91d6bbEqn0enF/1qIeXBDolU/y7r+kEdvnC7iHCry4g
        Iu8+MeBwrrqdjbTkpfafOepBjfmRnA==
X-Received: by 10.55.102.214 with SMTP id a205mr22612810qkc.154.1496723098499;
 Mon, 05 Jun 2017 21:24:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Mon, 5 Jun 2017 21:24:58 -0700 (PDT)
In-Reply-To: <20170605202529.22959-2-pc44800@gmail.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
 <20170605202529.22959-1-pc44800@gmail.com> <20170605202529.22959-2-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Jun 2017 06:24:58 +0200
Message-ID: <CAP8UFD0ZRW0N-WZfQB0d7+c+LQD3Jkcpcj44kWhnDaEOd42wCg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] submodule: port submodule subcommand status
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 10:25 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> ---
> In this new version of patch, function print_status is introduced.
>
> The functions for_each_submodule_list and get_submodule_displaypath
> are found to be the same as those in the ported submodule subcommand
> foreach's patches. The reason for doing so is to keep both the patches
> independant and on separate branches. Also this patch is build on
> the branch gitster/jk/bug-to-abort for utilizing its BUG() macro.

The BUG() macro is now in master.
