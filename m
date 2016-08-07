Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356922018E
	for <e@80x24.org>; Sun,  7 Aug 2016 09:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbcHGJwe (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 05:52:34 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:48087 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506AbcHGJwd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2016 05:52:33 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id D5FDDC040D;
	Sun,  7 Aug 2016 10:52:31 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id C9F0E20C4D;
	Sun,  7 Aug 2016 10:52:31 +0100 (BST)
X-Quarantine-ID: <e0fL-qzk-DEU>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e0fL-qzk-DEU; Sun,  7 Aug 2016 10:52:26 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 01FB56212B;
	Sun,  7 Aug 2016 10:52:19 +0100 (BST)
Date:	Sun, 7 Aug 2016 10:52:16 +0100
From:	John Keeping <john@keeping.me.uk>
To:	"Michael S. Tsirkin" <mst@redhat.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
Message-ID: <20160807095216.sdvofyz5qhdej35n@john.keeping.me.uk>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
 <18979417.pyyHNUINeQ@mfick1-lnx>
 <xmqqzj0u2k5m.fsf@gitster.mtv.corp.google.com>
 <20160804234920.GA27250@redhat.com>
 <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
 <20160807080857-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160807080857-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 07, 2016 at 08:12:23AM +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 05, 2016 at 08:39:58AM -0700, Junio C Hamano wrote:
> >  * When you updated an existing topic, you tell a tool like "rebase
> >    -i -p" to recreate "lit" branch on top of the mainline.  This
> >    would give you an opportunity to update the cover.
> 
> Combining patchsets might need conflict resolution,
> redoing this each time might be a lot of work.

git-rerere can generally handle that pretty well.  I wrote a tool [1] to
manage integration branches which I use pretty heavily and I find it
very rare to hit a serious conflict.  In fact, git-integration has an
"autocontinue" mode which accepts git-rerere's resolution if it has one,
which works reliably in my experience.

I hadn't thought about writing the cover letter in the integration
branch instruction sheet (I normally just put in some notes for myself
about the state of the branch), but I suspect it would be quite easy to
write a script that mails a series using the instruction sheet comments
as the cover letter.

[1] http://johnkeeping.github.io/git-integration/
