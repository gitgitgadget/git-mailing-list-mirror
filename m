From: Diego Viola <diego.viola@gmail.com>
Subject: Re: Please consider adding a -f switch to git-clone (or something similar)
Date: Sun, 8 Mar 2015 15:27:01 -0300
Message-ID: <CA+ToGPFZ3JUZJJch03Cc=r7oRj_CKaBwMFCnG0y8XGT6RJYZ2A@mail.gmail.com>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com>
	<87d24kzbor.fsf@igel.home>
	<CA+ToGPHOM9mu_ng4wVc7QUGyvf09y=nDjE32oSh9JzKbpbzN2Q@mail.gmail.com>
	<CA+ToGPFSbOjfd5gJg+r-7WkwMB=m=4sOupaZo1WUn+O0bxAAXw@mail.gmail.com>
	<569EEC82-664C-48A7-990D-BFCDB7D78D16@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 19:27:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUfuv-0006I8-IQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 19:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbbCHS1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 14:27:06 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34701 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbCHS1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 14:27:03 -0400
Received: by labhs14 with SMTP id hs14so66733141lab.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rUD3hbvYn9FfeODXUZpgJcpg0XOXCYX6DVmojl3eoEo=;
        b=iKLDVNzLHXFh8GObWRBj5zvLGrALGu5N7d32bbr5K2gUXcfkpF+m1i/g00HTJtSUHe
         4pfGs3zU9O47eyDfxIInpE7ozDhIwovyXl0HW1e8aKkwbk6Tl4YRiEC3/eYxvV4u5C8Q
         6/LpgGFZj3uJWcivE83yAXRFfi+UrgM57hBeWXlT7/hwfyU7QThQNjTTWjY4dX258a1H
         QzvytF7Dcv9tdY+1trEe1KFT10UN+BlEOOPaGEKW0S3mfn3QzYlQKAlFg3JHmWN2JABq
         sa74+0o57l856N4OmM+/ue+ePeN5DVSKd8GQFQaGDFHPug5QQmFGBUupPBoNlOfwh1QK
         5tEw==
X-Received: by 10.112.166.102 with SMTP id zf6mr18596788lbb.24.1425839221563;
 Sun, 08 Mar 2015 11:27:01 -0700 (PDT)
Received: by 10.114.1.208 with HTTP; Sun, 8 Mar 2015 11:27:01 -0700 (PDT)
In-Reply-To: <569EEC82-664C-48A7-990D-BFCDB7D78D16@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265101>

Kyle,

Thanks, I suppose that works well enough for my needs. I wasn't aware
that aliases were that flexible in git.

I also have no problem to git-init and do all the other steps manually.

Thanks,

Diego

On Sat, Mar 7, 2015 at 11:32 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Mar 7, 2015, at 17:53, Diego Viola wrote:
>>
>> Something like this is the scenario I'm talking about:
>>
>> $ mkdir non-empty-dir
>> $ cd non-empty-dir
>> $ touch foo bar baz
>> $ git clone -f url:user/dotfiles.git .
>> $ git status
>> On branch master
>> Your branch is up-to-date with 'origin/master'.
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>
>>    bar
>>    baz
>>    foo
>>
>> nothing added to commit but untracked files present (use "git add" to
>> track)
>
>
> Have you considered using an alias?
>
> git config --global alias.irfc \
>   '!sh -c '\''git init && git remote add origin "$1" && git fetch && git
> checkout "${2:-master}"'\'' sh'
>
> (You'll likely have to carefully unwrap that line above.)
>
> Then you get
>
>   git irfc <URL> [<branch>]
>
> where <branch> defaults to master.
> So your scenario would become just:
>
>
>
> $ mkdir non-empty-dir
> $ cd non-empty-dir
> $ touch foo bar baz
> $ git irfc url:user/dotfiles.git
> $ git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
> Untracked files:
>  (use "git add <file>..." to include in what will be committed)
>
>    bar
>    baz
>    foo
>
> nothing added to commit but untracked files present (use "git add" to track)
>
>
> -Kyle
>
> P.S. irfc = init, remote, fetch, checkout.  But do make up a better name. :)
