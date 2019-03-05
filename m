Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7562220248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfCEXwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:52:21 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46219 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCEXwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:52:21 -0500
Received: by mail-wr1-f52.google.com with SMTP id i16so11348115wrs.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+A6Czn3J6CWh4WcDAwu6tsJ8MGEvU8oZdlWo1oFhFb8=;
        b=OUyITPfd+VQIPbzZjql4wv0vLi1F2atAnVIkrwU7WbZFF1Ova8JPA82du16cKlo0q8
         atzjcdzdqXW+2RMnF8C7cHkIspEn/gfWVOzkzrXSn3yXL35eHtSa0+kkhQXHQ29oLij7
         DjHJBwAaS+iKr19pFflViP5aqskzA4iOcDsU3WS8h1mL1BNojNJ4ODu/pK5+1wRqTDTv
         uDuQwKicKI0sHx6l/xJlKrF1QgE9bqb0/ZrMCWu/NNlFUoti/vslQJr2JvYxY2aGUBYr
         zO7g4cUTyHgAt26oncjRvuZTZTbDOZVba710fyrJY24EV2uUDUKnEkwiPGFQpdtDlpQo
         01TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+A6Czn3J6CWh4WcDAwu6tsJ8MGEvU8oZdlWo1oFhFb8=;
        b=fEnNJN3t1B1+8g+Uno9p3LQfpUNpCY4f+WlXKyo9BjDRDXfi5NmV4jDONaYy7aLuRv
         H0YDgxXpvb1k2CU9BRN2lyvDHCI23zo7Le/jQLa0BzeIK7Q+A1bZzVHWwG5f9r34QE0O
         /7KrfmYmHbxbLZlZXUGX7D+GEuptCfb7XAau1UP12Dw38zgKF8OXSFYWsn+IFgXVPmG/
         4GbFt+AtMOnIX2DvyX9tsSJkQGGMDpwYRA9U+G9Drc5SMDglxoQlPgGtG+OtpXIoVgwB
         Q+lg8P/BJAnVHzbi6wwfAYTZXrC0y5m9ngtmNSCW0xVa3YsTW72U8I40nL5Bx/4+p6uJ
         7oOA==
X-Gm-Message-State: APjAAAUMONLFcKoDdtflfpLu98u8l6Nfy2Yw3a0Re6szZpbiQi0OAOBY
        AK0hf7RL70dtscQeghiUVr6I7oPKFis=
X-Google-Smtp-Source: APXvYqy6B1HSnSGKxmr7OX9c9UUiXOGR7nE1YhIJavtalDGwBdOlphu93tjGI6OsmxOv9gE30Q2m+w==
X-Received: by 2002:a5d:4804:: with SMTP id l4mr882180wrq.177.1551829938736;
        Tue, 05 Mar 2019 15:52:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s127sm142008wmf.39.2019.03.05.15.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 15:52:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git log print commits between a revision range (inclusive)
References: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
        <xmqq8sxvvzvg.fsf@gitster-ct.c.googlers.com>
        <CACUQV5_VCYdBoi=Vz97KVSWipzf+tbi2wrkY1U2h4i78FxVY-w@mail.gmail.com>
Date:   Wed, 06 Mar 2019 08:52:17 +0900
In-Reply-To: <CACUQV5_VCYdBoi=Vz97KVSWipzf+tbi2wrkY1U2h4i78FxVY-w@mail.gmail.com>
        ("Rafael =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Tue, 5 Mar 2019
 23:42:22 +0000")
Message-ID: <xmqqimwwswum.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascensão <rafa.almas@gmail.com> writes:

> As Junio mentioned, "A..B" means all commits reachable from B except those
> reachable from A. Understanding this is just a way to say "B --not A" is
> important to know you can take advantage of:
>
> `--boundary`
>     Output excluded boundary commits. Boundary commits are prefixed with -.
>
> In other words, git log --boundary <older hash>..<newer hash> should give you
> exactly what you asked with the small caveat it marks excluded commits
> differently.

You are correct, but only when dealing with a single strand of
pearls.  If the history leading to <newer> is bushy with merges, the
above will give _far_ more than what was requested.  The fork points
of the side branches that got merged during <old>..<new> will also
be shown, in addition to the <old>.

