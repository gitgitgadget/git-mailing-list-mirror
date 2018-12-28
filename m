Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55ACC1F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeL1Udf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:33:35 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30034 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeL1Udf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:33:35 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBSKXTJE016996
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Dec 2018 15:33:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <randall.s.becker@rogers.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'Git List'" <git@vger.kernel.org>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>        <20181226230523.16572-3-randall.s.becker@rogers.com>    <CAPig+cQ4p8kgAWji3r6WnudZdT4TOG15s1ip6p5SXmTec25mPw@mail.gmail.com>    <000601d49e0b$e11d7520$a3585f60$@rogers.com> <xmqqa7kpmmtj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7kpmmtj.fsf@gitster-ct.c.googlers.com>
Subject: RE: [PATCH v1 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Fri, 28 Dec 2018 15:33:23 -0500
Message-ID: <000f01d49eec$973d8990$c5b89cb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHP6M3TTaFeK+MquD7CewJFvBAGhQLF2eaCAnfCWWgBuWvOxAHe3dpmpVdYMHA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 28, 2018 15:07, Junio C Hamano
> "Randall S. Becker" <randall.s.becker@rogers.com> writes:
> 
> > On December 27, 2018 12:03, Eric Sunshine wrote:
> >> On Wed, Dec 26, 2018 at 6:05 PM <randall.s.becker@rogers.com> wrote:
> >> > A number of configuration options are not automatically detected by
> >> > configure mechanisms, including the location of Perl and Python.
> >> > [...]
> >> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> >> > ---
> >> > diff --git a/config.mak.uname b/config.mak.uname @@ -441,26
> +441,45
> >> @@
> >> > ifeq ($(uname_S),NONSTOP_KERNEL)
> >> >         # Our's are in ${prefix}/bin (perl might also be in
/usr/bin/perl).
> >> > -       PERL_PATH = ${prefix}/bin/perl
> >> > -       PYTHON_PATH = ${prefix}/bin/python
> >> > +       PERL_PATH = /usr/bin/perl
> >> > +       PYTHON_PATH = /usr/bin/python
> >>
> >> Is the in-code comment about ${prefix} still applicable after this
change?
> >
> > The ${prefix} is not applicable on this platform for perl and python.
> > Those locations must be in /usr/bin and are managed by the Operating
> > System vendor not by customers. The change is wrapped in an IF so is
> > only applicable to NonStop.
> 
> So the answer is "Our's are in ${prefix}/bin..." is no longer correct?  If
so, this
> patch must remove that stale comment at the same time, no?

Yessir. Fixed at v3 (now at v4).

