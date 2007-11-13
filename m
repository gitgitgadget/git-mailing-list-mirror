From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff woes
Date: Tue, 13 Nov 2007 01:03:50 +0100
Message-ID: <4738E9E6.2040001@op5.se>
References: <4738208D.1080003@op5.se>	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se> <7vhcjr2lte.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrjGE-0005Ss-3D
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 01:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbXKMADy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 19:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXKMADy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 19:03:54 -0500
Received: from mail.op5.se ([193.201.96.20]:56945 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbXKMADx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 19:03:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BE3581F08758;
	Tue, 13 Nov 2007 01:03:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSUtTVEeucpa; Tue, 13 Nov 2007 01:03:51 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 6F3431F08702;
	Tue, 13 Nov 2007 01:03:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vhcjr2lte.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64736>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> In the check_ntpd.c program, there is no bug. I found the git diff output
>> surprising, so I reported it.
> 
> This is what I get from "GNU diff -pu" which makes me surpried
> that anybody finds "git diff" hunk header surprising.  Notice
> that hunk at line 84.
> 
> --- read-cache.c	2007-11-12 12:08:00.000000000 -0800
> +++ read-cache.c+	2007-11-12 12:07:54.000000000 -0800
> @@ -60,7 +60,7 @@ static int ce_compare_data(struct cache_
>  	return match;
>  }
>  
> -static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
> +static int ce_compare_lonk(struct cache_entry *ce, size_t expected_size)
>  {
>  	int match = -1;
>  	char *target;
> @@ -84,7 +84,7 @@ static int ce_compare_link(struct cache_
>  		match = memcmp(buffer, target, size);
>  	free(buffer);
>  	free(target);
> -	return match;
> +	return match + 0;
>  }
>  
>  static int ce_compare_gitlink(struct cache_entry *ce)


I notice it, and I don't like it. I guess I'm just used to git being
smarter than their GNU tool equivalents, especially since it only ever
applies patches in full.

I have a patch ready to make it configurable but it lacks doc updates
and tests, so I'll send it tomorrow morning when I've had time to
fiddle a bit with that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
