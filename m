Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E26D201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756019AbdETV11 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:27:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33700 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdETV10 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:27:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so54590603pfh.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PHGurkip6DE1Lnqbs0DRLBdG2gOWTgTEw4Pxt8cT8Xc=;
        b=AuHjjrMT9oPADxb/z1fsCk24/noDeO5uFjm7IyZmE3rx54Y5In9fdMm+Rn4ZLkAu+s
         crfryVwVgP6htSPsiW6YeduiU4MELL3GuERIt9AIwLt5eKGormeKEsdnxrppSSqdLTw8
         JZ6mJwKzkVr2L2DP6/Gm6O8HuZbC9sDyJ2C4DyOlh5wxhGAt7hO1p8UbpLmw8wL8phkg
         /5DnBJFdEvka3Zlg9k0dhs+zGUnhXFe6VZs0l7F9aIs8amSG8VmoAtEAtxFPhrJMtYa/
         wObY8+2W4LnH9MwnEY4XNs8fGyXD2fCfc8l5fdPOzbZ90FXsy3KFDjXrzb0J9ZzkrHwt
         Tj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PHGurkip6DE1Lnqbs0DRLBdG2gOWTgTEw4Pxt8cT8Xc=;
        b=suycCOLQuAQ4BTFEeA6eA5FK/RY+2Lhh3z61uumw2dgcXqAAMC4rxeC41cQWqxFU7t
         1mmH//Ttvb9gOOH73lHAp6quR/1iy9/6Puh0ofd052vA3DUD9eWBuxdbpBFOMJtzqQkr
         ALVRPraKHmd8C/qNdFBJfApUYImgXuANTUe7DcmWO6pJwxfyhVmy0jRvy/YK7Z/1WpvX
         P0IVtD7L6YHdfFNUVGFKk4EFgHNU8DDFRFL0rl9wikiQTZbv6n/cLE4vXd9MvmKhuV/h
         1JkQbZSgz2nhZyY3MXjAz1fkX/aQNFudrGglFOWXJ8vp24lwd544ArfbSCns4ukp6lsz
         btmQ==
X-Gm-Message-State: AODbwcCJE7xJkPERrzckXEp4BT4MMfB2EjWT/Jm7o8GICNhtkwjeKk2D
        DmkSVuobE3bDMIV/aJ6n5caw2i0DZ4EY
X-Received: by 10.99.126.92 with SMTP id o28mr17570268pgn.63.1495315645674;
 Sat, 20 May 2017 14:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 20 May 2017 14:27:25 -0700 (PDT)
In-Reply-To: <20170518232134.163059-19-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com> <20170518232134.163059-19-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 20 May 2017 14:27:25 -0700
Message-ID: <CAGZ79kYY8sncbq-Zoi9iiqz+4qWOsA+y80T1RjO5c49OvY+uxA@mail.gmail.com>
Subject: Re: [WIP/RFC 18/23] repo: add index_state to struct repo
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  int
> +repo_read_index(struct repo *repo, const char *index_file)
...
> +
> +int
>  repo_init(struct repo *repo, const char *gitdir, const char *worktree)

The version 2.13.0.303.g4ebf302169-goog doesn't have diff slider
heuristics on by default, and you also did not enable it?
(I am curious if the heuristics would have helped here)
