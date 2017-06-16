Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620E720282
	for <e@80x24.org>; Fri, 16 Jun 2017 10:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbdFPKhL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 06:37:11 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36670 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdFPKhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 06:37:10 -0400
Received: by mail-io0-f194.google.com with SMTP id i93so4382036iod.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=pLYMsfuq/V+3KCvIjg9McB13cwIsOlTDLobXZ0ZYgYI=;
        b=dFo00VYvXrbHt3iyUtab8TBiIXR1Cma3X5gE5c/zvrMqUflw7oNKAY9NX1OeZbTuMv
         LAbx+8W8WmIo0lEuvJKwN5n3ZDCBwbzrOzNnh8SJuJC37hqvUzOGk6rksBaC4KUFfgn4
         1ClY0+AU6eM+OtDISrnEiiAQaryqgIBBJ4HkJQXQ4wwIlezIvzJ0DE72+B2tnoc0TFmT
         SawLZbAewy2WN3kMHZ9sKEIm83blwxURDWlAQhcPUqumgspQ27LUnh9nrOg9zXxMPEuU
         pEef+sD8kVraDUAuWmTwgyN+qqnJbHQSJiGiS0sddEz4OM4EKJdY1XtDKQ9E0k0DxGdD
         aqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=pLYMsfuq/V+3KCvIjg9McB13cwIsOlTDLobXZ0ZYgYI=;
        b=FLotb5MgzhwreRVgWkdTX9riv74OT9mfvRjARUmhzrHXdSj1mt8+P/YM8twelljCG4
         Q+piMCNd91uZu6sQAAdBmq9RWmiU17POhYbwL0YazlO50J2nCSWqUbHYSBx/0MGhxuH9
         GXsVWrn3VPj0wtZiX7Vu9yRh1B4Rl+wldkmnjW26Eoix/BLK+p5iM2ekbDdsX6H6lcH4
         AzwvWeNfeUJoGvEz/GAg4KZ7EcSD2KRI35uO0NP1/4PsWH/sVhh/VLn6hMO8tttocKYE
         2Rs13RfgKPbJdz138mUXyXYoR/AYLf2zC9WzkIERBUUtb07ZuHwBZJWCOGPF3FMZUKeW
         nGjg==
X-Gm-Message-State: AKS2vOycCyBKlOSax5BtFKjf4WKcrhXHcw7+VH2lNXmke8WWgUmqK+Dz
        /yuusSNtMpPlSw==
X-Received: by 10.107.55.139 with SMTP id e133mr9250254ioa.132.1497609429444;
        Fri, 16 Jun 2017 03:37:09 -0700 (PDT)
Received: from unique-pc ([2405:205:830e:bcfe:785a:a2ed:d859:2073])
        by smtp.googlemail.com with ESMTPSA id z64sm922317ita.25.2017.06.16.03.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Jun 2017 03:37:09 -0700 (PDT)
Message-ID: <1497609408.2517.4.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, Samuel Lijin <sxlijin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Fri, 16 Jun 2017 16:06:48 +0530
In-Reply-To: <20170615131245.zh5nuipmaadcfpdx@sigill.intra.peff.net>
References: <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
         <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
         <1497255003.1718.1.camel@gmail.com>
         <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
         <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
         <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
         <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
         <1497514760.2394.6.camel@gmail.com>
         <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
         <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
         <20170615131245.zh5nuipmaadcfpdx@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 2017-06-15 at 09:12 -0400, Jeff King wrote:
> On Thu, Jun 15, 2017 at 07:43:17AM -0400, Samuel Lijin wrote:
> 
> > > Saying just "staged changes" is definitely accurate. I don't know
> > > if
> > > some users would find that too terse, too. The phrase "not staged
> > > for
> > > commit" gives more information if you don't know what "staged"
> > > means in
> > > the Git world.
> 
> Oops, I meant to say "too terse, though". But it sounds like you got
> my
> meaning.
> 
From what I could get from this thread, I guess the current patch
stands something like the one below. I tried building it with the below
change, it seems to be having a little issue. I'm not sure why, it
seems to be working the other way round i.e., the message "No commits
yet on the branch" message is shown in the commit template and the
message "Initial commit" is shown when `git status` is invoked.

Also, let me know if any other change is required.

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..3ed8e40bc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1364,6 +1364,7 @@ int cmd_status(int argc, const char **argv, const
char *prefix)
                usage_with_options(builtin_status_usage,
builtin_status_options);
 
        status_init_config(&s, git_status_config);
+       s.commit_template = 1;
        argc = parse_options(argc, argv, prefix,
                             builtin_status_options,
                             builtin_status_usage, 0);
diff --git a/wt-status.c b/wt-status.c
index 037548496..34aa1af66 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,10 @@ static void wt_longstatus_print(struct wt_status
*s)
 
        if (s->is_initial) {
                status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
-               status_printf_ln(s, color(WT_STATUS_HEADER, s),
_("Initial commit"));
+               status_printf_ln(s, color(WT_STATUS_HEADER, s),
+                                s->commit_template
+                                ? _("Initial commit")
+                                : _("No commits yet on the branch"));
                status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s",
"");
        }
 
diff --git a/wt-status.h b/wt-status.h
index 6018c627b..782b2997f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
        char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
        unsigned colopts;
        int null_termination;
+       int commit_template;
        int show_branch;
        int hints;
