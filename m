From: Andreas Ericsson <ae@op5.se>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Fri, 25 Nov 2011 14:09:49 +0100
Message-ID: <4ECF939D.8020706@op5.se>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com> <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 25 14:10:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTvXU-00064C-AB
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 14:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab1KYNJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 08:09:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38968 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab1KYNJy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 08:09:54 -0500
Received: by faas1 with SMTP id s1so2120149faa.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 05:09:53 -0800 (PST)
Received: by 10.152.109.199 with SMTP id hu7mr20548227lab.16.1322226593158;
        Fri, 25 Nov 2011 05:09:53 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id hr17sm22690462lab.12.2011.11.25.05.09.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Nov 2011 05:09:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.23) Gecko/20110928 Fedora/3.1.15-1.fc14 Thunderbird/3.1.15 ThunderGit/0.1a
In-Reply-To: <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185928>

On 11/25/2011 05:13 AM, Sitaram Chamarty wrote:
> On Fri, Nov 25, 2011 at 8:46 AM, Sitaram Chamarty<sitaramc@gmail.com>  wrote:
>> (...and/or a post-upload hook)
>>
>> Has this ever come up?
> 
> Sorry for the google-fu fail and for replying to my own post.
> http://git.661346.n2.nabble.com/Removal-of-post-upload-hook-td4394312.html
> is the longest thread I (later) found.
> 
> The quick summary, in the words of Jeff (second post in that link) is:
> "Because [upload]-pack runs as the user who is [fetching], not as the
> repository owner. So by convincing you to [fetch from] my repository
> in a multi-user environment, I convince you to run some arbitrary code
> of mine."
> 
> My contention (today) is:
> 
>    - you're already taking that risk for push
>    - so this would add a new risk only for people who fetch but don't push
>    - which, I submit, is a very small (if not almost empty) set of people
> 

People who fetch but don't push is, by far, the vast majority of git users.
Think of everyone fetching from any public software repository without
having write access to it. If you think of git.git and linux.git alone
I think it's safe to assume the number of "fetch-no-push" outnumber the
"push-and-whatnot" group by some quarter million to one.

> I may be wrong but I imagine shared environments are those where
> almost everyone will push at least once in a while.  It's a closed
> group of people, probably all developers, etc etc etc...
> 

Not really. We fetch from each other quite a lot at work, and from
each others semi-public repositories on a shared server where we've
all got accounts (ie, write access), but we very, very rarely push
into each others repositories. The sharepoint is the "official" repo
on the repo-server, which the buildbots gets its code from and where
everything to be released, maintained or handled in some way in the
future resides.

Anyways. Shooting down the arguments *against* pre-upload hooks are
quite silly if it's not combined with some fresh arguments *for* such
a hook.

So... What usecase do you envision where you'd need one?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
