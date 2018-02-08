Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043C51F404
	for <e@80x24.org>; Thu,  8 Feb 2018 23:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBHXQO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 18:16:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41395 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeBHXQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 18:16:13 -0500
Received: by mail-wr0-f194.google.com with SMTP id u60so3701416wrb.8
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4lYNztJ00N56t4Tshxk/G4hZIUJx9eMPKkLilALu2v8=;
        b=cLP/pKE7u+SsAyBwe3PINKmW3eRxH6l9MDpFiNrvlcssKGNlsu9p+hmX209B5abXhH
         QEUF2CoQjhHUWQnKlcoH6Mll8TbW1R1W0PfXSBGdLNTrEKVoQ6fujFlZvZnmECdkjb2R
         dA7I9DFhgNEcdwq49N8ujlGwB4OyPUetDCshfFGM1JBKO4CVLcuBiShPJGVvP3+Ounok
         hfZwdCPsrOH6zEtBAK6w8l+bbvNYBlh8joRQ5RrLVqxSKxKz9/g1H0Y+gv8ltR9HUJFb
         dvRyp5TzDHDnj7lbSxXb5koEnHmK9wxXfoyLubkCcqVnDc/eGSpqSE64FYQhHsMbQUK+
         w2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4lYNztJ00N56t4Tshxk/G4hZIUJx9eMPKkLilALu2v8=;
        b=UrZe7u9lHA1fc7QwtINaeV0zrAp8/F3odedXhcd7wRyopZVgOPLaMnPtap7WzuY9w0
         Le/6sJHYcgENDQKoRwzin2b/M4PTF8QLPnGGDNtg1jazx+Fe7Fy4qBBPK4SpOgMFrlJo
         qdDBzqO411nt0hOTybHfn/lHVi/FC3eunTPLLRKC6cKskICj6vxNpbhO8xYu6LVUm3He
         AmK3bGQ4B/Xr2slAAyz698E/KEliVPcfy0nPmj8RavSxD3xbH8hdvb8KnnLtCaO0riqm
         nkQEvIQpoxERAYYGu+Dk/na5/tO1i4VtrW5U3TfAmQziZQ4hfVrHHpxnzY/cTYV0jRyG
         vYiA==
X-Gm-Message-State: APf1xPAvH+cXIXwVFmvL8ZzSYAuj1Bau23TCuGWzlXuJ0NqmQbGAH5iX
        F9dF7Ayq01+vq6I3XxlkJUA=
X-Google-Smtp-Source: AH8x224diYjWT67au6c/VaPSghl8W7Y4SvMvKQ7wC23cAFIH+y9elr3Hu1xTIiDE49OrBu2twkUB9w==
X-Received: by 10.223.173.2 with SMTP id p2mr634733wrc.107.1518131772261;
        Thu, 08 Feb 2018 15:16:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j31sm1359808wra.97.2018.02.08.15.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 15:16:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 01/14] commit-graph: add format document
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-2-git-send-email-dstolee@microsoft.com>
        <xmqq8tc3qitf.fsf@gitster-ct.c.googlers.com>
        <68287af0-a4ec-d2ab-bbcc-84326871120b@gmail.com>
Date:   Thu, 08 Feb 2018 15:16:10 -0800
In-Reply-To: <68287af0-a4ec-d2ab-bbcc-84326871120b@gmail.com> (Derrick
        Stolee's message of "Thu, 8 Feb 2018 16:33:21 -0500")
Message-ID: <xmqq8tc36pj9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> You're right that this data is redundant. It is easy to describe the
> width of the tables using the OID length, so it is convenient to have
> that part of the format. Also, it is good to have 4-byte alignment
> here, so we are not wasting space.
>
> There isn't a strong reason to put that here, but I don't have a great
> reason to remove it, either.

Redundant information that can go out of sync is a great enough
reason not to have it in the first place.
