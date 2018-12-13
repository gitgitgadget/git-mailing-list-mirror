Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4FD20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 02:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeLMCtU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 21:49:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeLMCtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 21:49:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so12803615wmd.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2JdArD+KV2hFX5N6qDnGk/2LVnQhlNYj/94du/iOkiM=;
        b=Y8CMKX1r7EuRi2uXJIWx7DtJ5TqYwzz0M3z9l5WdNGkNvvvc1OKxM7xTk45ffCOspJ
         U0PDSdZUy1LJbkFds3fvNUaXAtI+3p+GiJudubBYaRTsoivhNMLMzdXzk8OFzr60ogsf
         lxBGjMb/LGP7pAqj43Ubw3va0Dj325NiR2ZHMUJmhuunhGPsqn3h0OE+WADBX4dhDdQL
         8fcIx94VcoZmJzCdVSgT5nuREz0zTt1SCXMh+QBRc2osVwuIlPebu+bidOBBUpp+h4TR
         Xv1IIMjYJVetLvhGCTfyBM0+vkAa+V8daFyQRytqEYByWU2tTBQqEOCG9+MCyaMqdg49
         S/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2JdArD+KV2hFX5N6qDnGk/2LVnQhlNYj/94du/iOkiM=;
        b=PHw35VOSlZOqrTjc6xysEYj4JF0Vdk1NS8F167C70lBihMdx7vPWcSBD2J1bWEuQA/
         bZcoy24RkNQ53po5M4V0wcA7gRepZ0LejHjqmuIp6TxuqiP1dJngtHSC284dJbq2DvDx
         E12vWt8KeSJlO5XeJZowNaTz6I3QAARGoaidfamKii3hrz1eSSwxhXR+IRnYOSVUb3dK
         k9jl3yFiFzSr64kKgqQ2AveX50wVBFPyqSmvuWuWMxVtr5qd7a0OBsBGMnB3KuWg5wB+
         lWk6auyl168E9F+mLuhA9fJh9k8x6PJyKuUf7JG/OXAVitj00ubJhLaRnVzVINA2Zba2
         iIOw==
X-Gm-Message-State: AA+aEWaj1+fZ3oKopLK5o+8DMWFvv5vdZ7JRRs19CmROx/l6XBVgR6qA
        iCOpieZoivgNd26WVRNXgEtgCJ3exos=
X-Google-Smtp-Source: AFSGD/Xe4pDKUnrYVpDYFEVeq67E72ebKbftJrJHvpNRC1PD7HnTG3VhuHZi2y5GXfjSQakH955TLA==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr8259364wma.76.1544669358434;
        Wed, 12 Dec 2018 18:49:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s1sm406127wro.9.2018.12.12.18.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:49:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 0/3] Some fixes and improvements
References: <20181211212135.21126-2-avarab@gmail.com>
        <cover.1544573604.git.jonathantanmy@google.com>
Date:   Thu, 13 Dec 2018 11:49:17 +0900
In-Reply-To: <cover.1544573604.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 11 Dec 2018 16:27:55 -0800")
Message-ID: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Aevar for looking into this. I haven't looked into detail, but:
> ...
> If you agree with the general direction I'm going in, when you send out
> another version, I would add patch 2 somewhere near the beginning of the
> set, and then squash both patch 1 and patch 3 in the G_T_P_V=2 patch. 

Thanks, both.  I'll let these sit in the list archive and expect an
updated series ready to be picked up.
