Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950261F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbfAOTgR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:36:17 -0500
Received: from mx-out2.startmail.com ([145.131.90.155]:39824 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbfAOTgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:36:17 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 14:36:16 EST
From:   Michal Nowak <mnowak@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1547580542;
        bh=2QgaThjVrrhsQIw8eMVxth1mnLEf5j/z0eCecD9xtmU=;
        h=From:Subject:To:Date:From;
        b=sYbPPy6VZl7U0SWc81PR1ittV9dxIxuXvfGOJnBvoNhWe6xxcwv7C3N5uXE4fVjFy
         wpQkGJMRBOvknTudHbPbvEBNeD3X3Ym4dV2qVbbWET9J1icCSXJPIB2OaxQG/XiX11
         vK4DsOXWChwnTgH4a40QBBBp6gIAmm4eImC+4gEtv+gtdULlnFvcCeb/f0eZDTIvF4
         q5TDDwFJilbNokA7shbWMlC/wvl2CIuAKQZYxJDxglOy0UdWrlXfzFOI/50gDaB4Xd
         yuaTeQ+Sx1bL8IqlZYALFVeQ2ZRbuc7/o6GGfPE04qbPlDJDhjUrqfOXsMf98QJjt2
         NRZ/qjG4fAtqw==
Subject: Broken interactive rebase text after some UTF-8 characters
To:     git@vger.kernel.org
Message-ID: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
Date:   Tue, 15 Jan 2019 20:29:01 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

on OpenIndiana 2018.10 (illumos kernel) line of the interactive rebase 
text after a particular name (Gergő Mihály Doma) is broken:

pick 1ea94c756c 10202 loader: use screen-#rows to find bottom left 
co-ordinates Reviewed by: Toomas Soome <tsoome@me.com> Reviewed by: 
Gergő Mihály Doma <domag02@gmail.com> Approved by: Robert Mustacchi 
<rm@joyent.com>
p
pick cadd68ea00 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
<omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: Robert 
Mustacchi <rm@joyent.com>


Source: https://github.com/illumos/illumos-gate.git

See the second item which only has "p".

This is with LC_ALL=en_US.UTF-8 (same with cs_CZ.UTF-8), with LC_ALL=C 
the text is fine.

I checked various editors (vim, nano, cat), they are all the same.

`git log` (PAGER is set to `/usr/bin/less -ins`) shows the particular 
commit correctly.

I tested following git version: 2.16.5, 2.19.2, 2.20.1, git.next branch.

Here's the configure output: 
https://paste.ec/paste/oDdydNxZ#r3avan8BL+8lldFMo928cw3eXSServTsSkGPW4jRBOd

Michal
