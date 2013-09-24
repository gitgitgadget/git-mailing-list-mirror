From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Local tag killer
Date: Tue, 24 Sep 2013 09:22:32 -0400
Message-ID: <52419218.3020902@xiplink.com>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 24 15:31:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOSiO-00084T-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 15:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab3IXNbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 09:31:40 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:57486 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab3IXNbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 09:31:39 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2013 09:31:39 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp10.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6D46B3703C7;
	Tue, 24 Sep 2013 09:22:33 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp10.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C11313702DD;
	Tue, 24 Sep 2013 09:22:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130924075119.GD7257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235302>

On 13-09-24 03:51 AM, Jeff King wrote:
> On Sat, Sep 21, 2013 at 08:42:26AM +0200, Michael Haggerty wrote:
>
>> I think it would be preferable if "--prune" would *not* affect tags, and
>> if there were an extra option like "--prune-tags" that would have to be
>> used explicitly to cause tags to be pruned.  Would somebody object to
>> such a change?
>
> I think most of this problem is the way that we fetch tags straight into
> the refs/tags hierarchy. You would not do:
>
>    [remote "origin"]
>    fetch = +refs/heads/*:refs/heads/*
>    prune = true
>
> unless you wanted to be a pure-mirror, because you would hose your local
> changes any time you fetched. But that is _exactly_ what we do with a
> refs/tags/*:refs/tags/* fetch.
>
> If we instead moved to a default fetch refspec more like:
>
>    [remote "origin"]
>    fetch = +refs/*:refs/remotes/origin/refs/*

I'm all for such a change.

You no doubt recall the lengthy discussion about remote ref namespaces 
back in 2011 [1].  That arose while planning for 1.8, but my feeble 
recollection is that the change was considered too disruptive.  It seems 
2.0 would be a better home for such work.

		M.

[1] 
http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=166729
