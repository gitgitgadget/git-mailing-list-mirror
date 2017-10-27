Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7E020562
	for <e@80x24.org>; Fri, 27 Oct 2017 23:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbdJ0XW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:22:28 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:40642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932476AbdJ0XW1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 19:22:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 88C65100E86C0;
        Fri, 27 Oct 2017 23:22:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trail49_4f5c478a9be5b
X-Filterd-Recvd-Size: 1671
Received: from XPS-9350 (unknown [172.56.39.55])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Oct 2017 23:22:25 +0000 (UTC)
Message-ID: <1509146542.1914.19.camel@perches.com>
Subject: Re: grep vs git grep performance?
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Date:   Fri, 27 Oct 2017 16:22:22 -0700
In-Reply-To: <877evgxmu7.fsf@evledraar.booking.com>
References: <1509030170.10651.59.camel@perches.com>
         <CAGZ79ka41NdzNxGAvtVW802088KydKkp3yHx=Z5q3Mc9GGa_+g@mail.gmail.com>
         <1509039696.11245.9.camel@perches.com>
         <CAGZ79kYWPunzZ2u=MtCoCadxXu_4etEK5DYnhYXo+CgeHrXQwQ@mail.gmail.com>
         <1509124942.1914.9.camel@perches.com>
         <877evgxmu7.fsf@evledraar.booking.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-10-28 at 00:11 +0200, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Oct 27 2017, Joe Perches jotted:
[]
> > git grep performance has already been
> > quite successfully improved.
> 
> ...and I have WIP patches to use the PCRE engine for patterns without -P
> which I intend to start sending soon after the next release.

One addition that would be quite nice would be
an option to have regex matches span input lines.

grep v2.54 was the last grep version that allowed
this and I keep it around just for that.

ie:

$ cat hello.txt 
Hello
World
$ grep -P "Hello\s*World" hello.txt 
$ grep-2.5.4 -P "Hello\s*World" hello.txt 
Hello
World

