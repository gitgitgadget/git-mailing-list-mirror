From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Tue, 22 Apr 2014 12:27:13 +0200
Message-ID: <20140422102713.GC366@quack.suse.cz>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
 <xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
 <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
 <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcXvC-0005Y5-5g
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 12:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbaDVK1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 06:27:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35771 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbaDVK1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 06:27:17 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C43E0AD0E;
	Tue, 22 Apr 2014 10:27:15 +0000 (UTC)
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 06D9B81C3A; Tue, 22 Apr 2014 12:27:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246727>

On Thu 17-04-14 10:04:52, Junio C Hamano wrote:
> So perhaps the rule should be updated to do something like:
> 
>     - find candidate tags that can be used to "describe --contains"
>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;
> 
>     - among the candidate tags, cull the ones that contain another
>       candidate tag, rejecting v3.5 (not shown) and v9.0;
>
>     - among the surviving tags, pick the closest.
  I guess all parties agree with the first two points (and actually I would
prefer not to assume anything about tag names and consider v3.4-rc1 as good
as v3.4). Regarding the strategy what to select when there are several
remaining tags after first two steps I would prefer to output all such
tags. As people have mentioned in this thread it varies a lot between
projects what people want to see (and in some cases I can imagine people
really *want* to see all the tags). So printing all such tags would let
them select the desired tag with grep or some more elaborate scripting...
Just a thought.

								Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
