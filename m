Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A15A20196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbcGNP7O (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:59:14 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33345 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcGNP7N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:59:13 -0400
Received: by mail-io0-f174.google.com with SMTP id 38so79674385iol.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 08:59:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W1Cr6cCYRh1E/Vlsk5eFy2yVlmpJgGx2pf7HuVOO/FE=;
        b=orUlJa3gD8F83iffu1YohKmwxFUa2i3E+mTWydMrhAoBN7IiJrmSUz/jB57XoTKzHv
         gXdOmPpp8ZuZ5P7gh34uiRWmtFapd5rOU1d3W9CKQ/35MMP0YL8wpAjAody5K9pQHT4x
         dlQbAPz0Wrvgm2/VU89288KTXzSrVMfErML6qJr1HubC4YWOzwXFkwBoSxM27eX7duWD
         QMOMNshlJP8JSkI3KPdenS25MO2UOqhgwOwDqrAxlssFJDDtQUeFxFAuJ+t0Xwyp3zyG
         A5SYhjD207wSwYBBgREeuw3K3PY3a5DW/yR5dssXFL9WCxW5iGnXMdjtoHco3rcWoNk9
         wIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W1Cr6cCYRh1E/Vlsk5eFy2yVlmpJgGx2pf7HuVOO/FE=;
        b=Fy7y4odjcEcp9HDF6SOsjUgA4f9YktCJMO/iyq9906MC54jMovTvKb96uZJ6QWO9f4
         faqDnzVdxvcNO79hwtTA9sC11CLuBT9rQGeSYJOtNMvKC0DOME1E6KIx2DvA2GG6qsmA
         2aN1XngHExxmrrvSyfxsSJwv/Tic/+ejQRxOkzhFFFGb9Lc0j3UnVAQzvrYbuc3br/vK
         Nz1Ae2ja6xGf1YbK3wOdYCpyHPAnWD/JQRBIKSybObC/AUibXRG8ppV5L8tq8OsiXPuK
         8RMnA2vAY43Pv4EltEPkzlTN4AwyxYkrTwzMuu6ftLeYPZsv2xB81Emq3TR/p7D88UEG
         HjLw==
X-Gm-Message-State: ALyK8tI+8OtyaMIJzRlGpBaA/U9oIK0KocQg7o1SU283faWHk47cGW91qNOhItVyrwuEPgrjAUTQLJBrP03Ytg==
X-Received: by 10.107.159.16 with SMTP id i16mr14967176ioe.29.1468511952444;
 Thu, 14 Jul 2016 08:59:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 14 Jul 2016 08:58:41 -0700 (PDT)
In-Reply-To: <CACsJy8BRg6ej1ZWeAY0yaV3Zmk+UqW4YN+yt-FTOYihTC19PqQ@mail.gmail.com>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
 <CACsJy8Br-rSTKjpt2ykn8YyFruy8CZoXWm287BtTRcAYY2DjVw@mail.gmail.com>
 <5786B9CE.6010703@novalis.org> <CACsJy8BRg6ej1ZWeAY0yaV3Zmk+UqW4YN+yt-FTOYihTC19PqQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 14 Jul 2016 17:58:41 +0200
Message-ID: <CACsJy8DRm8U=mnyt_N=TepyWw6RreP7rUxzcWV+zEAuH42XySw@mail.gmail.com>
Subject: Re: [PATCH v14 00/21] index-helper/watchman
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>, kmaggg@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Big typo..

On Thu, Jul 14, 2016 at 5:56 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> For giant-scale repos, you probably want something more efficient than
> a script like this. And the good thing is you have freedom to do
> whatever you want. You can run one daemon per repo, you can run one
> daemon per system... In some previous mail exchange with Dscho, it was
> mentioned that something other than watchman may be desired. This
> opens up that door without much headache from outside.

s/outside/our side/
-- 
Duy
