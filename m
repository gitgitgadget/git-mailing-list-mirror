From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 11:18:27 +1100
Message-ID: <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
 <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnAc-0000ei-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243Ab2KOASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:18:49 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44918 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080Ab2KOASs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:18:48 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so2292415qad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 16:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=B97rIBfnLS8DEaxYIqe/PS7FOaQqPBy9jGF/FEQ1v7o=;
        b=M8fywpsGuJw43pnwiylmGw1piuT2RruaOfxvtz7WnyB6DOl6+PWCbW7ERSpyEkLSe1
         ObWfK5eqOXFWW9RTJWFg3CNjyo/I5ZwqFa+od/LqMF+LV+9sh2YIF9cm0aW6OBxlDK1i
         Wl3qG57W8qn5XcryYyk2bLS67j51JGtzZvK5riMa/JRIndJFpibErm1SGhpmFTQguy8n
         fKdpjobdCiQUGjxQt63uaQVLBCGNQOrIi1efUwBLqIcntampuAleYYjoXtwF3wcpUIzu
         DVkscirCnsMM1ITDKMA1LxlBVxtxb/6+HAGzGhn617QosKPYfcTkpv2pt0sP1jHj7zjU
         mZag==
Received: by 10.229.102.79 with SMTP id f15mr2698910qco.1.1352938728075; Wed,
 14 Nov 2012 16:18:48 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Wed, 14 Nov 2012 16:18:27 -0800 (PST)
In-Reply-To: <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209764>

On 15 November 2012 10:42, Javier Domingo <javierdo1@gmail.com> wrote:
> Hi,
>
> I have come up with this while doing some local forks for work.
> Currently, when you clone a repo using a path (not file:/// protocol)
> you get all the common objects linked.
>
> But as you work, each one will continue growing on its way, although
> they may have common objects.
>
> Is there any way to avoid this? I mean, can something be done in git,
> that it checks for (when pulling) the same objects in the other forks?

Have you seen alternates? From [1]:

> How to share objects between existing repositories?
> ---------------------------------------------------------------------------
>
> Do
>
> echo "/source/git/project/.git/objects/" > .git/objects/info/alternates
>
> and then follow it up with
>
> git repack -a -d -l
>
> where the '-l' means that it will only put local objects in the pack-file
> (strictly speaking, it will put any loose objects from the alternate tree
> too, so you'll have a fully packed archive, but it won't duplicate objects
> that are already packed in the alternate tree).

[1] https://git.wiki.kernel.org/index.php/GitFaq#How_to_share_objects_between_existing_repositories.3F


Regards,

Andrew Ardill
