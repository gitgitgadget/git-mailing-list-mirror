From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Tue, 6 Nov 2007 23:36:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062335150.4362@racer.site>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
 <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
 <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org>
 <4730EB4E.4080903@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2033686691-1194392143=:4362"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXzX-0008Kj-VL
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbXKFXhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbXKFXhl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:37:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:44984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754226AbXKFXhk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:37:40 -0500
Received: (qmail invoked by alias); 06 Nov 2007 23:37:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 07 Nov 2007 00:37:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FPeIECeuFZUYAwo/owFBs2+K3RmZFgUba6ehZMk
	28oA6SF84rHWtw
X-X-Sender: gene099@racer.site
In-Reply-To: <4730EB4E.4080903@lsrfire.ath.cx>
Content-ID: <Pine.LNX.4.64.0711062336240.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63750>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2033686691-1194392143=:4362
Content-Type: TEXT/PLAIN; CHARSET=utf-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0711062336241.4362@racer.site>

Hi,

On Tue, 6 Nov 2007, René Scharfe wrote:

> -char *interp_find_active(const char *orig,
> -		const struct interp *interps, int ninterps)
> +void interp_find_active(const char *orig, struct interp *interps, int ninterps)
>  {
> -	char *result = xcalloc(1, ninterps);
>  	char c;
>  	int i;
>  
> +	for (i = 0; i < ninterps; i++)
> +		interps[i].active = 0;
> +
> [...]

Funny.

I have the _exact_ same change in my repository.  I only forgot to send 
it, it seems.

Ciao,
Dscho

--8323584-2033686691-1194392143=:4362--
