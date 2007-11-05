From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Mon, 5 Nov 2007 23:18:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711052317170.4362@racer.site>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
 <1194017589-4669-2-git-send-email-krh@redhat.com>
 <1194017589-4669-3-git-send-email-krh@redhat.com>
 <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet>
 <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBER-0004YA-AX
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925AbXKEXTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbXKEXTa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:19:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:44672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755786AbXKEXT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:19:29 -0500
Received: (qmail invoked by alias); 05 Nov 2007 23:19:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 06 Nov 2007 00:19:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iGZx8KhRiCVFQTxdL4x07tNcszGswUJHdqf5l8h
	4krEqDidvL5h1K
X-X-Sender: gene099@racer.site
In-Reply-To: <20071105192347.GA29997@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63584>

Hi,

On Mon, 5 Nov 2007, Bj?rn Steinbrink wrote:

> On 2007.11.05 13:57:53 -0500, Kristian H?gsberg wrote:
>
> > The shell script just has
> > 
> > case "$all,$interactive,$also,$#" in
> > *t,*t,*)
> >         die "Cannot use -a, --interactive or -i at the same time." ;;
> > 
> > which doesn't seem to care about the value of $also.  As far as I 
> > understand git commit, it doesn't make sense to pass any of -a, -i, -o 
> > or --interactive at the same time so I guess I could join the checks
> 
> Note that there are only two commas. The asterisks catch everything and
> $# won't be "t", so that catches anything with at least two t's.

So shouldn't it be

	if (!!all + !!interactive + !!also > 1)

Hmm?

Ciao,
Dscho
