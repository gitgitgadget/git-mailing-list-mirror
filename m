From: Bill Okara <billokara@gmail.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Thu, 25 Feb 2016 09:25:24 -0700
Message-ID: <CADsr5c9j1ne5K4TKZGMvoFeaNWbQxDs253Y29bfb9BsA+7A0aA@mail.gmail.com>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
	<20160225114958.GC15324@ikke.info>
	<CAGZ79kZApquSRaY_BtHrqfvuWmtYuPjeshmT-oW6T8Z7atYdFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 17:25:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYyjJ-00036W-TD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 17:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625AbcBYQZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 11:25:26 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:32840 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759764AbcBYQZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 11:25:25 -0500
Received: by mail-ob0-f171.google.com with SMTP id jq7so52600010obb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kJqzsqNn5Z7jio0RLVu0s5aBmsy9MwGP9gmr60p9opI=;
        b=tCwp9kJnhkE/8Vs/iNHzUBPBhQCjUekne8wO7LSwMmXvw1YVT1U+2MpS24VCXqGkPQ
         O4PdYyV7kQX+zACqt5JctxAItTFmBfxdxua/3SDaL1gIBHVq16/HeTbvotadzBydDUYt
         7GcTZYMY9y/jJLm1W8c3wiS7KTjZQGiyiuZn9X0Mw9QTHAbeeGhkc0NvA147k8clDvKc
         AnvsVmHVWYXzthoUppm18EdZ7a4GBPC4kZi3rTWHmzAUTp8qprJ6PoAWSKWQ+5zMmlIy
         qyj9zRvNSe5HooOSqGCYbvJCJ6Hwdmqa68EEbUfDuRV0XpMnmvPRgcNp7b1MDsnOTqaP
         JBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kJqzsqNn5Z7jio0RLVu0s5aBmsy9MwGP9gmr60p9opI=;
        b=DTcOmVPcXQfRPztqq2bT5V+cPQDSqns00mZwFePQ1o9EJ48mvnmPZ5fh2AX0vO3OAQ
         WxoBA8OOG4tkF650d3QE4ht3TUjORJnQmuDh4WEwdSm5C7KOJD7kT50GG0J+aMLEyv2C
         G4R7JgbBlA5DyGgy61AYzk+WONw7H0DY+m7+oLQwqe+4C/vXVCJNdx1rYAnGEA7dYuSG
         l+8hpZf/3llNWHvVpIKnRCyIGN9RvKuXhuzb5U5zzuqkDIGlqv6K0uPB4833wUQLMmLv
         b66VDmIAGfuL6ixNkZnc/4rN9X1zmb5ru15XVW9qyhns/Jwqk9xf021ENnxuoNpUkVXP
         JbKg==
X-Gm-Message-State: AG10YOTmWw7JOXU14RbDxZI+JIKB96Y5i6VjA9EiS4gzVKWl7rC+zBCzamjnaImvSiwNK+LQoj+nXGuMrl19EA==
X-Received: by 10.60.128.163 with SMTP id np3mr12019382oeb.16.1456417524280;
 Thu, 25 Feb 2016 08:25:24 -0800 (PST)
Received: by 10.182.17.103 with HTTP; Thu, 25 Feb 2016 08:25:24 -0800 (PST)
In-Reply-To: <CAGZ79kZApquSRaY_BtHrqfvuWmtYuPjeshmT-oW6T8Z7atYdFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287397>

resent, forgot to reply to all...

I guess a bigger concern of this issue is the mess up of history. That
is, even if not doing an merge/update, just doing the 'git mv' will
messed up the file history, as shown in following:

// Add a new resources/qa/content.txt files with a new commit message:

> mkdir gitmvtest/resources/qa
> cp gitmvtest/resources/demo/content.txt gitmvtest/resources/qa/.
> git add .
>git commit -m "Add a new QA context.txt"
[master caba387] Add a new QA context.txt
 1 file changed, 2 insertions(+)

// Do the git mv

