From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 20:49:46 +0100
Message-ID: <20150902194946.GL30659@serenity.lan>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <20150901224431.GA9353@sigill.intra.peff.net>
 <20150902074826.GK30659@serenity.lan>
 <20150902080529.GA19248@sigill.intra.peff.net>
 <xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 21:56:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXE98-0004gB-7i
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067AbbIBT4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 15:56:35 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:37021 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbbIBT4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 15:56:34 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Sep 2015 15:56:34 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1AD5224F4C;
	Wed,  2 Sep 2015 20:49:54 +0100 (BST)
X-Quarantine-ID: <1LmHU-iMh6fr>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1LmHU-iMh6fr; Wed,  2 Sep 2015 20:49:53 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A789B22CFC;
	Wed,  2 Sep 2015 20:49:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277118>

On Wed, Sep 02, 2015 at 08:16:59AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Sep 02, 2015 at 08:48:26AM +0100, John Keeping wrote:
> >
> >> On Tue, Sep 01, 2015 at 06:44:31PM -0400, Jeff King wrote:
> >> > [1] I do think the error message for "relative-local is nonsense" could
> >> >     perhaps be more explanatory, but I couldn't come up with any better
> >> >     wording. But if you have ideas, feel free to switch it.
> >> 
> >> My only suggestion would be to reuse the "unknown date format: %s"
> >> message and avoid having a special message in this case.
> >
> > Heh, that was what I was trying to avoid. I wanted to avoid "I do not
> > understand our request" and have it more like "I understand what you're
> > _trying_ to do, but it doesn't make sense".
> >
> > I guess "relative dates do not depend on timezones, so -local is
> > meaningless" would be the closest thing.
> >
> > I don't think it is that big a deal whichever way we go, though.
> 
> I somehow thought that the discussion was about raw-local, not
> relative-local, but anyway, I think it would make more sense to
> allow both of them.  If you define the meaning of "-local" as:
> 
>     Pretend that the event in question was recorded with your
>     timezone, and show the timestamp using the specified format sans
>     -local suffix.
> 
> that explains what happens for all the other formats well, and it
> also makes sense for what would happen to raw and even relative, I
> think.

The discussion about "raw-local" was in a separate subthread, I think
we're just bikeshedding the particular error message here.

OTOH, I don't think there's any disagreement about what "relative-local"
and "raw-local" would output were they supported, just whether they are
useful.  There doesn't seem to be any harm in supporting them;
"relative-local" will be identical to "relative" and "raw-local" will
require preparatory code movement for the raw output.
