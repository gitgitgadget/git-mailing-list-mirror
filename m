Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD4D1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 18:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbcFTSly (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 14:41:54 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33454 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbcFTSlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 14:41:42 -0400
Received: by mail-io0-f175.google.com with SMTP id t74so130933678ioi.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 11:41:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=89SkdAV9fOqwz0aKv1sHXIlDhhqPzOnBfiUkv8aNcl8=;
        b=ut8QMQCjqJOxz8cXRAtUXDsKS47jR2BPafgD0BdkB4sCfMzQ6M3CSRTpGSSeOFnv8a
         bx05O1goLstUhKS5KIzoUX4b8PnWfeod4ax4Gfc2BI9gvyqRmK4sGH9AOSo4CHfX8dV2
         SY+5iTbKI2eFUgWUC/JDARaSzC5qOJI5tqkXhacYPcUQfHhFBCrNoJS4LuXvfAsAyJ1U
         De727rywSQF7I94Db7TTTHjXVxopEl1UCFsehVJQXTFQHhMlhhKTK8qD2yn5NsYFtMPm
         f1fyMKqQWEppufBGjJJOhBpByn67yIIaqmFNs/O5ITmkF/p5mY/JPk673knMnyGNh0ig
         HfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=89SkdAV9fOqwz0aKv1sHXIlDhhqPzOnBfiUkv8aNcl8=;
        b=WToAdb+wFItF3tYSbSrEZ+NiYQujZt8xdbUyP/uRz8RPb3TmZI57DFW27IMFHS209A
         09lqnybfZxXvmJJWD+4+FNF8bEcL5sHHpA326Q+QtbREhytQTtL5u/ZdlGzNDM+JpHnA
         ZgqsZoH8PvqWbVSXpzhIFW2uDTq/a9wdvSe67Da1X2Hf/Wnxw6D2J3QhbbrRva0S8TnN
         YFG9pBSZsCwGfvw/JbVJ928rzds4+S8CDXvQ0WTwp9bAlfJbxm5TA18rxwAEI1/HXKW4
         7FiqIRU8/73VLQLzvJTHrWl4eS3PiGFPJDNTgXCN7FpUuf/QGSFSEAYyghyqyQ1nRQ96
         9WIw==
X-Gm-Message-State: ALyK8tIOxEc50ccbfjg/oG0+mfCjB3FKNPSR3F/K4aXFhbSjVJV+I5Xv5atUBj9gAwBbEEHwo/NHzoyvG6xifw==
X-Received: by 10.107.134.140 with SMTP id q12mr25013308ioi.25.1466448100431;
 Mon, 20 Jun 2016 11:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.175.104 with HTTP; Mon, 20 Jun 2016 11:41:40 -0700 (PDT)
From:	Norbert Kiesel <nkiesel@gmail.com>
Date:	Mon, 20 Jun 2016 11:41:40 -0700
Message-ID: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
Subject: unable to pull from remote if commit date is in the future
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I'm following an upstream repo on github.  Today morning I saw a new
commit there, but a `git pull` in my clone did not fetch it and
instead said "Already up-to-date.".  On closer inspection, github
reports commit time as 2152-06-19. The same project has some other
commits with commit time in the future that were fetched.  My guess is
that happened when those commits got a child with commit date in the
past.

Is there any way to force git pulling that request?  (Perhaps I should
try to tell git that it's really 2152?)

For the record: the faulty commit is
https://github.com/seandepagnier/weather_routing_pi/commit/23c07cc5d2be7ce68349f4b3719b6fa6fe90e0bf
