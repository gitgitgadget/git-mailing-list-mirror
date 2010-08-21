From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 2/5] fmt-merge-msg: Make the number of log entries
 in commit message configurable
Date: Sat, 21 Aug 2010 11:25:59 +0530
Message-ID: <20100821055556.GI6211@kytes>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-3-git-send-email-artagnon@gmail.com>
 <20100821035403.GA2474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 07:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omh5c-0002vD-5G
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 07:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab0HUF54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 01:57:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44576 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0HUF5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 01:57:55 -0400
Received: by pvg2 with SMTP id 2so1503330pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 22:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yeFy6Ou5xQGtaWkBFaLIZ4Hij1OQJ9bD7M5tlBEQuEY=;
        b=eBOfWcElU2pEzm4nvbaDRmrUkKc135xjt09WZhcyWoGMvFS6EmJ+30ndEZmOwsMa4Z
         flhrQ1+iuJPewf1V4VVOq3v2kmg5rDwFN9L15DP1/8YrhNXDQwyiK8EOz3bIhvJABavc
         30C8AcUM5S6FPYMDAexEcHQviyAaZ1+D2SHV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tPTnK8JCBKEQeDTSXFFHe2uqAKjmseyedKuK2CpVje6Ji7F4Cn3WuEBNKBeqJmkYZv
         CIejtpcq8CaNvQ/3i+4flGIBz4yxjdxaXM0Pjy+iUdJR8MVPNdjNpc+5y1rINDoYUq3F
         ZUihk/PnY4ofFA4EsTpiI3iOoeWh/l9zqowUs=
Received: by 10.114.39.2 with SMTP id m2mr2671637wam.45.1282370274906;
        Fri, 20 Aug 2010 22:57:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n32sm6456978wag.11.2010.08.20.22.57.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 22:57:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100821035403.GA2474@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154113>

Hi Jonathan,

Jonathan Nieder writes:
> Hmm, this seems to be trying to have it both ways.  It would be simpler to
> either:
> 
> 	static int merge_summary;
> 	static int log_limit = 20;
> 
> providing independent internal "enabled" and "limit" knobs, so one could use,
> say,
> 
> 	[merge]
> 		log = 2
> 		log = false
> 		log = true
> 
> with the result being be a log_limit of 2, or
> 
> 	static int log_limit;
> 
> where 0 means disabled, so in that example the result would be a log_limit
> of 20.
> 
[...]
> What happened to the merge_summary argument?

This patch is roughly equivalent to my original log_limit patch. Yes,
I'm trying to have it both ways in this patch :) merge_summary is set
by both the command-line option and the config option, while log_limit
is set by the config option. As you noticed, the next patch removes
merge_summary.

-- Ram
