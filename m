From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reusing changes after renaming a file (Re: [PATCH 5/6]
 sequencer: Expose API to cherry-picking machinery)
Date: Sat, 13 Aug 2011 13:32:11 -0500
Message-ID: <20110813183211.GF1494@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
 <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
 <alpine.LNX.2.00.1108131215170.2056@iabervon.org>
 <CALkWK0=seEY+O8qmNKoPyYPW-QT9zpwGsh8SB89qcd6kUQRdKg@mail.gmail.com>
 <20110813175012.GD1494@elie.gateway.2wire.net>
 <CALkWK0mDdYTahhDx9_7-4AP8iuvkWMu1wHhQnmUcatEXiDiuTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 20:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsJ0Q-0004p7-OU
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 20:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab1HMScS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 14:32:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46554 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab1HMScR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 14:32:17 -0400
Received: by gwaa12 with SMTP id a12so2602571gwa.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8CvKOmYWt0tCo8ju/kxBtEDYg1cXu0Uo5fsNVGpkJF0=;
        b=nUIYcZeH0nVYW3OnOf5+3EoYOmj4q6ha5klwx3Ojh9GkZonx0xl9C7IkkSBznaNvx0
         cLdU3w583ZCGpxE+H3Pkltga/XxfGmT18SICwKhaHFFzuK/07ppMRqnLxctpaLAk5r4v
         uFD7f++adapiWh2sPnorbcKaEsoypnyXJqiLk=
Received: by 10.236.146.102 with SMTP id q66mr7545332yhj.2.1313260336672;
        Sat, 13 Aug 2011 11:32:16 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id q25sm2662909yhm.76.2011.08.13.11.32.15
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 11:32:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mDdYTahhDx9_7-4AP8iuvkWMu1wHhQnmUcatEXiDiuTA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179288>

Ramkumar Ramachandra wrote:

> $ git cherry-pick -Xrename-threshold=90 sequencer~1
> [test 7400609] sequencer: Expose API to cherry-picking machinery
>  3 files changed, 256 insertions(+), 1247 deletions(-)
>  rewrite builtin/revert.c (81%)
>  rename builtin/revert.c => sequencer.c (81%)
>
> Is it supposed to influence the diffstat?  I don't see any conflict
> markers in sequencer.c.  I can see lots of unintelligent (and useless)
> conflict markers in builtin/revert.c.

Perhaps "git merge-recursive" and its callers don't use the equivalent
of -B, so it doesn't look like a rename to them.  Cases involving
plain renames work fine for me.
