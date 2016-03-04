From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9700: fix test for perl older than 5.14
Date: Fri, 4 Mar 2016 17:21:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603041720550.3152@virtualbox>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com> <20160304085649.GA29752@sigill.intra.peff.net> <1457089104.2660.79.camel@kaarsemaker.net> <20160304114321.GA569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 17:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1absUB-0000vd-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 17:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759867AbcCDQVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 11:21:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:56839 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759778AbcCDQVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 11:21:41 -0500
Received: from virtualbox ([89.204.153.216]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M8Nik-1Zh8zz3WE6-00vxHM; Fri, 04 Mar 2016 17:21:30
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160304114321.GA569@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:dVa2xY3jmV9ATDtAaxJZ1w3SQft+DWZKcWZmWAneMTZDCibrkCX
 LCEYvNK/0LQ1yFMd+sU94jK9i83qDiVpPiixjS6D5fNnsjWJ7wLxghTu//C5QLQNFu836yC
 0C4ZJURXbIMMI5RcWO+GazyHJAUx9Zp9uunMvcIVEhNEWBKD5+s/9OaWJhXyohxsUwbqP7o
 vDyb49EAYriQiJjMBW05A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zIQbQRaqAf0=:IgR5eCTxnFNB/FL386WhAM
 yfb3tgy5ADGxQnRZ/5f1+9tUkRDAj8OIaBuG+6wLEOW5Dcr159Hg+NS6WJFnIAn4ZpcWoc4R3
 CcFsxk2PbzEH1glo6+brCvwgbCCu1lLrCdofAJmUf1mcNpAL0pZtqDxVuRJSMmndvbEzHTdsf
 LKuicIWCzgAaKIFqbCvruKGc/HA8qZWCrh7hW6et7FMkV6EtDslK5JGFwgGOuFnLV999ouuUs
 xFhgG2OG1U6ZV910Ms3VITH46mTFcjZnlE3otkKo7hFg5SVnB3KvYtTD1dTr6jDHOqI9QoHgb
 XiSnpkYSJHXOTwBjtkYhGj6pxNZLDitb0F/6R6fKFNbKOJMlzpD0f8v5foJfQMU296tmDpmf3
 Gk9joCb03VDhE4SknH/EGwfXnn1gsGwR/mIwwtge27QXnGM9sSWDflYPCE7/mfDkPWLSphP/3
 sUQ6qinqoNqiFskXRwz33XEpwAF+5a+CajYrhaxB24bHBifRYPOAK+PBWg+eJ2SITTApC3UeW
 dG5GgnfqIXbaNFe3+zI9Yw6Om16OM6jgn7qMjBIo64tpn1INogZ7mBp9nC/KYJ2sZ+z+xwGv/
 UP2s6oZi9DgGbi37YRkodXSrRsbtmqTTMjZgEDbEjZHrt70mLIn71/oAYcLhKoeaG94/YXHAm
 xzy1bM6MFgODx3sMSedl44vX8B/B+Cm3V42z/VWQa8J7n1ZRHXV/fuedsihNrDGAufkXQWxc4
 Em/rKM4oQdefdchZ4UnzF45HbylBqKwkIMtfKzR6IMd1HQeYayQnTV3flK1rQeBE3DjtGVEH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288262>

Hi Peff,

On Fri, 4 Mar 2016, Jeff King wrote:

> Subject: t9700: fix test for perl older than 5.14
> 
> Commit d53c2c6 (mingw: fix t9700's assumption about
> directory separators, 2016-01-27) uses perl's "/r" regex
> modifier to do a non-destructive replacement on a string,
> leaving the original unmodified and returning the result.
> 
> This feature was introduced in perl 5.14, but systems with
> older perl are still common (e.g., CentOS 6.5 still has perl
> 5.10). Let's work around it by providing a helper function
> that does the same thing using older syntax.
> 
> While we're at it, let's switch to using an alternate regex
> separator, which is slightly more readable.

My apologies! And thanks for cleaning up after me.

Ciao,
Dscho
