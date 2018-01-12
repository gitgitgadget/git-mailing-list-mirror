Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421F91F406
	for <e@80x24.org>; Fri, 12 Jan 2018 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964879AbeALPrz convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 12 Jan 2018 10:47:55 -0500
Received: from elephants.elehost.com ([216.66.27.132]:64240 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeALPrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 10:47:53 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0CFljxE006640
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Jan 2018 10:47:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <003601d38aea$e0e08ff0$a2a1afd0$@nexbridge.com> <000201d38b24$9e27ac40$da7704c0$@nexbridge.com> <20180112143912.GB9088@sigill.intra.peff.net>
In-Reply-To: <20180112143912.GB9088@sigill.intra.peff.net>
Subject: RE: [BUG] Weird breakages in t1450 #2 on NonStop
Date:   Fri, 12 Jan 2018 10:47:39 -0500
Message-ID: <001c01d38bbc$b04a05b0$10de1110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQExQbaZU2sHaLe3IAgxbGtzSYtiSgH/8Q3BAUb4OrGkmr0qIA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 12, 2018 9:39 AM, Jeff King wrote:
> On Thu, Jan 11, 2018 at 04:39:04PM -0500, Randall S. Becker wrote:
> 
> > > executed because the test_commit fails with a non-zero git commit
> > > completion code. There is no rn---- (actual r n 252 252 252 252) in
> > > the objects directory - even the 'rn' does not correspond to
> > > anything.. I am suspecting an unterminated string that ran into
> > > freed memory somewhere, but that's speculative.
> >
> > Does anyone recall fixing this one at or near
> > dfe46c5ce6e68d682f80f9874f0eb107e9fee797? There was a rewrite of
> > sha1_file.c including link_alt_odb_entry where I am finding memory
> > corruptions. I think I'm chasing something that was already fixed some
> > time after 2.13.5 but the common parent to where I am is pretty far
> > back compared to master.
> 
> I did a lot of work on link_alt_odb_entry() in the past year or so, and I seem
> to recall seeing some cases where we could run into unterminated memory
> in the error message.
> 
> Maybe dc732bd5cb (read_info_alternates: read contents into strbuf, 2017-
> 09-19)?

In that case, I think I'm going to jump right to 2.16.0-rc2. I think I would have preferred 2.15.2 - but there isn't one yet 😉

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



