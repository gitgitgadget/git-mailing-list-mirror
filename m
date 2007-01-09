From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Auto-quote config values in config.c:store_write_pair()
Date: Tue, 9 Jan 2007 11:29:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091128170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070109052741.GB27927@Hermes.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 11:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EEG-0000pf-CE
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbXAIK3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXAIK3L
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:29:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:46670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbXAIK3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:29:10 -0500
Received: (qmail invoked by alias); 09 Jan 2007 10:29:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 09 Jan 2007 11:29:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <20070109052741.GB27927@Hermes.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36341>

Hi,

On Tue, 9 Jan 2007, Brian Gernhardt wrote:

> +	if (quote)
> +		write(fd, "\"", 1);
>  	for (i = 0; value[i]; i++)
>  		switch (value[i]) {
>  		case '\n': write(fd, "\\n", 2); break;
> @@ -508,6 +520,8 @@ static void store_write_pair(int fd, const char* key, const char* value)
>  		case '"': case '\\': write(fd, "\\", 1);
>  		default: write(fd, value+i, 1);
>  	}
> +	if (quote)
> +		write(fd, "\"", 1);

AFAICS this misses the case where you have to quote a single '"'.

Ciao,
Dscho
