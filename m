From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add --format that is a synonym to --pretty
Date: Tue, 24 Feb 2009 00:45:24 -0500
Message-ID: <20090224054524.GE4615@coredump.intra.peff.net>
References: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com> <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org> <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com> <7vljrxveqa.fsf@gitster.siamese.dyndns.org> <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com> <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com> <7v3ae4r53f.fsf@gitster.siamese.dyndns.org> <20090224130626.6117@nanako3.lavabit.com> <20090224045041.GA4615@coredump.intra.peff.net> <7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, felipe.contreras@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbq87-0004Fx-6g
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 06:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZBXFp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 00:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZBXFp2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 00:45:28 -0500
Received: from peff.net ([208.65.91.99]:56113 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbZBXFp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 00:45:28 -0500
Received: (qmail 11353 invoked by uid 107); 24 Feb 2009 05:45:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 00:45:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 00:45:24 -0500
Content-Disposition: inline
In-Reply-To: <7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111215>

On Mon, Feb 23, 2009 at 09:33:59PM -0800, Junio C Hamano wrote:

> I think the patch suffers from the same problem Felipe's patch had, by
> conflating two issues.  Because it had the ":some string with %" shorthand

Yes, I totally agree they are two separate issues, and it should be two
patches.

> If we split this round into two patches, one that makes --format a synonym
> to --pretty, and then another one that allows --{format,pretty}='%h %s',
> and *stop there*, then we wouldn't have difficulties.

Right, and I am OK with that. I just wanted to make sure we were not
painting ourselves into a corner for a "patch 3/2" that has been
discussed.

> I do not think --oneline is a bad idea, but I do not think we should
> explain it as "You can write anything that you can write after '--pretty='
> without 'pretty=' and they mean the same thing".  That's where your
> concern arises from.  You just say "'--pretty=oneline --abbrev-commit' is
> so often used, so we have a shorthand for the whole thing: --oneline",
> without implying anything about other things such as --short or --tformat.

OK. I think that is reasonable. Personally, I would really only care
about --oneline, anyway (and I do think a --pretty=%h shorthand should
use "tformat"; the extra typing is probably not a big deal if you are
doing a big multi-line format).

-Peff
