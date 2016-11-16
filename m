Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0DE2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 14:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbcKPO3l (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 09:29:41 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:41162 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbcKPO3h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 09:29:37 -0500
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71DR-00062A-AW; Wed, 16 Nov 2016 15:29:33 +0100
Date:   Wed, 16 Nov 2016 15:29:30 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v3 3/4] batch check whether submodule needs pushing into
 one call
Message-ID: <20161116142930.GB32087@book.hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
 <0f1aaa07e151f6be87eb61b434f8c9448f8dad75.1479221071.git.hvoigt@hvoigt.net>
 <CAGZ79kZtQG5pE-6N-1yZKA95VRmrDRB3PnSd1gtqBM9fxD48Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZtQG5pE-6N-1yZKA95VRmrDRB3PnSd1gtqBM9fxD48Cg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 02:28:31PM -0800, Stefan Beller wrote:
> On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
> > -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> > +static int check_has_commit(const unsigned char sha1[20], void *data)
> >  {
> > -       if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> > +       int *has_commit = (int *) data;
> 
> nit: just as prior patches ;) void* can be cast implicitly.

Even though its just a nit: Will remove all the void casts. :)

Cheers Heiko
