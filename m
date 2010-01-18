From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Sun, 17 Jan 2010 20:51:40 -0500
Message-ID: <20100118015140.GB6831@coredump.intra.peff.net>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 02:51:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWgma-0002lR-2j
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 02:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0ARBvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 20:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463Ab0ARBvp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 20:51:45 -0500
Received: from peff.net ([208.65.91.99]:58721 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab0ARBvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 20:51:44 -0500
Received: (qmail 31835 invoked by uid 107); 18 Jan 2010 01:56:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 20:56:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 20:51:40 -0500
Content-Disposition: inline
In-Reply-To: <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137356>

On Fri, Jan 15, 2010 at 08:15:49PM -0800, Junio C Hamano wrote:

> Realistically, this most often is used when grepping in the log, e.g.
> 
>     git log --all-match --author=peff --grep=test
> 
> I actually wish "log" to somehow default to --all-match mode at least when
> using the --author option.  "Change by Jeff, or about test by anybody" is
> rarely what I would want to look for.

Agreed. That is the most common log grep pattern for me (author + grep),
and I always want all-match. I see from later in the thread, though,
that implementing it is not as straightforward as we might hope.

I would personally be fine with "--all-match" being the default, but
that may be too big a change in behavior for some people to swallow (I
would also be fine with log.allmatch in the config, but every time I
suggest something like that people's heads explode and I get told to
make an alias).

-Peff
