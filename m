X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] git-fetch: allow glob pattern in refspec
Date: Thu, 23 Nov 2006 08:55:02 +0000
Message-ID: <200611230855.04124.andyparkins@gmail.com>
References: <7vzmaik4mi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 08:55:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VrSp1JlWunWg7kiBTVufd+YNO0j587jwLXhYF+eqd5KvClMde1xIVSkfxG5qgfZl3rmBFvNE8uIHGaILq9OvkaeS2JC5t1ji8PGl1QtOSiL+msr96B2au2fjXthTMkMkUQWMzKRVsp5j/YJh96AkMgKX0jPtTEQ2UEb97kXKLew=
User-Agent: KMail/1.9.5
In-Reply-To: <7vzmaik4mi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32123>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnAMW-0004pR-ET for gcvg-git@gmane.org; Thu, 23 Nov
 2006 09:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756739AbWKWIzL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 03:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbWKWIzL
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 03:55:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:29918 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933299AbWKWIzI
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 03:55:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so383049uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 00:55:07 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr4689772ugh.1164272107148; Thu, 23
 Nov 2006 00:55:07 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x33sm11848319ugc.2006.11.23.00.55.06; Thu, 23 Nov 2006 00:55:07
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 23 07:24, Junio C Hamano wrote:

>  * Andy, I think this does the same thing as you wanted to do,
>    but is cleaner implementation-wise and also at the concept

It certainly is.  Looking at your implementation I see that I was worrying 
unnecessarily about passing extra globals/parameters to git-parse-remote.  
Your version is much better than mine; and I see that noone else calls 
get_remote_refs_for_fetch anyway.

>    level, to pretend as if the user listed the expanded form in
>    the configuration.  I deliberately decided not to apply the
>    wildcard expansion on refspecs that came from command line,
>    but if we wanted to we can move the expand_refs_wildcard call
>    a few lines down to make it also apply to them.

That's probably the most sensible method.  Using globs on the command line 
could get people into trouble if they accidentally hit a shell expansion.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
