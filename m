Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9FE1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbdDKLGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 07:06:33 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35991 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbdDKLGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 07:06:31 -0400
Received: by mail-io0-f182.google.com with SMTP id l7so129209289ioe.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Lp7cGJvwMdi0u72ZxU24Fdq/A4/LDszEC8uz4qIPb0=;
        b=ZzcFjT+VBNhY4LvEvH1gylxrU9sqBZSZclTd3w7DuAWLBlQDKIIoODw3k2iBZfjduV
         WMYYwil/IBlgzcnyBJUDAU3FrC0djVVRHbmcNMxABocK3KJo/0IJL31lejTYbQLiNIDl
         vlJVIHAhMI9QKHYaH48X4gscAK/rwNIjx8GBbiCuqstzxkrXGHKPaALl2hPNNGM2WR9y
         0Xz7+iXtiP8wc59oCm/LMGTOWzQ+RwxkQothjKglZ/MS+A524ykE6DjgSQr00lmPPUva
         VYhK3JgSpxKCslK8w914Wbga0DaX4Q89Th1FvLMdfDgv6Cag9mlimE3l7GzRyx2be3zM
         XEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Lp7cGJvwMdi0u72ZxU24Fdq/A4/LDszEC8uz4qIPb0=;
        b=HoDMbZXPD4sdI3WMrrf2oxdQEDtksX8wnS2nxiJJWHMU2QwH1RMc/IyZwvSZQogAvK
         h9J5NnJqmcAElugNKYQbx57lL559CHnsIAB5Q5MnCXOwiS/BtKkTpySmOLVwsGlZdkF9
         sh8WHEV1TOT9uIKkh6fzElVvTuT9MoBUhRki9n+uIKbZ+hOGZLp5yNy3QpmF5U6+eZ/5
         6sQBU0iQOCkVTFsT0KG+/KJj4NpLoiM2pMMzSWTsPE/bcteTcdhhq10a8jQtoeudofIL
         PlqL2fAhblLDsDY4JHeEfp6zpZ0Pd8wDNmvynI3MtPaWiUZ2A/bCKTya1zVs4e1kA1zt
         7vlw==
X-Gm-Message-State: AFeK/H0hWsI3bMS7HrICl8uZcJ7qWgiouR2ifajjSuNCo1pS4+6KQiz78QfuA1t0O8d2nGDq6T1tCLK6knUV1A==
X-Received: by 10.107.32.199 with SMTP id g190mr60721626iog.117.1491908790863;
 Tue, 11 Apr 2017 04:06:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 04:06:10 -0700 (PDT)
In-Reply-To: <20170411105408.332krulfrbqqi42k@sigill.intra.peff.net>
References: <20170409191117.25175-1-avarab@gmail.com> <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
 <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net> <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
 <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com> <20170411105408.332krulfrbqqi42k@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 13:06:10 +0200
Message-ID: <CACBZZX5SooaEjLSy-dTRF-Aa2EnH8S2hS+w40mPTUOvonBNPDg@mail.gmail.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:54 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 11:27:57AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Junio: If you're not in some rush to pick this up I'll take this, fix
>> up a bunch of other bugs & tests failures on odd --root directories
>> and submit this and Jeff's \r patch (after adding tests etc) along
>> with it.
>
> That's fine by me. We may want to pick up the segfault one separately
> (though I don't think it's security-interesting).

Up to you, but in case it's less work for you & Junio I already have
it in my branch of fallout from this series/discussion, so if it's
easier for you/Junio I can submit it, and it would save my a tiny bit
of work since I could just base on master instead of some other
in-flight patch.
