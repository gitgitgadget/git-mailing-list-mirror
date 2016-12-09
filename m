Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252362093C
	for <e@80x24.org>; Fri,  9 Dec 2016 01:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbcLIBpv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 20:45:51 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33170 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbcLIBpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 20:45:50 -0500
Received: by mail-yw0-f176.google.com with SMTP id r204so3432256ywb.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 17:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=saqpDIfdLf3gr/JioRDuS1OLyYi/GlGCNhQK938xn+Q=;
        b=mzLIZDe3se0PQ0ze5ySRUHY8oB1K40p3ch6v8mEcphX0+TBXgHXsG7SrRe0Sk4IV9J
         G+7+s2Npv2y7WkiDGCRbAB+2Af6kFnHh9J2rGrwghtrhMXMeuWuChdAnjL0Dv0jIhMfF
         Q4ksZZBoR4Ww90AnBtxIWKOjEfEHvJUm/GMe+Z+n1BrQaNO/1dWMmmUwG8rjIOVE+QPG
         TgTmbNfZ6ABSTkYcP/NjySggXKoqVhPOsfxwRJrv4no4U6wefaSeB/dddc4d0NoNlMou
         KrY1yoYN5YFXhaVonBjXdK+RqwXnvucaDtwwGid0RduwXhPZ3hjXnefXPJ5S744bDVg4
         qSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=saqpDIfdLf3gr/JioRDuS1OLyYi/GlGCNhQK938xn+Q=;
        b=H1HuQkHruwEk2qanGcjqGlnBGdkDL0NW6tJ+j0JmEN/3BuA/3dEHLE4XyXJPLYfpQe
         1L/n8QQyHvgNQ8zkudlC7A2BRG9Wx5Y35w9hXZ8Dtm/WFI09z5xafwvtwkWCLqWIzNWR
         ke2AvREhd9ck2836SZ9yOza3fQiX0GRSMOHWB89vCSeB9qQ6FvY4pkOWYnXjhTRq0d2e
         gJBi/eu9+o8tyNH9Rzauxyku0jILHM8tl8cg4WlB98kP4YH7ZRLeEbbHYVQSCMwjXL2p
         y01p84ydDbKNoRvPMhVS3TEbCwBRvUVnk25o9oSdF8Y6jtwvODEkdkvss6qrERy4M8yX
         xK6g==
X-Gm-Message-State: AKaTC03fFHkbQAb9eWHED3+FLDUI0dRnDOfgJG+cuGNIipNcjrtCrtCSD+Ub7/gtd3hkTsquNRMURnBjamkvvA==
X-Received: by 10.13.250.3 with SMTP id k3mr69206959ywf.276.1481247949371;
 Thu, 08 Dec 2016 17:45:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Thu, 8 Dec 2016 17:45:28 -0800 (PST)
In-Reply-To: <xmqqa8c6tfhc.fsf@gitster.mtv.corp.google.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
 <xmqqa8c6tfhc.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 8 Dec 2016 17:45:29 -0800
Message-ID: <CA+P7+xrGuEjc-QFkPSg7FCNFfq-rRTa7PsuiiY-1Edj381LidA@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> *1* A malformed formatting request (e.g. %(if) that is not closed)
>     cannot be satisified but that is true for all refs and is
>     outside of the scope of this discussion.  The command should die
>     and I think it already does.

Agreed. I was only making the case that if it could "possibly" be
satisfied, then we shouldn't die.

Thanks,
Jake
