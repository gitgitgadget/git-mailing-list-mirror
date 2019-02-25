Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F2420248
	for <e@80x24.org>; Mon, 25 Feb 2019 09:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBYJpu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 04:45:50 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33465 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfBYJpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 04:45:50 -0500
Received: by mail-io1-f65.google.com with SMTP id e186so6997733ioa.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3WXSF6D99rA7l2gDRi7hHEf0rjAX9jfc2HuZjMB/cC4=;
        b=Rhm7fRNPLDkn58Mis9XrmSp7FiGGkOSw0N9OmWothXEtdUJi/TNE5FKhlFz5jrCkg0
         UO0PZKoYnbo1jTmmOBppkDpdklSv3IZ9igVSaYJGvTxsV+aasaYTYHedIakD+Wi/fajV
         Fljbc9i/cvnornry9RJ0Vu4i7pBSq1GRtHeZUWalbsYQE+jFvA+Zl0UjY4KKklW890kS
         a8P5lBpVeCl8W014FGDXRAN9txi5uySAdMSp3SfXS/MfPdBPGDOvm/Cw1myDIiYg/JkO
         +9+lmyKhKEGMKOWTQNTcwVvKC1tOMbzX+f4CoVU75pKWm6P9cdTtSFh28xcgLcjAN4c9
         sU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3WXSF6D99rA7l2gDRi7hHEf0rjAX9jfc2HuZjMB/cC4=;
        b=gdf9/p0SgkFey+dq2nuNfHsSTLSxZg1PfSQfvFJzbeF24xo5ywUmXfAmb7mDB36MlX
         BZU6wltKdAYFm/+Cc9WtdirkDG9cupEb+l+rkZuLdtZnijeOLl4ZQTM02BuuXpOwKqXJ
         JafRcmbDpzoGMNZtfQA6ntIxglzQLdjBgqX+ZcvSju8+qe7FbyStvwcvRXBvxD0XlGsc
         bSGC9EaXCA8w18As1gwADgP5IaV+EiAjrVwdEXyvHy28bCU1pARaXn3NDIRZH+xHZP+k
         J2O5oWbecyPwbqX8kD42fSnPLYEDB+ZLWiE5hyJ+7qehZ+4w7emhizpxsWpZ6K7BDGmo
         AHAA==
X-Gm-Message-State: AHQUAuYitGCxE7U9yxCIiw8Hs5xFadsfEy2ONI41gZHwC0eMtj+ZkNaP
        RSOTghJfVhpX6VgsY61f+bDFF4uXOLs9bFzcRsw=
X-Google-Smtp-Source: AHgI3IbWZ2SC18K0X6rH/XFubfn0Cp41bP22PQ2hmeX/8i2tV1F9bQE5IQdfkZOTFUL1L6hzAMoJ6yVAS7glSWiNc+0=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr7817852ioc.282.1551087949290;
 Mon, 25 Feb 2019 01:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br> <87va1a3z8e.fsf@evledraar.gmail.com>
 <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com> <87tvgt454u.fsf@evledraar.gmail.com>
In-Reply-To: <87tvgt454u.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Feb 2019 16:45:23 +0700
Message-ID: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 24, 2019 at 9:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> ..
> Can't the utility function we're moving to just be made to be
> bug-compatible with what we're doing now with symlinks?

I haven't really followed closely this thread. But I think the first
step should be bug-compatible (it really depends if you count the
current behavior "buggy"). Then add improvements on top if there's
still time or strong consensus. It's easier to bisect that way at
least.
--=20
Duy
