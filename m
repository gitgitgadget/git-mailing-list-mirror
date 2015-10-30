From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 20:14:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510302013340.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <20151026191724.GE7881@google.com> <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info> <xmqqlhakky0e.fsf@gitster.mtv.corp.google.com> <20151030190256.GI7881@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:14:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsF7t-0000rd-SS
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760386AbbJ3TOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:14:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:54659 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758433AbbJ3TOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:14:08 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Metpl-1a7K3m3jVx-00OYIC;
 Fri, 30 Oct 2015 20:14:03 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151030190256.GI7881@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:g4zJ6ymkrDZvCm+2VaECnk5ooa+pP9tpkzWnB52TItgzjtnLPsn
 71KOVCTQBslOxr9v2uxNTdixMxxjJ2ea5xwtDNFvtD4XGMZucqX3VobekxlDIRlskcYfqWc
 DNjD9mSZCeslmR2qNGQ7yjHHtlBtBFCZJcW98LgCoTID4ormZaCQ5JfbuCRP6vu/YATx4qk
 vfqJnClIwuWWKB7Hhp0Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eLZB67sNOh0=:pVpXEvobpnfsBIduG3YrB0
 +yxXFioTVHBfaKjbjTWB2VO3deA+ljgWlci0Oa50oDVOSIcGezKuNmMIw5IOEm1afNSYfjxyu
 fo2rw/4v+Q4gnHd1u1Wavik4+wCmeBZ2UNwjtOjNmBy9sMgNQrUlDXzUh00BE9Xk0qB09WDeJ
 cPrwnb35+GZyvPdjTrJBwQaHvI7R8pN914eZOtIJN8wrQpx15ZLDHbhhjqppfWtdmF4AtbAF3
 0wrE/xD2wqm/SLPx7x8T+kkOXMomtGCvID7O343yCfl/IbXPuR6XW5EV3CjE6nllVVEZWr81B
 js9ijWki+SejYBg6kGF6npOvwt8txOeV1zJ73z2dNN/9tU1tgB4EHOpWGzhs+pbuiU1DOA0lb
 CcsU7Brpfxwow8UWV0/eSDUhdbtHe/aKhBhqvFtJoI9v6befu9MF+VY/Lp1dOnIf7z473uNQd
 2JWdywdoopqB1/SVWIC5gS6xwSo9i+pWbrUh8KSU+D7QEqvk17M8OPmyV5Drqy41PYamnLBUJ
 I/kmjOaHDxhasikzUCzaU4FiOj7KxlBmTgeoTAitzHV87lGmfCBbABBzxDufG1ZleQcGQvEJk
 tyogR27zwhe4SS9mGaEozrGEUs9AeoDDdKZIU80A0mJ2aMmVZblVkyIYJez31YexFeMXR7lQU
 S7+rVpjwAqFURGrMy4xDBshxeJyA33x8WsL4AirzryUcqw3mX7j3jbXzBYgRCpK0fRoLE//wd
 bkPgODaT4j2+ia5DwAo40HzehUSIUV92Fwv8DtFdFj6Yi7S4fMD79C0lVgYmLPfAD6caDmlM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280526>

Hi Jonathan,

On Fri, 30 Oct 2015, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> On Tue, 27 Oct 2015, Junio C Hamano wrote:
> 
> >>> It can be called GDB=1, perhaps?
> >>
> >> No, this is way too generic. As I only test that the environment
> >> variable's existence, even something like GDB=/usr/opt/gdb/bin/gdb would
> >> trigger it.
> >>
> >> I could be talked into GDB_GIT=1, though.
> >
> > As I said in another message, I have no preference myself over the
> > name of this variable (or making it a shell function like Duy
> > mentioned, which incidentally may give us more visual pleasantness
> > by losing '=').
> >
> > I'd just be happy as long as the feature becomes available, and I'd
> > leave the choice of consistent and convenient naming to others who
> > have stronger opinions ;-)
> 
> Here's a suggested patch.

I am fine with this patch as a replacement for my original version.

Thanks,
Dscho
