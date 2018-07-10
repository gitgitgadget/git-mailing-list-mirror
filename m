Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8308C1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 07:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeGJH6H (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 03:58:07 -0400
Received: from agora.rdrop.com ([199.26.172.34]:1212 "EHLO agora.rdrop.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbeGJH6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 03:58:04 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 03:58:04 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
        by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id w6A7fSni030330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 10 Jul 2018 00:41:29 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
        by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id w6A7fSmd030329;
        Tue, 10 Jul 2018 00:41:28 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
        id AA08876; Tue, 10 Jul 18 00:14:09 PDT
Date:   Tue, 10 Jul 2018 00:13:42 -0700
From:   perryh@pluto.rain.com (Perry Hutchison)
To:     peff@peff.net, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-Id: <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
In-Reply-To: <20180710035635.GA13459@sigill.intra.peff.net>
User-Agent: nail 11.25 7/29/05
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> If I understand correctly, the Linux implementation requires reading
> from /proc. So an executable that only did RUNTIME_PREFIX (with no
> fallback to static paths) would be unhappy inside a chroot or other
> container that didn't mount /proc.

If we need /proc, wouldn't we _already_ be unhappy inside a chroot
that didn't mount /proc, even _with_ fallback to static paths?
Last I knew, the whole point of chroots/containers/jails/etc. was to
prevent access, from a process running inside the container, to any
part of the FS that's outside of the container.
