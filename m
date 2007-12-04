From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 4 Dec 2007 23:08:55 +0100
Message-ID: <200712042308.57048.jnareb@gmail.com>
References: <4755B3B3.80704@gmail.com> <m34peyur8r.fsf@roke.D-201> <4755CD32.7040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzfxA-0004T4-Py
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbXLDWJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXLDWJA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:09:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:55209 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXLDWI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:08:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2999381nfb
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 14:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=7r5IioQ8LdEox6XIqVuTpoiNYrrA+46O+Ziv9rRmN18=;
        b=cY5ODC7aCbnxabHg1sYTtIvwOly2aD8raZfbghc1ABk2IVmTre0uybuAW+jMoGq4xTNjR42hMLzJQ7pNmR9uvWxOcsuISIpgQ69Q+XdEIDafqwhi4par0ir/neQOGkAG58AGOZJCFepOvF2Nim0W7/V5aJI/g6oSrOolvVo8lNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fkAqW6XIBxDkpIRmXfsMLJgAWkZ4MWlnNqlKy5SNddXnXGmL3cgdqeRK4Sc8QDCx7uUuAad1N9Vs0Us4aCw7INOAlxisNS/GN9i+CKPY3+0UE3W7N+BWH9duEB1x6+0YWGYR5qoaKyd9hf+5BPLq0Bg+a0F8jcJeVaJWlU14yFk=
Received: by 10.86.54.3 with SMTP id c3mr9709449fga.1196806137555;
        Tue, 04 Dec 2007 14:08:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.161])
        by mx.google.com with ESMTPS id f19sm74750fka.2007.12.04.14.08.55
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 14:08:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4755CD32.7040204@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67091>

On Tue, 4 Dec 2007, Salikh Zakirov wrote:
> Jakub Narebski wrote:
>>> Salikh Zakirov <salikh@gmail.com> writes:
>>>> This combination leads to the confusing user experience
>>>> if the branch changes independently of the working directory.
>>>> This can happen in following cases:
>> 
>> All those cases are cases of not recommended workflows.
> 
> I guess those cases are not recommended exactly because
> there are prone to causing confusion with current git.

BTW. I think for each such workflow there is alternative
in git, which does not cause those problems.

> I use multiple workdirs quite often, and by now learned
> not to check out the same branch in different workdirs, 
> but it would very convenient if it would not be necessary
> to remember it. 

Those cases are not recommended because they would _always_ cause
confusion, whether the user is informed that somehow working copy
or current branch has changed while he/she was working or not.
Currently git tries to follow "merge when ready" (i.e. you
explicitely ask to merge or rebase), not "merge when needed"
(like in old, broken CVS workflow where 'cvs update' might have
_forced_ a merge before being allowed to save his/her finished
work).
 
>> BTW. how in your proposal would you detach HEAD?
> 
> Deleting .git/BRANCH should be enough.

Hmmm...

> But I cannot see the workflow that would need it.

Checking out tag. Checking out remote-tracking branch. You cannot
commit on top of either (immovable) tag, or (externally controlled) 
remote-tracking branch.

Besides rebase now uses detached HEAD, and I guess that bisect would 
too.
-- 
Jakub Narebski
Poland
