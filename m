Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E491F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757341AbeFSUzF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:55:05 -0400
Received: from alerce.blitiri.com.ar ([51.15.5.42]:59358 "EHLO sdfg.com.ar"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757315AbeFSUzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:55:05 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 16:55:04 EDT
Received: from sdfg.com.ar (authenticated as rodrigo@sdfg.com.ar)
        by alerce.blitiri.com.ar (chasquid)
        (over submission TLS-1.2-TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
        (envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 19 Jun 2018 20:53:04 +0000
Date:   Tue, 19 Jun 2018 21:53:04 +0100
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180619205304.m37wkgl3ojuzmwo6@sdfg.com.ar>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
 <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 10:40:16PM +0200, Torsten Bögershausen wrote:
> 
> 
> On 06/19/2018 08:22 PM, Eric Sunshine wrote:
> > On Tue, Jun 19, 2018 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > Torsten Bögershausen <tboegi@web.de> writes:
> > > > t5562 fails here under MacOS:
> > > > "gzip -k"  is not portable.
> > Very odd. Stock /usr/bin/gzip on my MacOS 10.12.6 _does_ recognize -k,
> > and the test does pass.
> 
> gzip 1.3.12

Oh, this seems to be the issue. As I've said in my prvious email, the first
version to include this was 1.6 IIRC.

The commit adding it is here[1]. But yeah, it was not added 20 years ago, and it
seems there are systems with such old versions of gzip (although can probably
update? Don't know much about mac) :-(


[1]: http://git.savannah.gnu.org/cgit/gzip.git/commit/?id=0192f02e26ac9fa0a27ed177263ee3ea73d5e95c
