Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758DE1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbcLISta (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 13:49:30 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35849 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcLISt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 13:49:29 -0500
Received: by mail-qt0-f175.google.com with SMTP id w33so24276233qtc.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v6OlmXC7Yoz6W7wR+2Nw0nlDCwg/clF43X7vPLGOP8Q=;
        b=YnCrZ1FY1xx8hmm0piwlorLkundL0qYBy6TZN26oNT0G0UBT0ftNAS45oUnrtoD9pA
         UrVvU9FpqmbFM2IY1EJmehhmG53ZY5nmfqUo3e6q5Ooiu2dNN3zUZr7kGcCzm8bzqSAd
         iGlyVuKxSdR6tVdaoXiPVAK9zb/Q9FprDgueE5v1KhIWN/IsCJC1Zbnzp09cKurBg8gy
         tckbzMjryX3m1KZ7W4aASToisY+PwZFhaMelZwwz/bRSbYwEmASH/jdPY0aL5m1DXZXq
         6r/6D1Mg66jyfsew9X3MyHVQ/1aQ61WP22HJJRs6wmeg9tkhATtsHIiwgwudgObHFFR+
         SH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v6OlmXC7Yoz6W7wR+2Nw0nlDCwg/clF43X7vPLGOP8Q=;
        b=XzjZtZw9GKqJ+8O+e/2Wly188SiUtnflkmTJXBdEBqVloBtFOyUOXxj7AgDl8Z23LM
         6QwBVU2lPaW5GDzYShTTBK2DNPYuM2Et89ZudciqC/pm06hU5pePxbBVNCK1b+UInF0Y
         Pm/Wt95QgEvd9gxgAiTFPu+kecRb+KIIgc9YLwO3VJnChSbcXz6e18Xg5/8mw+xl3YLU
         V3fkyg1TTssW1DMxOsiwdZb3NPZ22nmCk23SgS6cNNP+d5+LAO/9q8rJlOBxkcSODIzw
         VFyiSy8rP627cBN0XShVu4a9yBqUBb2wkHGgJNRDqPJdrt6dTEU1Q6kQR5kxS/VSY6tB
         sTIA==
X-Gm-Message-State: AKaTC01QRpgvQJanKFYjqoDQG4vjaaetixqOjp1/T16Oo6Jtrx1w5zuD91MXjD0ZHiTzPEcho/8zBcAWYXum1NW6
X-Received: by 10.237.34.206 with SMTP id q14mr69317163qtc.101.1481309368520;
 Fri, 09 Dec 2016 10:49:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 10:49:28 -0800 (PST)
In-Reply-To: <20161209120006.GA6609@ash>
References: <20161208210329.12919-1-sbeller@google.com> <20161208210329.12919-5-sbeller@google.com>
 <20161209120006.GA6609@ash>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 10:49:28 -0800
Message-ID: <CAGZ79kaV4FYZEbRWQxKBHJg1jVzOkte1QxLZgu75=Jja_BMRGQ@mail.gmail.com>
Subject: Re: [PATCHv7 4/6] worktree: have a function to check if worktrees are
 in use
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 4:00 AM, Duy Nguyen <pclouds@gmail.com> wrote:

> int submodule_uses_worktrees(const char *path)
> {
>         struct strbuf path = STRBUF_INIT;
>         DIR *dir;
>         struct dirent *d;
>         int ret = 0;
>
>         strbuf_addf(&path, "%s/worktrees", path);
>         dir = opendir(path.buf);
>         strbuf_release(&path);
>
>         if (!dir)
>                 return 0;

The submodule may be one of the linked worktrees, which would be
caught if we use the code as I sent it out?

If this is one of the linked worktrees, we'd rather check if a file
"commondir" or "gitdir" exists?

I ask that because I would not know how to relocate such a linked
worktree gitdir?
