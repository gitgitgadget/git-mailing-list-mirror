From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Tue, 19 Jan 2016 12:05:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601191041260.2964@virtualbox>
References: <20160114202608.GA8806@sigill.intra.peff.net> <alpine.DEB.2.20.1601150743590.2964@virtualbox> <20160115183010.GA10431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 12:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLU7D-0007CT-6c
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 12:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbcASLGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 06:06:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:62693 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbcASLGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 06:06:18 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ln8Tl-1Zeyka3XoL-00hN8s; Tue, 19 Jan 2016 12:05:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160115183010.GA10431@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ZRbHEjGy3iDD1bifrIHBl1Z2P9sCuqymphFCGW009uGGjfWJXmd
 HKBM4c6tei1qbat90jAMRg1geeidCKfNYa+MCkAuw6zitnzIsPIzyEPn7IVOHODkbi2dMgG
 q3+borbNKz5S0LW9ZW/fd6CoZQ5di2N8PbzOFoBtqnOfR12meVHgSia3Pm4VySnfliU9ZVY
 kjNocMWZtsIJiDNFS6yOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:39OJkteDOec=:D0+TuAKJ3GrYkQucZav8j1
 NfoYEvJ/yWPbc9klqb4LufA3ziIHu21Xmy3NLhEpGnxnmrzrcthLNYhzJDlP+slYY2aGGTSgD
 hdVnUp94PjQvDqjfpU9M0pM6xdoeAex2xFIkxhN1PjckcvIsoIhaKzvZBxLPy7kS6kqnGo5K1
 MBN7WEar+KiYyi1TdZ8gdaNTejJ2nT+MiQLyIZCF1rAOEPw5qTk8LAUSkRVW7NG+6+gDREZP1
 sfszt+tObnLwu2E5nSRL0a+3t8y1rUHnziJOk9M2dHEfFMWPp5EYswpL3K8ERiDkmNSqlV0Kc
 G5UVsI8Sne5ZhhxQam26O63ovuQ9CAB1eJKbQVp+xtDMAp4KEK7VLpS2IbH2PYq6oYOmCpX1l
 +kO+ubMMdk/HQMhdHW930sUXPHoJUqGg6zNEocORnjcDnpivLoIwt1hYP4oMWXSGMqi0CjGQV
 IwKcNRPfNyCexq4OdOPAjgBigAunKSIkWqY2x9g9VzpKnnV5WzN62bmnZhpoJTdjz+Soaxiu4
 Pck+Egi2zz5iGSJsfuI6sULTJtc2cMzQJ+m6U8W21pOw5X7m9S7Xrj27XndxnoIaxKvI51WzP
 QjC2kb3fcgtfpqCAkTXiOuIQCqYkIJguwAI+CShl9ca2za1frh0nB0C1NyKbZr1Axm35pmv5a
 dQG9z7cdLEkrLT5xcEO3I5xKGqLMhvMSxvGUNu3t/YXimiCtWsm2FmNVy+pAUrWFfE4qNev4X
 MUOkazctVoSQ4s24FwrHYZXWL3k5qFPPj4NEIal+akWT6oCUbOoVdnPwXRXLRXrvRfwbgkUW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284354>

Hi Peff,

On Fri, 15 Jan 2016, Jeff King wrote:

> On Fri, Jan 15, 2016 at 07:45:16AM +0100, Johannes Schindelin wrote:
> 
> > > This sort-of applies on top of js/dirname-basename, which is in next.
> > > Textually, it's fine, but that topic is based on v2.6.5, and xsnprintf
> > > was only added in the v2.7.0 cycle. The simplest thing is probably to
> > > wait for it to graduate to master, and then apply there as a new topic
> > > (if we do v2.6.6, it's OK for it not to have this patch).
> > > 
> > > I can hold and resend in a week or two if that's easier.
> > 
> > If you have a patch to make dirname/basename safer based on xsnprintf, I
> > would like to have that as soon as possible (next was rewound to 2.7.0,
> > no?)...
> 
> I'm not sure what you mean. `dirname/basename` themselves don't have any
> problems. It's only the `strcpy` in the test program that I wanted to
> fix.
> 
> If Junio wants to rebase js/dirname-basename on a more recent tip (say,
> current "master") as part of the rewind, this could be applied directly
> (or just squashed in).

My bad... I misunderstood which code was affected.

Sorry for the noise,
Dscho
