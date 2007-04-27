From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Thu, 26 Apr 2007 22:47:07 -0400
Message-ID: <4631642B.2010501@gmail.com>
References: <20070427021505.1740.58136.stgit@rover>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 04:47:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhGUQ-0007oT-Nv
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 04:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbXD0CrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 22:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbXD0CrN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 22:47:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:42063 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbXD0CrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 22:47:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so770870wxd
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 19:47:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MkaWObRbfd5rFWiUgU68tB1l4hAZy6hkAZ+54uOHwSwGQeHVknW49SFQWwRXuz3baQTpZ1lrGYObA3KQTP8y6M1roDOf1m+kpdpmNxPwLsSltEAS7v2nhSstfxT+p5AZI2w0B5K0z7TJYoqvTXYp+paf2DbjbJa3n1dplrLqn+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HqFUi5LRMHY0Q98ARJRhiFcRXDpmQr1/BAlpPYltH5nfXYBzh+g19eRdFh/pmTudTtJW7XJio36uT4C1+VPAKNaTt33rfguS3Xamr+wh/UR6vfGT+BXXOQ29/hzepnIcCK4kgxMx9GLYHeKzWbdjHE9eGnR4ewBvTJGhGR0D488=
Received: by 10.70.65.5 with SMTP id n5mr4964864wxa.1177642031146;
        Thu, 26 Apr 2007 19:47:11 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h16sm363629wxd.2007.04.26.19.47.08;
        Thu, 26 Apr 2007 19:47:08 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20070427021505.1740.58136.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45675>

Petr Baudis wrote:
> Sometimes its handy to be able to efficiently backup or mirror one
> Git repository to another Git repository by employing the native
> Git object transfer protocol.  But when mirroring or backing up a
> repository you really want:
> 
>   1) Every object in the source to go to the mirror.
>   2) Every ref in the source to go to the mirror.
>   3) Any ref removed from the source to be removed from the mirror.
> 
> and since git-fetch doesn't do 2 and 3, here's a tool that does.
> 
> This is based on Shawn Pearce's patch from 25 Sep 2006, updated to take
> Junio's and Sergey's review into account, to use few newer pieces of Git
> infrastructure and with few trivial tweaks. The repacking part was dropped
> since git-fetch does that on its own now.
> 
> I actually still would kind of prefer this to be a git-fetch's feature but
> the general mood seems to be to have this as a separate command and I can't
> say I care at all.
> 

It would be nice if this had an option to not mirror HEAD and another 
option to map the refs from (/ref/[^/])/(.*) to /ref/\1/${repo_path}/\2.
