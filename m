Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168421FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932804AbcLMLSK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:18:10 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33862 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbcLMLSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:18:09 -0500
Received: by mail-io0-f178.google.com with SMTP id p42so49442433ioo.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TM1pruogXTjciHRsk8MzMPZ9taO6+hSESVaZ+lhJXQw=;
        b=cYfD7weOdlZdqA8B/5vuRLN1aXzsoRAFTHgPfdaZX9TdUGmg91lPiPcLlebSnt/swR
         Ukgk120KnlcWpdAL04fBsof04bNk+agse8uGDpyCY9bcZF7DeYhJEkKJmzZGLkRyDxDk
         mG7uUIkNHIfeTjVfzzaUx/fDn7L3Gr7RcuwL25Ev53ntziAfQliW5TJQzVB4huF9oW9K
         YnrSIuSxNAJaBi+RcOSszBPKOVbI9MBBhTHz6IB1J36rgGIPzt5kMm9Pt5LGbYkIKrAB
         wPYQMo9VIjq0hA7+EVI+5MPN7LVSIX6mQeMvEkmZnEisNTD38ddcYHaKkxGJsZleTtb4
         C+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TM1pruogXTjciHRsk8MzMPZ9taO6+hSESVaZ+lhJXQw=;
        b=cKeG+m4ORiTEVDcKqW4Hwmp6e9EGWvdpwaB1SGa0bCHFRoWbg/6A8b4LXITm6GAip6
         KlXSTaXKa4HEX4ntdSE3JlRuN0RK5n/OSOuyd9PBShM98sSZbjNH+z9GZI7ucGHQ+sQY
         daankTKV8mk8GrDexRJ4Z60qikvJHs5qvkqV8rcdK98rtplp6oIcVGa21a8AxCS4DgZM
         Z3qcwDxtHCkvdu9zERbIB69jERqqrXIVj0jM14DQvGYUEnRPjUKBq8dTRU025uFrz+F+
         ogNl2kRSkZyy2Igs0AarHhkelayhfUf2EZYt3XaUADZb3VFFmLl4as5a8iEyH4QWsehf
         9UcQ==
X-Gm-Message-State: AKaTC03mNPjhh0htTASgkIn4itJaNB9BpIQpjQkIMF3oOsOhFRuiYsElctKVmHAGiYR8+sUK+RKNU1K+fMmh8Q==
X-Received: by 10.36.184.194 with SMTP id m185mr1833786ite.3.1481627888449;
 Tue, 13 Dec 2016 03:18:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 13 Dec 2016 03:17:37 -0800 (PST)
In-Reply-To: <CAE5ih7_6Ap_dY3mRb3Hk2yzDRMkZ3HnnQOaikF=ybx_XNdVWhQ@mail.gmail.com>
References: <20161210215734.7468-1-luke@diamand.org> <20161210215734.7468-2-luke@diamand.org>
 <CAE5ih7_6Ap_dY3mRb3Hk2yzDRMkZ3HnnQOaikF=ybx_XNdVWhQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Dec 2016 18:17:37 +0700
Message-ID: <CACsJy8A+cEJoKyfEnJvqwT4pvUGgcrmJdRmXKyRoAff4EYgcuw@mail.gmail.com>
Subject: Re: [PATCHv2] git-p4: support git worktrees
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 11, 2016 at 2:19 PM, Luke Diamand <luke@diamand.org> wrote:
> On 10 December 2016 at 21:57, Luke Diamand <luke@diamand.org> wrote:
>> git-p4 would attempt to find the git directory using
>> its own specific code, which did not know about git
>> worktrees. This caused git operations to fail needlessly.
>>
>> Rework it to use "git rev-parse --git-dir" instead, which
>> knows about worktrees.
>
> Actually this doesn't work as well as the original version. "git
> rev-parse --git-dir" won't go and find the ".git" subdirectory. The
> previous version would go looking for it, so this would introduce a
> regression.

Maybe git rev-parse --git-path HEAD, then strip out the /HEAD part?
-- 
Duy
