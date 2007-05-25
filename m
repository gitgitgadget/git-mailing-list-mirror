From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Fri, 25 May 2007 14:12:02 +0100
Message-ID: <200705251412.06196.andyparkins@gmail.com>
References: <200705251150.09439.andyparkins@gmail.com> <20070525105836.GG6667@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joshua N Pritikin <jpritikin@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 15:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrZam-0002KH-IN
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763095AbXEYNMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763166AbXEYNMT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:12:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:8925 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763095AbXEYNMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:12:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1116643ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 06:12:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H5A1zkclFd6dGQh1qhOtt2MrKL4FktzmpiCyoWTNzuFmlLa6hXwUOfPJoRsCFElUFc5P/jmWD7QR0iO9vsiSsgk+wf/fAGNrbF4/CX9r9693xjYR6MAbhXbl1ReaPlpskURXyFp/MTFFW/+ZcPyFeJIO4dqEoHFipJUhR9Ca2e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Flh/vgkLwnwZFB4AKu9Lv2X+sx8RPYhI4blucFYbH1v0L1soFoi9yH7E+Yefh3nLTJZwenT5MYQ9BEhJPm4L5d+n8Y3mDrCrga+TdtEhiPcWJPgsdhi2oSlujdfxnLLoK5bbuvA9GR+/qenp9qx+53dd9fXJJ29OrdRZEc7WU10=
Received: by 10.82.173.19 with SMTP id v19mr5395088bue.1180098735493;
        Fri, 25 May 2007 06:12:15 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm288752iky.2007.05.25.06.12.14;
        Fri, 25 May 2007 06:12:14 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070525105836.GG6667@always.joy.eth.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48369>

On Friday 2007 May 25, Joshua N Pritikin wrote:

> Can this loop throw away newlines? Removing newlines seems like a bad
> idea.

It can and does.  My patch is only a bug fix though, not a change in 
functionality.

It's probably not likely that they will appear inside the $Id: XXXXX $ 
expansion, and even less likely that that expansion will make it into the 
repository copy; however it's easily fixed ...  patch to follow.  


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
