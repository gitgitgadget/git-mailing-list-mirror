From: Bryan Turner <bturner@atlassian.com>
Subject: Re: bug report : 2.3.5 ssh repo not found
Date: Sat, 25 Apr 2015 16:04:34 +1000
Message-ID: <CAGyf7-FVf4Pf90eaRnfNwC1JJV7ANkSGLONJZaF=eKRadnhqQA@mail.gmail.com>
References: <553B2CC8.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Chris <chrisb.duck@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 08:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YltCt-0003sA-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 08:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbbDYGEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 02:04:36 -0400
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46234 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754326AbbDYGEf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 02:04:35 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]) (using TLSv1) by na3sys009aob116.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTsucrR5nmhr2U2wzMTwqJVpXfF9EqPI@postini.com; Fri, 24 Apr 2015 23:04:35 PDT
Received: by obcux3 with SMTP id ux3so52254076obc.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 23:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3u3e0FTAyb6bIgZ15ewq0MAPk8qfXzar4VQsPWzM5lg=;
        b=ZeLqRv8L9KcMe4Mi3eR2sP67n7rG3RJGv+ASo/ux9QJa389umNDtTeaGhitd//nCRp
         jwivKj0WaY6vk4B5hyyjLNkDIk8NTzK+tYCXz9k3X+YLr4SsqqZAnl7RHsh1TkknofZ8
         1ppoaYytdi3/soHTOF0nLXG6WLTOMI9WfnWzB2RCKusd9+4W/xOSXwNwNdpKZAyhKya7
         D2IEj4aQcXrDFtvs/iTfxBa8Rl9MYtYju14vshRVGUl5/wodv/6xX2ONb/7v+lc7eexI
         4Cpi+4dKgp96NCM6VuUG/bZptlsIbnjOY4EqXP0R/AIEN/A7NAQlDPdQpcV0AlLux2HH
         zKJA==
X-Gm-Message-State: ALoCoQlxNNpC13QcgxqB29U2pHMarKKu5c/1ddt+P7KyVsCJb0s8R1l0gNJWQfoCuqJvSqBiJVmVOL0AAB6cMm5WR41aEy/A5UrOxkN2a5dFjrfXTaa2qRP8o9o8WcZc4FXunWK+3BEE8HoRt7YlkP/ROnvc34q9tg==
X-Received: by 10.60.179.6 with SMTP id dc6mr1650225oec.74.1429941874429;
        Fri, 24 Apr 2015 23:04:34 -0700 (PDT)
X-Received: by 10.60.179.6 with SMTP id dc6mr1650220oec.74.1429941874328; Fri,
 24 Apr 2015 23:04:34 -0700 (PDT)
Received: by 10.182.128.74 with HTTP; Fri, 24 Apr 2015 23:04:34 -0700 (PDT)
In-Reply-To: <553B2CC8.9020204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267776>

On Sat, Apr 25, 2015 at 3:57 PM, Chris <chrisb.duck@gmail.com> wrote:
> Hello,
>
> Using git version 2.3.5 with kernel 3.19.3-3-ARCH #1 SMP PREEMPT x86_64 I
> see the following error message when pulling or cloning a repo over ssh:
>
> """
> git clone ssh://user@mydomain:/home/user/path/to/project.git
> Cloning into 'project'...
> ssh: Could not resolve hostname mydomain:: Name or service not known
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> """

I believe that's [1]

Remove the : between the domain and the path and it should work, per
Jeff King [2]

[1] http://thread.gmane.org/gmane.comp.version-control.git/266649
[2] http://article.gmane.org/gmane.comp.version-control.git/266659

>
> Obviously I changed the url to hide credential info
>
> After ensuring DNS was OK and being able to ssh to that instance directly I
> tried downgrading git to my distro's last installed version of git version
> 2.2.2 and now I can clone / pull / push to/from that repo without issue.
>
> Is this a bug?
>
> Best,
> Chris
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
