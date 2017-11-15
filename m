Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7C4201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757919AbdKOPI3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 10:08:29 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:41692 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756731AbdKOPI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 10:08:27 -0500
Received: by mail-wm0-f45.google.com with SMTP id b189so3645548wmd.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=oVyU37Rr9gFvhT3mvgaGGWh4hDvs1RiORzWKa3Kk2b0=;
        b=sXc+Lul+YKofk8k0nXTgPVJKORg9I7Cm+qdZroYHi1q0JnaXPsxl5oTfpqoA/6asYU
         3t064iSYeUmGoCLDqN8DuQIhw8XQgTQ84xPCH8yT3oXegMK8SmQtv3IMcMewFxJ3SnTD
         /DWVyQFp9JOcdYhAyin4FZc8sI+p8L7wF8/dt58TUqWL1qtM6dz+D3X6jDfCw3fRePkJ
         bEnhdl+6yz/pb09oHN++HVLd7d/lpMJ81NfXWdNZW6crZ7aFkC3fLJab6fbYicgVt1zO
         NJmVTECpxzRQNprP1VOe0V9zIOziwzfhXAOh7oidJPk9XGp1v3hDKlNbiC9h2L8CETdW
         jHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=oVyU37Rr9gFvhT3mvgaGGWh4hDvs1RiORzWKa3Kk2b0=;
        b=o+9p5iEV0OCazk/ed81abv9KwAxaXovW5abQmHgKO9DxnLaEnbr5U2rG0rspAD0OK1
         iLfsXKneXHyYUQWQ6oweVhUyfR6yy1KmsbULTagKvqapIGGiNJX2vPCqov5q+LIeldKi
         ZwpUZIb9iXjVGo9sQIM8fy5K1/SamNybPbNLiNL1BJLXvHfyegLL6V5Z1/6WXZ1rqaOX
         sZCkc1itbiYUSpyRaBmbf6/yZgfwkOUMv7mzXeZTYZw9aWyyV4thBc5LuUBIKstlGkSd
         I4pRQqRDasjw/JrIJztgXUBmjGUOqFZXgcGTAQp6DN3sDarQ6VmZfYFsfEpL1Yl00Q7z
         NxOA==
X-Gm-Message-State: AJaThX6+Y5SK6R4cUXLsY/2daDrXT1W1vv24mMIJvRUNhRbTEEYeozLV
        o6rmBNJrM7WJ53jXojLnd8FGVk52
X-Google-Smtp-Source: AGs4zMayTRNkkEBHqPV4OpKunEnYpMLYxjU3pTs3tyj/b3S+Wd9d/qUlzMMQC4LTN46O2CgqTyJ2nQ==
X-Received: by 10.28.105.142 with SMTP id z14mr12919346wmh.41.1510758505842;
        Wed, 15 Nov 2017 07:08:25 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i8sm3797315wrb.29.2017.11.15.07.08.24
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 07:08:25 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [RFC] Indicate that Git waits for user input via editor
Message-Id: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
Date:   Wed, 15 Nov 2017 16:08:23 +0100
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git gathers user input via text editor in certain commands (e.g. "git =
commit").
If you configure a text based editor, such as vi, then this works great =
as the=20
editor is opened in your terminal window in the foreground and in focus.

However, if you configure an editor that runs outside your terminal =
window then
you might run into the following problem:=20
Git opens the editor but the editor is the background or on another =
screen and=20
consequently you don't see the editor. You only see the Git command line=20=

interface which appears to hang.

I wonder if would make sense to print "Opening editor for user input..." =
or
something to the screen to make the user aware of the action. Does this =
sound
sensible to you? Am I missing an existing solution to this problem?

Thanks,
Lars=
