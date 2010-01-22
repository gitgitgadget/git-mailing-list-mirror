From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem
 generator
Date: Fri, 22 Jan 2010 19:40:42 +0000
Message-ID: <4B59FF3A.5080502@ramsay1.demon.co.uk>
References: <4B575838.2010504@ramsay1.demon.co.uk> <4B5789AD.2080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPla-0004AQ-Vr
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab0AVUFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 15:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503Ab0AVUFz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:05:55 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:58803 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753487Ab0AVUFx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:05:53 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NYPlQ-0003XY-f6; Fri, 22 Jan 2010 20:05:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4B5789AD.2080807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137781>

Sebastian Schuberth wrote:
> On 20.01.2010 20:23, Ramsay Jones wrote:
> 
>  > '-o' or connective. This resulted in the buildsystem generator
>  > mistaking the conditional 'rm' for a linker command. In order
> 
> Thanks for spotting the cause of this! Some comments:
> 
> 1. How about deleting lines 183-185 in same run? That commented out 
> code, too, is missing the escapes for the pipes that Pete mentioned anyway.
> 
> -#        } elsif ($text =~ /^test / && $text =~ /|| rm -f /) {
> -#            # commands removing executables, if they exist
> -#

OK, will do.

> 
> 2. Couldn't we reduce the test to just
> 
> +        if ($text =~ /^test /) {
> +            # options to test may be mistaken for linker options
> +            next;
> +        }
> +

Yes, good idea.  I will send a new version of the patch soon.

Thanks!

ATB,
Ramsay Jones
