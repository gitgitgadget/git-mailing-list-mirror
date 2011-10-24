From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Mon, 24 Oct 2011 15:39:47 -0700
Message-ID: <20111024223947.GA10481@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <1319472131-3968-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 00:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RITBV-0006TP-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 00:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1JXWjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 18:39:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55682
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab1JXWjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 18:39:51 -0400
Received: (qmail 9956 invoked by uid 107); 24 Oct 2011 22:45:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Oct 2011 18:45:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2011 15:39:47 -0700
Content-Disposition: inline
In-Reply-To: <1319472131-3968-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184188>

On Mon, Oct 24, 2011 at 06:02:11PM +0200, Erik Faye-Lund wrote:

> The POSIX-function fork is not supported on Windows. Use our
> start_command API instead.
> 
> As this is the last call-site that depends on the fork-stub in
> compat/mingw.h, remove that as well.
> 
> Add an undocumented flag to git-archive that tells it that the
> action originated from a remote, so features can be disabled.
> Thanks to Jeff King for work on this part.
> 
> Remove the NOT_MINGW-prereq for t5000, as git-archive --remote
> now works.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> ---

As with other versions of this series, I have no comment on the mingw
bits. The archive.c parts still look sane to me. :)

-Peff
