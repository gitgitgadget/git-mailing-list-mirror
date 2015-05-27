From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 10/11] t5544: add a test case for the new protocol
Date: Wed, 27 May 2015 03:12:15 -0400
Message-ID: <20150527071214.GA6898@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVVr-00047v-RO
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbbE0HMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:12:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:36524 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbbE0HMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:12:17 -0400
Received: (qmail 919 invoked by uid 102); 27 May 2015 07:12:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:12:17 -0500
Received: (qmail 5193 invoked by uid 107); 27 May 2015 07:12:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:12:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:12:15 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-11-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270032>

On Tue, May 26, 2015 at 03:01:14PM -0700, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t5544-fetch-2.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100755 t/t5544-fetch-2.sh

Obviously we are not there yet, but a fun test will be to globally bump
the transport version to "2" and try to run the test suite.

We will also want to test interoperation between v1 and v2. Though the
_best_ test of that is not hitting a v2 server configured for v1, but
hitting an actual older version of git. Which is outside the scope of
the current test suite, as it always operates on a single version.

It might be nice to have a separate test suite for doing
interoperability, that knows how to build various versions (there's
already some prior art in t/perf). I know this isn't the first time this
concept has come up.

-Peff
