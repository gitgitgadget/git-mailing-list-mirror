Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6681F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEGPzK (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:55:10 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40866 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEGPzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:55:10 -0400
Received: by mail-wr1-f45.google.com with SMTP id h4so3812890wre.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J86PZPHVbbMp7voDfoLJdo+o/wYFakRR5zw4+Z6cQhE=;
        b=RgofxhpnBOepIqFBzdH4I/wwvfaJOVs8dnj5mELbHx3ZLSpa44U0uaNjlCtIyEzv4X
         Kb3BYfr4Bgvy6KqnOW9cYSz9wRM47Al+yngwLN2Qh1EXLrg5z/XPzOijE93N4vN2MXHp
         UyUxMuO+/6hC+U1l8Hfm0dUsqPI6AtDb91qiZr43xQ4oo+LvisDAl6yC6Ef+M3RlW8B1
         VTTQFk13kS+lu8Rd1ZJBdlr0NkUWITlvBLc4wRDviXvQk5Clw7sQRp5A1GKYftDJZL4z
         2qyLB/xK08xgBU1Vr7JRiOTx/ZJv3PBf/DVkjzYYtWeOw5SDLO+kogAwR2KJaMMNRCmV
         aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J86PZPHVbbMp7voDfoLJdo+o/wYFakRR5zw4+Z6cQhE=;
        b=rqKEXQrdbTF9wEyIXtRlIggDFWiXtRTLl0YsTQQkbohe+P74T1yRlpq/MPIQl0QjAw
         R5ReVUuw5XSrN7UYExgHYeZygGPPDunxo504H81dTJnpg+1EMeZ/S0s6EUJ7dQWP5B5E
         RFd94rbEN+/Em3VXsMGOqhh0tOg3xBOxkygngTneHldY8peN/RNx37GjYhYPM67RV1VI
         CvwPmyzP/6MpiRqZ38LlB5MixpQ5EmOgY/6DvPSN8dceGlVC7hEMv2jfExglCPb1URWK
         QNWIb2uJe8NajVLKePnn2ZW86WxDS3kJM1dtfmojUzIdZ5R9iXC++a2YirL1tJJRyeDy
         jgbw==
X-Gm-Message-State: APjAAAXwDNexovXIRY+2YitYLUU29mzWMCoy6ie4HjBlJc17KSF4wPvm
        Vhnvld1xzJWfZbHAGY3mKbSLsUXM
X-Google-Smtp-Source: APXvYqxxc5VuwEOtrB7PJ79diUF5rfkmZGAOsuYngX6TBQ4SZbTmcuob5zAHy2cymHNR38BCLwszLw==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr24317854wrv.131.1557244508293;
        Tue, 07 May 2019 08:55:08 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id j71sm14319795wmj.44.2019.05.07.08.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:55:07 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Tue, 7 May 2019 17:55:05 +0200
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Merge commit diff results are confusing and inconsistent
Message-ID: <20190507155505.GA31344@esm>
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm>
 <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com>
 <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
 <20190507145849.GA6313@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507145849.GA6313@archbookpro.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 10:58:49AM -0400, Denton Liu wrote:
> For more details, this code[2] just blindly diffs the first two
> endpoints returned preceding `repo_init_revisions`.

If you throw in more than two endpoints, the result is a combined diff
with respect to the first commit. You can have some fun with that, eg
"git diff -c @ @~4 @^^2~4".

> Also, not to rehash an old discussion but I'll let this thread be my
> argument *against* allowing range-notation in git-diff.

Well, I think the most confusing part is to have this undocumented
around. The range notation are basically just the same symbols for
git-diff, but the meaning seems to be quite different. If this is going
to stay - shouldn't there be at least some documentation for people
trying such stuff out? And that we can point to? Or is there a reason to
keep this undocumented?

Greetings,
Eckhard
