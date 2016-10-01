Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DA620986
	for <e@80x24.org>; Sat,  1 Oct 2016 21:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbcJAVBj (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 17:01:39 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34677 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcJAVBi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 17:01:38 -0400
Received: by mail-lf0-f41.google.com with SMTP id b81so10968036lfe.1
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ORiqlduB4DtbHdwuVmXvJx5GGeBSoFiSwBw8xrNXMbQ=;
        b=m35cnNX/JHtzCFwd+lwpUnd1ei7RXIzIEKbcru7nm704ukeA4MPzsDr+n0VpDKCxbw
         sqK07wswvqgPZDqzWJmqJWno86Vwrgt92fdWut22WL2JyTAXX7bFK5txYAPzWEp6+o1b
         PsmTyx0zpMRSTD0sWmjYxTah5p8OpLxqg8uoA3/0wE4Drg7VJlVjRuPC2ccw+LQQLsHl
         HTkKNcufSol0bxVW8QnZcuJ+rm+uWb1vsZ/HKv9Sj8AwWw+5pjsTJMMH/j+DLb29nFId
         eE1zLaYbzctFrOjz7ImKHBZqLZQjX1YbyXAHcQ9dyAYXlSSsL8oK8o5rsz257GBCa6Xc
         fm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ORiqlduB4DtbHdwuVmXvJx5GGeBSoFiSwBw8xrNXMbQ=;
        b=mGiE8akzNNwD6hXakqLx0L22Pj/cTqSNWRghwE7+8ErILdFWQAIidv04qStQVYjgZ3
         C/qJk5S9nI8VSG35SkgK1PRLXUDWaf3J0q7U1GZbPCTzZ/DJRBy3NeQJxFNTx8pOVKCe
         KOr3pMaboc7jTRb1Wm85ffWEYGTK9193ecevc/VKAoWUiahyhiulP6ic98mKp1XEh4Y6
         oJL/d5pSTqXUzntXy4XER/rcp7cvN0WBypTRJ4bT0nf+CbfzSun6tDHPG9A27KC8mqN5
         3ADOOIOd8SVBYFeM0ulq0Zo5bzjSa5pIwjZKiJmY22qZpMPcZH/GKo/PTMDmY7r8SvLv
         +eqg==
X-Gm-Message-State: AA6/9RmqHZt8Aa5W2ibGNaqxfqO1gyl5wgWPKb6dfml6GQOE66Bz4JEsGSnDtvA5hT+fiXvJ1BbJi9ToQK2Ymg==
X-Received: by 10.25.20.209 with SMTP id 78mr975365lfu.5.1475355696444; Sat,
 01 Oct 2016 14:01:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.173.200 with HTTP; Sat, 1 Oct 2016 14:01:15 -0700 (PDT)
In-Reply-To: <b032fcbc-045b-7822-f9d4-84930cbf6b41@web.de>
References: <nrje96$q7s$1@blaine.gmane.org> <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
 <b032fcbc-045b-7822-f9d4-84930cbf6b41@web.de>
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Date:   Sat, 1 Oct 2016 23:01:15 +0200
X-Google-Sender-Auth: vs6I9old6lNzYBoLJQtczVdpCFU
Message-ID: <CACNzp2=tRrAunuP0x2QtBfToXSLj1bW54-U63dpyUokpywxOOw@mail.gmail.com>
Subject: Re: Two bugs in --pretty with %C(auto)
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ren=C3=A9,


On Thu, Sep 29, 2016 at 8:13 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Reverts the change to t6006, so we'd need another test for this.
> Anatoly? :)

I've checked my example commands and couldn't find any regressions.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
