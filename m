Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE8D1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJBPY1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:24:27 -0400
Received: from gate3.osm-gmbh.de ([194.77.68.107]:39400 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJBPY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:24:27 -0400
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id 8FA4F3C0D4;
        Wed,  2 Oct 2019 17:24:25 +0200 (CEST)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id 95B333DC01E;
        Wed,  2 Oct 2019 17:24:25 +0200 (CEST)
Date:   Wed, 2 Oct 2019 17:24:22 +0200 (CEST)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: missing tags from "git fetch"
In-Reply-To: <20191002135518.GA3599@sigill.intra.peff.net>
Message-ID: <alpine.LSU.2.20.1910021707570.32588@cpza.bfz-tzou.qr>
References: <alpine.LSU.2.20.1910021431130.32588@cpza.bfz-tzou.qr> <20191002135518.GA3599@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1707157324-1830003502-1570029865=:32588"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1707157324-1830003502-1570029865=:32588
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wednesday 2019-10-02 15:55, Jeff King wrote:
> So instead of this:
>
>> $ git fetch origin master
>
> try this:
>
>  $ git fetch origin

It creates the master branch. This is what I'm trying to avoid.

> or even this:
>
>  $ git fetch origin master:refs/remotes/origin/master

Bingo. It's ugly but it works. Problem solved :-).

> There's more discussion in this thread (but it looks like no patches
> ever came out of it):
>
>  https://public-inbox.org/git/20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net/

The explanation makes a kind of sense, but if someone want to avoid 
polluting the tags when fetching into FETCH_HEAD one could get it with 
--no-tags. So this is more of a misguided attempt to get a seemingly 
sensible default while destroying a consistent behaviour.

Sometimes I can see why people say git is confusing ;-).

Thanks
Martin Nicolay

-- 

No MS-Word attachments (http://www.gnu.org/philosophy/no-word-attachments.html)
_______________________________________________________________________________
OSM AG | Ruhrallee 191 | 45136 Essen | Fon: 0201-89 555 | Fax: 0201-89 55 400
web: www.osm-ag.de | e-mail: info@osm-ag.de
IBAN: DE67 4325 0030 0001 0059 82 | BIC: WELADED1HRN
USt-ldNr.: DE163337313 | HRB: 28171 Essen
Aufsichtsratsvorsitzende: Dipl.-Kff. Sabine Elsas
Vorstand: Johannes Kuhn (Vorsitzender), Christian Damsky, Axel Roland

--
Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich erhalten
haben, informieren Sie bitte sofort den Absender und vernichten Sie diese Mail.
Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht
gestattet.
_______________________________________________________________________________
--1707157324-1830003502-1570029865=:32588--
