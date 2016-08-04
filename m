Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51711F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbcHDXtf (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759140AbcHDXtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:49:35 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 676834E320;
	Thu,  4 Aug 2016 23:49:21 +0000 (UTC)
Received: from redhat.com (unused [10.16.197.238] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u74NnKdX004737;
	Thu, 4 Aug 2016 19:49:20 -0400
Date:	Fri, 5 Aug 2016 02:49:20 +0300
From:	"Michael S. Tsirkin" <mst@redhat.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
Message-ID: <20160804234920.GA27250@redhat.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
 <18979417.pyyHNUINeQ@mfick1-lnx>
 <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Aug 2016 23:49:21 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Sep 10, 2015 at 11:39:49AM -0700, Junio C Hamano wrote:
> The problem with "empty commit trick" is that it is a commit whose
> sole purpose is to describe the series, and its presence makes it
> clear where the series ends, but the topology does not tell where
> the series begins, so it is an unsatisifactory half-measure.

Actually, when using topic branches the series always ends at head, so
it's better to keep the empty commit where series begins.

This was actually suggested by Philip Oakley on this thread
but I'm not sure it was noticed as it was part of a bigger email.

It also maps much better to git am uses - you apply patch 0/N first to
create the empty commit, then the rest of the patches.

This does mean you need to use git rebase to edit that cover
commit, but maybe that is not a big deal, and git rebase could
learn --cover to find and edit that.
-- 
MST
