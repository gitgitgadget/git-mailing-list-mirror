From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Mon, 6 May 2013 19:22:42 -0400
Message-ID: <20130506232242.GA27393@sigill.intra.peff.net>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
 <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue May 07 01:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZUkD-0004u6-EI
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 01:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760867Ab3EFXWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 19:22:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:42367 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758701Ab3EFXWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 19:22:44 -0400
Received: (qmail 4143 invoked by uid 102); 6 May 2013 23:23:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 18:23:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 19:22:42 -0400
Content-Disposition: inline
In-Reply-To: <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223513>

On Tue, Jan 22, 2013 at 08:49:22AM +0100, Robin Rosenberg wrote:

> Specifically the fields uid, gid, ctime, ino and dev are set to zero
> by JGit. Other implementations, eg. Git in cygwin are allegedly also
> somewhat incompatible with Git For Windows and on *nix platforms
> the resolution of the timestamps may differ.

This is an old commit, but I noticed a bug today...

> This change introduces a core.checkstat config option where the
> [...]
> +core.checkstat::
> [...]
> +	if (!strcmp(var, "core.statinfo")) {

One of these is not like the others. I didn't prepare a patch, though,
because I wasn't sure which it was supposed to be. A documentation bug
or a code bug? :)

-Peff
