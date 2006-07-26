From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] git-instaweb: Fall back to Apache when LigHTTP was
 not found
Date: Wed, 26 Jul 2006 21:57:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262153380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261633560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr708qih4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 21:57:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5pVT-0006zG-Ni
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWGZT5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWGZT5V
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:57:21 -0400
Received: from mail.gmx.de ([213.165.64.21]:64927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751765AbWGZT5U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 15:57:20 -0400
Received: (qmail invoked by alias); 26 Jul 2006 19:57:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 26 Jul 2006 21:57:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr708qih4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24243>

Hi,

On Wed, 26 Jul 2006, Junio C Hamano wrote:

> Please don't use "which" in scripts.  Consult this thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/23382/focus=23394

I remembered vaguely, so I searched in git-instaweb:

$ git grep -n which next:git-instaweb.sh
next:git-instaweb.sh:40: [white space...] which $httpd_only >/dev/null

Well, the fallback mechanism might not be that useful anyway: if you have 
apache, you have to specify the modules path. I'll do a patch instead 
which exits cleanly if either $httpd or $browser could not be executed, 
okay?

Ciao,
Dscho
