Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B3020954
	for <e@80x24.org>; Fri,  1 Dec 2017 23:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdLAXkS (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 18:40:18 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:46149 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdLAXkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 18:40:17 -0500
Received: by mail-it0-f68.google.com with SMTP id t1so4288679ite.5
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZvQQMtirPl6oF8bF6acTm+CmUB8aZXjMriC7V1lXf4=;
        b=DOMhAltjGmlxJXQAf+CZIIrl1B31sxVIAEBkgKxcdV0omRVL6Y7x6tYeBbDN2Yk4g0
         rycXX3iQHTFPIaM9wUq9cRPg7fIWYNdm5fpNWmWZV6dPy07OMGNRLznO9duVt7J4jfgJ
         vEP4+F+cXEkg4sFpPlkR2mU9AWRreUVP/PTIPdPIthDgvz1GtmYBJToJtH5K2Rj/2TiV
         ZsEh0EwkmMRNIAb0tOkiqV36DC++aGv2H83ZgnJkC7v+4vCDSRXdxNc6OBTSzeorAWeL
         3IIy7YWq+uTd26JdUmiQ6+cOUB6y/zltl6mcEJ3dOrW+znXwr20hCGTIXubdGlgffvM0
         iMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZvQQMtirPl6oF8bF6acTm+CmUB8aZXjMriC7V1lXf4=;
        b=MP9+sBaMLkqSTTk4wlTWRhlLSntFcOhD86pw/nIE8KM01kR5G6nZGFzsIZ9/aiz2bh
         SDFKxPfX7jjDW5mVF2Xyq6LDORVTIMIZXY/yPIah/+G4+fElu7qOgfFqBkQaWQFJBOv5
         f8kyhJm8D40RP2yLj4DB2mep7MuQSGtCdmoUxzwKpXCChreJ8sgwpf0ux2mLeMA8GEsD
         5Ghd/BTCs2GlcGTFaF0etiGZVtV7e9biG6Xl4ai2zxedIqaK3FxJLKDewVnSmY81tFpr
         zstowhfuoEYiTeogtMeG0ETBhPUtecoB4S0ylYIEBrZoHRS8U0DXOZsIsrPkZyJ/om9X
         X/6Q==
X-Gm-Message-State: AKGB3mLOECeliNOIqATp3oC8TE3+OJOt9zOZQ5xRICI/t0Est6US0UJD
        /oREKtpcHkjE0a6ps5cWuM0=
X-Google-Smtp-Source: AGs4zMaPQBkMtJ+PpcEnU6zuNcgGocdjDtHU1goV9+im8lQISh2QW/gUglrGnXx8AN7Gm8cfbl+fPw==
X-Received: by 10.36.93.6 with SMTP id w6mr4312940ita.47.1512171616260;
        Fri, 01 Dec 2017 15:40:16 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j21sm3782576ioe.25.2017.12.01.15.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2017 15:40:15 -0800 (PST)
Date:   Fri, 1 Dec 2017 15:40:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Timon <timon37@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: allow Ctrl+T to toggle multiple paths (Re: [BUG]
 git gui can't commit multiple files)
Message-ID: <20171201234013.GD18220@aiede.mtv.corp.google.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
 <20161204204057.32dnkjx6ixv3swez@gmail.com>
 <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
 <CANtxn9KjTToqXKeO1mM8c6kD+jLf8QcAVXF46tX61uQB7YdKYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANtxn9KjTToqXKeO1mM8c6kD+jLf8QcAVXF46tX61uQB7YdKYA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: git-gui: allow Ctrl+T to toggle multiple paths

In the Unstaged Changes panel, selecting multiple lines (using
shift+click) and pressing ctrl+t to stage them causes one file to be
staged instead of all of the selected files.  The same also happens
when unstaging files.

This regression appears to have been introduced by gitgui-0.21.0~7^2~1
(Allow keyboard control to work in the staging widgets, 2016-10-01).

Also reported by zosrothko as a Git-for-Windows issue:
https://github.com/git-for-windows/git/issues/1012

[jn: fleshed out commit message]

Reported-by: Timon <timon37@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrn@google.com>
---
Hi Timon,

Timon wrote:
>>> On Sun, Dec 04, 2016 at 05:36:46PM +0100, Timon wrote:

>>>> This is a regression in git 2.11.0 (version 2.10.2 is fine).
>>>>
>>>> In git-gui I select multiple files in the Unstaged Changes (using
>>>> shift+click) and press ctrl+t to stage them. Then only one files gets
>>>> staged instead of all of the selected files.
>>>> The same happens when unstaging files.
[...]
> Originally I had this problem in gentoo and assumed in the end it's
> likely due to my specific configuration.
> However recently I switched to nixos and am still experiencing it.
>
> I've search again if I can find anything and lo and behold, it's
> already fixed in the *windows* version of git-gui...
>
> issue thread: https://github.com/git-for-windows/git/issues/1012
> commit: https://github.com/git-for-windows/git/commit/1c4d4e7cbcf404c168df5537d55e9afd57f2b01b
>
> I applied it locally to git-2.15.0 and can confirm it fixed the problem for me.
> If you need any more info/help from me, or would like me to test
> anything, feel free to ask.

Thanks for this pointer.  I'm including the patch here so the project
can consider applying it (it doesn't appear to have been sent upstream
before).  I have not tested it or verified the claim it makes about
what change introduced this regression --- if you're able to help with
that, that would be welcome.

Thanks,
Jonathan

 git-gui.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index ed24aa9..ef98fc2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2501,6 +2501,19 @@ proc toggle_or_diff {mode w args} {
 		set pos [split [$w index @$x,$y] .]
 		foreach {lno col} $pos break
 	} else {
+		if {$mode eq "toggle"} {
+			if {$w eq $ui_workdir} {
+				do_add_selection
+				set last_clicked {}
+				return
+			}
+			if {$w eq $ui_index} {
+				do_unstage_selection
+				set last_clicked {}
+				return
+			}
+		}
+
 		if {$last_clicked ne {}} {
 			set lno [lindex $last_clicked 1]
 		} else {
-- 
2.15.0.531.g2ccb3012c9

