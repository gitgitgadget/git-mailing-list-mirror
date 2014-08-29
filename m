From: Jeff King <peff@peff.net>
Subject: Re: git fsck exit code?
Date: Fri, 29 Aug 2014 14:53:25 -0400
Message-ID: <20140829185325.GC29456@peff.net>
References: <1409177412.15185.3.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRIh-0003u8-DF
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbaH2Sx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:53:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:33339 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753199AbaH2Sx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:53:27 -0400
Received: (qmail 30490 invoked by uid 102); 29 Aug 2014 18:53:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 13:53:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 14:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1409177412.15185.3.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256177>

On Wed, Aug 27, 2014 at 06:10:12PM -0400, David Turner wrote:

> It looks like git fsck exits with 0 status even if there are some
> errors. The only case where there's a non-zero exit code is if
> verify_pack reports errors -- but not e.g. fsck_object_dir.

It will also bail non-zero with _certain_ tree errors that cause git to
die() rather than fscking more completely.

> Is that really the intended behavior?  I think it would be nice to at
> least support --exit-code (but probably a sensible exit code ought to be
> the default).

I don't know that the current behavior is really intended. I agree that
I would expect a non-zero exit code if there are errors. Fsck also has
some warnings. I do not know what those should produce (I'd think a zero
exit normally, and some option like -Werror to turn them into errors).

-Peff
