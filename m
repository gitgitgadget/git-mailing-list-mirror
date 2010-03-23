From: Scott Chacon <schacon@gmail.com>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 09:05:41 -0700
Message-ID: <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
	 <1269354326.14299.7.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, howard@e-learndesign.co.uk
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Tue Mar 23 17:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu6c4-0004YC-VD
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 17:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab0CWQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 12:05:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51370 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0CWQFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 12:05:45 -0400
Received: by wwe15 with SMTP id 15so4194813wwe.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lEZ6jw/AgHPItadhAzcIfbNiZG2T5DNq5uGY11CJyxc=;
        b=ThKFjQ3YP0cfAv78OACVjc9JapR9Su/lA9e9iSRSHsdy5zsoxXAebueEdyZZlIe4iq
         MdkMQmotsFCz9k1Oxpofg7zE+TIxkAkTvN8PBR/iLOUQu0hMRZaQyYq3q9CskJdzDjZv
         ITiAmGNVHT938ahgtrgnP27oNeqdn/qJprstc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w412IyzQDClcq9BPBwAb/Q8QW/hgKCzp7nfO0GMfBNdls4Yi1LIvT4OtboMsXcO3hS
         oatTA/k8dKbs0zsuS+W7UWKES8wM69iCOQQU1p5SjRKGLrnBNwXw3RuAM/j4qj4bPm00
         0PTvjhDgJ4sCt4UF+tEbUNQlMFu5HOpU/o7PU=
Received: by 10.216.157.145 with SMTP id o17mr3566982wek.125.1269360341474; 
	Tue, 23 Mar 2010 09:05:41 -0700 (PDT)
In-Reply-To: <1269354326.14299.7.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143026>

Why would we teach someone to do that instead of just recommending the
far less obscure 'git push -f'?  A leading '+' on the refspec is
ridiculously confusing compared to "just tell it to force the push
with -f".  Am I forgetting something?

Also, Howard, what do you mean by "I forgot to merge"?  Do other
people have push access to this branch?  You can't just tell people
"use the local version" after you force a push.  If anyone has based
work off of that point, you're going to get into way more trouble
forcing a non-ff push than if you just did a merge and then resolved
all the conflicts as --ours.

Scott

On Tue, Mar 23, 2010 at 7:25 AM, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> On Tue, 2010-03-23 at 14:13 +0000, Howard Miller wrote:
>> >
>> > git push origin +local_branch:remote_branch
>> >
>>
>> Thanks!
>>
>> Tell me more about that '+'. I've never heard of it before. Can't see
>> anything in the docs (although I'm probably not looking in the right
>> place)
>
> http://kernel.org/pub/software/scm/git/docs/git-push.html
>
> the '+' means that you want to bypass the security which does not allow
> non fast-forward pushes.
>
> Note that you shouldn't do non fast-forward pushes to a repository which
> can be cloned by other people than you. Once published (accessible to
> anybody) you should do a merge and then push to origin even if you only
> take your local history in the merge to avoid user pulling from origin
> conflicts due to the non fast forward history.
>
> Regards.
>
> --
> Sylvain Rabot <sylvain@abstraction.fr>
>
