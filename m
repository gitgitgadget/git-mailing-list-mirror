From: "David Neu" <david@davidneu.com>
Subject: Re: Converting from svn to git
Date: Mon, 11 Aug 2008 13:46:43 -0400
Message-ID: <e0b44a890808111046q2626defdnab31b0d7b1c4578@mail.gmail.com>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
	 <20080810132409.GE18960@genesis.frugalware.org>
	 <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
	 <g7n1mk$67t$1@ger.gmane.org>
	 <e0b44a890808100848p367f5c66qfa21cba1b3ba12a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Aug 11 19:48:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSbUi-0007Ua-Ch
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 19:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYHKRqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYHKRqq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 13:46:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:54364 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbYHKRqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 13:46:45 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1300978wxd.4
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 10:46:44 -0700 (PDT)
Received: by 10.70.63.12 with SMTP id l12mr11167689wxa.45.1218476804466;
        Mon, 11 Aug 2008 10:46:44 -0700 (PDT)
Received: by 10.70.53.6 with HTTP; Mon, 11 Aug 2008 10:46:43 -0700 (PDT)
In-Reply-To: <e0b44a890808100848p367f5c66qfa21cba1b3ba12a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91967>

OK, I did

$ git-filter-branch --tree-filter 'rm -rf subdir1/ subdir2/ subdir3/' -- --all

which looks good, except when I open gitk, I still see "empty" commits
that correspond to subdir1/, subdir2/ and subdir3/.

Is there anyway to remove those?

Many thanks!

Cheers,
David

On Sun, Aug 10, 2008 at 11:48 AM, David Neu <david@davidneu.com> wrote:
> That's great - thanks to everyone!
>
> On Sun, Aug 10, 2008 at 11:32 AM, Michael J Gruber
> <michaeljgruber+gmane@fastmail.fm> wrote:
>> David Neu venit, vidit, dixit 10.08.2008 16:54:
>>>
>>> Thanks for the reply - this looks like what I'd need, but
>>> I can't see how to keep the contents of the base dir and
>>> lose the subdirs, e.g.
>>>
>>> $ git-filter-branch --subdirectory-filter . HEAD
>>>
>>> removes all subdirs and the contents of the base dir.
>>>
>>> So, I figure I'd remove each subdir, using
>>>
>>> $ git-filter-branch --tree-filter 'rm -rf subdir1/' HEAD
>>>
>>> but this complains if subdir1 contains subdirectories, it
>>> says: Namespace refs/original/ not empty
>>
>> It complains because filter-branch stores the original refs in that
>> namespace, and on the second filter-branch run it wants to do this again.
>> You can avoid this by using the "-f" option to filter-branch, or by removing
>> all subsirs in one go ("rm -rf subdir1 subdir2..."). Also, you might want to
>> rewrite all refs ("--all"), not just HEAD.
>>
>> Michael
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
