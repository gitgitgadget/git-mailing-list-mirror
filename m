Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3116B1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 19:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbdAZTTW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 14:19:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49402 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbdAZTTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 14:19:21 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CB2C31F70F;
        Thu, 26 Jan 2017 19:18:42 +0000 (UTC)
Date:   Thu, 26 Jan 2017 19:18:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
Message-ID: <20170126191841.GA6060@dcvr.yhbt.net>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
 <20170126001344.445534-1-sandals@crustytoothpaste.net>
 <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
 <20170126074304.GA26530@starla>
 <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Eric Wong <e@80x24.org> writes:
> > You can use '\' to continue long lines with any Ruby version:
> >
> >     "<citerefentry>" \
> >       "<refentrytitle>#{target}</refentrytitle>" \
> >       "<manvolnum>#{attrs[1]}</manvolnum>" \
> >     "</citerefentry>"

Junio C Hamano <gitster@pobox.com> wrote:
> +          "<citerefentry>\n"
> +            "<refentrytitle>#{target}</refentrytitle>"
> +            "<manvolnum>#{attrs[1]}</manvolnum>\n"
> +          "</citerefentry>\n"
>          end

You need the '\' at the end of those strings, it's not like C
since Ruby doesn't require semi-colons to terminate lines.
In other words, that should be:

          "<citerefentry>\n" \
            "<refentrytitle>#{target}</refentrytitle>" \
            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
          "</citerefentry>\n"
