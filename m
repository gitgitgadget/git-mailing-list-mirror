From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/8] git-gc --auto: restructure the way "repack" command
 line is built.
Date: Mon, 17 Sep 2007 10:41:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171040070.28586@racer.site>
References: <11900186941912-git-send-email-gitster@pobox.com>
 <1190018713416-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD7i-0006k7-LD
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXIQJm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbXIQJm3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:42:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:55269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752582AbXIQJm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:42:28 -0400
Received: (qmail invoked by alias); 17 Sep 2007 09:42:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 17 Sep 2007 11:42:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LWroiSV1L6mM20G0+5cRoms9Jvnf6cowKlnMU9r
	8/5wgpkTl/uLul
X-X-Sender: gene099@racer.site
In-Reply-To: <1190018713416-git-send-email-gitster@pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58411>

Hi,

On Mon, 17 Sep 2007, Junio C Hamano wrote:

> @@ -154,8 +161,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		 * Auto-gc should be least intrusive as possible.
>  		 */
>  		prune = 0;
> -		for (i = 0; i < ARRAY_SIZE(argv_repack_auto); i++)
> -			argv_repack[i] = argv_repack_auto[i];
>  		if (!need_to_gc())
>  			return 0;
>  	}

This subtly changes behaviour: --auto ran also garbage collection for 
reflogs and rerere.

This might be intended, but is not documented.

Ciao,
Dscho
