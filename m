Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763B11F404
	for <e@80x24.org>; Mon, 12 Feb 2018 04:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeBLE6J (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 23:58:09 -0500
Received: from mail.javad.com ([54.86.164.124]:57069 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeBLE6I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 23:58:08 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 7E86A3E926;
        Mon, 12 Feb 2018 04:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518411487;
        bh=XPuKNaMSUb+LpmWLhrE+IdaiXF7RbxFdfbFb/aG++0A=; l=428;
        h=Received:From:To:Subject;
        b=KECSuX23GxmzbQCJstQN9giRsnk7N8YznUHl5jAGCk8kQbrcGqRnimzlj6TZAKPID
         xTNsguMcUohvNHXZx+ePjdlk70VSIK/KFB9J7RteIWEqgeLg6eJZHBJMJWFMzzUAE4
         eMBOlB7Bl8ztUkD5/VzCcO3VIszVqhpKFv6FKJnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518411487;
        bh=XPuKNaMSUb+LpmWLhrE+IdaiXF7RbxFdfbFb/aG++0A=; l=428;
        h=Received:From:To:Subject;
        b=KECSuX23GxmzbQCJstQN9giRsnk7N8YznUHl5jAGCk8kQbrcGqRnimzlj6TZAKPID
         xTNsguMcUohvNHXZx+ePjdlk70VSIK/KFB9J7RteIWEqgeLg6eJZHBJMJWFMzzUAE4
         eMBOlB7Bl8ztUkD5/VzCcO3VIszVqhpKFv6FKJnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518411487;
        bh=XPuKNaMSUb+LpmWLhrE+IdaiXF7RbxFdfbFb/aG++0A=; l=428;
        h=Received:From:To:Subject;
        b=KECSuX23GxmzbQCJstQN9giRsnk7N8YznUHl5jAGCk8kQbrcGqRnimzlj6TZAKPID
         xTNsguMcUohvNHXZx+ePjdlk70VSIK/KFB9J7RteIWEqgeLg6eJZHBJMJWFMzzUAE4
         eMBOlB7Bl8ztUkD5/VzCcO3VIszVqhpKFv6FKJnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518411487;
        bh=XPuKNaMSUb+LpmWLhrE+IdaiXF7RbxFdfbFb/aG++0A=; l=428;
        h=Received:From:To:Subject;
        b=KECSuX23GxmzbQCJstQN9giRsnk7N8YznUHl5jAGCk8kQbrcGqRnimzlj6TZAKPID
         xTNsguMcUohvNHXZx+ePjdlk70VSIK/KFB9J7RteIWEqgeLg6eJZHBJMJWFMzzUAE4
         eMBOlB7Bl8ztUkD5/VzCcO3VIszVqhpKFv6FKJnA=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1el6Bp-0008AL-S0; Mon, 12 Feb 2018 07:58:05 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 12 Feb 2018 07:58:05 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Sun, 11 Feb 2018 00:06:28 +0100
        (STD)")
Message-ID: <874lmmerdu.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for explanations, and could you please answer this one:

[...]

>> I also have trouble making sense of "Recreate merge commits instead of
>> flattening the history by replaying merges." Is it "<Recreate merge
>> commits by replaying merges> instead of <flattening the history>" or is it
>> rather "<Recreate merge commits> instead of <flattening the history by
>> replaying merges>?

-- Sergey
