Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12918207FF
	for <e@80x24.org>; Thu,  4 May 2017 16:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbdEDQWz (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 12:22:55 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36123 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbdEDQVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 12:21:24 -0400
Received: by mail-wr0-f173.google.com with SMTP id l50so10719112wrc.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sternerstuffdesign-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1pVD+W9iuNyr9vHaWI5uiEZUpMvgE79Ue8f4N0h3xLs=;
        b=suhJv21zJDCo+qK//dN7ezZVOaqev0bphgYRb2pTD1RjDTJEqmr65vDQ3PTH17z2C1
         SbNwXM1y7ygm0UOArnZ18ZWj5VSbCqXB5M80JxZxwdpzv+UzJDDPC2Bi4eUCai+GwvCV
         fLZb4d3mQtKJ7jZwaMXVeLWhco95D571OdV9/mj/z9k7npo9vOfBwlnKVP7IH2tQwGDd
         gpUR/f2+tap4THBKvGbl1vvqFZvWInTibBFhaj1Q/QKITovPx8SpqZ9nqb5oZQ9n6hD0
         f4nYpCifMIPUvUoOraTQeXJULAAdJobPjgSlK/FK1iEPpqm9AAPRWPasrGya+516sNLd
         6ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1pVD+W9iuNyr9vHaWI5uiEZUpMvgE79Ue8f4N0h3xLs=;
        b=eNENtwgEwbW/jDuHrIYkgsDpt3JTYEdVA5g+FXq+9uXupxbaCcwKr8ZIqbXy0b295u
         B8fswSsSNAV4WOKaJrF/DbE61JgmXK4WBEUalC1FijvsWX0+IBRvb2m/EjlXm+NBVarl
         PY4jc4OHBNOLGBaf/tuWaSU2WPhxMuO/fEFJHMino86EFL5S1n/2/IVj/Xt6/xlNKxV5
         I88nlmufPlOeRDuYI3X/rNF+ja9/OrA+kG8agPT/a2NbkMYu1v5AqtQLQ9aXc8tNj7n/
         xGzufLWY4pBzDjEO/V6F2/AeTn4fSVLv4mLQk+iQFx6Fp300DhbjkBGcRs7YvZ/imj5U
         vtVA==
X-Gm-Message-State: AN3rC/4eHQKRDmhn2at4KUvikalxwSOI58p5LiqEytFTHK0NfauiimJF
        4lIcHnKB/dc525/9DxbPotEr0frMf9eY
X-Received: by 10.223.177.215 with SMTP id r23mr32123909wra.97.1493914882446;
 Thu, 04 May 2017 09:21:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.90.68 with HTTP; Thu, 4 May 2017 09:21:21 -0700 (PDT)
From:   Ethan Clevenger <ethan@sternerstuffdesign.com>
Date:   Thu, 4 May 2017 09:21:21 -0700
Message-ID: <CAOY55trVg7CYqzp7vTxaeVnqvM7YKnys-+88DnDRc4nbmBEBAg@mail.gmail.com>
Subject: Bug? git svn tag Authentication failed
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git version: 2.12.2.windows.2

`git svn tag 1.0` results in:

> Copying https://plugins.svn.wordpress.org/gf-payment-continue/trunk at r1651123 to https://plugins.svn.wordpress.org/gf-payment-continue/tags/1.0...
> Authentication failed: No more credentials or we tried too many times.
> Authentication failed at C:\Program Files\Git\mingw64/libexec/git-core\git-svn line 1200.


In my .subversion directory I do have cached credentials under
auth/svn.simple. A vanilla svn CLI commit also works:

>  svn ci -m 'do creds work?'
> Adding         trunk\.bar
> Transmitting file data .done
> Committing transaction...
> Committed revision 1651133.


Unsure if this is actually a bug or my oversight.

Cheers,
Ethan
Sterner Stuff Design
https://sternerstuffdesign.com
