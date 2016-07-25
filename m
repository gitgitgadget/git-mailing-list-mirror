Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3E1203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbcGYQF2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:05:28 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33727 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbcGYQF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:05:27 -0400
Received: by mail-io0-f171.google.com with SMTP id 38so165632472iol.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 09:05:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jSgGAJ1VY8JYy9Za5jDlKWFMg5FrYlvgt47bV5Clxa0=;
        b=r8+rk9GxadeQ+0IYJz5D+br2tCyatm90qkVxPpgaKs6hgMbIhHr0vt4Jezc7Je7XtG
         bhPhgQxVCsJznGpotiDmaeZjFx/CaFtiJ4881gmY/LR+3Bbg+GjRl5xh7WVvsPnoQRcm
         PLghj46ueWAAjKFdDNrfZfWk3/OaVEe0al2VlAl+8TsDmckNnZCOuScQqXImxon6wE1I
         Fa3uM6o0C9RPvXFOOja/8lbL3zOd/OdOGABqbvCC2X4ZdtsmaPB1Qj2sop5opr1FEz5w
         4qy4WMWXTZPJ8m4zRpHWS3ObVhOJkdVt28Bi6UE5THDMQIG51+S0Us9HPlARIc5uinQD
         3G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jSgGAJ1VY8JYy9Za5jDlKWFMg5FrYlvgt47bV5Clxa0=;
        b=aUl1o2iR8FQDkUb6NByRQvgJ9u7JWtlyUBOSDZtUKnpwYuIG1trfqYptKWMLT7b0v2
         qsvfCZZ6rkK7sp389Y9WdBxI7inNLXCsEXN0lEkSZgx06jVYF1nCZUNbkIgYkx8Vevk6
         rt4xXl3NzMIo45oPiDKazBygWBPUA2jS/BuF0jihC/jezaucUknEEUKMYcj4MbtpGFH+
         4uTMq58sBaD2IInltkRnIPsXz65zWWj9NOptyXkQVYTpPI12osIKzqHocDRHDLRwT0TP
         aGYIYCxSiyAlveqr2DCb5Pcxfwl3euFl7FLOVo2WoBtjZkY2hGFZFQ3kdqmxXFBm3IXX
         GHNA==
X-Gm-Message-State: AEkoouvVoABbxI0cuq0IfN6Rh2FQ6FkukWOO2vPCcG/qoO0l1Trz7H07azz/WZllivPqLKtBtuX2BMah5GrPnA==
X-Received: by 10.107.8.140 with SMTP id h12mr21673259ioi.95.1469462726435;
 Mon, 25 Jul 2016 09:05:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 25 Jul 2016 09:04:56 -0700 (PDT)
In-Reply-To: <CAP8UFD20WtCPLb3VzCJnYZSreUM7Q8GOC_VBG3h1j3wjOcR=_w@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <CACsJy8ApNJ+EBOVNC0GoPUaO898QRqHUZ2yQ39Qg5uGq4sHHGg@mail.gmail.com> <CAP8UFD20WtCPLb3VzCJnYZSreUM7Q8GOC_VBG3h1j3wjOcR=_w@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 25 Jul 2016 18:04:56 +0200
Message-ID: <CACsJy8DRmcUzG+Uj65nqmyjbohbWq1Us4c7YkNkG15fjGijfEA@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/8] Add configuration options for split-index
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 23, 2016 at 6:11 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Ok, I started working on automatically pushing back all changes to the
> shared index when the percentage of entries in linked vs shared
> indexes is greater than 25% (maybe I will make it configurable later).
> It is very basic and doesn't work well for now (for one thing it is
> missing added entries), see:
>
> https://github.com/chriscool/git/commits/config-split-index8
>
> Basically I would like a way to count then entries that are only in
> the linked index without modifying them to be safe, but I have a hard
> time seeing how I could modify prepare_to_write_split_index() to get
> that.

Hmm.. can you do the counting separately? A shared cache_entry must
have its field "index" greater than zero. By counting the number of
entries whose index is zero (i.e. not shared) against the total number
of real (*) entries, you should have a decent estimate when to split.
Then you can do exactly what "git update-index --no-split-index" and
"git update-index --split-index" sequence does, but in write_index().
It's easier than messing inside split-index.c. If we hit performance
problem, then we can look into changing split-index.c

(*) remember that some entries may be marked CE_REMOVE, which are dead
entries and should not be counted because they will never be written
down on disk.
-- 
Duy
