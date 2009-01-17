From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so
	that editors can recognize, it as a bash script. Also adds a few
	simple comments above commands that, take arguments. The comments
	are meant to remind editors of potential, problems that
Date: Fri, 16 Jan 2009 20:40:57 -0500
Message-ID: <20090117014057.GA15331@coredump.intra.peff.net>
References: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: markus.heidelberg@web.de,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 02:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO0Cf-0007Mn-U5
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 02:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZAQBlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 20:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbZAQBlA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 20:41:00 -0500
Received: from peff.net ([208.65.91.99]:56069 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755102AbZAQBk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 20:40:59 -0500
Received: (qmail 23475 invoked by uid 107); 17 Jan 2009 01:41:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 16 Jan 2009 20:41:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2009 20:40:57 -0500
Content-Disposition: inline
In-Reply-To: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106008>

On Fri, Jan 16, 2009 at 03:06:34PM +0000, Baz wrote:

> > At the beginning I tried to fulfil this limit, but often it's not easy.
> > So should it be adjusted to a slightly higher value in the documentation
> > or even split into a recommended limit (e.g. 50) and a recommended
> > absolute maximum (e.g. 76)? Hmm, the split wouldn't make sense, I think.
> 
> The 50 character limit is for the first line, try "git log
> --pretty=oneline" and it should be obvious why.

I'm not sure it makes sense to make a workflow recommendation that the
git project itself does not follow. Of 14590 non-merge commits in
git.git, 6940 (nearly 50%) have subject lines longer than 50
characters.

In practice, is this a problem for people using git.git?

Personally, I find --pretty=oneline unreadable because so much of the
screen real estate is wasted on random characters that I don't care
about. I find --pretty=tformat:'%h %s' much nicer (yes, --abbrev-commit
works, too, but I find the '...' a pointless waste of space).

For reference, here are the percentiles of subject lines in git.git
longer than X:

 X | %
50 | 48%
60 | 24%
65 | 14%
70 |  8%

So it seems that quite a large chunk are between 50 and 65 characters.
Which still leaves room for "Subject: " or 8 characters of hash at the
beginning.

> perl -ne '$lim = (50,0,72)[($.>3?3:$.)-1];

Ugh. Would a little whitespace have killed you? ;P

> (I wish I'd had something like this when one of the devs here pushed a
> commit with a 346-line message,
> just listing what files he was changing...doh)

Well, yes. That's just insane.

-Peff