> git checkout -b branch5
> git mv gitmvtest/resources gitmvtest/src/main/.
> git commit -m "Move resources to src/main/resources"
[branch5 dd44309] Move resources to src/main/resources
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename gitmvtest/{resources/qa =>
src/main/resources/demo}/content.txt (100%)    <-- WRONG
 rename gitmvtest/{resources/prod =>
src/main/resources/dev}/content.txt (100%)    <-- WRONG
 rename gitmvtest/{resources/dev =>
src/main/resources/prod}/content.txt (100%)    <-- WRONG
 rename gitmvtest/{resources/demo =>
src/main/resources/qa}/content.txt (100%)   <-- WRONG

// WRONG HISTORY
> git log --follow --oneline  gitmvtest/src/main/resources/demo/content.txt   <== demo/content.txt points to the new QA history
dd44309 Move resources to src/main/resources
caba387 Add a new QA context.txt                <== WRONG HISTORY



thanks,
Bill

On Thu, Feb 25, 2016 at 6:56 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Feb 25, 2016 at 3:49 AM, Kevin Daudt <me@ikke.info> wrote:
>> On Wed, Feb 24, 2016 at 04:38:11PM -0700, Bill Okara wrote:
>>> Hi,
>>>
>>> I noticed the following 'git mv' issue with:
>>> git version 2.6.4
>>>
>>>
>>> If there are identical files in different subfolders, 'git mv' the
>>> root folder (and/or each file individually) will mess up the file path
>>> mapping. that is, if having identical 'content.txt' file under
>>> gitmvtest
>>>     |--demo/content.txt
>>>     |--dev/content.txt
>>>     |--prod/content.txt
>>>
>>> after doing the "git mv gitmvtest/resources
>>> gitmvtest/src/main/resources", the 'git status' will show:
>>>
>>> renamed:    gitmvtest/resources/demo/content.txt ->
>>> gitmvtest/src/main/resources/demo/content.txt
>>> renamed:    gitmvtest/resources/prod/content.txt ->
>>> gitmvtest/src/main/resources/dev/content.txt            <== NOTE:
>>> wrongly mapped the prod/content.txt to dev/content.txt
>>> renamed:    gitmvtest/resources/dev/content.txt ->
>>> gitmvtest/src/main/resources/prod/content.txt            <== NOTE:
>>> wrongly mapped the dev/content.txt to prod/content.txt
>>>
>>> I tried running 'git mv' on each file individually, got the same problem:
>>> > git mv gitmvtest/resources/demo/content.txt gitmvtest/src/main/resources/demo/content.txt
>>> > git mv gitmvtest/resources/dev/content.txt gitmvtest/src/main/resources/dev/content.txt
>>> > git mv gitmvtest/resources/prod/content.txt gitmvtest/src/main/resources/prod/content.txt
>>>
>>> > git status
>>> renamed:    gitmvtest/resources/demo/content.txt ->
>>> gitmvtest/src/main/resources/demo/content.txt
>>> renamed:    gitmvtest/resources/prod/content.txt ->
>>> gitmvtest/src/main/resources/dev/content.txt          <== WRONG
>>> renamed:    gitmvtest/resources/dev/content.txt ->
>>> gitmvtest/src/main/resources/prod/content.txt          <== WRONG
>>>
>>>
>>> NOTE:
>>> =======
>>> if modified the content.txt in the 3 folders to contain different
>>> data, then repeating the above 'git mv' will produce correct result,
>>>
>>> renamed:    gitmvtest/resources/demo/content.txt ->
>>> gitmvtest/src/main/resources/demo/content.txt       <== CORRECT
>>> renamed:    gitmvtest/resources/dev/content.txt ->
>>> gitmvtest/src/main/resources/dev/content.txt             <== CORRECT
>>> renamed:    gitmvtest/resources/prod/content.txt ->
>>> gitmvtest/src/main/resources/prod/content.txt          <== CORRECT
>>>
>>>
>>>
>>> just want to see if this is a bug, user error (on my end), or??
>>>
>>
>> This looks like the same issue as submodule--helper list has:
>> http://article.gmane.org/gmane.comp.version-control.git/287227
>
> The submodule--helper is not called from within git-mv, so it may be
> a similar but not the same issue. ;)
>
> Looking through the code, the pathspec is not treated according to the newest
> style convention, I think it is one of the last places where the
> pathspec internals
> are poked with, instead of using parse_parsespec && match_parsespec.
> (That said it is very old hence often tested code in the wild. old
> code != bad code)
>
> Stefan
