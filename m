Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8B31F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdKMXjG (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:39:06 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:50481 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdKMXjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:39:06 -0500
Received: by mail-vk0-f50.google.com with SMTP id h82so9777730vkf.7
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M7U30VBdKw20wqUmMluoZuAFDyIkqtZ09uiZ9TJGikc=;
        b=cz9mgZynHkgy7GO9E+zm3rhJ/H2l3ww0iolJOd/cLwDhdBJYWS7LPO+attBz/5F5hj
         BabSL90IYoujZwBnFv+HTztvoZ2DW8kOdNKFNWaVe+zYuXRY7ys1RuDGBpPbVYcpDPvj
         mDRFAKQMKxITRQ8VNe8ENlcbUWvyu4SjyoWG5IyY2SAH9wKie80+UyL3x8iXC62POxET
         gAbbArQP+l63jjpD63Aew5GnaZVT6kebEk+B63f36XqJskXw4ZoJm1iTVUzlYhB+8OoG
         syAsxJb9v5z4MeEInwZk/Yhx0yfibmcPUrLK8EGGHkjE7TEhO86SBnxDEViX4yFUehfQ
         p3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M7U30VBdKw20wqUmMluoZuAFDyIkqtZ09uiZ9TJGikc=;
        b=sWaD475ICIQRrDVdbIAtkAxhjbc+9i8IcVrL/ghtI5RrE41dkaTF0QUcWObLMQy0cp
         sABuLmNuyjt8OcEJEY3LW4BGSRcu3g3AIrg9W7UDWWXHp4QMPt+6LFFDQo5dPt5V6WTT
         yZpym2ozBo6XIoxSlNN8iS7AAJ6fMMrqNGIQIflzOmQ7ehXxlCHJ39JVji9WiUoZ5Kcp
         XjROygWJeicLC747iK9Z3yxSYXIHHaOHcSgpoAu228x0xlG66gksfOcHf4G9RUjluQNd
         QFCWh6jTxmke+tYIgLuG3P4ENlgo7M/pNdVPibF6NpNsC2VvY+6sCxTRheqeR8mm1FEU
         Hl5w==
X-Gm-Message-State: AJaThX5m3aysJ/cCxhhyBsx7TqP6K7h25OcY9ZcbKc2TkAvOE17FFrvz
        R470eSGh0tNQJGoZesHWJyxcGNrMf3+NgWrxrIU=
X-Google-Smtp-Source: AGs4zMaFJyCeq6Akm+9XoIyT2kpf4DKoSMSIr6tMqWvZQxBwtAhNwJhroMpTaOow3ip8K6Mplkd17RySK+7V4fLKQdE=
X-Received: by 10.31.61.11 with SMTP id k11mr8130707vka.153.1510616344919;
 Mon, 13 Nov 2017 15:39:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 15:39:04 -0800 (PST)
In-Reply-To: <CAGZ79kYEwOhjMfNH3ovfEnRdU_OYWnGnai8HrZWxoBEC67xKVw@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-3-newren@gmail.com>
 <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com>
 <CABPp-BFX-xZf962vuCjJSaB0=sPMT_zNF8+mGPG04dFi5PE6SQ@mail.gmail.com> <CAGZ79kYEwOhjMfNH3ovfEnRdU_OYWnGnai8HrZWxoBEC67xKVw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 15:39:04 -0800
Message-ID: <CABPp-BFynaf6abbd2ywzjuQnus5BFp=DQmKd80qHj9vFOqEmig@mail.gmail.com>
Subject: Re: [PATCH 02/30] merge-recursive: Fix logic ordering issue
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
> I wanted to debug a very similar issue today just after reviewing this
> series, see
> https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/

Oh, bleh.  That's not a D/F conflict at all, it's the code assuming
there's a D/F conflict because the entry it is processing ("sub") is a
submodule rather than a file, and it panics when it sees "a directory
in the way" -- a directory that just so happens to be named "sub" and
which is in fact the desired submodule, meaning that the working
directory is already good and needs no changes.

In this case, the relevant code from merge-recursive.c is the following:

        /* Case B: Added in one. */
        /* [nothing|directory] -> ([nothing|directory], file) */
<snip>
        if (dir_in_way(path, !o->call_depth,
                   S_ISGITLINK(a_mode))) {
            char *new_path = unique_path(o, path, add_branch);
            clean_merge = 0;
            output(o, 1, _("CONFLICT (%s): There is a directory with
name %s in %s. "
                   "Adding %s as %s"),
                   conf, path, other_branch, path, new_path);

Note that the comment even explicitly assumes the newly added entry is
a file.  We should expect there to be a directory present (the
submodule being added), but the code doesn't have a check for that.
The S_ISGITLINK(a_mode) makes you think it has special handling for
the submodule case, but that's for the reverse situation (the
submodule isn't yet present in the working copy, it came from the
other side of history, but there is an empty directory present).
