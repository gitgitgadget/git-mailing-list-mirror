From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 20:48:15 -0400
Message-ID: <20081025004815.GA23851@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <7v3ail3dfy.fsf@gitster.siamese.dyndns.org> <20081024225001.GA13978@coredump.intra.peff.net> <20081024225605.GA16774@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:49:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXLQ-0002qZ-CR
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYJYAsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYJYAsS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:48:18 -0400
Received: from peff.net ([208.65.91.99]:1418 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYJYAsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:48:18 -0400
Received: (qmail 25712 invoked by uid 111); 25 Oct 2008 00:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:48:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:48:15 -0400
Content-Disposition: inline
In-Reply-To: <20081024225605.GA16774@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99084>

On Fri, Oct 24, 2008 at 06:56:05PM -0400, Jeff King wrote:

> Ah, I see. It looks like we would have to munge fill_blob_sha1 in
> builtin-blame.c. In which case totally splitting this out from
> diff_filespec is even better, since we don't have one there.
> 
> So let me try to re-roll my series based on your suggestion, and then
> I'll see if I can add "blame --textconv" on top.

Actually, the blame thing is a little trickier than that. The textconv
stuff is still tied to a diff_filespec because it uses the diff
prepare_temp_file interface. So I will have to work around that if I
want to add blame support.

However, I re-did the existing patches according to your suggestions,
and I think the result is pretty reasonable. Six patches to follow.

-Peff
