Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6397F1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 21:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeJSF5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 01:57:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46653 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSF5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 01:57:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so36132384qtk.13
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 14:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xR1zMr3O2IN9FxCAT9Qff3CVN98/RmhcSVX56VXo+TU=;
        b=L8kYjrkPFRAx0wgDzPToTEH5cSBRVPhUXGZ39uUno9z4aA83fFzKk7jPkwAf1OqK1y
         zwR3J4foSormVh7wv6iSh/S7ZQbLmoA7jEqhARAtJv4LVSTa6X0NpOpLGuvAV4fwSXNj
         b8hSweACR18m5RgVuuWGh5Kf+ApGGozn5XrCvnEvyYTtn5q6VNt2aJZCfq5NwfrccW/T
         HPGVtTdSm/iAskqfS48IvEZOkTgy+GEDyQb3XoxrcUavqLVUNLIRBVPNUHDsin3MZpJH
         N5tA+0Pl9oVotL5mNo0TcHIy8tXgL7CMnUOl/7a/dpNrdoUjufw4qnh7Z0AhoqB7tXgh
         xSrA==
X-Gm-Message-State: ABuFfogP0o0RYj3im8pRTDy6W7zxppgQK2xYsOZrEMsLB2Oh1Pz9WLzb
        WbTAcppTokKTegT/8wWkhbPnlbSB66+uV/OVudeC+w==
X-Google-Smtp-Source: ACcGV61yWDs163RrzlOTglfpD1yWUy5bLmVfWHTxSAFBonOu1SgdKR4fcIRd73/247KRgkyJ9FaWOr8iRKXQopD5Crg=
X-Received: by 2002:ac8:3097:: with SMTP id v23-v6mr30139961qta.335.1539899642356;
 Thu, 18 Oct 2018 14:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181018211527.25597-1-JPEWhacker@gmail.com>
In-Reply-To: <20181018211527.25597-1-JPEWhacker@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Oct 2018 17:53:51 -0400
Message-ID: <CAPig+cR27mPmH+0oeT+2T878K-cBNqBnxPUumETnVK1cvz2qnA@mail.gmail.com>
Subject: Re: [PATCH] send-email: explicitly disable authentication
To:     jpewhacker@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 5:16 PM Joshua Watt <jpewhacker@gmail.com> wrote:
> It can be necessary to disable SMTP authentication by a mechanism other
> than sendemail.smtpuser being undefined. For example, if the user has
> sendemail.smtpuser set globally but wants to disable authentication
> locally in one repository.
>
> --smtp-auth and sendemail.smtpauth now understand the value 'none' which
> means to disable authentication completely, even if an authentication
> user is specified.

Implementation complexity aside, spelling the option --no-smtp-auth
might be more intuitive and consistent than --smtp-auth=none.

> The value 'none' is lower case to avoid conflicts with any RFC 4422
> authentication mechanisms.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
