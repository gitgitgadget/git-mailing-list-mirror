From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] format-patch: introduce option to suppress commit
 hashes
Date: Mon, 14 Dec 2015 16:32:39 -0500
Message-ID: <20151214213239.GH14788@sigill.intra.peff.net>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ajf-0008OK-4T
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbbLNVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:32:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:41541 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753549AbbLNVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:32:42 -0500
Received: (qmail 20309 invoked by uid 102); 14 Dec 2015 21:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:32:42 -0600
Received: (qmail 32019 invoked by uid 107); 14 Dec 2015 21:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:32:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:32:39 -0500
Content-Disposition: inline
In-Reply-To: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282423>

On Sun, Dec 13, 2015 at 05:27:15PM +0000, brian m. carlson wrote:

> git format-patch is often used to create patches that are then stored in
> version control or displayed with diff.  Having the commit hash in the
> "From " line usually just creates diff noise in these cases, so this
> series introduces --zero-commit to set that to all zeros.
> 
> Changes from v1:
> * Rename the option --zero-commit.
> * Improve the tests to look for a 40-hex hash value in "From " header.
> 
> brian m. carlson (3):
>   Introduce a null_oid constant.
>   format-patch: add an option to suppress commit hash
>   format-patch: check that header line has expected format

The intent here makes sense to me, and with the exception of the
test_line_count thing that Torsten mentioned, the code looks good.

I briefly wondered if the option should simply be "--diffable" or
something like that, and trigger this new behavior as well as implying
--no-signature. Along with any other relevant options (if any; I don't
recall if --stat-width is terminal-dependent for format-patch, for
example).

But that is probably overkill. People can flip those switches
individually if they want to (and even if somebody did want
"--diffable", it may make sense to build it on top, so they can flip the
zero-commit thing individually if they want).

-Peff
