From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] sequencer.c: fix detection of duplicate s-o-b
Date: Wed, 6 Apr 2016 18:37:26 +0200
Message-ID: <20160406163726.GG28596@1wt.eu>
References: <20160312130844.GA25639@1wt.eu>
 <xmqqr3eizsxu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 18:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqSZ-0003f8-2B
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbcDFQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:37:33 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:65377 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbcDFQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:37:32 -0400
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id u36GbQJf028743;
	Wed, 6 Apr 2016 18:37:26 +0200
Content-Disposition: inline
In-Reply-To: <xmqqr3eizsxu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290848>

On Wed, Apr 06, 2016 at 07:57:01AM -0700, Junio C Hamano wrote:
> This seems to have been lost, perhaps because the top part that was
> quite long didn't look like a patch submission message or something.

Don't worry, we all know it's the submitter's responsibility to retransmit,
I apply the same principle :-)

> Git 1.7.12 is a quite ancient release and I wouldn't be surprised if
> we made the behaviour change during the period leading to v2.6 on
> purpose, but nothing immediately comes to mind. Christian (as the
> advocate for the trailer machinery) and Brandon ("git shortlog
> sequencer.c" suggests you), can you take a look?

FWIW it wad changed in 1.8.3 by commit bab4d10 ("sequencer.c: teach
append_signoff how to detect duplicate s-o-b").

The change made a lot of sense but it didn't assume that this practice
was common. And indeed I think this practice only happens in maintenance
branches where people have to make a lot of adaptations to existing
patches that they're cherry-picking. We do that a lot in stable kernels
to keep track of what we may need to revisit if we break something.

Thanks!
Willy
