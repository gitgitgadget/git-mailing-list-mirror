From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/5] p7300: add performance tests for clean
Date: Tue, 28 Apr 2015 02:33:11 -0400
Message-ID: <20150428063311.GN24580@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-5-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 08:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymz55-0007CM-FD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 08:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbbD1GdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 02:33:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751889AbbD1GdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 02:33:14 -0400
Received: (qmail 20923 invoked by uid 102); 28 Apr 2015 06:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:33:14 -0500
Received: (qmail 12128 invoked by uid 107); 28 Apr 2015 06:33:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 02:33:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 02:33:11 -0400
Content-Disposition: inline
In-Reply-To: <1430030985-14499-5-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267905>

On Sun, Apr 26, 2015 at 08:49:44AM +0200, Erik Elfstr=C3=B6m wrote:

> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
> new file mode 100755
> index 0000000..6ae55ec
> --- /dev/null
> +++ b/t/perf/p7300-clean.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description=3D"Test git-clean performance"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo

Do we actually need a large repo here? The real cost is coming from the
directories we create. We could actually start with a totally empty
repository if we wanted (though I don't think the t/perf system handles
that right now). But if there's not a reason to use the large repo, I
think using test_perf_default_repo is better, as it works out of the bo=
x
without specifying extra environment variables (well, it works either
way, but you get a nasty warning from perf-lib.sh).

-Peff
