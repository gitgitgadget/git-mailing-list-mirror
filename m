From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix clone not to ignore depth when performing a local
 clone
Date: Tue, 11 Dec 2007 11:54:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712111154070.27959@racer.site>
References: <20071211064731.GA30525@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 12:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J23ic-0008FL-4O
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 12:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbXLKLzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 06:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXLKLzs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 06:55:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:35547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751615AbXLKLzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 06:55:47 -0500
Received: (qmail invoked by alias); 11 Dec 2007 11:55:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp052) with SMTP; 11 Dec 2007 12:55:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zW35uVK4z70fi9e5DhB1wiQeqtd1PtNDJR5f1Qs
	vXkheijWnnG5+o
X-X-Sender: gene099@racer.site
In-Reply-To: <20071211064731.GA30525@hashpling.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67840>

Hi,

On Tue, 11 Dec 2007, Charles Bailey wrote:

> @@ -205,7 +205,10 @@ fi
>  # it is local
>  if base=$(get_repo_base "$repo"); then
>  	repo="$base"
> -	local=yes
> +	if test -z "$depth"
> +	then
> +		local=yes
> +	fi
>  fi

Or shorter:

-	local=yes
+	test -z "$depth" && local=yes

Ciao,
Dscho
