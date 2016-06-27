Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1E51FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 06:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbcF0GCl (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 02:02:41 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38279 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcF0GCk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 02:02:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id r201so98761463wme.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 23:02:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=M0DjtBM/BiD/EpklckP3YpLh+M4mRhcNGgUrzrJuZ80=;
        b=kM1vTtMVmnNzOAwIiGitPZd0ZD6dHKtP4UltowcUvYkNzws0h0Hjz6/drH09vYcAeV
         M2PoNmZWV79EH2mf3qmb155H2ZxTvoDD3MTfwv4NF/twfNPh2i+Bd2PerU7tIjyESHqA
         ZB5uk2hm7CPNSm6Z1aE5BgDO31my3LkmKrXhiHzfvoVGxA8CAl5B3x18RHCRdsAX658j
         XeA7G/Lc0MXOkjbsN+Xm941QG5o+zQHaH4Esfx+Dg8SliZl8x9AcMW9rhYwGHPy4shDr
         us+sEk+Zqtflv1jr/PLJ/m6e15IK4L5rYit1XSvElbqQWR9hJS9cwyHX0i1zJJ4f7XLf
         AaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M0DjtBM/BiD/EpklckP3YpLh+M4mRhcNGgUrzrJuZ80=;
        b=eB98PzzQ2MDXHA2dEiTW1i6Kx7jaXMOSKalp7WnH/3u/2PqTjlv9fZvWVVSQ+g0oOv
         SL5sgacbQx/m+El2TjkEKvHJzU72I9fomateeX6cBvam916Gxfd+wAsCYmOquNmreou7
         dml+t0aQECSBZJ9aBwBxmmpokMp9LR4SxY7a8PH2M9F8YJezpG0jF73+vfYYDP8OOEJR
         cLaJW75KQwvrlBQsZxYZiFGEldBdfckB0SqRHW4BHExXWEJGFgFQ7mVHetpzZL7okWc4
         XAraCe8iHcjdvXDEXTr/5mrimKU+GPZagm1fllLpJjsuyjN8ymAnehreB/L7n7w8LH1W
         kIZQ==
X-Gm-Message-State: ALyK8tKlyCRY7+Q9r4D2Vx/xZC/HE917er5DNoy9n9kz6elmEiBGarDTLuEWSHKJHOBArs6okvRuHIPGh/uEiw==
X-Received: by 10.28.234.16 with SMTP id i16mr9163733wmh.36.1467007359045;
 Sun, 26 Jun 2016 23:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.107.170 with HTTP; Sun, 26 Jun 2016 23:01:59 -0700 (PDT)
From:	Bart Bogaerts <bartbogaerts@gmail.com>
Date:	Mon, 27 Jun 2016 09:01:59 +0300
Message-ID: <CAOG-3GJdH5q9fdj+7zdEv-UUZMTAnunZu1PRJYjFNV360r6+sQ@mail.gmail.com>
Subject: Git mv -- submodule -- recursive
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

With a repo structured as follows

main-files
|- submod
    |- subsubmodule

git mv submod newlocation

does not do what it is supposed to do. It actually breaks the git repository.
It can be fixed easily.
A complete description of the bug, including a workaround, can be found on
http://stackoverflow.com/q/32782382/2274140

-- 
Bart Bogaerts
