Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72B820193
	for <e@80x24.org>; Wed,  2 Nov 2016 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756845AbcKBU1M (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 16:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756774AbcKBU1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 16:27:12 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7679364D84
        for <git@vger.kernel.org>; Wed,  2 Nov 2016 20:27:11 +0000 (UTC)
Received: from mail.random (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA2KRAhp031594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 2 Nov 2016 16:27:11 -0400
Date:   Wed, 2 Nov 2016 21:27:09 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     git@vger.kernel.org
Subject: send-email garbled header with trailing doublequote in email
Message-ID: <20161102202709.GI4611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 02 Nov 2016 20:27:11 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

send-email gets confused with one trailing " at the end of the
email. Details and how to reproduce below, it breaks also with
upstream git version 2.10.2.dirty.

Feel free to CC me if you need any further info.

Thanks,
Andrea

----- Forwarded message from Andrea Arcangeli <aarcange@redhat.com> -----

Date: Wed, 2 Nov 2016 21:07:02 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
To: linux-mm@kvack.org
Subject: Re: [PATCH 00/33] userfaultfd tmpfs/hugetlbfs/non-cooperative
User-Agent: Mutt/1.7.1 (2016-10-04)

FYI: apparently I hit a git bug in this submit... reproducible with
the below command:

git send-email -1 --to '"what ever" <--your--@--email--.com>"'

after replacing --your--@email--.com with your own email.

*snip*
Dry-OK. Log says:
To: "what ever" " <--your--@--email--.com>
*snip*
X-Mailer: git-send-email 2.7.3

Result: OK

It's not ok if the --dry-run outputs the above with a fine header, but
the actual header in the email data is different. Of course I tested
--dry-run twice and it was fine like the above is fine as well.

*snip*

----- End forwarded message -----
