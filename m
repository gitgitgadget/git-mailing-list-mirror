From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: report errors if reflog entries point at
 invalid objects
Date: Mon, 08 Jun 2015 09:27:09 -0500
Organization: gmx
Message-ID: <e9d2f8cc371aa41e5d9095abd3cb7edb@www.dscho.org>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
 <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:27:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1y1T-0001ht-F8
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 16:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbFHO11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 10:27:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:63427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbbFHO1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 10:27:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M2tKM-1ZIwR71cwg-00sf9U; Mon, 08 Jun 2015 16:27:11
 +0200
In-Reply-To: <2ba9ee48a062b049c8b64fed4caba32c42f03031.1433769878.git.mhagger@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9m5exghDyZrnTNtllIt3buOTNNjGxLL/zbJiVR8Mr1t5K+lJ5al
 9WB31DngIvpU3Hlnb5WHHHwM6Zlet0ANlbcGiD7QtLYinNSzWrDZ0lpYDsF8+f3vWHTLa9k
 2ys4lyHrgMB0/mZyRKvq2edgsZH9XuruyGMpWtUpABhE82JIVuIgtM7dUp9+sV6EyfqF+zE
 PhmhzH7LSSteTqsaVOA0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M9WP9UKJVws=:WUqPSaTccyevLBWdyINYy2
 NcXchuP2u2n1UGnni7W+qMMaeUcNWY+YV28yWTq+Ij3K2pxnDn0IeKnqnE7nR8yjP3C6OTMSs
 bK+oT8QiXXkq0z/Zo23Ziu6VPAvbTydUcrPW0O8rGXUQ23juNpK/zKUPoE95Ax9g//U4KkkzU
 W4rGJ/v4+FiKFTHgxluwgijBwurbQwoa1ZH7Hcwyb9dgseb1JuGJ6/qPN4SezrzbNY4SmBj0X
 AsGSPPYO1EHl7gbLtc7Dsn4dLUZEeDavZfdYC1KnVm87guKtiCyEbEL7/1a9j6YLvHJS40dd6
 1z80U7QnPxgwAf9METSm/NRE1lQ1V8HAFODV9oFT76Ekuu7FVvKSx6iP3KmD85nrGm1gSTjIH
 DYcqSaOD3f6NRmj6z2e86Gz/SJPYwyolHNNygnxtHv2/bBxAsrkYFwH3mK/BjtvQkgpKqaBZt
 Qj5J0zbxnxmCPGcCFBevM+lLApwdn48YQiBG0aEm88FZBrQKJU8P1OQvLuwHtqcBscbaYn4SX
 1I2/sAXhxxlWc0Y6tBKNuhvzS8XwM5BBtlJbjBkF5rqE3DAm6xQiGmg/tnRmQ1C1foDI03Nkr
 HB2OAj2FwLk/hV5nKgqQmEkhaSy5j0dUJW88n8bLiPB9H5/oNoLHAoejRsCvr7tpnPq5voeeD
 MAZrWC1dII7cDef8atcgQHtGNsWIfHUbG8dedQ6BLhw3/IIX+1MKlmC5xfW1KN+ZIkzQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271035>

Hi Michael,

On 2015-06-08 08:40, Michael Haggerty wrote:
> Previously, if a reflog entry's old or new SHA-1 was not resolvable to
> an object, that SHA-1 was silently ignored. Instead, report such cases
> as errors.

I like the idea, but I am a bit uncertain whether it would constitute "too backwards-incompatible" a change to make this an error. I think it could be argued both ways: it *is* an improvement, but it could also possibly disrupt scripts that work pretty nicely at the moment.

My fsck-api branch will help with this, of course, as users whose scripts break could be (temporarily) demote the error to a warning. I planned to work on it this week and would be happy to rebase it onto this here patch series.

Ciao,
Dscho
