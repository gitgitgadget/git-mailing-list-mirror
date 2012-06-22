From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 14:01:11 -0500
Message-ID: <4FE4C0F7.2080309@gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 21:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si96d-0001Cr-QA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 21:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2FVTBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 15:01:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41410 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2FVTBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 15:01:15 -0400
Received: by obbuo13 with SMTP id uo13so2319094obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=23mMzOKpYF31EzgLXahG5Y3QfP4FYGEhjA9FP/Q2E3A=;
        b=t1jmT+OSWFWMXpIOGzE9y4vzqmJvFSRYTY+PeOpUMu6veT+vIV70DSWipuJkubY3k6
         q+/d+NQStgjJJ4XWAgAfvJRyaAhn16+0ziUoLGm1LxucI+Fw5sj9turUhH2giUn72+Lj
         aONFJyBRbgkPJnF7ozB9KlikvX6ibDQRxxNXnQpmHnrMopUz0EQsJkftu0Uwr81pET7m
         cMoJVVbkvCklVKBx9iVHtcnwBwrWjDOibGKsU1y8zncGPH1ZKcMW18cAdW4xTVjEB+4Y
         RULeIT5j4StU0MYph1MW1h6aig/yua0gsc+qKTy7jG32lG2L+Xu+u14ZlSjNaYCplZiq
         5/MA==
Received: by 10.182.174.70 with SMTP id bq6mr3103751obc.78.1340391674743;
        Fri, 22 Jun 2012 12:01:14 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p10sm16060505oeb.0.2012.06.22.12.01.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 12:01:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200459>

On 6/22/2012 12:53 PM, Hilco Wijbenga wrote:
> Hi all,
>
> One of my developers managed to push something that somehow "diverged"
> origin/master from everyone else's local master.
>
> A --> B --> C --> D (everybody's local master)
> |
> \--> B' --> C' --> D' --> E (origin/master)
>
> (i.e., A is the commit where things diverged; everyone's local master
> points to D but the new commit (E) that was pushed to origin/master
> uses different SHA1s for B, C, and D). I hope I explained it clearly
> enough.
>
> Now running git pull creates a merge commit joining D and E.
>
> When I asked the developer what he had done he told me everything had
> looked normal. No Git warnings, nothing strange in gitk (i.e. normal
> linear history). So I do not understand what went wrong.
>
> Does anyone have any idea as to what might have happened? Perhaps if I
> understand how this happened I might be able to prevent it from
> happening again.
>
Some ways you can prevent it from happening again:
(1) setting your canonical repo config to deny non-ff, and deny deletes:
[receive]
         denyDeletes = true
         denyNonFastforwards = true
(2) have your devs do git pull --ff-only

v/r,
neal
