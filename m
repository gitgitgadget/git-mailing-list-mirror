From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: coming from git, understanding mercurial branching
Date: Sat, 7 Sep 2013 19:42:46 -0500
Message-ID: <CAMP44s3ypvEBWnsfN5c73wT8cvGhpTnd3vbmpPfn8GMb4FVLvQ@mail.gmail.com>
References: <20130905212714.636db4c4@bigbox.christie.dr>
	<20130906175124.7d08947410503681449642ad@domain007.com>
	<20130906142927.279a994a@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 02:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIT5i-00077K-PA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab3IHAms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:42:48 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:54953 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab3IHAmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:42:47 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3903598lab.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9GGjz0hkzFIoVYxVdrJ3a2Ppt06FUlA1gTZ+81NC5pQ=;
        b=MxFkYjfl1wabSpEhrvPljJ5lFL/l8CdD1hfpLb5PuA5Uc4wvZfTmx4TFkYEcVCqXBl
         lkOmMlea0uScrAKGQv3M5veJxj6x3aVJ6rs4hYSoP7/bpf3YPnZhUQit7NEtltl62wdZ
         VkZV50Vh6Ue1SUkZinEltsazxFqyXK4kJC1/6TVK0kSPi0ssxT8eh36CcL82dhkzFyKG
         RH9YNsb3ILyO8wMXXZFj8ElMimF9W0FdDhBFWQmYXZQC7l+2gFR0b4X+ovuMyyNr98pS
         rsGTc8Z0Pg703xrEmlYas/KeQV4A6qm0qak7GheEqud+IQUKqGIxU2l9BYzTqTHa9uFx
         b22Q==
X-Received: by 10.112.168.170 with SMTP id zx10mr9489426lbb.0.1378600966274;
 Sat, 07 Sep 2013 17:42:46 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 17:42:46 -0700 (PDT)
In-Reply-To: <20130906142927.279a994a@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234152>

On Fri, Sep 6, 2013 at 2:29 PM, Tim Chase <git@tim.thechases.com> wrote:
> On 2013-09-06 17:51, Konstantin Khomoutov wrote:
>> I found this guide [1] very useful back in the time I tried to grok
>> Mercurial.
>>
>> 1.
>> http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial/

I've written various blog posts about the subject:

http://felipec.wordpress.com/2011/01/16/mercurial-vs-git-its-all-in-the-branches/
http://felipec.wordpress.com/2012/05/26/no-mercurial-branches-are-still-not-better-than-git-ones-response-to-jhws-more-on-mercurial-vs-git-with-graphs/
http://felipec.wordpress.com/2013/08/27/analysis-of-hg-and-git-branches/

> Indeed, after reading it, that's the most sense I've been able to make
> of Mercurial's strange branching.  I guess it boils down to the
> following rough heuristic:
>
> - if you want to dink around locally, but don't want to publish your
>   branches (yet), default to bookmarks using "hg bookmark"

Kind of, but then they added support to push bookmarks, so now you can
fetch and push them, so not exactly local.

In addition, they are starting to think on adding remote namespaces,
like in Git, except that jon/devel becomes jon@devel.

> - once you want a branch to be public, consider making a "real"
>   branch using "hg branch"

Not necessarily. You can merge or rebase, so "the public" doesn't see
the bookmark.

> - if you want complete isolation in case you screw up something like
>   merging, use a clone

I guess so. There's also the option of using the 'mq' extension, which
I guess it's similar to quilt.

-- 
Felipe Contreras
