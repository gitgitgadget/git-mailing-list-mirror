Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8011F453
	for <e@80x24.org>; Tue,  2 Oct 2018 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJBXq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 19:46:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52007 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJBXq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 19:46:56 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so4434597itw.1
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ej+xQRkHSRAHQqDMSeRK2fEtm7uWKhC8lCfXym3vU4=;
        b=tsytKvGkGV8prm2v6n5Uc59peG+YN7JV4fV+zM+uT3xz61icFnuqNFRowiTeTawJHy
         KZ9/UImMNa7CXSa420w53KfNw5NJz6q52VKbhI5yGCjIOgkiE8eKTfbGRsZRZfMarf9H
         gY4nTIkzkqkWvEZzEaZTQt8SGE7Qm7tC0ICOVgdgG3WwkNB9HGvzKqol3UtsyaWyBEgA
         Xyi1yw6RtnT0mWuVhMXtelbfy5LLdDMyKKcpryafScLbHMkpEXFU0iubzYV9LuN+vyiB
         m/OCOo9logMKSzxxsGVDRhH40I71tYFTQFqTzIn/OwgMbGjcaP22raY3WSu1CjRk4iCr
         7lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ej+xQRkHSRAHQqDMSeRK2fEtm7uWKhC8lCfXym3vU4=;
        b=Fn71auVQQrdIMZeUFwQJaq3dAOpPHrMnM7hAEdDwgoTP6/OwRs/urm1vl7BBZ9G48c
         O8jiMiD2UvaSRdhhE6GIlG3nURG622eLp85r526/Fqgu0f1Tie1sk5zInVp2zKIIlHEM
         V+8Ch9wVrkQz6e4L23BqRx6mi2miDW4y7UrJg/6ubCnDwupARPoSqOuLxDXI7Vi7VWtg
         M/3ofQ3ExVtWfHDkNBfpjZbaORbEr8AaaCShc+3IQY/xSERE4r4mm70m7inkkXacqMu2
         MxEF0QTyJEOEiJWmSdj/6kqmQ50ef9Ig23BfmLXqVq/uBk2DIdfaqGLze1h/orTZcTle
         vmKw==
X-Gm-Message-State: ABuFfojm5qt8Sbw9XMFVqRn7PrRFYEw3agat7OJbJ5Linw2KSPdXviqu
        4KobStTbe+XX/ANXgCjTV0UwvoEQnNSJbD1rKRE=
X-Google-Smtp-Source: ACcGV62UDwOeDlnhPLKpOFThZguLSemwusy8t/nDmd+s+E+0TET2EkvypvZ3uLKzxKilbzhl60vX31ymnlKARdxeo4A=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr2459996itb.62.1538499755311;
 Tue, 02 Oct 2018 10:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com> <20181001134556.33232-7-peartben@gmail.com>
 <CACsJy8B9dd-N=w13XP2FuHRfqK2tmzuNx0WN-ZhuchssG6RUdg@mail.gmail.com> <351b9746-6c2e-a658-3f51-71c1f4cbc3ac@gmail.com>
In-Reply-To: <351b9746-6c2e-a658-3f51-71c1f4cbc3ac@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Oct 2018 19:02:09 +0200
Message-ID: <CACsJy8BEk9q0DNzXLUo0BgN3DUYYk=vSQcLqtQY=-JLAn74RXg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] ieot: add Index Entry Offset Table (IEOT) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 6:34 PM Ben Peart <peartben@gmail.com> wrote:
> >> +                       offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
> >
> > This only works correctly if the ce_write_entry() from the last
> > iteration has flushed everything to out to newfd. Maybe it does, but
> > it's error prone to rely on that in my opinion. Maybe we need an
> > explicit ce_write_flush() here to make sure.
> >
>
> This logic already takes any unflushed data into account - the offset is
> what has been flushed to disk (lseek) plus the amount still in the
> buffer (write_buffer_len) waiting to be flushed.  I don't see any need
> to force an additional flush and adding one could have a negative impact
> on performance.

Eck! How did I miss that write_buffer_len :P
-- 
Duy
