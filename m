Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BED81F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 10:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbeGKKm0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 06:42:26 -0400
Received: from gecko.sbs.de ([194.138.37.40]:50267 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732348AbeGKKm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 06:42:26 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BAcMaZ020569
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 12:38:22 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6BAcKWF032628;
        Wed, 11 Jul 2018 12:38:20 +0200
Date:   Wed, 11 Jul 2018 12:38:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 9/9] gpg-interface t: extend the existing GPG tests
 with GPGSM
Message-ID: <20180711123819.1e4880c3@md1pvb1c.ad001.siemens.net>
In-Reply-To: <xmqqlgai6bhi.fsf@gitster-ct.c.googlers.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <cover.1531208187.git.henning.schild@siemens.com>
 <f97d2d79f6a46ddffcd0065239f99b084708e813.1531208187.git.henning.schild@siemens.com>
 <xmqqlgai6bhi.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Tue, 10 Jul 2018 14:12:57 -0700
schrieb Junio C Hamano <gitster@pobox.com>:

> Henning Schild <henning.schild@siemens.com> writes:
> 
> > Add test cases to cover the new X509/gpgsm support. Most of them
> > resemble existing ones. They just switch the format to x509 and set
> > the signingkey when creating signatures. Validation of signatures
> > does not need any configuration of git, it does need gpgsm to be
> > configured to trust the key(-chain).
> > We generate a self-signed key for committer@example.com and
> > configure gpgsm to trust it.
> >
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  t/lib-gpg.sh               |  9 ++++++-
> >  t/lib-gpg/gpgsm-gen-key.in |  6 +++++
> >  t/t4202-log.sh             | 66
> > ++++++++++++++++++++++++++++++++++++++++++++++
> > t/t5534-push-signed.sh     | 52
> > ++++++++++++++++++++++++++++++++++++ t/t7003-filter-branch.sh   |
> > 15 +++++++++++ t/t7030-verify-tag.sh      | 47
> > +++++++++++++++++++++++++++++++-- t/t7600-merge.sh           | 31
> > ++++++++++++++++++++++ 7 files changed, 223 insertions(+), 3
> > deletions(-) create mode 100644 t/lib-gpg/gpgsm-gen-key.in  
> 
> I saw my post-integration tests taking forever to finish for 'pu'
> and "ps x" output showed that many tests (I ran tests in parallel)
> were stuck and all of them were running gpgsm. 
> 
> For now, I've ejected the topic out of 'pu', as I want to finish
> today's integration run with all the other topics first before
> coming back to this topic.

That must have been the key generation, see my reply to one of
Jeffs mails.

Henning

