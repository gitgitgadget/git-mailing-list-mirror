Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CE51F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbcGKS23 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:28:29 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37649 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbcGKS23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:28:29 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so62607021ith.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 11:28:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Zl10W2BqFSJS9GSF6fUVVvL0U4ZgXnZZAVZTDEz69w=;
        b=fFUJrqyFz7XFf3IEZHmUE4xbbx+zfYJp2GTHM3GD+SmKUxqkEWcCKvINRKZ1PPcGXH
         5YZds74/MDSuW7fnmpkBAxvHZUSpsFlO2oSKd2h9LamzsFcllz/nxpDAQ1FeH+o8UdKn
         W2QRNAqJyEn59OfvIsyprZWOu7vQme2Q273wv75OUt/hWGcmxTO7CiNEmhobxSlLoCnE
         LBau5AzSweynYN7dQu6bmE2qOJKScjEfgpY9l8ldozFCNGzkrziN0yOKBMucCOxwbhC/
         gPpx6Jgn8hBCHGpq+htpqjMdPKQKWR/B327OSpnDx0Bf9syZB75F4MDIiHYl3PbXvtX5
         gFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Zl10W2BqFSJS9GSF6fUVVvL0U4ZgXnZZAVZTDEz69w=;
        b=OJYVz914dni69VgRDWjM9kM27hm3rn5S6X+9WIyIOy6LYsVsA1Zmm81K8fzqmSYrZm
         bFYg0sVw3LZWE6x3EGKLypQWuuoOeKIsnwV/u0C6AdoYhjweRMOONsLS5SSu+cZ4BVa2
         ja1gBYGxXuVTBrE2cGTSRS8fOqVxOAICmVOGMh8o6zpkuL/EhX+juUffj50zD5Evatt1
         J1yKg5YCLWM6RfrIpAJZfkXuGik5HYrIQ2psJeLpSwSx3UKcqy8CijyZdhX4vWE+r9ir
         TryPN4T5UsHpO+P1OZF9nnYiPHJ8T6pa0BsE/JqetxJhmkSre+Z+K6jzrr2lDwtp8aBR
         cl8w==
X-Gm-Message-State: ALyK8tL1shIoqoAttkncXo3l7vdGs/FTAyYSE7jb965BPE7nhlq/EV6ZP717aFYiLJdJm4xND0oC+G5yoXd6VQ==
X-Received: by 10.36.81.15 with SMTP id s15mr17185177ita.57.1468261708157;
 Mon, 11 Jul 2016 11:28:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 11 Jul 2016 11:27:58 -0700 (PDT)
In-Reply-To: <20160711172254.13439-9-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org> <20160711172254.13439-9-chriscool@tuxfamily.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 11 Jul 2016 20:27:58 +0200
Message-ID: <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
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

On Mon, Jul 11, 2016 at 7:22 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Everytime split index is turned on, it creates a "sharedindex.XXXX"
> file in the git directory. This makes sure that old sharedindex
> files are removed after a new one has been created.

Hmm it's one-way link, we don't know how many index files use this
shared index file, how can you be sure nobody else will need it? I'm
thinking about temporary indexes. If a temp index is created, saved on
disk, and use delete the shared index file, the real, main index may
become useless. Temp index will most likely replace the main index
(git commit) but if a failure happens, we can't fall back.

A safer approach is "touch" the shared index every time a linked index
is used, then we can delete shared indexes with old mtime, older than
a grace period, in git-prune (or here).
-- 
Duy
