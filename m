Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F8A1F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937647AbeE1NrX (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:47:23 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33527 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937507AbeE1NrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:47:21 -0400
Received: by mail-wr0-f169.google.com with SMTP id a15-v6so20416178wrm.0
        for <git@vger.kernel.org>; Mon, 28 May 2018 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TtofHrHI2rq+kj/7BHMbLqjMEJzrq0FEpWnfA+1BWj8=;
        b=nMrNRj2zOyfABIH0L9bWUbGS82WYKvUca9EzN+dlka56iafmSOg1maq/2Ps+qIyHbf
         z+wUcQNFuj1CwcAEfsPDvhQAiTav0bZjvCpWAxMnPHgUrZe75lQrmRmbwefhjBX5HPMa
         ddjdpP6+wPqXAvKruClYZeSAY4zD11Lw0Q+OQqlDaGEVYnmHTPvQhAVpoviO4qOfesLl
         qpFfi9cyhHeFg23adp/jtXSqtEM63+Oi3OMGaGd7JUBHkFmbUmyd/KQiT609RKyU1cRH
         IEEoLZz8Un65WnhxgKzpUbGpk6jQC8AuDgkSZwOD2LGQApxiVLOj/wBSW7QtEgJYnru5
         P/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TtofHrHI2rq+kj/7BHMbLqjMEJzrq0FEpWnfA+1BWj8=;
        b=HjtR1Xx/X3JXtPIfE6JQCZYYSjet/jQiGdRzXTVB948p25hlN3jm21+Om22ij1+fua
         RpfSlXJ1SYZnXKy8NpMtKMvuGBID6i93SKLHET+R02d9PypybMRnuYzK2uVyh0sIjBXZ
         Afufg39l6+77GBwrX98Xk1PORc6xNiEl/DYTqjowT4zZltFUrLrI2DyyGFtyzzqlR9LF
         Z6OmXzKq/nREgVrWW8bgpBKb1CmqAOlx4sQRPlUBPLqzMyRPBnEkhvHpHgJ3ckCZCO8j
         7vU4KikPiH7ljxrS1fPSbuc/MTXv7WRJDVXqEa6X6A7MDUDc7Mrm9dlXXHQrRjTvg7CD
         kuIg==
X-Gm-Message-State: ALKqPweanEbsa/K8NPaXYyf/DW8FAoSDgJTjmiRvcZz2JkLF2g2RKqwF
        riHYOhmMLrBb29RigINjhqk=
X-Google-Smtp-Source: AB8JxZriSOlMUiE9/ABEVqfD+rCDzRXfCBVukQ0cCzzfOzEIuG4mw8UfQnWhe5NMUho/04QnjwaEzw==
X-Received: by 2002:adf:800c:: with SMTP id 12-v6mr11489210wrk.45.1527515239846;
        Mon, 28 May 2018 06:47:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j13-v6sm25296453wre.38.2018.05.28.06.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 06:47:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: protocol for updating .po gettext files?
References: <alpine.LFD.2.21.1805280754160.8049@localhost.localdomain>
Date:   Mon, 28 May 2018 22:47:18 +0900
In-Reply-To: <alpine.LFD.2.21.1805280754160.8049@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 28 May 2018 07:56:52 -0400
        (EDT)")
Message-ID: <xmqqvab7j3ix.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>    i was going to submit a minor patch to fix grammar here:
>
> builtin/init-db.c: warning(_("templates not found %s"), template_dir);
>
> as it should display "templates not found in %s" to be consistent with
> other messages, but i know from nothing about .po files, so does one
> also have to update those, or how does that work?

You as a developer generally don't.  Instead, you just update the
code i.e.

	-	warning(_("t not found %s"), t);
	+	warning(_("t not found in %s"), t);

and leave it up to the i18n coordinator to update *.pot and *.po so
that localization teams can work on it, which all happens closer to
the next release.

I think po/README has a bit more details describing which part is
handled by whom.

