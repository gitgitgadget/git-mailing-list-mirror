From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Sat, 15 Mar 2014 02:27:31 +0530
Message-ID: <CAD6G_RTzbJGc10doV_ZbC5bd=Zpr6rPbNXni+Yo7cxD38DCLMQ@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
	<CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
	<CAD6G_RSmpfhTr_qtdaChR9TqMZgn8BAuSNDmK5B3HJDZMyoM1Q@mail.gmail.com>
	<CADgNjan2SQXXfYfMP0sk5tqY_=c68=y0dfANF_KFaPQpzNG3yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon McCaig <bamccaig@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZAe-0003Lx-RH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 21:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbaCNU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 16:57:32 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:58320 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbaCNU5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 16:57:32 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so8146148ykp.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iqd23Fd3/iAfHd64e+IwPfjnozu9Y/HgWPerXxC26To=;
        b=HV4TCCketlpSlWtWyAL7Ab631M15HoDTubGXHlR1mQgqaZXdFO+sTQdU2IrGSzeRAg
         HpgXtTfJ6NTcclza/NHdMzVRFwzj9DFdQG0M/1gRWXT/+g6J1PXyASUvf6uuTZWismxb
         BSjooZzuDw/iJekO0ycK8E057/uCiC/fIOKskoHUD3YArbAprvkV0ALDOQoD9KfcPQqt
         vvwd1wvW3jgb3j63thQ5vsBK2S3U7QDpV61+B+8gUqdI+ySRQs3etSGgqcsN5N9h2wiF
         xXzH1C1pTf2UO2NKn0s3B+FpGZQE59mnQxaITe/2fyV4ofxZATaXcpJUn+BDN2SqmeM/
         eImA==
X-Received: by 10.236.66.143 with SMTP id h15mr13752160yhd.36.1394830651558;
 Fri, 14 Mar 2014 13:57:31 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Fri, 14 Mar 2014 13:57:31 -0700 (PDT)
In-Reply-To: <CADgNjan2SQXXfYfMP0sk5tqY_=c68=y0dfANF_KFaPQpzNG3yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244110>

On Sat, Mar 15, 2014 at 2:07 AM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On Fri, Mar 14, 2014 at 4:01 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>> On Sat, Mar 15, 2014 at 12:48 AM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>>> On Fri, Mar 14, 2014 at 1:39 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>>>> Suppose developer send 10 patches on branch1 where are changes in terms
>>>> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
>>>> is fine then I need to apply same 10 patches on to my branch2 where source
>>>> tree <dir> which is quite question here how can I do.
>>>
>>> You might be able to use the subtree option in recursive merge. Try
>>> something like:
>>>
>>>     git cherry-pick -X subtree=foo <commit>
>>>
>>> This tells git to apply the changes to the "foo" directory in your
>>> current branch (branch2).
>>
>> How do I do this?
>>
>> Suppose I'm in branch1 with two commits on foo_v2 and I need to apply them
>> on branch2 where in foo.
>
> Since this uses cherry-pick, the changes that you want to apply have
> to be on branch1 already.
>
> Let's say your branch1 looks like:
>     --A--B--C--D
> and branch2 looks like:
>     --1--2--3--4
>
> And you want to apply commits B and C on branch2, but they modify
> "foo_v1/" on branch1. You can tell git to apply the commits onto the
> directory "foo/" on branch2:
>     git checkout branch2    # make sure you're on branch2
>     git cherry-pick -X subtree=foo B C    # pick the commits
>
> If there's no conflict, the commits should apply cleanly, and your
> branch2 would become like:
>     --1--2--3--4--B'--C'

I created two commits on foo_v2 when I move branch2 and
did cherry-pick it shows below:

Mr.J> git cherry-pick -X subtree=foo
cc70089614de16b46c08f32ea61c972fea2132ce
14e9c9b20e3bf914f6a38ec720896b3d67f94c90
error: could not apply cc70089... AAAAAAAAAAAAAAAAA
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
Mr.J> ls
foo
Mr.J> gs
# On branch branch2
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#    deleted by us:      foo/foo_v2/test.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

thanks!
-- 
Jagan.
