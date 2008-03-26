From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 3/4] Head reduction before selecting merge strategy
Date: Wed, 26 Mar 2008 05:50:21 -0700 (PDT)
Message-ID: <m3k5jpved8.fsf@localhost.localdomain>
References: <402c10cd0803252058k2f35b33fr99ec7446235eeb6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 13:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeV5w-0008Uh-7Y
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 13:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbYCZMu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 08:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbYCZMu0
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 08:50:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58780 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbYCZMuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 08:50:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so52023ugc.16
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=p8/2BwKpbNvMQkGf4ad/IqFSaKDWsVOj18D2D3rzQAM=;
        b=VSuGoQWtFYF83XeDiOYq2yYcz7sR/rHJgeP6cC440LlGCpBv9sFdJJKnCeSeL5de4WEIdPHxSyPqjEVuq6DFWEzANT9vERMASVl7/sGSmtEDOYyWph8aR5mHCHGf3jTPseNSaM2WUkua1f4HaJ0cOG5PscwIHiSvhMzLKEQD3WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=nMbdpO+x7CbDjlUkv3Y/jhR6HrPbOwgs+/U0bY+VDD832H7YhdL2GSWrOIIJOj3bL5vTy50/UXMHKKUc7n7X7ZG4n1xNLWam7tIM22di7kPinYuwH2pnVI2knK2pptm36upJ/7SsQQ2i6VSr9bfPKiDfNboI7t86YhDNxLU6hzA=
Received: by 10.150.195.21 with SMTP id s21mr4782404ybf.114.1206535822620;
        Wed, 26 Mar 2008 05:50:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.230.153])
        by mx.google.com with ESMTPS id h4sm17960952nfh.8.2008.03.26.05.50.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Mar 2008 05:50:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2QCoEmk005194;
	Wed, 26 Mar 2008 13:50:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2QCoBia005191;
	Wed, 26 Mar 2008 13:50:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0803252058k2f35b33fr99ec7446235eeb6e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78283>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> See the documentation for an explanation of this feature.

That's good that the feature is documented. But I'd like to see 1.)
why this feature is implemented, and perhaps also 2.) how this feature
is implemented (for example: uses find_real_parents() function.
 
> +If more than one commit are specified for the merge, git will try to
> +reduce the number of commits (real parents) by eliminating commits
> +than can be reached from other commits.  The commit message will
> +reflect the actual commits specified but the merge strategy will be
> +selected based on the real parents, but always including `HEAD`.  The
> +real parents (only including `HEAD` if it is real) are the parents
> +recorded in the merge commit object.

By "real" you mean "reduced" set of commits to merge?  This is not
clear enough, IMHO.

You would have to defend that recording reduced set of parents is a
good idea (is it always done, or does --ff=never has side-effect of
recording _specified_ parents for a merge?).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
