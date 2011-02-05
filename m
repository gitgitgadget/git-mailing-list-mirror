From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sat, 05 Feb 2011 19:00:52 +0100
Organization: Digium, Inc.
Message-ID: <4D4D9054.8040906@digium.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102020322.00171.johan@herland.net> <7vpqr7xw4z.fsf@alter.siamese.dyndns.org> <201102050218.44325.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:01:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlmRd-0002Fp-QB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1BESBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:01:05 -0500
Received: from mail.digium.com ([216.207.245.2]:32864 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab1BESBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:01:04 -0500
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1PlmRL-0008H1-Fw; Sat, 05 Feb 2011 12:00:55 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 7785BD82A1;
	Sat,  5 Feb 2011 12:00:55 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsXQQuGD7bvY; Sat,  5 Feb 2011 12:00:54 -0600 (CST)
Received: from [192.168.3.103] (unknown [109.128.227.230])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id D445ED82A0;
	Sat,  5 Feb 2011 12:00:53 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <201102050218.44325.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166103>

On 02/05/2011 02:18 AM, Johan Herland wrote:

> Today, when you fetch from a remote, the config typically says
>
> [remote "origin"]
>          fetch = +refs/heads/*:refs/remotes/origin/*
>          url = ...
>
> But this fetch refspec does not tell the full story. In addition to mapping
> origin's refs/heads/* into refs/remotes/origin/*, it also fetches origin's
> HEAD into refs/remotes/origin/HEAD, and anything in origin's refs/tags/*
> that happen to point to a fetched object is fetched into refs/tags/* (aka.
> auto-following tags). These other fetches are not explicitly specified in
> the config, but "magically" happen anyway. Instead of having such implicit
> refspecs, I'd rather have all fetch refspecs listed explicitly in the
> config, like this (for replicating current layout):
>
> [remote "origin"]
>          fetch = +HEAD:refs/remotes/origin/HEAD
>          fetch = +refs/heads/*:refs/remotes/origin/*
>          fetch = ~refs/tags/*:refs/tags/*
>          url = ...
>
> or this (in the proposed new layout):
>
> [remote "origin"]
>          fetch = +HEAD:refs/remotes/origin/HEAD
>          fetch = +refs/heads/*:refs/remotes/origin/heads*
>          fetch = +refs/tags/*:refs/remotes/origin/tags/*
>          url = ...

I would appreciate this as well; the less implicit behavior in areas 
like this, the better :-)

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
