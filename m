Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A9920248
	for <e@80x24.org>; Mon, 25 Feb 2019 18:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfBYSho (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 13:37:44 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33365 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfBYSho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 13:37:44 -0500
Received: by mail-wm1-f54.google.com with SMTP id c13so436941wmb.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 10:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCyXM2YfVgznhiI/DAiZsfLJI2W9PE8U8AQ/Ip+f7yA=;
        b=pgcYcOie0aVxP3VURubG5aC1JOFWD6W11VbiVaTW9/n7eCJAp+jouJDEG2+Za8moaf
         BK62/VmRt8j+bg2gv73xciX+P9rryHZ9D2w6+BGvs8ZdPRZWarM0v3GgnB6eUVIx67Vl
         m92IEtjEnK3/NkssnRXkpwgUpiLkIN4IxWw7xJMJI0YI+kqtMwp5d+t9GNpKRNcUyVhc
         UeyTykTbyHvvUrcXKRQujKtbscsH0AZbVrDcMlwJeuYfcxwHoifOOcN/cbAnu9HnfoEi
         Cs9oK3htehYPcA4NKsNJxDgGxpx4ovZ9SmNFNV6M55RLtrCS15FgmIhNhhl0gvWHP94/
         xjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCyXM2YfVgznhiI/DAiZsfLJI2W9PE8U8AQ/Ip+f7yA=;
        b=R4G7KU3SYtMx5dhjBS0NVFathCeU0Vj0NTYOvPZg1lqX0EDTY7WmSOZnG8xO2YyH5C
         uaANR6yalu6Kusc4cZEVv9zpBgk+hFxzxAS23rOf/J78RFoeZ41j9dialC0D1xaXRr8j
         JvavUfQRdgkAgVmJzcjJFkqT7JEvNXUW1eQRKTBYtJeVbEE/w/tnFV9DoJ2ynoOfUzKm
         rV00GL2Y1gFPxs1bRGtRPYuQWKRoFjjkdY/Mtu218QnNXW92G1h9ZsL3YI5FkC1KvXsm
         YDCLZD3VNjcMlzAjpL3ZZjqwZFas0+NYYF64lEC4zMqfrujfANnKfORrSrrH16XoW714
         VF0w==
X-Gm-Message-State: AHQUAuY41EReUz3tcOCvMUa1oDwf44Qbfq6hYReHdoLnjJmHPTA0CR6Y
        KLh8lFQlwOL0Lz0sJQG+pp2Vzqc95QU=
X-Google-Smtp-Source: AHgI3Ia9Qeu4D8ymnqCY0xtg3rWy3FdGJHLs+E4/uUdEqrkAFUwwceqPUn9mFWwhdS76X3kqJ3E+rA==
X-Received: by 2002:a1c:6409:: with SMTP id y9mr144053wmb.68.1551119862464;
        Mon, 25 Feb 2019 10:37:42 -0800 (PST)
Received: from andromeda.localnet ([92.184.117.188])
        by smtp.gmail.com with ESMTPSA id b197sm20488276wmd.23.2019.02.25.10.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 10:37:42 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: ag/sequencer-reduce-rewriting-todo, was Re: What's cooking in git.git (Feb 2019, #04; Sun, 24)
Date:   Mon, 25 Feb 2019 19:37:30 +0100
Message-ID: <2308479.hZ6iDFDOiv@andromeda>
In-Reply-To: <xmqqmumlkq3r.fsf@gitster-ct.c.googlers.com>
References: <xmqqmumlkq3r.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 24/02/2019 =C3=A0 19:18, Junio C Hamano a =C3=A9crit :
> * ag/sequencer-reduce-rewriting-todo (2019-01-29) 16 commits
>  - rebase--interactive: move transform_todo_file() to rebase--interactive=
=2Ec
>  - sequencer: use edit_todo_list() in complete_action()
>  - rebase-interactive: rewrite edit_todo_list() to handle the initial edit
>  - rebase-interactive: append_todo_help() changes
>  - rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
>  - sequencer: refactor skip_unnecessary_picks() to work on a todo_list
>  - sequencer: change complete_action() to use the refactored functions
>  - sequencer: make sequencer_make_script() write its script to a strbuf
>  - sequencer: refactor rearrange_squash() to work on a todo_list
>  - sequencer: refactor sequencer_add_exec_commands() to work on a todo_li=
st
>  - sequencer: refactor check_todo_list() to work on a todo_list
>  - sequencer: introduce todo_list_write_to_file()
>  - sequencer: refactor transform_todos() to work on a todo_list
>  - sequencer: remove the 'arg' field from todo_item
>  - sequencer: make the todo_list structure public
>  - sequencer: changes in parse_insn_buffer()
>=20
>  The scripted version of "git rebase -i" wrote and rewrote the todo
>  list many times during a single step of its operation, and the
>  recent C-rewrite made a faithful conversion of the logic to C.  The
>  implementation has been updated to carry necessary information
>  around in-core to avoid rewriting the same file over and over
>  unnecessarily.
>=20
>  Was still being worked on, but seems to have stalled.
>  cf. <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
>  cf. <97f77aca-bd19-f763-349a-de40c4b94161@talktalk.net>

I=E2=80=99m still working on this.  I sent a v7 shortly after the release o=
f v2.21.0-
rc0, and I almost finished the v8.

Cheers,
Alban




