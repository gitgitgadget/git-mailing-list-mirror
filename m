From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 18:07:53 +0200
Message-ID: <201110251807.53893.trast@student.ethz.ch>
References: <20111024201153.GA1647@x4.trippels.de> <87y5w9ayoa.fsf@rho.meyering.net> <201110251800.28054.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:08:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjXm-0007v3-C6
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab1JYQH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 12:07:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25035 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756609Ab1JYQH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 12:07:56 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 18:07:54 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 18:07:54 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <201110251800.28054.trast@student.ethz.ch>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184216>

Thomas Rast wrote:
> Jim Meyering wrote:
> > Thomas Rast wrote:
> > > [GCC moves access to a file-static variable across pthread_mutex_lock()]
> > 
> > Thanks for the investigation.
> > Actually, isn't gcc -O2's code-motion justified?
> > While we *know* that those globals may be modified asynchronously,
> > builtin/grep.c forgot to tell gcc about that.
> 
> I'm somewhat unwilling to believe that:
> 
> * "volatile" enforces three unrelated things, see e.g. [1].

Argh, forgot my reference:
[1] http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2006/n2016.html
    section "Existing portable uses"

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
