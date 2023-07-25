Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4205C0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 18:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGYSXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYSXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 14:23:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212E1FC1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 11:23:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d16639e16e6so1523685276.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690309417; x=1690914217;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+sBN4H7fMUCqLG/5n7noafn60BfeSERDXe/7GvtC/w=;
        b=GD/haLEHrz7n/zDOjw1cS3U9DBf1iGGW/w6FqRnkOqWNKUs01xtZ7TTWnuTuOOEYS8
         xqPPN2mDovVcRadRyAZumss16LfSGadpbS/338Bl64nYF/skC6F6N+J1NO8s2bDiYUqA
         A18fwDRQZvQgF6N9IvXgwVkclhN+kQFcCminYbSCU8cv91mKEUHwsJ12ASRRo63ywoZr
         n5qo0Y4GYLu4efVkiFKWTECUUSQ5V00SJQk1YcF6BGZTZyy1fCcZOlQhvmi9V6I9JoUO
         3eV/zetZYtCrVJRAeu60fyJzpoXc5qbe4bWjHMcEOaOswKC0w39ivfUeQ39O2GNdLktw
         iCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309417; x=1690914217;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+sBN4H7fMUCqLG/5n7noafn60BfeSERDXe/7GvtC/w=;
        b=VWEMyupK9qryHe/DS65/hG66zuUZfa8n2T/EAhD8mcDjWrQ22FRoY1qJK2JUPSGOm2
         QlPhhqU6YpUaQ50Y9L6/P3xKK8RkZgwKXH33OSDbU4JPgy2/9WUw87CvOOAyCMgwZAl5
         Ms4La68nH0QJldyGXr5ch2jwLoNHsdw52pAsk8tduR9USlfTX1nLr/FM0d9Nd3goJgdF
         eHMKO5wzSeMiEvAd/rm+m6Atm+7UdaR3gJnPqdJPqYdRwKtayWkiSPmeUSklHbNqo+tO
         oukEmG5Yu4wLCZnrxJGmcM8Ie5BXcBkgofwUltkyzAFGxhrUBtzGbkHFwnzaaJNlT/F7
         5h7A==
X-Gm-Message-State: ABy/qLbt/DGsyfkV8FlLoS35hC4t0j0d0NNNSF6bHGkJmz364wAgFY+M
        wDnY8Jjv+DIZSFmMX44/puUBOalskeiDpCdCnJzV9Q==
X-Google-Smtp-Source: APBJJlEU3KzIBEwj4SBiB3+vTP3t9vcr6TxlpiaTf44UdmW711aB4EaGdlPCBsVyvy7iL0Jj/vdoSA==
X-Received: by 2002:a5b:4a:0:b0:d0a:f80b:10ac with SMTP id e10-20020a5b004a000000b00d0af80b10acmr6274120ybp.46.1690309417326;
        Tue, 25 Jul 2023 11:23:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n190-20020a25dac7000000b00d0d2c7dbfecsm1590341ybf.7.2023.07.25.11.23.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:23:37 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:23:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Virtual Contributor's Summit 2023
Message-ID: <ZMATKIaU1A1D0wJg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

As I mentioned a ~month ago[1], GitHub is not hosting an in-person Git
Merge this year. Instead, we're focusing our efforts on hosting a
Virtual Contributor's Summit, the details of which are below.

  - We'll host the Contributor's Summit on either Zoom or Microsoft
    Teams (since GitHub is in the process of transitioning from the
    former to the latter).

  - The schedule/duration is not fixed, there are options to vote on
    preferred days, length, and timezones in the form(s) below.

  - To participate, you must be either (a) an active Git contributor,
    (b) planning on contributing soon, or (c) working on a Git-related
    project that has interest in Git's internals. If you aren't sure
    whether or not you are welcome, please ask!

Participants should fill out the following forms:

  - https://forms.gle/xiRcJWBAWJjWR7Zh6 (participants)
  - https://forms.gle/rQ5oWVSVBwyPZ1K29 (topics)

The participants and topics lists are being recorded in the
spreadsheet below, and this is also the place to record your vote(s)
on topic selection.

  http://bit.ly/git-contributors-summit-2023

Please send any feedback or suggestions you have for this year's
Contributor's Summit to me on- or off-list. My hope for this year is
to have a smaller, remote-friendly, diverse, and efficient discussion.
As we get closer to the date, we'll finalize the schedule, make sure
we have volunteers to take notes, etc.

I'm looking forward to seeing everybody (virtually) soon :-).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZJoDjnr+FkgrDsKA@nand.local/
