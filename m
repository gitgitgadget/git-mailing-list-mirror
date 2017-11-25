Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E5D20954
	for <e@80x24.org>; Sat, 25 Nov 2017 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbdKYUqV (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 15:46:21 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37041 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdKYUqU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 15:46:20 -0500
Received: by mail-it0-f48.google.com with SMTP id m191so17056222itg.2
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 12:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4S8eyuzZC+bu5iuAvyTnaa/hP36Q4/zKBKR7/mRCwSc=;
        b=sKAZ71gkEObT+CvJjvLH3WtEWR3WmRC5gJIPpT1dph+jp+VXmAXRCqqScxZks9Clsc
         kK6DMU8PNLXGSLqp05N+Oac3Ppo2GONLoFA4YBu20Osj093K9QIFzuqqGzlTidKkrSu/
         NeluWrwpH+Fn9G4UJGZ+lyMn/UJMaOn3tkTHjat4zbaDvEJkTBNuHDqTdgX2ekqvWRgk
         x9OBUzPB7BVHTSBo7UpXnWnJ048IR5YqCJwGWd0xbtWnP/NzF3VBwCIGFuJIIJpv7wf9
         7clg2Pb7/366WPRzGoa6fI2dWEz41xbEylDqm3mTayzmCKNN+UxKMUHPl4DC9XGyJeYm
         OfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4S8eyuzZC+bu5iuAvyTnaa/hP36Q4/zKBKR7/mRCwSc=;
        b=E52ozVYo2MeUnD7LN8pUkiYziAfRs29449jA+bUqVO9jmEk+dcFeDp1Wfj0qE2GkJJ
         MSfATnCxATISuFT6LjQfUxbuBblOBklP01CT8ua2GV8T8HWh48em4eV9wvjulj1aL04h
         Y0MLLYqiMuK9LBajykqtsRdxeDaxZUtOJJzY9caMGD3tZA9qQ9fF7a7O6gHpjpoDOVNh
         kVO9xVJsEEtTcgfwg4p0L8hKuPJT8s81mF7zt894KjUBG/sA4V5WoKxavqFA+4NUOwqt
         OZp7JwtzKWPA24D4R2xBrEDYdbhJdK267xdzrHE13Yo7+GVRwrtknOYu7x1G9EJLoBj+
         NhZA==
X-Gm-Message-State: AJaThX6ak4LFR5X0Ofeh6JyK6mGuerWfpJ0TX5v381SFV1HXxGAIGdxV
        RvcpnbJbVuk+NWW1nXJLVI95HdRuLC7OjpiKXEcDzQ==
X-Google-Smtp-Source: AGs4zMaj3csnOBHga+5wSFkcLXkFfpesAFjFZxCsHllQvoqHgvOV2XX0HQb1k+qGMr1B/srD3UQKVtHvio8cCp/xNOo=
X-Received: by 10.36.0.209 with SMTP id 200mr21983906ita.55.1511642779125;
 Sat, 25 Nov 2017 12:46:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 25 Nov 2017 12:46:18 -0800 (PST)
In-Reply-To: <20171120171517.6365-1-chriscool@tuxfamily.org>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 25 Nov 2017 21:46:18 +0100
Message-ID: <CAP8UFD1YY_f4Ds0sYK86OBb7Wyud_YWr2Wx8nx1pdnwSsPgJ8A@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 6:15 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> By default running `make install` in the root directory of the
> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
> and "gitk-git" sub-directories to build and install these 2
> sub-projects.

Has this patch fallen through the cracks or is there an unresolved issue?
