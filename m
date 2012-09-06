From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: git blame --follow
Date: Thu, 06 Sep 2012 12:12:42 +0200
Message-ID: <k29sup$2e0$1@ger.gmane.org>
References: <k29hpo$3av$1@ger.gmane.org> <20120906095804.GA15277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 12:13:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Z55-0004l3-M8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 12:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab2IFKMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 06:12:55 -0400
Received: from plane.gmane.org ([80.91.229.3]:54188 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab2IFKMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 06:12:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1T9Z4x-0004ae-1C
	for git@vger.kernel.org; Thu, 06 Sep 2012 12:12:55 +0200
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 12:12:55 +0200
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 12:12:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <20120906095804.GA15277@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204873>

Thanks for the explanation.

I actually do not have any clear opinion what it should do. Just that 
the current situation is confusing when experimenting and trying to 
understand the behavior of git blame and git log: an intuitive option 
that is accepted but ignored.

The option should either be rejected or do *something* documented and 
useful. Ideally, it should result in behavior that matches 'git log 
--follow' as closely as possible. So maybe, it should be a synonym for a 
certain number of "-C" options?

Greetings,
Norbert



Am 06.09.12 11:58, schrieb Jeff King:
> On Thu, Sep 06, 2012 at 09:02:17AM +0200, norbert.nemec wrote:
>
>> 'git blame --follow' seems to be undocumented. The exact behavior is
>> not clear to me. Perhaps an alias for some combination of '-C' and
>> '-M'? It seems not be be fully consistent with 'git log --follow'.
>>
>> Could someone clarify? Did I miss something?
>
> I don't think it was ever intended to do anything; the only reason it is
> not rejected outright is that "blame" piggy-backs on the regular
> revision option parser used by "log" and others.
>
> What would you expect it to do?
>
> I can't think of a sane behavior for "blame --follow". The follow code
> is about tweaking path-limiting during traversal, but blame does not use
> pathspecs. It tracks content, and the "-C" option already instructs it to
> look across file boundaries.
>
> -Peff
>
