Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C241FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932307AbeARWbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 17:31:22 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:42900 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbeARWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 17:31:12 -0500
Received: by mail-pf0-f178.google.com with SMTP id b25so9522651pfd.9
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMExLQwUrd1Rs+eX35xOYhpZoR18CdwIdWp+nozI25Y=;
        b=E3KiRw0KzcW4DAwIetH9nBBCNKr0wY7BLnpo+YAYcEn1PFSpZXAUhJvvuSNRXrBrUm
         KIcV3J5y1gq/YJ4LsCVIlVp7EAOnD5fo/LV9C+wzoIc7dx1BlGKkNMzt04z8tl7kod/R
         2Y0EAJ3fJ13pW1HxAMYVyelo0arNdo1Htwr0+czV/YpyPa81qmMbGEWhgEQ5SsXwGC+U
         viVHfNmlA9QVaatZV//a/xH58CRFkJPuSGjGBDITzVUjZb41Oa6/EIDcVNCllF9lDRje
         dq8cUHQnDlz7tVA3oVqQl2DsQP3FEXBCa74jlVnF+NS+eQcd0QJaIOMq6sUOVkS9F46g
         gkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMExLQwUrd1Rs+eX35xOYhpZoR18CdwIdWp+nozI25Y=;
        b=UwD8sCX2KGW2sBr+AsqVDqpXvPgEF9BQEmxT3FtoeD2lLDT38diYrWtOpDddt6/iRo
         SP+dyrvGnT4Ik8yJdZO3BaGlzE42jC/i4UWVSxk86KXBTuf3k2NgQ4nD+aOyKjz9QR1p
         u2g/kZXmibg0MwOYojKK6ngwRzUyJ1fWpOFiJsEgMrSTkdpJ+h0GSTVDIoaXUYs1tMVX
         VyGXmpjFrCR3zXkVuD8EyMTVg4b8QZ2lKIyBT3mrNyy063kepZ0v8lVD2olbfDDNdhj3
         O2TkWVn8fb6RiIRxawghQD4HDGis5hG2AlRa2NzFdshd5ExFZAHYKc19dA35d3zKeJgw
         VRhA==
X-Gm-Message-State: AKGB3mK/NEER+0/5rXUtSGNT2xpP3QyQV91c9BLwyKJ5h5bKvXGx8aXh
        IdEbI0Vx6xA7a2qixlki+6YlBA==
X-Google-Smtp-Source: ACJfBoui1wNpZuTZM8n6yDrdv+yH0KWn2CB/3EAcGkBHazoO573gJUEpO8HY5UB1GycN/OAELhjfyQ==
X-Received: by 10.98.103.83 with SMTP id b80mr34532808pfc.223.1516314671719;
        Thu, 18 Jan 2018 14:31:11 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y131sm14566327pfg.69.2018.01.18.14.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 14:31:10 -0800 (PST)
Date:   Thu, 18 Jan 2018 14:31:09 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
Message-Id: <20180118143109.bc0eb10b036411e0a5a3694f@google.com>
In-Reply-To: <CAP8UFD0P7kVo2NP4Wq7OaSV4H1+sqHapuzW5AQef+enNS0S5hw@mail.gmail.com>
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
        <718e2723-9547-8cd6-ac46-07e8631da09a@jeffhostetler.com>
        <xmqqshbd1o8a.fsf@gitster.mtv.corp.google.com>
        <bda13f22-b6ca-f46d-9730-ff00ec536b0b@jeffhostetler.com>
        <CAP8UFD0P7kVo2NP4Wq7OaSV4H1+sqHapuzW5AQef+enNS0S5hw@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Jan 2018 09:56:50 +0100
Christian Couder <christian.couder@gmail.com> wrote:

> I am still not very happy with fetch_object() not returning anything.
> I wonder what happens when that function is used to fetch from a repo
> that cannot provide the requested object.

My idea was to save a verification step - the caller of fetch_object()
needs to reattempt the object load anyway (which includes a verification
that the object exists), so I didn't see the need to have fetch_object()
do it too.

> Also I think the "extensions.partialclone = <remote>" config option is
> not very future proof. If people start using partial clone, it is
> likely that at some point they will need their repo to talk to more
> than one remote that is partial clone enabled and I don't see how such
> a config option can scale in this case.

In the case that they want to talk to more than one
partial-clone-enabled repo, I think that there still needs to be one
"default" remote from which missing objects are fetched. I can think of
a few reasons for that - for example, (a) we need to support commands
that give a nonexistent-in-repo SHA-1 directly, and (b) existing Git
code relies on the ability to fetch an object given only its SHA-1. (a)
can be overcome by forbidding that (?) and (b) can be overcome by an
overhaul of the object-fetching and object-using code, but I don't think
both (a) and (b) will occur anytime soon.
