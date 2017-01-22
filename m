Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A231F89C
	for <e@80x24.org>; Sun, 22 Jan 2017 05:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdAVF0U (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 00:26:20 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36526 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAVF0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 00:26:20 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so7921447pfo.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 21:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYdWhd/OyGXDkzmv45QV74Ls9N/ohLw/Ms01KRfOHHk=;
        b=Jol+SWhEw9vD5K7VYeyJfnxALW3ND/b9mUFfO9yztX23kh44XUFu3TD6lNIToJGVDu
         aLgrr2haCl97+QPYK37ZGsAC6A6mlzPCd0V8ybPGpnKd9Jnv8JkcLvsHnt70rXl6wW08
         a0Vd8VuwrI0Ofw4IQSlZCmBPQMTS6hGcjJ/eKTNcgErDR+MYGOOtdNZ7bDoEpaj20lic
         JC49aDXDJW8YlUVeklAYx6nzNSAZNvNTN/HeYRqwpnA4osyn4+2xHNM80HPtHdpULuqU
         0O9Giax3d4Di8uQAap1Ze0zk8fjGB+YLKJCsEswVWXHaPaQoQ6DYDFzmVsvOvkqgHKL6
         738Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYdWhd/OyGXDkzmv45QV74Ls9N/ohLw/Ms01KRfOHHk=;
        b=IUqmaQB3DR0O/37p2n1JHB6sRh2ACuBGpTrOWLQ2JnNJH9F9YL/lt8/B19RDwQ15z+
         0Gzm1NYRcaqhN48Njx4SCyOMTbfWpMiX7JDQgJUBmO4UP8Ek9LivlI1zCZlGOrqoWUSr
         dOXHoEJJUV6CoHWyuMAEE5Ju4vt9gGadGzC5sBUVZ7Tb03pFnDX3pkSO70pxeTGihZBu
         YWvS5cjmZ0e5zJgpgHV3EEJf6sDIJ396pMt0gkSz6aFTNu67bug9WhS9mwf4A0DVQjtD
         V1+AN0JlounvQwogzLwC4ziz0zirPSbY/avlNwGsFVUAho1tC2bu3gct1QZ3fDuZOYtJ
         f4Fg==
X-Gm-Message-State: AIkVDXIZPbFzTH/kvt+wcy/deaRFrF/PkVBYmwTzh6CUtoN5KapXFbRk53kTBAGviR4GuA==
X-Received: by 10.84.140.133 with SMTP id 5mr32680098plt.178.1485062774512;
        Sat, 21 Jan 2017 21:26:14 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id x2sm27261071pfa.71.2017.01.21.21.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 21:26:11 -0800 (PST)
Date:   Sat, 21 Jan 2017 21:26:08 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20170122052608.tpr5pihfgafhoynj@gmail.com>
References: <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
 <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
 <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
 <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
 <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
 <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 01:50:57PM -0500, Jeff King wrote:
> On Thu, Dec 01, 2016 at 10:20:50AM -0800, Junio C Hamano wrote:
> > I also still think that any_printf_like_function("%s", "") looks
> > silly.  I know that we've already started moving in that direction
> > and we stopped at a place we do not want to be in, but perhaps it
> > was a mistake to move in that direction in the first place.  I am
> > tempted to say we should do something like the attached, but that
> > may not fly well, as I suspect that -Wno-format-zero-length may be a
> > lot more exotic than the -Wall compiler option.
> 
> Yeah, I think portability concerns are what caused us not to go down
> that road in the first place.
> makes it harder to disable if your compiler doesn't like it.
> 
> > An obvious second
> > best option would be to drop -Wall from the "everybody" CFLAGS and
> > move it to DEVELOPER_CFLAGS instead.
> 
> Yeah, though that doesn't help the example above.
> 
> As ugly as warning("%s", "") is, I think it may be the thing that annoys
> the smallest number of people.
> 
> -Peff

How about using warning(" ") instead?

For difftool.c specifically, the following is a fine solution,
and doesn't require that we change our warning flags just for
this one file.
-- 
David

--- 8< ---
From 28bdc381202ced35399cfdf4899a019b0000c7a0 Mon Sep 17 00:00:00 2001
From: David Aguilar <davvid@gmail.com>
Date: Sat, 21 Jan 2017 21:21:09 -0800
Subject: [PATCH] difftool: avoid zero-length format string

The purpose of the warning("") line is to add an empty line to
improve the readability of the message.

Use warning(" ") instead to avoid zero-length format string
warnings while retaining the desired behavior.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 42ad9e804a..d9f8ada291 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -567,7 +567,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				warning(_("both files modified: '%s' and '%s'."),
 					wtdir.buf, rdir.buf);
 				warning(_("working tree file has been left."));
-				warning("");
+				warning(" ");
 				err = 1;
 			} else if (unlink(wtdir.buf) ||
 				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
-- 
2.11.0.747.g28bdc38120

