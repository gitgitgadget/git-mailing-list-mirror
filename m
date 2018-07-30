Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69AA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG3T1k (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:27:40 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35348 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3T1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:27:40 -0400
Received: by mail-wr1-f47.google.com with SMTP id a3-v6so13807387wrt.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=b+kD15uGQNkCehcqYvO9HcRqm0rEKm4lavNm3yHY3BE=;
        b=VBJ75jo82yIfFi2TLsXTxJvMSp69oHaQrMcvWTH6TshQWrZa0NVNN6L5R0tyNASXTz
         aLNYgj9eLKpMlpU2olLn9wzvi1cfviyj6bC80Appo09MMJRz/34RU26k6dOdT2Dea+tP
         5hyeFWwYZb6yLWwWdsQt4X8GQcMVBVFrYP/ySmmygGpMgn1KEp9GHXuVfp9lCy2gsEKf
         tO/9rOy0RVCSG22WVl7nekkgyNr0kDqVEHn4SlG1hG9l/fObwCXqPXoBVA0cVQJTxG41
         rlYqc7g0gdDN08OpQyEvo/iPomL/NCCtjZHr30uLt7/KKRduzO8HDziajDEvOAUtEa8O
         k7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=b+kD15uGQNkCehcqYvO9HcRqm0rEKm4lavNm3yHY3BE=;
        b=ayo3qsq/ivr2gHl3cVNuunteLxuWgwpxVKpnJAVL/eHahTqw60zNKIEDcs5QNxVtLQ
         nfhYOWSnNhbK6g6uHFVLvb5Bdr8+AjBDOf193RMrMiZ8aZ3bhkko3NtAgO6wHgXWOU5p
         15b2Li5RBMWXznwyThBi4su9b/1ibQR+b0P25h/cFGZ/xgIwdLnp6XN+I1EecJK8lASE
         /eb4BEdbS73NL2b4h89mpLkYwnPNsdueiZ5179ss9TrVbssjimSgMK5EM6l9RWqduM/h
         7en/N/kJlZrGXORLl4E8xeF5nvUmH59yprgDehRtX2u43vkloXQ9J0RfU2PaAXjKmh/r
         0NcA==
X-Gm-Message-State: AOUpUlFHx4s/bZksFwweeCHtz+sX0PSZiy0kVjV4ahyJF6BhTNPWQ5Dl
        9zjgu2zU272QjdYc2l6AmfA=
X-Google-Smtp-Source: AAOMgpfbtfr69GsoxErLooLoSBGdyMDV78MhQWEVKFrQfJMAghUaVbYJmkrMvxPu7+kQiUjjMJDOdw==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr17840265wrn.163.1532973092978;
        Mon, 30 Jul 2018 10:51:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 185-v6sm224632wmy.38.2018.07.30.10.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:51:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 09/11] rerere: return strbuf from handle path
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-10-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:51:32 -0700
Message-ID: <xmqqpnz4fw7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently we write the conflict to disk directly in the handle_path
> function.  To make it re-usable for nested conflicts, instead of
> writing the conflict out directly, store it in a strbuf and let the
> caller write it out.
>
> This does mean some slight increase in memory usage, however that
> increase is limited to the size of the largest conflict we've
> currently processed.  We already keep one copy of the conflict in
> memory, and it shouldn't be too large, so the increase in memory usage
> seems acceptable.
>
> As a bonus this lets us get replace the rerere_io_putconflict function
> with a trivial two line function.

Makes sense.
