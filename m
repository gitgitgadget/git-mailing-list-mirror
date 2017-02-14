Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE851FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbdBNSRi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:17:38 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37782 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdBNSRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:17:36 -0500
Received: by mail-wm0-f51.google.com with SMTP id v77so23774938wmv.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FQ8hww6IZLonCdxZ95mHhm8zWCNqX33TLxIl8Lx1wEE=;
        b=YYhcmVIwRRd7W0lA/rvjDF9PGhQR1nqHy8GEzDK5bfbK+OUkqKYToO2umX8R4W+BKD
         yvfRnXPZ5P/ONdzvM/h7WTzlemEj+s+d1zfxc2l42sUgD04azMCg4loBWohTaNZONgB2
         aGKvAi5ulb9TETTEUr73TbQ/8q51zctFl/o06wUz3yBiVTQvJ88hNL/u8ncvyV+zRMdt
         MFsPe5fhjgzgFnDu+gFMV2hNxBcEmRB1l6tm2NPt9pq+DsqDMNJ3iPXHpOjd42+u8G6x
         9IxeaOlHpLYHPKR/yEOXQRYgN6z04tXZdYJV2kWy8mRswoOM6kKIDqpAS+NNr8erepaQ
         oFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FQ8hww6IZLonCdxZ95mHhm8zWCNqX33TLxIl8Lx1wEE=;
        b=ETmKE45YPUp/bCI4nbL9Dqq0cqBHAS3maeNTEQByfDc4k+i/85cCB0V6LoWUIjffyO
         pswYZBrGDNntAkNL12KDa0l1oa/bywvg7XCIehI3eKq9sUJt8STcS49jscmBoj3V3sHS
         Qy/hFPmvmG4bcjZzwLkAxsVaIQK5tt+K2LZispYL47zhDJu0XhWQk6QiAbRPj9yFhoOS
         t8xcDKfn5CeV+rAZjC1khBgApnglMSRrvMDRYqznwc9uggwH/SLTwL50ZlvP8HzL+NJR
         v3zWdafvGvKVpgf1Jq0bc6kXenZcNJ8Za3PgDdXPeq6buR3cGeDwzljfk9wAfMb0JYK5
         3sdw==
X-Gm-Message-State: AMke39lhUgRQCzVaTG4gUK06Bb4pK29FFs2ATw8RIy7P7yf6bGpaJg9J1VkZL93KlZCyfBLEuZZGcsNDDZ6D4w==
X-Received: by 10.28.148.66 with SMTP id w63mr4678793wmd.43.1487096254761;
 Tue, 14 Feb 2017 10:17:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.166.198 with HTTP; Tue, 14 Feb 2017 10:16:54 -0800 (PST)
From:   Martin-Louis Bright <mlbright@gmail.com>
Date:   Tue, 14 Feb 2017 13:16:54 -0500
Message-ID: <CAG2PGsqs2dQM0SJ25ocHJ+Nex_m2NC5yQQuROxcF6SG2e93wCQ@mail.gmail.com>
Subject: git-p4.py caching
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi!

I am using git-p4.py to migrate a lot of medium and large Perforce
depots into git. I almost exclusively go one way: from Perforce to
git. I also frequently re-clone/re-migrate as the Perforce migration
client spec is refined.

For this, I have added rudimentary caching in git-p4.py so that
Perforce requests are not repeated over the network.

I have it working and tested on a ~150MB repo and the migration time was halved.

Is this something that would be of interest to the larger community?

--Martin
