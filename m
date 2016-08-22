Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8831F859
	for <e@80x24.org>; Mon, 22 Aug 2016 18:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755599AbcHVSnP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 14:43:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34965 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbcHVSnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 14:43:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so14740200wmg.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HxQoZLhjJZuaJZRrmpCB/p+zp/Xl3gDcgh/TI8k12xg=;
        b=ckCFnldGoCYclCDAzuYRactnJcO05pOXSDc/zt9PBlTg6bCVviMMEqLVa9U2eoKBNu
         bHNvyItl3MOyKz+FeRPMK6tVauzhNaTVaWaRTwY73FIlADhnWPYBO8H3kwRVAxQn3iSa
         KcgPR20HS7gSC/yX/liUf3w/wppMDeyJkclMHJIqPCTuojGOOG+zOGkNkdB5uWswgeml
         TilaAltiZVA0+/EEJ/RS6jvqigwqUIa9tQpq9gonOoKQeUcUvIFNmmBlsppBKY0kx8T6
         PyoXaLc8G3Mr3A4NC7SQa3qcvXhlPFoJ4qct/BL+shPNwmuiwIa0alU5lvTyMM2ARLqc
         ylwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=HxQoZLhjJZuaJZRrmpCB/p+zp/Xl3gDcgh/TI8k12xg=;
        b=AQdUWe8bzQJWuNepL+wVxamvDPsFo3vGiPF2wdWvE2PmBg7Ek9NcRhCGQ4/uUY+UG9
         rBYL0EisJpKLEdn/YQpDAa7BspLiWykNzcHGfjdMpfOyEEz7Q1AUZps/S2sRaMKthGvD
         pzsenuhc4VlI8xRWPZvtreZwpWyxfiHqMPOY6abQzzrg3ScQdXy/7fImaPI5P6eEbRL5
         WtZZxVSM4kD3JIR+tEjf8vVsOvfLTwkNrR9PYfKptLTIKGOc/qWQqnAfOCaS0TEGDyXE
         cOwaS5dFxUSGicw+o23lbp8KtS4ieVM7fbpXfzklEeiOFluhNXoH1g7uK6AYN6CljFWx
         5jkg==
X-Gm-Message-State: AEkoouvJF6ImaSZS16dKeVHd8MdeM5wrtQg5lqaR0qBiksX4xP0mwVHVnb80krkZ7FWL7bDHnvH1Ym66gK3SZA==
X-Received: by 10.194.172.165 with SMTP id bd5mr18093807wjc.33.1471891392529;
 Mon, 22 Aug 2016 11:43:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.165.199 with HTTP; Mon, 22 Aug 2016 11:42:52 -0700 (PDT)
From:   David Glasser <glasser@davidglasser.net>
Date:   Mon, 22 Aug 2016 11:42:52 -0700
X-Google-Sender-Auth: -aJ2fE4slL3COh8kYhD3h8-zAXE
Message-ID: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
Subject: git-config(1) should mention `git -c`
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to describing the `git config` command, git-config(1) also
appears to be where the algorithm for determining the active
configuration values is documented, in the FILES and ENVIRONMENT
sections.  (There is minimal documentation of these files and
environment variables in git(1).)

However, `git -c name=3Dvalue` is not documented in this manpage. So to
understand the full set of ways to affect the configuration of a git
command, you need to know to read both git(1) and git-config(1).

I'd like to add a reference to `git -c` to git-config(1). I would
happily send a patch but I'm not sure of the best place to put it =E2=80=94
maybe in the FILES section?

--dave

--=20
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
