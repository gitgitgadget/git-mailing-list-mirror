From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 05 Oct 2007 11:24:01 +0200
Message-ID: <470602B1.8090706@viscovery.net>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 11:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdjQ4-0003AT-U0
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 11:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbXJEJYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 05:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbXJEJYG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 05:24:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4086 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045AbXJEJYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 05:24:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IdjPa-0001Vv-EB; Fri, 05 Oct 2007 11:23:58 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 73DEDB662; Fri,  5 Oct 2007 11:24:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071005085522.32EFF1E16E@madism.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60059>

Pierre Habouzit schrieb:
> @@ -281,20 +283,19 @@ static int apply_filter(const char *path, const char *src, size_t len,
>  		ret = 0;
>  	}
>  	if (close(pipe_feed[0])) {
> -		ret = error("read from external filter %s failed", cmd);
> +		error("read from external filter %s failed", cmd);
>  		ret = 0;
>  	}
>  	status = finish_command(&child_process);
>  	if (status) {
> -		ret = error("external filter %s failed %d", cmd, -status);
> +		error("external filter %s failed %d", cmd, -status);
>  		ret = 0;
>  	}

If you want to, you can leave away these cosmetical corrections since I'm 
working on a patch that replaces this entire passus. (Will be needed for the 
MinGW port).

-- Hannes
