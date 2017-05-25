Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2837E209FD
	for <e@80x24.org>; Thu, 25 May 2017 23:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966945AbdEYXbJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 19:31:09 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35115 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966859AbdEYXbI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 19:31:08 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so180518067pfb.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vAvh+LtoSLo3rq3MRYh7RV5CANVabjdoetfwTWng56Y=;
        b=rwj6zjAm/etc3o/HdEbDBjxRMEw/OHokiZCRBGPoFXVKfJmu79G/WGIcmykgqxH5oo
         XigHYc2VBegzLT8E97BBuf+Iv4jH5OxTEAWdltMdvU3FSWAl5V1rY9J8JcVUT7HWZO/q
         zTEjM92myNU6qXuUnGYtN4UHehXNBPHmi0qg90u1HoSeerAnJo7FKhcsK874jqiAhAqD
         j276w0Zwhp8KoV6GPLJCwn5QJKoeegNCEKr9aP6fvQg9fG6AKDOHhjuinZLDEGQMWLyI
         RNwe1ajFzMAKuZjUIwKIsTqQ9FgYbON7d3Xsn2Y+1J7bxFzIec7LnDfU2caruLCW6zQh
         QXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vAvh+LtoSLo3rq3MRYh7RV5CANVabjdoetfwTWng56Y=;
        b=hlTn7YEaivcZmQKY2b3B5I5cfAngtr/7H0bIq1klsaFErbpOuW/cji76mVHmq+PYrR
         VS6NLh3jANmk5ZCExql+gQynHvWcY7R1MJ5wgtODNcOgGa4Z6Tn/W5rVFwEXUEmOwaPJ
         uiVB1AGqFcOE2gzD/aiwoSJ2j8+vC14VSSgDHut5T8FPSiLyE2eD4OzGUL4jpZ9/Tc5q
         koxbgP0sSJf5t96mdQxGNgzUYVEsPl2dkzNGoJpKzTsuD7R54M8Gz7l5P/76cLnLqA1F
         BCSLNSMz1NRsanFokj5722rZ4a9vCDKSXZUONcDtncawKOmokX3aqNjPL4bXgKi84Ap1
         8RQQ==
X-Gm-Message-State: AODbwcDb5vVD3jPeUUYQzqbK7P3M7QADv1ovqfJ8gH4gMFHOS+zL1KgH
        bnQJPgKXEc0cyQ==
X-Received: by 10.84.215.155 with SMTP id l27mr52957089pli.31.1495755067511;
        Thu, 25 May 2017 16:31:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id n71sm15409196pfg.46.2017.05.25.16.31.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 16:31:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-1-avarab@gmail.com>
        <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4d4-EGiUtJQT8cvuMzm0c5DUu5sxUb11kUnJu3ocuSHw@mail.gmail.com>
        <xmqqo9ujk9ii.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5Aa9cQngCgMVP2kb8Jnk_V7coK-f5J6jMOhn=AWCrXzQ@mail.gmail.com>
Date:   Fri, 26 May 2017 08:31:06 +0900
In-Reply-To: <CACBZZX5Aa9cQngCgMVP2kb8Jnk_V7coK-f5J6jMOhn=AWCrXzQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 25 May
 2017 12:44:34
        +0200")
Message-ID: <xmqqtw48cy4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But from what you're saying here that seems like a non-issue, i.e. in
> such a scenario we'd just mirror the original repo[1], change the URL
> in git.git to that, and then anyone could easily use older history
> since it would be pointing to the new mirror.

Those who cloned before such a switch will still have the URL they
chose when they cloned and did "submodule init" on it, I think, so
they need to explicitly choose to switch to the new URL.  So I would
not exactly say "seems like a non-issue"; it certainly is an easy
thing to work around.
