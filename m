Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8DF2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdKVAXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:23:33 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45069 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdKVAXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 19:23:32 -0500
Received: by mail-qk0-f181.google.com with SMTP id d125so14586400qkc.12
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KSchO13ZSW/zT77CZDX4IRgsZtLYei0VlrRUzfi+VAI=;
        b=mlvpnk6+hNnemOsTIomn1ZzW0qsFrNi84/5qxuNi2O0sOTPx0loogI/w9DnsPLP4Cl
         MDzLvTHzjYzeFPnL5OYvO7gTpc5fVpsvGnctaPIlioihMbeoVE4VQSwK5sf+npBHgf1w
         rJIhqUuiMRQz59AW8K8E32ZLitV/8tfcE1H9GnMKP90ki6f1YXPQSle7iu6imn6BWIZX
         Hppnq12ONHkzAa77Bpv5014EHwCxVErLEJRD3QqeauLyOds38GnFzvz4emah5v5zJ4V2
         tsZAFDPwgeV7pc1FWsgiCg9H0u5E8bdMwi/YCeL6zP8vnCeFIUpV8RQf2eAJdi/JfJBI
         cHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KSchO13ZSW/zT77CZDX4IRgsZtLYei0VlrRUzfi+VAI=;
        b=LaZou6uFx6t7Rkcduy6xnFGfRnmBdy4eZwxrrd3nKoviiN5D7n/rrnovDpy81592jK
         m1lMLcCIx2eSY/ZcmZFqrnCfPxaprySiHE80rsjouYjmFh/W6rLx49fkb5vk7djRt70h
         GVOW9jk9rd+aw5pZ6JT1gqsLF4Qk6KLSoQCgUFiEoswm4sn3QQw33QKDVpjxMJcpE7DI
         /5ZiLZQZQxKa5lJkDg1fpVBry0wWt6LAQPZPqzJuh86fGbu8W06nWPwjkH1aPyQyguLA
         5onmZdr06eVZ3jvX1Z4OlEpfN36IigqKGoXjTCy9aZfTMYp4WmHGO5C7G0t6YC3RAaQ/
         1Abw==
X-Gm-Message-State: AJaThX49xxLFqAORnPlN1NJSX/YnNeeQBrqm+9G+dmfdEa2J0OEFEB9h
        hLzao7A/11RoVMSva6Y7gBYeJBaTAT5Le8Hv/eGvDQ==
X-Google-Smtp-Source: AGs4zMaz0fKKluGtAdmKn9IXCa0YleW4vF9dCzDByQudO72eMEWz6kWQGNUGGWgvqW22N2Jr6PKA6uhpsLLDZ4VuP7Y=
X-Received: by 10.55.107.65 with SMTP id g62mr5837327qkc.295.1511310211494;
 Tue, 21 Nov 2017 16:23:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 16:23:30 -0800 (PST)
In-Reply-To: <b5a6ddb1-0971-92d1-4cfb-94366d8f14c3@ramsayjones.plus.com>
References: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
 <20171121011634.dw6tdgp2s7lpl2lm@aiede.mtv.corp.google.com> <b5a6ddb1-0971-92d1-4cfb-94366d8f14c3@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 16:23:30 -0800
Message-ID: <CAGZ79kaKWRMDFQLbeRtGmejOD7JD_RCjK5J_HOFqddReT6yOEA@mail.gmail.com>
Subject: Re: [PATCH] list-objects-filter-options: fix up some sparse warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [It would probably be easier if I used git to output this for me, rather
> than typing it into my email client!]

git config alias.gcs "show --date=short -s --pretty='format:%h ("%s", %ad)'"

will make you the `git gcs` alias that I use to describe commits.
