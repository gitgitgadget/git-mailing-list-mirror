Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7117F1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbfAOXCo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:02:44 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:41285 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbfAOXCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:02:44 -0500
Received: by mail-oi1-f201.google.com with SMTP id j13so1801377oii.8
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mGLoTXPyi+sh3OuwmEKOQ33m85qo56yZXygWcEivfH4=;
        b=NeRFdEx+7CYRiPdWamYEYRQsV8yw3iSr7q0fKfO5IL19fk+QtRBj0iZfr+E5b7GPRn
         2motrUtFku2Mkyk6Vi1o4FT3AYTBjB3oLbEDhYfu9CZPmCpXyaSkPCvWurZzwCKXOxHE
         Ra1DLRh8NO/8twWs4s8yHBXriP2OtpkuTDFrk+vZfO+PGcbXCn5uyuUKg+raHghtYZKt
         bTvcZXK1ftP4dl3uEwgeKein3hL4CwdAF9x7YVRKoXmiAN29Kb5XVv7za4OAjc+xp9zZ
         JLAYTDW+7GDWHGqdQUuX/1QP1Ws1i+n6gINL+7yBSSIDIwt91bjRYhCeCn7CSfzUf8Ol
         P7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mGLoTXPyi+sh3OuwmEKOQ33m85qo56yZXygWcEivfH4=;
        b=NGz8z76rceRRNuhmmfyqarYU07Em0TWobfcGhGFGGpf6jHzOrMMCWJN+tMZc6X+DXF
         YdNhvH7lT5aj84F6imeqVW5LyWvSJTFCR2JRh4fgLKDsJ5JcL2tngRoWOwqI9RwElgXW
         rVfmyXsS/KJkjMyiocJE22gwqd4bkJpdgQOWTsOD3y1Uh0eG6/uW2N9a0kT2F6J1hvWz
         npsAgfAaWE7QwwP9XazvOyLuiLVYYMvJ57L8lCglbMoTqAAOX6s/b7QeVI22Lrkc4B4o
         YuZZ+b+0ychTJtifcUXsNyvzW6blkdpDBvd9qohQPhg8I0Kpp4B9sGRPeXZZ0z+QETeA
         cqaQ==
X-Gm-Message-State: AJcUukfRV+psf72UQE2ReEOcKsnpFD9yA0y4H/tUSc2pdRB4eMvtRYPO
        uFg7X2/RCS7qf/iesL3Fiad08zRHMIsKv9EyPsEy
X-Google-Smtp-Source: ALg8bN4ttdKFG3zHklgdsui2ljxc2fg3B2mcc7W0wEnUw5VReiSsuF781tE3O81G2OyYRIUKCPQ2UV9PcU44RifAPx7N
X-Received: by 2002:a9d:7ace:: with SMTP id m14mr3595325otn.31.1547593363491;
 Tue, 15 Jan 2019 15:02:43 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:02:39 -0800
In-Reply-To: <xmqqva2ppn17.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115230239.57954-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqva2ppn17.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> Jonathan Tan <jonathantanmy@google.com> writes:
> >> 
> >> > Like v1, this is on origin/ms/packet-err-check.
> >> 
> >> By the way, when merged to 'pu' as one of the earlier topic, t5409
> >> starts to fail under --stress.
> >> 
> >> 	$ git checkout 'origin/pu^{/^Merge branch .jt/fetch-v2-sideband}'
> >> 	$ make
> >> 	$ cd t && sh ./t5409-col*.sh --stress
> >> 
> >> This is not new to this round; v1 exhibited the same symptom.
> >> 
> >> Thanks.
> >
> > Thanks for checking. I don't think this branch is the cause of this
> > issue, though. I ran the same stress test on both:
> >
> >  - f3035d003e ("Merge branch 'sg/stress-test' into jch", 2019-01-14) and
> >  - the result of merging sg/stress-test into master,
> >
> > and the test fails with the same result.
> 
> Interesting.  That is not what I am seeing (as I manually bisected
> the first-parent chain between f3035d003e and the tip of pu).

Ah...yes, you're right. I forgot to build before running the tests. I'll
take a look.
