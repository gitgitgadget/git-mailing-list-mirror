From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 22:29:35 +0200
Message-ID: <200610102229.35642.jnareb@gmail.com>
References: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 22:54:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXOc0-0003sU-VX
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 22:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWJJUyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 16:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWJJUyA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 16:54:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:64433 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030348AbWJJUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 16:53:59 -0400
Received: by ug-out-1314.google.com with SMTP id o38so830486ugd
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 13:53:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=hf/l304AcIPRrY0B+B0s1V9hiugiYZc7K0Z8AHWsZYK+C7Mho8KGXBeQOX438XE3nBGBKcur7IerrysXZX+OZUqlXUVNG/l6TAZqeLNIPffQhIE8LRP53A5o4BrB0EDY0hIVzL4YIWqf7vw5X3SfVMSi9Pa5eII6+k70bY/keig=
Received: by 10.67.105.19 with SMTP id h19mr8700750ugm;
        Tue, 10 Oct 2006 13:53:58 -0700 (PDT)
Received: from host-81-190-20-194.torun.mm.pl ( [81.190.20.194])
        by mx.google.com with ESMTP id e34sm3209455ugd.2006.10.10.13.53.57;
        Tue, 10 Oct 2006 13:53:57 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>, Junio Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061010191904.99261.qmail@web31809.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28666>

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Luben Tuikov wrote:
>> 
>>>> It probably is wise to resurrect those "redundant" links.
>>> 
>>> If someone does this, can they also remove the now "other"
>>> redundant link? (the link at the pathname itself) A simple
>>> code analyzer would show the duplicate code in gitweb.
>>
>> I'd rather add some more "hidden" links, but for each hidden
>> link (which are convenience only, to have larger are to click,
>> or to have closer area to click) I'd like to have clearly marked
>> link (marked as a link, i.e. using default link style; and with
>> link text denoting _kind_ of link) which leads to the same contents. 
> 
> Why would you like all this?  If users start using those other links
> all the time, what is the purpose of the "hidden" links as you call
> them? 

It was answered in the part you haven't quoted. Sometimes "hidden link" 
purpose it is to have larger area where we can click, for example in 
"tree" view the name of file (the name of directory is not hidden, as
it uses default link style), in "shortlog"/"heads"/"tags" view the title
(subject) of a commit/ref. Sometimes it is to have link closer, for
example name of files in diff header being "hidden link" to file 
contents before and after the change.

"Hidden links" are in fact half hidden, as I think all of them are 
underlined on mouseover. 

But, as I have said, we cannot use default link style for those "hidden 
links", either because as in "shortlog" view this would negatively 
affect readibility, or it would clash with syntax highlighting as in 
the case of "commitdiff" and "blobdiff" views, or because we have two 
types of object we want to be visually distinct, but there is only one 
default style of links like in the case of directory (tree) and file 
(blob) entries in the "tree" view.
 
> Consider the "tree" link between "commitdiff" and "snapshot" 
> (if enabled) in shortlog view.
> 
> Consider the "hidden" link of each entry (file/directory).
> 
> Can you see how they are different?

Yes, "tree" link is small, blue (if not visited), and underlined.
But I guess that wasn't what you had in mind.

IMPORTANT: By the way, by removing 'redundant' "blob"/"tree" link we 
remove the possibility of denoting which links (which directories and 
files) we have visited (sic!).

> Introducing this to an engineer who has little knowlege about git:
>    "Click on the file or directory name, to get the file or go into
>     the directory"
> Simple and intuitive, no need to mention "blob" or "tree" or "object".
> Or,
>    "Click on the 'blob' link to get the ... Click on the 'tree' link
>    to get the ... Oh you didn't know what a 'tree' or 'blob' object
>    is? A 'blob' is ... A 'tree' is ..."
>
> At which point the engineer has lost 90% of his interest.

The links are for git and gitweb users. They tell (we assume that git 
user knows what blob, tree, etc. means; we assume that gitweb user 
knows what blob views or tree view means)
    "Click on the 'blob' link to get 'blob' view for current line file"
like the "history" link tells
    "Click on the 'history' link to get history of a current line file"

For example "hidden link" of title/subject of a commit in "shortlog" or 
"history" view doesn't tell us what kind of view it leads too: commit, 
commitdiff? Well, it doesn't tell us that it is link, either... ;-)

> It even gets even worse for the obnoxious "tree" link next to each
> commit in shortlog view:
>    "The tree link is the the tree object which is part of a commit
>     object. Oh you don't know the internals of a commit object?
>     A commit object binds a tree object and a (parent) commit object,
>     but blah, blah, blah..." 
> 
> Can you see how all this apparent "simplicity" you're trying to
> introduce contradics the mere links you're introducing it with?

I don't understand you. The "tree" link in shortlog is a _shortcut_ to 
the "tree" view (and I think that one can guess that tree view means 
directory listing in the state as saved by given commit), without it 
you would have to do it in two steps, first going to commit view, then 
clicking on tree in the main navbar. So it is IMHO usefull.

Perhaps you meant "tree" header in "commit" view? There surely we could 
use ordinary link style for sha1 which is tree identifier. Cause surely 
we don't need for the sha1 to be readable, as in the case of commit 
title in the shortlog view. Additionally it would serve as a way to 
distinguish on first glance which headers are clickable, and which are 
not. And there we could I guess loose redundant headers.

[...]

> The question is: Given the average engineer, what is the gitweb
> interface such that they can start using it fastest with the minimum
> amount of  questions?

Given average user/programmer... 

>> But we agreed (I guess) to disagree on the whole redundancy in user
>> interface issue (although I agree on the issue of reducing clutter).
>> BTW. we can reduce redundancy in the code without need for removing
>> "alternate entry points" in interface, I think.
> 
> Clutter and redundancy is just a part of it.  A larger part is
> how much git or non-git oriented we want to make the interface, which
> seems related to the overall simplicity and intuitiveness.

One must pay atention to not to make interface _too simple_, and less 
usable because of it. And definition of intuitiveness depends on the 
person...

-- 
Jakub Narebski
Poland
