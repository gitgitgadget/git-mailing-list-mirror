From: Zhi Li <lizhi1215@gmail.com>
Subject: Re: how can I push a sub-tree
Date: Fri, 18 Dec 2009 10:05:13 +0800
Message-ID: <2986b3940912171805s6cbdb974u31f1b8ef5c65b7c7@mail.gmail.com>
References: <2986b3940912170150o17118a07i8f91e785c08e2ac9@mail.gmail.com>
	 <be6fef0d0912170214u433769e3ucf8180022aa72fb3@mail.gmail.com>
	 <2986b3940912171655t397f90b2tf28bac3555181292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 03:05:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLSDr-0000cy-Qf
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 03:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885AbZLRCF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 21:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757873AbZLRCF0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 21:05:26 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:62186 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757027AbZLRCFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 21:05:14 -0500
Received: by iwn1 with SMTP id 1so1882251iwn.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aAEJt63JpffZbDJWZ0Gt7c/OLR2vNWAQcGqN2g+riqo=;
        b=yACXUNkZRCmfoQ24G3j/mU65OrR54rKnPVis90PB6bW7wSWCH8hSfCGIRWJShoQzrG
         4uUJy5pTwZ+SuN4HWBfRrWfLRql7NWYaA1HLb4Pv7juIf4Vq36SH8+HLTgSXDnl4MbSN
         2/L492c+xftQ50gSN4IdTL7qU4BzUejGKapzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XS8LhRKz5bs21Dh9hStGJCOaA4AClADYqE+Iuzf8XlGq5tCjFs6ejtQOm+3RC8czbh
         Q/p3CqLzTIl3eISYNXRyHzhj5YieNzC5suXydFe9YUhIV+qu+ztxaJZHssl6EReu28MP
         DYobch7mBuOYJPvU196d+jhXHKTYIUruj6qCI=
Received: by 10.231.29.149 with SMTP id q21mr430477ibc.35.1261101913192; Thu, 
	17 Dec 2009 18:05:13 -0800 (PST)
In-Reply-To: <2986b3940912171655t397f90b2tf28bac3555181292@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135394>

Hi,

I found a way to do it, but I do not know whether it is the simplest.

In master branch, run "git cat-file -p" several times to find rack
sub-tree sha. Then check-out branch "rack_branch", run "git read-tree
sha". The sha is that one just get by "git cat-file -p". Finally,
git-commit, git-push...

Cheers,
Zhi

On Fri, Dec 18, 2009 at 8:55 AM, Zhi Li <lizhi1215@gmail.com> wrote:
> Hi,
>
> Not sub-module, but sub-tree.
>
> My problems are:
> $ git remote add rack_remote git@github.com:schacon/rack.git
> $ git fetch rack_remote
> $ git branch rack_branch rack_remote/master
> $ git read-tree --prefix=rack/ -u rack_branch
>
> Now in master branch, I have a sub-tree rack. Later I modified
> something in rack sub-tree. Then, how could I push my changes to
> rack_remote?
>
> Thanks
> Zhi
>
> On Thu, Dec 17, 2009 at 6:14 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> Hi,
>>
>> On Thu, Dec 17, 2009 at 5:50 PM, Zhi Li <lizhi1215@gmail.com> wrote:
>>> I tried to find a way to push a sub-tree. In section 6.7 of "Pro Git",
>>> there's a way for pulling a git sub-tree. But I have not found the
>>> opposite: push a git sub-tree. Can someone help me?
>>
>> I've not read the book, but perhaps you mean submodules?
>>
>> If so, refer to the part in the git submodule tutorial that describes
>> how to make changes within a submodule on the GitWiki at
>> http://git.or.cz/gitwiki/GitSubmoduleTutorial.
>>
>> --
>> Cheers,
>> Ray Chuan
>>
>
