From: Andreas Ericsson <ae@op5.se>
Subject: Re: request for documentation about branch surgery
Date: Tue, 07 Jul 2009 12:06:40 +0200
Message-ID: <4A531E30.5040907@op5.se>
References: <200907070105.12821.bruno@clisp.org> <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com> <200907071151.03567.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 12:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO7Ze-0000HF-P2
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbZGGKGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 06:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZGGKGm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 06:06:42 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48463 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751659AbZGGKGl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 06:06:41 -0400
Received: from source ([74.125.78.24]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlMeMxGvLQhD+y9iNzXXtDodRmcRJMKt@postini.com; Tue, 07 Jul 2009 03:06:45 PDT
Received: by ey-out-2122.google.com with SMTP id 22so1088889eye.35
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 03:06:43 -0700 (PDT)
Received: by 10.210.61.8 with SMTP id j8mr1890911eba.37.1246961203034;
        Tue, 07 Jul 2009 03:06:43 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 7sm2966367eyg.47.2009.07.07.03.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 03:06:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200907071151.03567.bruno@clisp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122832>

Bruno Haible wrote:
> I said.
> 
> Still, can someone please extend the cited chapter of the user's manual,

Presumably you can. I'll jot down some notes for you though ;-)

> so that it answers these questions?
>   - How do I insert some commits between other commits in a branch?
>                                                        [TODO]

git rebase --interactive (don't do this on published branches).

>   - How do I reorder commits in a branch?              [TODO - mention "git rebase -i"]

git rebase --interactive

>   - How do I cut a branch?                             [TODO]

Define "cut". Possibly "git branch -d" or it's less forgiving
sibling "git branch -D", in case the branch to be removed isn't
fully merged.

>   - How do I replace a branch tip with the contents of another branch?
>                                                        [TODO]

Easily understandable:
git checkout branch
git reset --hard otherbranch

The low-level way:
git update-ref [-m <reason>] [--no-deref] <full-ref-name> <newvalue>

There are more options to git-update-ref. The man-page lists them all.

>   - How do I reconnect a branch to another branch point?
>                                                        [TODO]

I don't quite understand what you mean by "reconnect", but this might
do something along the lines of what you want:
git checkout branch-to-connect-to
git merge branch-to-be-connected

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
