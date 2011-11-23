From: Jeff King <peff@peff.net>
Subject: Re: git not resuming push
Date: Wed, 23 Nov 2011 00:02:20 -0500
Message-ID: <20111123050220.GA9127@sigill.intra.peff.net>
References: <4ECC6F80.6010907@piem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Brossier <piem@piem.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 06:02:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT4yh-000689-33
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 06:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab1KWFCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 00:02:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49212
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab1KWFCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 00:02:22 -0500
Received: (qmail 976 invoked by uid 107); 23 Nov 2011 05:02:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 00:02:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 00:02:20 -0500
Content-Disposition: inline
In-Reply-To: <4ECC6F80.6010907@piem.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185819>

On Tue, Nov 22, 2011 at 08:58:56PM -0700, Paul Brossier wrote:

> If the connection fails after uploading part of the data, it seems I
> need to start over from zero again. Is there a way to resume the upload
> instead?

No, there isn't a way to resume just using push.

If you have shell access on the server, one workaround you can do is to
create a bundle with the commits in question, upload it via some
resumable protocol (like sftp, http, rsync, etc), possibly taking many
attempts, and then fetch the result on the server side from the bundle
into the repository.

See "git help bundle" for some examples.

-Peff
