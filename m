Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC96D1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHSBgK (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:36:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44002 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeHSBgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:36:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so4993708pfi.10
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hHrRPvGczqvl0kJ1OJtgHaimNbHNCsvRdV27AfK1Up8=;
        b=iSquAapr7o+3NCzu5T/RjEjGk5HIvYYbMvQQ1qCAhBq7F/4tqPy8nXcEN8hDlu/NmT
         Ac2U9F6tufQ5I0elkUGlfaKodHZ9W2VRpSVJ0BCWAKcuBWoN/4IGQ+xAYDQXM8nGZQMV
         vusCaPXut4wkumJHjwQck4JHrQRSKP3rtAKypx69wzfamKjXSnmuB6v4fjMa71l1wwfp
         TtbJ9PjtYSgxM8x0Vq4lpk4VokQ8JsqX2ZV+nEp2857gj77Aizct5EoHPVMIyKkqpe3g
         aZ0WellKeDNfE9P0QKED7oulTRfaULQDzQK+8G6yE+k9ZyHGuRARPtrqz5T0Afj5I/MY
         QKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hHrRPvGczqvl0kJ1OJtgHaimNbHNCsvRdV27AfK1Up8=;
        b=Aupiek9tPBwCIRBPx6rvOA2ZQX6pyLy/yGCSGdsQSlB1EjT50h8LdGkWCyqPnZ5i01
         DgOHzOSswRVo9bpIAopJ6w/1SR4LU3CW00LoGXe2/CNhLTP3g16Weie9/tk69GxY2Nfb
         dF1hGZ5JDmSLkWjV7DDCekORvQVVpj6rrKsmKQn2u3/0fhQqfSSIRZ2Gy9zJpFcxUaXl
         RlHZuhn+AykTiZhJ6SaiDnlEdG7WN8z2QheWzp4vZMPEVv4ftJl5Sz2MSrvqJYPpz04i
         QlYkMbqECHlPq4mHanuPPM15EKpGFYMlE3EMcMG6IOezXu3oUyUDrHWC2zSo3g2qgK96
         uIZw==
X-Gm-Message-State: AOUpUlE8fdRqpFgE/oaJU+R4/2NNJFumyqxbqhVn0MbmpWjqoyF474rW
        1zL9jGP/LApidhhQiX99woLYtYbu
X-Google-Smtp-Source: AA+uWPwSEXxOQi95bA0USeNXekDzNy4n8CRNssXlKa6S0e2BzJhqi/PsQ6qDXg/aDMFyH6CYBJWcOQ==
X-Received: by 2002:a62:c0c4:: with SMTP id g65-v6mr41818076pfk.72.1534631216195;
        Sat, 18 Aug 2018 15:26:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 77-v6sm7398649pga.40.2018.08.18.15.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:26:55 -0700 (PDT)
Date:   Sat, 18 Aug 2018 15:26:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180818222654.GD144170@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818054300.GB241538@aiede.svl.corp.google.com>
 <874lfrrhfp.fsf@evledraar.gmail.com>
 <20180818204243.GA136983@aiede.svl.corp.google.com>
 <8736vbqr2p.fsf@evledraar.gmail.com>
 <20180818220821.GC144170@aiede.svl.corp.google.com>
 <871savqpvo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871savqpvo.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> I'm just pointing out in the more general case that if someone comes up
> with a badly named git-xyz it doesn't scale to try to point this out to
> them before git-xyz is widely deployed.
>
> So we must either let it go (solution #1), or come up with some
> API-level solution that makes it a non-issue (my #3).

How about solution #4: live and let live when it comes down to it, but
act like actual people and talk to avoid negative consequences?

Some social problems don't have technical solutions.

Talking scales, in strange ways.  For example, people are able to look
at the list archive, people are able to spread thoughts they have
found interesting, and so on.

Jonathan
