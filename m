Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19A81F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHNVVF (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:21:05 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37153 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeHNVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:21:04 -0400
Received: by mail-io0-f173.google.com with SMTP id z19-v6so19238889ioh.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+zstJ0ejav1GDNy5Q8PQTMYbqM5I4hyCk6IPXAiIYs=;
        b=sbZE/nQpo3k3+bFEa7nGFWZa1APdVxsMwyXoAVemXVNC4IQX3oc8mNJj2LT21QzrZb
         ZilHS+0EUStY3h/iYXRRIQCh+qQ43WUprzG9fWadz0NsqNl40zLtvi0QvloPaZxRATtC
         qlNskL3nMFUKe9dKRn+B/VBDqPn65ghhKB44E3ZHEKuJ5bvy3z39KAMZiTM1HiXkQUEr
         tdYyJkb00qOZPnJ5YpLs468EauRElCPMw969lX4N9Uc0VO0VaTOa1HsdbJqp+ewWPwRS
         vnAgHf8yrI3xNxcgNpfUYP68H0s3zRohmq7Nc+vmJz3nTmAJQxEuLJ45k8mraNPxcyHc
         swfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+zstJ0ejav1GDNy5Q8PQTMYbqM5I4hyCk6IPXAiIYs=;
        b=jl6Zs1gmL33GpeMZLxjIlaZrKn6rs7eky+Do8TqkrinAlSJFNMRbofQFaPbfwzfA8R
         9Buc33hTn2iNvwd45+KRyfB+faqkFPS1Tie34NeFPRkwXyoTubYzdsR4oAjaBxyPeAPb
         JE76S6i0QrVNhWrF5pGhSnlq2bIyFGl/FJvEoeKBh5o06ZS0J5xfap7aGkZXvMQq72+y
         f1Op+5rN8Wult7cgarbq3nSmSEzt9fpZxECyiZZcLAW3/HJAdXfHInqS8pIbOgs4GV6c
         1vYCv/SEL7VFXAfaf/wYQdS7LOsTv2vf+ZeojrzGrY+Vn0Xiwv3acffcoLAwKypu3HTk
         HHGA==
X-Gm-Message-State: AOUpUlF+oQoAyKf0d1aoLa/TpUhEECpwCJ77DCi8HoyAFqAYrjd8mi3m
        GXqePI7P7XcNr9Pvyo9VcZiRwD4kSotKq8I+6mwINg==
X-Google-Smtp-Source: AA+uWPztdn2CJTfSoiD4Ny7nyqC7RNuUIs2hnUNsSlr0CK80V2XxJrCTOHUQZPdEKyzQzjq21J06kYcKuXCpIyOeq0M=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr5991233iok.236.1534271557773;
 Tue, 14 Aug 2018 11:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com> <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
In-Reply-To: <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Aug 2018 20:32:11 +0200
Message-ID: <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 8:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> I'm looking at adding code to my SLOG (better name suggestions welcome)
> patch series to eventually replace the existing git_trace facility.

Complement maybe. Replace, please no. I'd rather not stare at json messages.
-- 
Duy
