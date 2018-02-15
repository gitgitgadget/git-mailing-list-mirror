Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C241F404
	for <e@80x24.org>; Thu, 15 Feb 2018 04:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966475AbeBOE2W (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 23:28:22 -0500
Received: from mail.javad.com ([54.86.164.124]:38522 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754214AbeBOE2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 23:28:21 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6A6A83E89E;
        Thu, 15 Feb 2018 04:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518668900;
        bh=Pr6hH1vEMypvkJOJFJXBKBMbitgA8UNX/UKpwlzjL2U=; l=1067;
        h=Received:From:To:Subject;
        b=rohZnawDZ5XnClrE1Krji0F+PvGOOHg+60zByk6L7sVOKq1Qawkf6PmqZ7pVYk9yg
         0Q/jsSpBZ1RWlOEHJGRewqQm2KJLALhyVWCt7hqD21mtbWsjc+qTozfNxXqqpoT5vE
         1rnHyruqyPUoj5ch48fqYgcgGG/E5r1S4yxvEsXc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518668900;
        bh=Pr6hH1vEMypvkJOJFJXBKBMbitgA8UNX/UKpwlzjL2U=; l=1067;
        h=Received:From:To:Subject;
        b=rohZnawDZ5XnClrE1Krji0F+PvGOOHg+60zByk6L7sVOKq1Qawkf6PmqZ7pVYk9yg
         0Q/jsSpBZ1RWlOEHJGRewqQm2KJLALhyVWCt7hqD21mtbWsjc+qTozfNxXqqpoT5vE
         1rnHyruqyPUoj5ch48fqYgcgGG/E5r1S4yxvEsXc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518668900;
        bh=Pr6hH1vEMypvkJOJFJXBKBMbitgA8UNX/UKpwlzjL2U=; l=1067;
        h=Received:From:To:Subject;
        b=rohZnawDZ5XnClrE1Krji0F+PvGOOHg+60zByk6L7sVOKq1Qawkf6PmqZ7pVYk9yg
         0Q/jsSpBZ1RWlOEHJGRewqQm2KJLALhyVWCt7hqD21mtbWsjc+qTozfNxXqqpoT5vE
         1rnHyruqyPUoj5ch48fqYgcgGG/E5r1S4yxvEsXc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518668900;
        bh=Pr6hH1vEMypvkJOJFJXBKBMbitgA8UNX/UKpwlzjL2U=; l=1067;
        h=Received:From:To:Subject;
        b=rohZnawDZ5XnClrE1Krji0F+PvGOOHg+60zByk6L7sVOKq1Qawkf6PmqZ7pVYk9yg
         0Q/jsSpBZ1RWlOEHJGRewqQm2KJLALhyVWCt7hqD21mtbWsjc+qTozfNxXqqpoT5vE
         1rnHyruqyPUoj5ch48fqYgcgGG/E5r1S4yxvEsXc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1emB9e-0005Ly-FE; Thu, 15 Feb 2018 07:28:18 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874lmmerdu.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802122118420.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87bmgt8k2k.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802150207170.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 15 Feb 2018 07:28:18 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802150207170.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 15 Feb 2018 02:08:02 +0100
        (STD)")
Message-ID: <87eflmzxjx.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 13 Feb 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > The wording is poor either way, but you are also not a native speaker so
>> > we have to rely on, say, Eric to help us out here.
>> 
>> Likely, but why didn't you keep original wording from --preserve-merges?
>> Do you feel it's somehow poor either?
>
> Yes, I felt it is poor, especially when --recreate-merges is present, that
> is indeed why I changed it.

So, how about this (yeah, I noticed the option now got arguments, but
please, tweak this to the new implementation yourself):

--recreate-merges::
	Recreate merge commits instead of flattening the history. Merge
	conflict resolutions or manual amendments to merge commits are
	not preserved. 

-p::
--preserve-merges::
	(deprecated) This option is similar to --recreate-merges. It has
        no proper support for interactive mode and thus is deprecated.
        Use '--recreate-merges' instead.


-- Sergey
