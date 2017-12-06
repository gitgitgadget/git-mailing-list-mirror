Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95BC20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdLFSkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:40:52 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:43680 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbdLFSkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:40:51 -0500
Received: by mail-vk0-f49.google.com with SMTP id u84so3307682vke.10
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nRWE7B+MP7sh4P/O+AI4KcPid0Qg9xI6mwlKFEK86ec=;
        b=JCWfcbb16Mx2MeSHUEFsZCD36iIoZ8npXL9AsXH0/LcgYX5pnsiwXpM4Sbm+zJUZVl
         JRtJuRjDAaoR40B9FxtCPnC+5VSHnDcYYQkpSpX/Ga6p/0O07DSir8N95VdPjvSDE3Y2
         5m4ZP3JX2Em2gzKgHwopnbJOSVZKkJ2kP5sS1rcLum9H+bd1Tpdy0TSMkXg6HlQqTFFF
         tpX9cCGgkDdibZtvzZANLvVyXCWG8FgFt1naJVpeCPDd2qwIO4IsWDMRoMv6GgUEqqsV
         9/WzHhr6Fs9B6gzgQTIP5Q+lqgT6hZlN4R4na0xtaZo1zj3xilCV6MdpF7iqZ5Y3Of0n
         L7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nRWE7B+MP7sh4P/O+AI4KcPid0Qg9xI6mwlKFEK86ec=;
        b=fdWorGlaITIpqoyixAZdZ6jB5MYSOUY/gU65qbjinJdqXT7Hagzo5DVJm3+dNYPfl5
         iKSULXs411ErZSLdskEqj2Cqll3vdye/q6wRvi0UdS0oA7k8BmD4WzOrNDJEepQnw+Z4
         dhhoEHqapL5d34jLEAXzZwnmgzWsIO/yg6gT6w5TeYYVgglfF32guTqsQAE/mTB5N+pV
         fiqYw0YVyuG4P7Q3/JPZ1d34rq0AjJ0AEuKJO9rMWzjVJ7eb+MXXFlzXUabXcHmPdcGc
         WAB3EeC4Nw/j55uJH9B/1vMie4CKiOMRLKDGWQaj9ZylxIGffCmvi3rAok/swXw6MqnA
         0vCQ==
X-Gm-Message-State: AKGB3mJfBKR/HLPwiRzohag0A0cRmILsKZBt/614fOmbor6XN4to+W65
        m/M5RD7u0TMjSPvqAelJJuLmMkVPQh4IRobQj1s=
X-Google-Smtp-Source: AGs4zMZlAzQgIfTFL4OQK8koJ1i9XeccKcAuy8Wt7GrjymaLXXDkhLseLjQL61BiFHjuxyFCAgikc9k++ljjGK6Be/E=
X-Received: by 10.31.190.72 with SMTP id o69mr10790767vkf.103.1512585645436;
 Wed, 06 Dec 2017 10:40:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.157.195 with HTTP; Wed, 6 Dec 2017 10:40:24 -0800 (PST)
In-Reply-To: <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org> <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org> <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org> <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 6 Dec 2017 10:40:24 -0800
X-Google-Sender-Auth: SmYAL67OeSpElQKR5rFDs8WuIRo
Message-ID: <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 10:34 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> I am sorry for not responding in detail. I think we've reached a mutual
> understanding of our workflows.
>
> Though, from the ideas you tossed around most recently, you seem to want to
> make git-commit into a kitchen-sink for everything. I have my doubts that
> this will be a welcome change. Just because new commits are created does not
> mean that the feature must live in git-commit.

Nicely put.
