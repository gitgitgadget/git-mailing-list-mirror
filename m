From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git-p4 Question
Date: Fri, 24 Apr 2015 08:36:57 -0600
Message-ID: <CAFcBi8-GGxrtm+f7NEf0PmWTkS0m6x2fNPt+y4bopqNLfyvyoQ@mail.gmail.com>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
	<553552FD.80703@diamand.org>
	<CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>
	<CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com>
	<CAFcBi88ZohscEZXVXbaf+6=ZKJAy9LRfn2-4WT0JV+1RodBTJg@mail.gmail.com>
	<553A0ACF.4000006@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylej1-0001yE-87
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 16:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbbDXOg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 10:36:58 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35818 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbbDXOg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 10:36:57 -0400
Received: by iejt8 with SMTP id t8so84898818iej.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZFor6lTcF4y9nQWqmqugpR4IZXZgbgzuoAwErmN0+v0=;
        b=Eqnf80brsmFlVa1R7FtIDda7YMPFUk6Ai7QS+UP8XTVrgtOHEd8tPkav5KYk65cff9
         CK5FPdalB+cGX6AVDqysEsrpIvNiZ6VW00nARrX6eRXJRtVb2Z9Tb6sj/t0Qt5ypSmtA
         OZPBdlGRuM50i/f6uPq/+JLyOoy/XLAgepHgi5LaXGXefs97ujJ95pyW4C2puNEKEC7I
         iGC3xyyT8iEsTBx0uGyuuyp9jxb5UE90yELxGm2d+WVylipOzJHxWC44RD6SUzysR1pK
         evkt+/7DTUVSFcDiPtv+Rr7f3dlXB+TPx9poJI3gDZ9o6I4Ub6Ovekh5BZaMpHoySfs4
         jt+g==
X-Received: by 10.50.143.106 with SMTP id sd10mr2886745igb.17.1429886217365;
 Fri, 24 Apr 2015 07:36:57 -0700 (PDT)
Received: by 10.79.93.199 with HTTP; Fri, 24 Apr 2015 07:36:57 -0700 (PDT)
In-Reply-To: <553A0ACF.4000006@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267740>

I get an error if I misspell part of the path. For example, if I type
//depot/maain instead of //depot/main I will get the "no such files"
message you indicated. BUT using incorrect case like //depot/main
instead of //depot/Main doesn't return any error, but still completes
and creates an empty repo. If it does require correct case, then it
should throw an error for //depot/main as well.

Let me know if you need any additional information.

On Fri, Apr 24, 2015 at 3:20 AM, Luke Diamand <luke@diamand.org> wrote:
> On 23/04/15 14:42, FusionX86 wrote:
>>
>> Hi Luke,
>>
>> I found a silly mistake I was making in the command I've been using.
>> The folder under the depot should have been capitalized, but it
>> wasn't. Also, I expected that if there was a problem with the command,
>> it would fail with some message instead of creating an empty local git
>> repo.
>
>
> I would expect that as well - it will usually create the empty git repo, but
> it should then fail with an error message, like this:
>
> $ git p4 clone //depot/main/nosuchpath
> Importing from //depot/main/nosuchpath into nosuchpath
> Initialized empty Git repository in
> /home/lgd/p4-hacking/git/nosuchpath/.git/
> Doing initial import of //depot/main/nosuchpath/ from revision #head into
> refs/remotes/p4/master
> p4 returned an error: //depot/main/nosuchpath/...#head - no such file(s).
>
> $ echo $?
> 1
>
> If you get a moment can you send your command output; if it's not doing
> something like the above, then it's a bug.
>
> Thanks!
>
> Luke
>
