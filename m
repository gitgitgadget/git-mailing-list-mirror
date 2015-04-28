From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How are submodule conflicts resolved during rebase?
Date: Tue, 28 Apr 2015 10:19:54 -0500
Message-ID: <CAHd499Ain-+HwOydC30YDMFFd5rh9_dk7qaRHJe1w4WUTO-_Vw@mail.gmail.com>
References: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:20:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn7Ip-0006II-Mm
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 17:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030802AbbD1PT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 11:19:57 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34951 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030402AbbD1PTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 11:19:55 -0400
Received: by iejt8 with SMTP id t8so20643081iej.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=ljJiD1+oustwZT6ctEu+PGyR31wNBPZJyEGAmlR6hho=;
        b=PU5GQnf7KFgnqQ4m4qOl3Nv+uKCCA/vYYhTz4LE5yEd7BevV+7LKAxbWwUZxA1Pd3F
         IhV+CzQn5V0D1cjp/WFwNiC3raO+5ZPkPp7FKq8y0BzcvqoeJXNMkQPj6NZWS+qm/4E5
         bC02PqjOGrzDYD5O1pTzSmzhJZVh3oabPwmalUAUpiYKwx1tVdExehuDDSOHuVuLhwxn
         kipR/KqKA+3USeQIXV4RuyWBL0Rh5AlUecmJrQExm26es41eyRGL1WO85iQWPqA3ms66
         dqHizWEk2uMOAm/v3NLYVsuMi7UJ4xwhVlXquEiTzfVyV8bPPz6ArBovpuLbUr6QvzH6
         HyCw==
X-Received: by 10.42.104.143 with SMTP id r15mr18859830ico.33.1430234394537;
 Tue, 28 Apr 2015 08:19:54 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Tue, 28 Apr 2015 08:19:54 -0700 (PDT)
In-Reply-To: <CAHd499CSshO-929PF7fiR4hpxd9J=S+XFuE3sdQHFjPvXT_C0w@mail.gmail.com>
X-Google-Sender-Auth: 8OZ4PFQLVzSuYSCp2-ePN2YP5tY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267927>

On Tue, Apr 28, 2015 at 9:34 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Hey guys,
>
> I'm using Git for Windows 2.3.6. There is a bit of confusion I have
> with regards to how submodule conflicts are resolved/handled during a
> rebase.
>
> Suppose I have a branch with 10 commits on it, 3 of those commits
> contain a change to the same (and only) submodule in the repository.
> When I rebase this branch onto the tip of its parent branch, I get a
> conflict in each of the 3 commits because the submodule also changed
> on the parent branch since my last rebase.
>
> I've seen some cases where I am asked to resolve the submodule
> conflict with local or remote. I expect this behavior and it isn't
> confusing to me. However, I have also seen cases where rebase auto
> resolves the conflicted submodule.
>
> How does Git know to auto resolve some submodule conflicts but not the
> others? I find this behavior unpredictable and I haven't found any
> documentation on it (I'm giving the git docs the benefit of the doubt
> and assuming it's there, since the git docs are very very good).
>
> Help is appreciated. Thank you.

I also have rerere enabled in my global .gitconfig. Would this result
in the behavior above? Resolve first submodule conflict, rebase
--continue, then the next one is auto resolved?
