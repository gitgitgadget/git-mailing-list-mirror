From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 23:49:49 +0200
Message-ID: <237967ef0806111449i7d23976dxa3290eece06b5876@mail.gmail.com>
References: <484F2174.9020508@keyaccess.nl>
	 <alpine.LNX.1.00.0806111340570.19665@iabervon.org>
	 <XZoDb2arIiMts-bX6jjK15wC9cOn5lPGgCOQYbY9YIyNm_nfcDf5gQ@cipher.nrlssc.navy.mil>
	 <alpine.LNX.1.00.0806111513380.19665@iabervon.org>
	 <kpNEshc02wSu18FDnzOIvMAjQu_lmbk4tK_T_9HGh38@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Rene Herman" <rene.herman@keyaccess.nl>,
	git <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6YDQ-0005ho-5R
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYFKVtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbYFKVtx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:49:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:58319 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbYFKVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:49:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1681756rvb.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=X88w4Q4GqhTebhjZ3I8gt4kvBCmkrBeT1njk39brtFU=;
        b=TVxSzxMqw1gkTHPiSRqasUxs8eQ6xy1sgvs6r/XkGNLdohHi/Lds1P0Mjj8XQFuKp/
         JKjCmsp0E6IBuwQqdVH2RixEMesEfoyxFKdJqKBCnx7eUweljZbH0S52/LfZeykPivts
         HevPSyl8kFu1VeEd9eNIlWSul+ltUKKXAIFrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iU+Qc6JroRbW/3nn623dtsVmg+0w9eWQWTG7/S3MnUKtKGyDinXSQrBfDmTl1GwV18
         4C5GsPA355HfqPbCzRJb8WbzGIPvdxp/yQWNYJWRMg+cq2t0fHfnFYrOVBc7o2pulGB2
         bPIxoUo1t3/V9hSILGWuiRu1fRtY0B6wD6djQ=
Received: by 10.141.35.21 with SMTP id n21mr383731rvj.115.1213220989196;
        Wed, 11 Jun 2008 14:49:49 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Wed, 11 Jun 2008 14:49:49 -0700 (PDT)
In-Reply-To: <kpNEshc02wSu18FDnzOIvMAjQu_lmbk4tK_T_9HGh38@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84671>

2008/6/11 Brandon Casey <casey@nrlssc.navy.mil>:
> Daniel Barkalow wrote:
>> On Wed, 11 Jun 2008, Brandon Casey wrote:
>>
>>> Daniel Barkalow wrote:
>>>> On Wed, 11 Jun 2008, Rene Herman wrote:
>>>>
>>>>> Good day.
>>>>>
>>>>> The manpages seem to be making somewhat of a point of mentioning "git pull .
>>>>> <branch>" as the way to merge a local branch into the current one but a simple
>>>>> "git merge <branch>" seems to work well. Is there a difference?
>>>> Those manpage sections predate the existance of "git merge <branch>". If
>>>> you're not planning to use git before November 2006, there's no reason to
>>>> use the "git pull ." form. They should probably be replaced with more
>>>> helpful examples at this point.
>>> Was there some past discussion of the ui merits of a separate 'merge' command
>>> for dealing with local merges and a 'pull' command for remote merges? I
>>> understand merge is the backend. The question has to do with the high-level
>>> user interface: one command or two? Why wasn't git-pull enough?
>>
>> "git pull . <branch>" does "git fetch . <branch>" and then merges it. Of
>> course, "git fetch . <branch>" does nothing at all, and it's weird as a
>> user interface to have the only (simple) way of selecting something to
>> merge be to fetch it as if from a remote repository, but from the local
>> repository. After all, no other purely local operation requires you to
>> first fetch the thing you're interesting in from yourself.
>
> I don't agree with this paragraph. I think it _would_ be weird if you had
> to type 'git fetch' and then 'git merge' (or git pull) when operating on
> a local repository, but that is not necessary. It is only necessary to
> type 'git pull'. There is symmetry between operating on a remote repository
> and operating on a local repository. The user does not need to know that
> a noop fetch is first performed, or whether the pull command detects that
> it is operating on a local repository and just skips the fetch, any more than
> the user is required to know the exact sequence of events that allows an ssh
> session to succeed.

> The user _must_ know how to use git-pull

I've used git for a couple of months, and I've never used git-pull, only fetch
and merge. To me it doesn't make any sense that you would want to merge changes
without looking at them first. It also seems very strange to me to treat
not-yet-fetched branches on a remote the same as a local branch. I don't really
have any useful input other than that you shouldn't assume what other people
find intuitive, because you are usually wrong :).

> Well maybe that exaggerates the point a little, git-merge is not that complicated,
> but it is an additional command to learn with little benefit that I see.

For me, git-pull is that additional command, and using git-pull .
<branch> to merge
feels really really strange. Why would I pull something I already have?

> I saw it as something similar to suggestions I've seen to use git-reflog
> (not porcelain) rather than 'git-log -g' (porcelain).

The output of git-reflog is easier to read when you know what you're
looking for,
the actual commit message and author info that log outputs is usually
superfluous.

-- 
Mikael Magnusson
