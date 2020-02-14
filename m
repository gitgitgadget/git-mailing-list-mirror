Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E97DC352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 00:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007AB217F4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 00:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITDZftvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBNAwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:52:13 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:45577 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBNAwM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 19:52:12 -0500
Received: by mail-lf1-f48.google.com with SMTP id 203so5572072lfa.12
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 16:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pIiL3EBg/rsyR66wi4sEzSGUzZ98rbP8zNSvOHZj7Xs=;
        b=ITDZftvrQKdMb37bpArXQ43XHwSeYx1D6mf+yPNwObWadrUX0k4EojlvO4vIpFyDab
         wkjD5NUuld9/Y5JnVYObmZj198Bye2NQnIEZuWPMKmX8FIxsYLob7rms16WGWRqt2N9+
         bkGvs2bsPsDIcmgLM0PAt2TODlIhhE4pa3e6BfnaZIofc9ug8zwMnHJ0srxflNVeQP7F
         ZpjEfpz4U4J2kBi/GyNqWXhlAJpwQLxRPQ1qyIBCrCgtuwteIQ4NjWIpQJnHY8RO5xex
         9jJf6IMPpq+s/15Wx9ncpPVw/5b7qGUGcifWZ/P5EPu6pKN2oHD2TZfLwr14kDUtjRUr
         FWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pIiL3EBg/rsyR66wi4sEzSGUzZ98rbP8zNSvOHZj7Xs=;
        b=pCXpeQKfI8MEz8232RkEpwBiI+7zzFo2+thwoWzM01Xe5Zwsd8PrsnT1hkooloVP4k
         WCqabsk2kp/a+3r/PjcUqRYvXiGe0cczbvoJOZTRViiW6PySEvKwd7GV+t4+I4uis6xF
         0gSVPXtslNu+v2SWauWqf4tcISQ4ngZdk2SnAxVkv/7TyvERRU5vy5lwOs+BpqJfVDnf
         k9c4x8OW0d9nwVylNFhZ97XJWmDIKbkol9hOsp8qoMc5XA5gZPJl3lGCGmvic9INrLoE
         5LmnKZ/w/R6HDpFIBgyzig2aGfROMbX2NdctdTnYC3lAs+zBc9QvT0LB2vfjNpLr/mu6
         DIbQ==
X-Gm-Message-State: APjAAAUgPSpCHsxQuoGnM/cLrOWn9HNrIV29nPnmMr0BKQ8pHW3NaPlP
        uvlnMoKlxCyK4v/YD7cK4ECgzhMy7T3xyIav1taB3u3j
X-Google-Smtp-Source: APXvYqz2AqeXdU8v5Ns52fkJLIsO9/q/8eyauKlcCGcoqiR0IIB36NuxSbg5qDh78JOKifCu0D9pB/4CKUu673CWcSw=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr286767lfp.133.1581641530047;
 Thu, 13 Feb 2020 16:52:10 -0800 (PST)
MIME-Version: 1.0
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Fri, 14 Feb 2020 02:52:00 +0200
Message-ID: <CALH1-Xr_pK02j6_51EnZN=ZrSz6dijt9tn0ANJ21331GzAmBdQ@mail.gmail.com>
Subject: [RFC][GSOC] Microproject Suggestion
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, so it came to my attention that GSOC applicants will need to
submit a microproject to be considered. I was thinking about
implementing the squash as a separate feature from rebase. I did not
dig up enough in the mail history to know whether this was suggested
before or not.

It would be something that looks like this:
> git squash <number_of_commits> [--offset-from-head=0]
I did not really think it through, yet, and I don't know what options
could be put there so I am open to suggestions.

My motivation is quite simple. I think it is more intuitive. When
someone first asked me to squash multiple commits before, the first
thing I had in mind was `git squash`. It was kind of a disappointment
that this was not its own command.

So does that sound like a good idea?
