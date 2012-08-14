From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 09:02:29 -0700
Message-ID: <CAJsNXTmUB-isPVHPcWupL-gAag--DzhdkazXj0Z+aEbv+_w7Rg@mail.gmail.com>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1JZl-00070I-DC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 18:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab2HNQCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 12:02:32 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41934 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777Ab2HNQCb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2012 12:02:31 -0400
Received: by lagy9 with SMTP id y9so295056lag.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1B7hRwtEzkrWKXaq+0r+1EqnS2aGhHVTy7yqA+qINyE=;
        b=JHvgMWii6p4z0KdnaOMoTXquPkorZE1W3XpLWJBMe79Bn0/rZbjp4IM/h02cii8haq
         +OGfKcEcyfk3HIRJAFJIfVTm6Pb5rnfKsAiVMGgrMIZD9myise/ubicGhohVvFfCmOgK
         JtH5PhlCPUxbWBs+4MzOWEDL7E9h6p9yJIP/LXPYainO4L82hugetFzB/EqdTe1MDeBu
         I+qK1V++/EpZSHPriH9ZEBZp6WbRuKaMEcKTphvJ25DItggFA1GU4yp6NDF8q6UViHLN
         W2IiScOpKOzvDS8YHQLpmXR+Da7U+N4mgVby9ssZ1OqUJm/+icGR21VOqY09hFs7JPNH
         VXCQ==
Received: by 10.112.47.133 with SMTP id d5mr8208992lbn.47.1344960149798; Tue,
 14 Aug 2012 09:02:29 -0700 (PDT)
Received: by 10.112.60.197 with HTTP; Tue, 14 Aug 2012 09:02:29 -0700 (PDT)
In-Reply-To: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
X-Google-Sender-Auth: 1dpIDyz9chhlEzPe_MlFJc-a68Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203407>

On Mon, Aug 13, 2012 at 12:58 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Hi all,
>
> A colleague of mine (after a relatively long absence) noticed the
> following when running "git status":
>
> # On branch master
> # Your branch and 'origin/master' have diverged,
> # and have 250 and 19 different commit(s) each, respectively.
> #
> nothing to commit (working directory clean)
>
> He asked me what to do and I told him to do what has always worked for
> me in the past when something like this happened: gitk, "reset master
> branch to here" (to a commit before the divergence and using --hard),
> git pull origin master. Problem solved.
>
> Well, not this one. This one is persistent. :-) I am at a loss what to
> do. "master" and "origin/master" do *not* point at the same commit.
> Even after the "git reset --hard ..." and "git pull". Running my
> silver bullet solution gets us in the same situation every time.

I assume that the commit you reset to wasn't actually before the
divergence, then.  It sounds like what you're trying to do is just
long-hand for 'git reset --hard origin/master'.  As mentioned before,
that *does* assume that you want to throw out everything you've
committed locally.  If that's *not* the case, try 'git rebase
origin/master' or 'git pull --rebase'.  And then go slap the person
who rewrote the history of origin/master.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
