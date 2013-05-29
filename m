From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Thu, 30 May 2013 00:44:52 +0100
Message-ID: <51A692F4.5080805@ramsay1.demon.co.uk>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 01:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhqH4-0008WS-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 01:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967263Ab3E2X7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 19:59:19 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41732 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967257Ab3E2X7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 19:59:17 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id EA471384081;
	Thu, 30 May 2013 00:59:15 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 54F65384080;
	Thu, 30 May 2013 00:59:15 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 30 May 2013 00:59:14 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225900>

Junio C Hamano wrote:
> 
> * rj/mingw-compat-st-mode-bits (2013-05-28) 1 commit
>  - path: Fix a sparse warning
> 
>  Will merge to 'next'.

Hmm, this breaks the build on cygwin. :(

Now, I always test my patches on Linux, cygwin and MinGW
before sending, ... except that I obviously didn't test
on cygwin this time - it doesn't even compile. *ahem*

The extern declaration for get_st_mode_bits() must come
*before* including compat/cygwin.h; otherwise it will
get mangled by the macro in that header file.

Sorry for breaking the build.

A v3 patch is on it's way. (I'm liking the v1 patch more now ;-)

ATB,
Ramsay Jones
