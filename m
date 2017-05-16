Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47881201A7
	for <e@80x24.org>; Tue, 16 May 2017 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdEPGPa (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 02:15:30 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34448 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdEPGP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 02:15:28 -0400
Received: by mail-io0-f194.google.com with SMTP id 12so13567811iol.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 23:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5PyK9GbdUXttoPGkbSHBjYOzTEJvjmDwYQRsZRt054s=;
        b=sE8//6S1ztzg/9z+luSzZDOrGUhVNhf/R1/wPQ67/bV0MU7cUa3D+AEdHkBF9sSiUo
         VwNhUmixQpjS4pyxskhFLcPFPMzXAXoPbMwJ1ptTeTaC5ybMUsTRRBGDoKj725fYQXok
         BvRa3nWpkp32mwDTz764BrtCNJT83nlg7Qd05NKODsrX7fKzDW82i402azaFCTvp2Nwa
         vUBpagKPLZgARCentiAVdP5O+KQ85RCVM0vjKyHYPB8JOqajA4rnIgE0lvy4dmOtG2BE
         6mVtCGygeibKF84WkbvwnidtbIdK0skvrHw95OAqv7Vnhu4jsQa1flt1ZOSGe0bgyd0g
         ub3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5PyK9GbdUXttoPGkbSHBjYOzTEJvjmDwYQRsZRt054s=;
        b=ScgUL6/rCveGYQKQDKAQiCbTy/WREkuH0UIw/urqfFdR8f1ACwVe7kWAEpgEP3ydmn
         Zyw6/cJrEJDRMOLIw7yrm+EJFPLFa0koqEztfBOnvkJfGH87EZZyZUXhD+ciVIMJdV/6
         mfOR+Wp6OD3Y7FeVqOFwxz2P2GT7bNztr1Kwzc+NRgW40velsAnoTHqtRiUA99FAnxFv
         xEHdpp6L7UMcqsYJ0IAMGFoRTvFNTbqOHENYxz6aqT8GeMnerTSvxVl9IZ02pCYspZNE
         s3VlE4IzJzgx7fVWR0RoP6IK22WEvmOZ/XKa36RBa0WdKnUxc2pqOrRz9C3AXT9tilke
         innw==
X-Gm-Message-State: AODbwcDt2dJ5yPC/LqnuTPzPh+SjatUc7ecJSqkNXB9iYKi9XDxnB7gb
        Vx/X7v0bCjjhr7Ps/p2Aw43pZea3pw==
X-Received: by 10.107.201.131 with SMTP id z125mr8539381iof.160.1494915327477;
 Mon, 15 May 2017 23:15:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 23:15:06 -0700 (PDT)
In-Reply-To: <xmqq37c56334.fsf@gitster.mtv.corp.google.com>
References: <92c10618c688bb8cb1f31ee2a93110c581974468.1494586245.git.johannes.schindelin@gmx.de>
 <CACBZZX7MXh_9mG1EROZVEEGapBwjzRWzr3S57f6rWLnQe9L+XA@mail.gmail.com>
 <xmqqbmquyiae.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705151418000.146734@virtualbox>
 <xmqq37c56334.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 08:15:06 +0200
Message-ID: <CACBZZX4GZnpVzhL-bDSxmsH_JWZjxOPzpEYyZC=d+wLPLs6Kpg@mail.gmail.com>
Subject: Re: [PATCH] fixup! log: add exhaustive tests for pattern style
 options & config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 2:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 15 May 2017, Junio C Hamano wrote:
>>
>>> My knee-jerk reaction matched Dscho's, but grep is about contents,
>>> and we should be able to test this if we used a sensible tagnames or
>>> didn't use any.  Glad to see somebody can step back and think ;-)
>>
>> Maybe somebody should step back even further and think even more, as we
>> could adjust test_commit to mangle the argument into a tag name that is
>> legal even with a refs backend relying on NTFS.
>
> Perhaps, but I am not sure if that is needed.
>
> The point of the helper is to serve as a simple "we are building a
> toy sample history by only adding a one-liner new file" convenience
> helper, and I think it is sensible to keep its definition simple.
> The callers (like the ones being added in the rerolled patch under
> discussion) with special needs can supply tagname when the default
> one is not suitable.
>
> In hindsight, perhaps it would have been better if the default for
> the helper were _not_ to create any tag (and callers who care about
> tags can optionally tell it to add tag, or tag the resulting commit
> themselves), but that is lamenting water under the bridge.

This works, but I wonder if it's worth it to solve this one-off issue:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5ee124332a..4cab67c410 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -195,7 +195,15 @@ test_commit () {
                test_tick
        fi &&
        git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
-       git ${indir:+ -C "$indir"} tag "${4:-$1}"
+       if test -n "$4"
+       then
+               git ${indir:+ -C "$indir"} tag "$4"
+       elif test -n "$(echo $1 | tr -d A-Za-z0-9/~_.#-)"
+       then
+               error "Implicitly created tag '$1' looks unusual,
probably fails outside *nix"
+       else
+               git ${indir:+ -C "$indir"} tag "$1"
+       fi
 }

 # Call test_merge with the arguments "<message> <commit>", where <commit>
