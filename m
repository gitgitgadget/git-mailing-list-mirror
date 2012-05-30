From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] clone --local fixes
Date: Wed, 30 May 2012 07:08:19 -0400
Message-ID: <20120530110819.GB13445@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
 <7vsjemp20j.fsf@alter.siamese.dyndns.org>
 <20120528053602.GA11174@sigill.intra.peff.net>
 <7vhauy6fy3.fsf@alter.siamese.dyndns.org>
 <20120530110305.GA13445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 13:08:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZglQ-0000P0-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab2E3LIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:08:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36239
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab2E3LIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:08:23 -0400
Received: (qmail 3743 invoked by uid 107); 30 May 2012 11:08:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 07:08:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 07:08:19 -0400
Content-Disposition: inline
In-Reply-To: <20120530110305.GA13445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198798>

On Wed, May 30, 2012 at 07:03:05AM -0400, Jeff King wrote:

>   2. File URLs require absolute paths[1]. You can't do the equivalent of
>      "git clone --no-local foo.git" without resorting to $PWD.

I forgot to include my footnote, which was:

  You can actually do "git clone file://foo" and we will treat that as
  the path "foo". Which does not match the definition of the "file"
  scheme, which would interpret that as "host 'foo', no path", but does
  match what some other software does. However, if there _is_ a slash,
  then we correctly throw away the host bit, so that "file://junk/foo"
  _also_ points to the path "foo". Which means there is no equivalent
  for:

    git clone --no-local subdir/foo.git

-Peff
