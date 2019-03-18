Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CE520248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfCRCe0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:34:26 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37359 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfCRCe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:34:26 -0400
Received: by mail-wr1-f52.google.com with SMTP id y15so15283816wro.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wkNFtRdDNpFkiiydRfLE8hiXpf7M/8CiisocGV+3w7k=;
        b=XbDwfQU5CwvQ9b3+vWJlenRVDqL6KVfKy76+TR8dLMj72ohN2ZS5IfiRNzeZi6DJ5X
         cqqd9Q2fgBbNLefD2DK0UljBCkCmpvvd5xZuFO645MUYIXMAKMh0dpxWu2RajrTQOqXN
         4VlufqU3Ba7DDkx8Pzl4TN8aa2HUovziSX9rPim7oPKlVjqNSVqnje48rM4L7D91wJxG
         4SRcFOK0hUnjXGmzmiLh4PhRnTtfiMe+Q5UnfPGgCgWZTypULfjdf28ZjgWKT06u2DpL
         Gv0Q4WoP5oNQ+5PNmQGcq5qeFvcLC2AaKcVkoTVuXFM1DTkfb6//35B2hNkaRT8lIomS
         awqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wkNFtRdDNpFkiiydRfLE8hiXpf7M/8CiisocGV+3w7k=;
        b=dEngeehp0jyRL5IRzAQAC+KBTvyGj9QWyAtCuRGXLm7218ZUTp+GbL9GXyK5Zg/Pxm
         kndcyU21MV66y0EHwzzMSFyT3ZI1EuG6//WZwLXdqBr+Q5hkvWxuxxW99J26ACOKuAwO
         hs3R6HBuVcJvOa3E2MdPJoxGPHbTu4B2jtJLDqk6D2GuvRiP4R8Y8e1TQbuLXxHPcC6+
         BJlh2BY8wEMsILlTIKUfv4+CL1wbgPlfZs/pc9OOZogo07CnubMvoSUSSKU37Jwqy/pO
         /lL7HexaYUZqj5911lasRZPwDzfwUrYbB0IRNvc/a6V7kcgmGeZDBTjaI/oiZ36y2wah
         OZMA==
X-Gm-Message-State: APjAAAWFiN+XG6v74D20sl84EgV2AKVbr0rezfe1Ib7bIou2bf8p4Whj
        Ze96Gx1OoTPJ8Jjv3GwKyok=
X-Google-Smtp-Source: APXvYqze0z2QzRY4rxqkNSasJ3+FJ2O1f/ph4vO1ns6P4btqfyA7ewS6ijRZa5Z5UjI44vk4WEy43Q==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr3730593wrm.302.1552876464150;
        Sun, 17 Mar 2019 19:34:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d15sm19473733wrw.36.2019.03.17.19.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:34:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakobus =?utf-8?Q?Sch=C3=BCrz?= <wertstoffe@nurfuerspam.de>
Cc:     git@vger.kernel.org
Subject: Re: ls-remote set timeout
References: <0MUoma-1haJEB1Ckm-00Y6Wl@mail.gmx.com>
        <0Mey7N-1hOXHn3kBF-00OYB8@mail.gmx.com>
Date:   Mon, 18 Mar 2019 11:34:22 +0900
In-Reply-To: <0Mey7N-1hOXHn3kBF-00OYB8@mail.gmx.com> ("Jakobus =?utf-8?Q?S?=
 =?utf-8?Q?ch=C3=BCrz=22's?=
        message of "Thu, 14 Mar 2019 10:38:01 +0100")
Message-ID: <xmqqbm287vwx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakobus Schürz <wertstoffe@nurfuerspam.de> writes:

> Does anyone has an idea?

Lack of response generally indicate that people are not interested
but the reason why they are not varies.  It may be because you did
not give them sufficient information about your situation (are you
trying to do this on Windows, for example?).  It may be because you
are looking for a solution that applies only to a narrow situation
that they are not interested in, but by stepping back a bit and by
coming up with a solution that may apply to more general problem may
pique their interest.

Instead of patching "git" to tell it what the connection timeout is,
perhaps a more general command that runs anything and aborts it if
it does not finish within given time period, e.g.

	timeout 180 git ls-remote <REMOTE>

may run "git ls-remote <REMOTE>" but kill it if it does not finish
within 180 seconds.

If you wrote such a general purpose command, that would help you
running ls-remote and abort it if it does not finish within the
given timeout, and also help others who are not using Git but with a
similar need to run other things and kill them when they run for too
long.

Who knows.  If you look for such a command, you might find that one
already exists.  http://lmgtfy.com/?q=run+linux+command+with+timeout
