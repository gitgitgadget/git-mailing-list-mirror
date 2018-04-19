Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5267D1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 01:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDSBqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 21:46:02 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38662 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDSBqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 21:46:01 -0400
Received: by mail-it0-f44.google.com with SMTP id 19-v6so4794343itw.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9a2hX9eUZP5MSxsjkLsuioVgrmCzl4KbWhjciz9xliY=;
        b=qm2LQQ7VLKTnb8pCELr2xN1iEpehE8zmymySMojnqzM6y2pLiq3S5jfyD8OQm1VdKQ
         Z5csnZISBAVehpO1vbRoU9sHen2YP8VooDOBg3fWPbtSou8Tro7Cml2Il6Xr9rUU/EU+
         GU2dkOONwDv7xpXxKXvuxMejedZjxoS6w9UYrZJlMEZAfVQdm2FxXIi6q5Gk0VwqLI2P
         uj28UiVA10K38u914jFfHY6vixvijdD+liVutvW87sWRRYg3WNN6lWKT7GQNAyqnkl3T
         lwa3ALGznaQ3CpTQrrIwy5bP03dvol2UT0zeBSYTC1tkxmchrgY+QDF5rEekpcvNewRL
         Gs7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9a2hX9eUZP5MSxsjkLsuioVgrmCzl4KbWhjciz9xliY=;
        b=c/C/OOmERG0UaA1Np97jXBget7BWmrsIvLIF7yMienZzCjIt+7eyb1tnrmbCG/KkeR
         SI1t7olmsp9fRmw+/j/Hl5+NTIE24Fa0qskZ6aiY6zJ6cdh2HhQok3OVxLgU5RhNEM7g
         DjtIFjE+gCz3FcXqyHXktOUEf11LISp7JIacU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=9a2hX9eUZP5MSxsjkLsuioVgrmCzl4KbWhjciz9xliY=;
        b=Q1cbjaUX8zdMIvhV2ohwOhyxwXmJ0Z+ltqihhxk9DNHFoQGBPdKUrf3GTQTbB4abuP
         JisUhlGTH+dfq5f/a4omgveOj8mLKa+Jia7omtn2hhcuSnHGcCCeb6xtEKjiy5xsxelw
         cuaLVms0dvDsBfn0LyU3cAacel66SKiSXDA9KrLLhd5aB0tG5dG8RKOW+bak/6jIuZo3
         ZMTlhmwZpm6acHKwpP/ror18L6kWnmpbmoRUatJNR6CsSSp1Sa26ebRB4S8V6PxjGwv8
         FzBU4DhcNqtayZsdz2U0O/l8wS1v+JWN6z2EnV2D/9rQOwjk23tz2k0QSoXRYZ8dvhGK
         hVsQ==
X-Gm-Message-State: ALQs6tBWrleFB6JLk91XuF4RaDkqFLgkHiMyY0WKiry9QoNyA3BmIl3y
        65wDa97DycwLMc/DhZSYG5guCDzqzR2eWTLiRszgMA==
X-Google-Smtp-Source: AIpwx4/JuunSmQJFFnkxiY9ISzdp+05H6YbfZ3KSLkUjaHuRopvPBZZbINdUn/hPiydyuBO7rik09DbHMB2OSfPKUhY=
X-Received: by 2002:a24:5b02:: with SMTP id g2-v6mr4696512itb.100.1524102360456;
 Wed, 18 Apr 2018 18:46:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Wed, 18 Apr 2018 18:45:59 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Apr 2018 18:45:59 -0700
X-Google-Sender-Auth: h44Xw89HnVZ49KzEx_AKK1-79wE
Message-ID: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
Subject: Silly "git gc" UI issue.
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, this is ridiculous, but I've done it several times, so I thought
I'd finally mention it to somebody on the git list that may care:

  "My name is Linus, and I'm a klutz".

what does that have to do with anything?

Now, imagine you're a klutz. Imagine you want to clean up your .git
directory. Combine those things, and what do you get?

You get this:

   git gc --prune=npw

Yeah, that "npw" should be "now", which is where the klutz thing comes in.

It turns out that git reacts ridiculously badly to this.

I'm just assuming that everybody else is scarily competent if I'm the
first to have reported this.

                  Linus
