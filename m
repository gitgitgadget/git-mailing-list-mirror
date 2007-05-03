From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-blame not tracking copies
Date: Thu, 3 May 2007 08:29:30 +0100
Message-ID: <200705030829.31144.andyparkins@gmail.com>
References: <200705022033.25885.andyparkins@gmail.com> <7v8xc64wsu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 09:30:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjVlP-0002p3-K9
	for gcvg-git@gmane.org; Thu, 03 May 2007 09:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbXECH3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbXECH3o
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 03:29:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47148 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030384AbXECH3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 03:29:43 -0400
Received: by ug-out-1314.google.com with SMTP id 44so399022uga
        for <git@vger.kernel.org>; Thu, 03 May 2007 00:29:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AlsFo15zzkXaWI3+Lc1P7YgXH2Dxk/5C4vLIpVG9fMylsynbNybWLW24t3FVS6nnkNhXQf7uTTV5jwlHBi+hjqpX0RwpmpxshYpD6fBq9AxQY8RJmRZ5OqGvFgfVkOZY2oP7r1nlqUeVRZephMT1yVwMngWgMTDgnmb+wXF+eDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rWiKVIHh7fyP9gxI0FRTs9rnetCRTi9fLdJGpK7zCYUCPAB/S0RzzAtKzecYbzjzJfmSiflWcL/cNSZxhWF0CesdPL52p+WVQ4BOmxL0QbcYdH5byfO3bWirdAxVAwl6NJXcc1C03caX86q4j28NxP6egz0DT0BexIeDf80av6c=
Received: by 10.82.169.4 with SMTP id r4mr3301575bue.1178177382119;
        Thu, 03 May 2007 00:29:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm2157776ika.2007.05.03.00.29.36;
        Thu, 03 May 2007 00:29:40 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xc64wsu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46074>

On Thursday 2007 May 03, Junio C Hamano wrote:

> I am sick and not functioning well today, so will not be able to

I'm sorry to hear that.  I hope you feel better soon.

> review what is happening with your example deeply, but here are
> some comments to get you started digging.
>
> There is a built-in sanity valve in git-blame that refuses to
> pass down the blame via -M/-C for really trivial hunks.  Without
> such safety, all the empty lines in the latest revision would be
> attributed to a random empty line in a random file in the root
> commit ;-).

That sounds like an excellent feature.  However - in the case of a full 
file-to-file copy, surely that valve may be safely disabled for that one 
step?

The copy is easily detectable because the hash is the same, so can't git-blame 
just continue having flipped itself on to the original filename?  I suppose 
in essence a move is the same, the only difference between a move and a copy 
is that in one case the copy is spatial in the other it is temporal.

Please excuse the fact that in the above I've completely minimised the fact 
the job git-blame does is flippin' hard; I don't mean to imply that "any fule 
could fix it" - because I can't :-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
