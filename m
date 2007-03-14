From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git protocol over port-forwarding
Date: Thu, 15 Mar 2007 11:14:37 +1300
Message-ID: <46a038f90703141514q5273e493r87f0ac7f52c1c216@mail.gmail.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
	 <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
	 <17912.29057.435478.123662@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 23:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRbk1-0002zm-ID
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 23:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXCNWOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXCNWOj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 18:14:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:10370 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXCNWOi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 18:14:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so346511wxd
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 15:14:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BdWX3Iw77ttNdAtMq/DEgToSeZDNtSOwYP6q8JEXJTyhCyHjsKDuO+XGKRxPJkhOjt80HeGFsUsOZJavFwFixWPwGfgK9rTL6Zyke7fu3lx9I6i3t9wkAJaC8Tj4VkYo8/x36gw4tEoO9d/00vH7hSZY4hHyVks9SWOU7dWTs5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o6ujFYuMDp9kpohavTEqyS9BfpfcOzSEhCqCpAy9SJQvuqKHiKR1q/49JqIunnsNkRJ2Hc4iKwbad3fWLnkxY4mtc4HcPBZciHvOkTvX9HL31YRAthoshcPV07tKVqSYoGXg+xm1y7FDpfoMh2TcO4DNrJMGoVE90jqG9QBMM00=
Received: by 10.90.65.11 with SMTP id n11mr8079536aga.1173910477584;
        Wed, 14 Mar 2007 15:14:37 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 14 Mar 2007 15:14:37 -0700 (PDT)
In-Reply-To: <17912.29057.435478.123662@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42240>

On 3/15/07, Bill Lear <rael@zopyra.com> wrote:
> On Wednesday, March 14, 2007 at 21:05:37 (+0000) Julian Phillips writes:
> >...
> >I don't think there is anything that needs changing with the git daemon
> >... or at least I was able to successfully clone over an SSH port forward.
> >
> >I did get the same error as you originally, but this was due to SSH
> >failing to setup the tunnel connection (checking the logs showed that I
> >had got the hostname in the forward wrong).
>
> Ok, so were you doing something like this:
>
> % git clone git://localhost:5700/project
>
> etc.?  and not using the ssh protocol, like this:
>
> % git clone ssh://...

I think pure port forwarding won't support git+ssh. For that you need
the proxycommand approach I mentioned. Actually, I think there's a
more elegant approach just saying

Host fooproxied
    ProxyCommand ssh -q -a foo.yourdomain nc -q0 %h 22

cheers,



m
