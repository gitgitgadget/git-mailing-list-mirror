Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115481F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJ3UHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:07:36 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:50146 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbfJ3UHg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Oct 2019 16:07:36 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 16:07:36 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 9BB6118024545
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 19:59:08 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C60392476
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 19:59:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brick69_4fa5bfdb96a51
X-Filterd-Recvd-Size: 872
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 19:59:07 +0000 (UTC)
Message-ID: <277ee7531df8dfd3249f189b9b298a5d187ec479.camel@perches.com>
Subject: request: add git grep -o option
From:   Joe Perches <joe@perches.com>
To:     git <git@vger.kernel.org>
Date:   Wed, 30 Oct 2019 12:58:59 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of duplicating a grep pattern with grep -oh after
git grep like
this:

$ git grep -P '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?' -- '*.[ch]' | \
  grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?'

it could be useful to have git grep have the same '-o' option 
as gnu grep.


