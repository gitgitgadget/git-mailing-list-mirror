From: "David Aguilar" <davvid@gmail.com>
Subject: Re: git mergetool
Date: Sat, 17 May 2008 13:47:41 -0700
Message-ID: <402731c90805171347g62197f5diab513e409d7cce25@mail.gmail.com>
References: <b6840c770805171021g63df7d0dm4532655ed49209bc@mail.gmail.com>
	 <m3tzgw4r7w.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Evgeny <evgeny.zislis@gmail.com>, git@vger.kernel.org,
	tytso@mit.edu
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 22:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxTKU-0002zA-Ha
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693AbYEQUro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758860AbYEQUro
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:47:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20367 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512AbYEQUrn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:47:43 -0400
Received: by ug-out-1314.google.com with SMTP id h2so168279ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K2IxKKdh+Af1gNcHZQ6hSOzjgZOeHSnt9woE/iWxado=;
        b=MlWIX+bHSaZfJca2DC+HLMZjLfIUh97f0DeLTllIYnnvp4zhf8GJ70q/tWVlrbYXTqMR14dQvnKA2QkpVmKmAkxfF8wqy0QC2MDuxjJiXNT4lE6U6Sl3b5K3Gp3vsgDGZWlOt30V3nYeO144/hFnXLBypsrhCvqYi2ep1RMzkKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SkRvxYanu2O3GLvo7jE8IKPugz399TJRtndiydW1Tv6FyL8dWgNs7Y3LUmGcPfNTe4HwkIGQZ2VLOWSOox48DVVQxseQQYJBPqN391zYvw7oLOVf/DTkQ4vZU9qkjaCs6LEcG9FHWEiFyWwLPHrymKJZh/3/hidHMc7ujrPnoA4=
Received: by 10.66.250.18 with SMTP id x18mr1411242ugh.79.1211057261619;
        Sat, 17 May 2008 13:47:41 -0700 (PDT)
Received: by 10.66.236.11 with HTTP; Sat, 17 May 2008 13:47:41 -0700 (PDT)
In-Reply-To: <m3tzgw4r7w.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82363>

On Sat, May 17, 2008 at 1:21 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Evgeny <evgeny.zislis@gmail.com> writes:
>
>> Background:
>>    I am trying to use a custom mergetool with git.
>>    The documentation explains that environment variables
>>    $BASE, $LOCAL, $REMOTE, $MERGED
>>    are set for the invocation of the mergetool command.
>>
>> Problem:
>>    I wrote a wrapper for P4Merge, and I check for these environment
>>    variables - but they are not there.   After a closer inspection
>>    of git-mergetool I see that infact these variables are not being
>>    sent to the external command at all, and are just in the context
>>    of the git-mergetool script.
>
> From what I know of git-mergetool, you can use one of the predefined
> merge tools: kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
> ecmerge, and opendiff (optionally providing path to the tool)
>
> To add support for P4Merge you would have either modify
> git-mergetool.sh (and, optionally, send a patch to git mailing list),
> or make use of `mergetool.<tool>.cmd` configuration option.
> Unfortunately there is no example...
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git

I just sent a patch that exports these variables.

Presumably we do not want to modify git-mergetool.sh every single time
someone needs to be able to use a new mergetool, hence the patch I
sent makes sense to me.  Let me know if you think otherwise.
Thanks,
-- 
 David
