Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA361F731
	for <e@80x24.org>; Mon,  5 Aug 2019 16:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfHEQ2M (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 12:28:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34691 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHEQ2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:11 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so168627455iot.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8U1ThpMKLGiRA+6tUaz8jAOelm/o2H07tMk8f+rbtk=;
        b=QrdmgBCB5vjBrVNQfjS8wXS7p1VEPsxDUIarYt7b1wrk+O7vGt7eEu+6DT2Jps//B7
         2Ua4tb6x/1uq4K95iXqDZxs+vZjSfCMvIqIDLHQAwd4V0xHS5ilcvcE09JX2kU1qefT9
         Qzf5OVycH38a9N7xx8723QUfq4P+MFUNIfl0lftXALn2DswVOluRadLmG0nyxbILSamr
         YzMdYLv+2vFVhEINejcYSIdUO9NPFr7Z8uYxoxiqoGJ88qaTUWlt/vLeo/YAAXgi81QQ
         tCwyUNGgg6/Ow51NIPERvFmaAwZHD7O3vDHugrZt4B5xavK17MtRp4EK0yvm8N7r54Wo
         FOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8U1ThpMKLGiRA+6tUaz8jAOelm/o2H07tMk8f+rbtk=;
        b=o63pZ6D1V+7Y+TgmVagWs0uRku3ZUxtMMPQJk2/3wgi0vybk3HQOpfxEpXpLuWSWaA
         kO7o4KfkjVggJrCA62T0cRF5tFX6S/0n7QNwCJSymI8b+QGHDWmM6S40vctnlUvv7/ud
         iksT+zZzwlfrY3thuXt0vNziHsaUQjMxdSMk64L6Urn+fs2BJDXtobVvQMbzvS9NF9SG
         soStJFVxS9xM04Y+lRsKP3zsQQr8o1NY1BDK5ZBV/v0tQlavqQqoqZ1mOfc2UbL8kan3
         Jjo36UtF5QrD88C9sJrXo5buXrTvGqGd9G9/M6t3Fu3xFL6DzUuSNXwIqM5T7GshhG0y
         kE3A==
X-Gm-Message-State: APjAAAVB+e7oGBwE7eZMMv5EhYulyRdRA6Qihf+pZcrImoG5SDDV55rK
        jZWMaKBsLJ8yXIVZo4+zpHfXg+mby7I7B4PyT4k=
X-Google-Smtp-Source: APXvYqx64uMCGy1aXNrG/uDo7Rwue35YOY5BQsPCEihWC8DXSvkJfBkaWfjZTFu5zfUQl9JuMtpYPFqlV58g+VK9370=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr22499099ioa.161.1565022490535;
 Mon, 05 Aug 2019 09:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.306.git.gitgitgadget@gmail.com> <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
 <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
In-Reply-To: <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 5 Aug 2019 09:27:59 -0700
Message-ID: <CAPUEspi2i_ZYoseQ8SkJm6k-YPva3fR4G5kFsGOT0KyNZNkQEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And forgot to mention that technically these are not UTF-8 tables but
single byte tables like for example the ones used with en_US.ISO8859-1

Carlo
