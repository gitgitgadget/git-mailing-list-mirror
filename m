From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/4] Makefile: keep MSVC and Cygwin configuration separate
Date: Wed, 04 Nov 2009 19:29:09 +0000
Message-ID: <4AF1D605.1020900@ramsay1.demon.co.uk>
References: <4AE74659.6020503@ramsay1.demon.co.uk> <4AEFDB6B.8010209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mNQ-0008NR-Ei
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbZKDUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbZKDUWS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:22:18 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:58995 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932299AbZKDUWR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 15:22:17 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N5mN3-0001Cn-lo; Wed, 04 Nov 2009 20:22:22 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AEFDB6B.8010209@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132142>

Johannes Sixt wrote:
> 
> I like the direction of this change, but I think that you must use ':='

Yeah, I've always been a bit sloppy with recursive assignment versus simple
assignment when the value does not contain a variable reference ;-)
So yes, you are right...

> assignment, and I would put this right after the uname_* assignments at
> the beginning of the Makefile:
> 
>  uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
> +ifdef MSVC
> +	uname_S := Windows
> +	uname_O := Windows	# avoid cygwin configuration
> +endif

OK with me. (but you are avoiding the MinGW configuration as well...)

ATB,
Ramsay Jones
