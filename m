From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix a comparison bug in diff-delta.c
Date: Wed, 23 Aug 2006 15:45:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608231542380.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1156324675415-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 15:45:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFt2h-0004w3-5B
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 15:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWHWNpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 09:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHWNpI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 09:45:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:44453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932079AbWHWNpG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 09:45:06 -0400
Received: (qmail invoked by alias); 23 Aug 2006 13:45:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 23 Aug 2006 15:45:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <1156324675415-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25917>

Hi,

On Wed, 23 Aug 2006, Pierre Habouzit wrote:

> -	for (i = 4; (1 << i) < hsize && i < 31; i++);
> +	for (i = 4; (1u << i) < hsize && i < 31; i++);

The variable i never takes on the value 31 (or any higher value), so there 
is no bug here. Unless you port git to a system where an int has less than 
32 bit.

Ciao,
Dscho
