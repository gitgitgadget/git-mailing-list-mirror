From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Remote tag namespace
Date: Wed, 02 Feb 2011 14:38:34 -0500
Message-ID: <4D49B2BA.5050002@xiplink.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <4D48219D.8060603@xiplink.com> <AANLkTim4qOiF=3GMixZuWJs=cqcAtawtgkKzLiVdBhuZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 20:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkiXN-0003xM-PA
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 20:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab1BBTii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 14:38:38 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:42279 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1BBTih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 14:38:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp53.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id BBDCE5828D;
	Wed,  2 Feb 2011 14:38:36 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp53.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7C12758374;
	Wed,  2 Feb 2011 14:38:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTim4qOiF=3GMixZuWJs=cqcAtawtgkKzLiVdBhuZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165928>

On 11-02-01 10:35 AM, Nguyen Thai Ngoc Duy wrote:
> On Tue, Feb 1, 2011 at 10:07 PM, Marc Branchaud<marcnarc@xiplink.com>  wrote:
>>> Config branch.*.globalTags (perhaps takes a pattern?) may be defined
>>> to create refs/tags/* in addition to refs/remote-tags/<remote>/* when
>>> fetching tags.
>>
>> I may be getting into the weeds prematurely here, but why put the config item
>> under branch.* ?  Or did you mean remote.*.globalTags?  Personally, I don't
>> see a need for this.  I'd rather have the rev-parse machinery search in
>> remote tag namespaces if it can't find anything local.
>
> Ahh.. yeah it's remote.*.globalTags. I don't know, some people might
> find current behavior useful. So instead of dropping it entirely, I'd
> limit it to certain remotes.

IMHO, it's best not to assume what people might want.  Better to wait 
for someone to ask for something specific.

[ ...snip... ]

> When tags are put in remote namespace (wherever it actually is),
> git-tag must learn -r like git-branch. I think option name change for
> -a is too late though. When "git-ng" rewrite project comes (that is
> after libgit2 replaces git core), we may have everything consistent
> again.

I think we could start by making "git tag -A" a synonym for "git tag -a" 
with a verbose warning when "-a" is used that it'll soon gain a 
different meaning.

Also, during the transition "git tag -a" without any other options could 
(without the big warning) list all local and remote tags (like "git 
branch -a") and if someone wanted to make an annotated tag of the 
current tip they could do "git tag -A" or "git tag -a HEAD".

		M.
