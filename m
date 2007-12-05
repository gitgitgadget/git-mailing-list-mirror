From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re:* [BUG] "git clean" does not pay attention to its parameters
Date: Wed, 5 Dec 2007 09:49:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712050947370.27959@racer.site>
References: <200712050654.lB56scKk000311@mi0.bluebottle.com>
 <7veje1zibm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@bluebottle.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 10:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izqts-0002eQ-8R
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 10:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXLEJuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXLEJuR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 04:50:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:44015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbXLEJuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 04:50:16 -0500
Received: (qmail invoked by alias); 05 Dec 2007 09:50:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 05 Dec 2007 10:50:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R5lp8rZCRYuKbxxr3mLyp8jRU6CNbXvEwA5U70Q
	YCrtPZuv8doWn1
X-X-Sender: gene099@racer.site
In-Reply-To: <7veje1zibm.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67129>

Hi,

On Tue, 4 Dec 2007, Junio C Hamano wrote:

> @@ -85,12 +86,17 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	read_directory(&dir, path, base, baselen, pathspec);
>  	strbuf_init(&directory, 0);
>  
> -	for (j = 0; j < dir.nr; ++j) {
> -		struct dir_entry *ent = dir.entries[j];
> -		int len, pos, specs;
> +	if (pathspec) {
> +		for (i = 0; pathspec[i]; i++)
> +			; /* nothing */
> +		seen = xmalloc();

Did you mean xmalloc(i)?

Ciao,
Dscho
