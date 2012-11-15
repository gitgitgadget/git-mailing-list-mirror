From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 11:53:19 +1100
Message-ID: <CAH5451m4saVa7-NLbVbXp7q8ca5_0N4FLk3wYaqxLT=AE5frbw@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
 <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
 <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com> <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYniN-0008WU-DU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123Ab2KOAxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:53:41 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59359 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab2KOAxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:53:40 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so798092qat.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 16:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cXHZ/8Z4kwocFhyU2HWphiW17fbAAbb2d6w0G1VFgM0=;
        b=BQEj5qRlLH7LYJrRO9ikv4ObP31V407j6EHrpQuoOd+9cN9+ygdKXAK3Q7OYE7LMlH
         jYIkJv80W+Edkjh+nf3OUd6rhoOJcFONajHGKrd/u4b4XUSrEMmZk4DIaGRN471GtlPX
         DOT5xzWr2tIK99bxzA+Cpvkqszu2b2lswUCHox0iRrvN6FJZx+PHYmR1kXgXeCU6Kalz
         DbSy3e8Lcnt4bbblgyAIqkpyb+xCJYbtN7G63XxQdkoWdXT4l/qNg9LukI0zpAShqdMG
         LTs55A2MxQWT4VhdnR76cFDVjht3ksztQLFBVcdWEYTveztOZqSVXNufCxLpK9QYEwSM
         ZBPw==
Received: by 10.49.28.231 with SMTP id e7mr33029261qeh.49.1352940820328; Wed,
 14 Nov 2012 16:53:40 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Wed, 14 Nov 2012 16:53:19 -0800 (PST)
In-Reply-To: <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209776>

On 15 November 2012 11:40, Javier Domingo <javierdo1@gmail.com> wrote:
> Hi Andrew,
>
> The problem about that, is that if I want to delete the first repo, I
> will loose objects... Or does that repack also hard-link the objects
> in other repos? I don't want to accidentally loose data, so it would
> be nice that althought avoided to repack things, it would also
> hardlink them.

Hi Javier, check out the section below the one I linked earlier:

> How to stop sharing objects between repositories?
>
> To copy the shared objects into the local repository, repack without the -l flag
>
> git repack -a
>
> Then remove the pointer to the alternate object store
>
> rm .git/objects/info/alternates
>
> (If the repository is edited between the two steps, it could become corrupted
> when the alternates file is removed. If you're unsure, you can use git fsck to
> check for corruption. If things go wrong, you can always recover by replacing
> the alternates file and starting over).

Regards,

Andrew Ardill
