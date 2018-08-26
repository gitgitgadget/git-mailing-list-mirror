Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D871F404
	for <e@80x24.org>; Sun, 26 Aug 2018 18:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeHZWFy (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 18:05:54 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50918 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 18:05:54 -0400
Received: by mail-it0-f50.google.com with SMTP id j81-v6so8251978ite.0
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Le+WCHMfhrbF9bCwZvJiL0kUGAOSgMYRHlxYaebUP0M=;
        b=16bNY6luTACwwg5TfZ3IIWe//Ncm25w7TEmxBXyPSzSfIU82mLfKU+i9UVTVksYY06
         MiY5YNI9iwvouaEyYig7p0+3I4lJFosL7yydN/wX+flyREZYqTG+EJNbv/jP7CgpyTrj
         KvTc5I2hD/batc2ti5j1oPkHFt4jI3XGm6Jb11H90sXzNukDcRmiqPjaPwT9QDcNVsnz
         gZCLT8dTGqc9fVZq5atRULjo1+F2TSkn2A8KH8FGEpfubat7rVVdi9rwBg9XBQ5FphYh
         W+1B+N+aOy54JSEJPE0TKkPqTawWdGO8uqHHjsTpv3fjte+rChG8AiGYWLLzwcOIz5wM
         /iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le+WCHMfhrbF9bCwZvJiL0kUGAOSgMYRHlxYaebUP0M=;
        b=lhVPVZUODbAe2R7ln0YO/ulRGrFo7BL3vwbG/ZNeIN2OuzpmDfOlg/YlipTu0AuVKZ
         RwpyV6KmlDY7pnpdsZl3MJJv5W3XKwP859+aLajreCm/BM8VvmqMOyOPCTTQGqO9ll2G
         GUaMbA/U7CrcBo554wAX9IfjAJC9hU1WObisfzEDyZfARXebvzDu6odZZUQeAI17XKY4
         VHV4bvK+4xRC9isl1hqlJiUNvsHOuZBlXQ/iPKcoVo4t/TlqCbzCQVyOC60AM1lZK8oD
         q12GjvE1Y6TEuxr2/P1GnumDeOWpqKmcDJBZES9066XGEjFlr86E8IfsAfkwrlC+GvV0
         6bdA==
X-Gm-Message-State: APzg51CYczTkNMgtqb30IomVmK2C2vDldBkr1vs8Y5dZL/dSAE9zZPXK
        k+GjR7CvHMwTm3wJcRrEMyB+teTsrMd3MZTLdbjruY9pCAc=
X-Google-Smtp-Source: ANB0VdYLwvQ9GAwKGIorRy2EDLhbquSRDHvTidWtV5spqzTym4YCV/hlf25zifhhyuIRUan7RzASSGYPf1pPpYhXQ2w=
X-Received: by 2002:a24:d9d6:: with SMTP id p205-v6mr4496894itg.89.1535307755401;
 Sun, 26 Aug 2018 11:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR10MB1517982C582BEFB7D9171EFD9B340@MWHPR10MB1517.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB1517982C582BEFB7D9171EFD9B340@MWHPR10MB1517.namprd10.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sun, 26 Aug 2018 11:22:24 -0700
Message-ID: <CAGyf7-H+YoeO5bOvTkLtViMWv85cpQsxL=gxmA592WJ8=rd8hA@mail.gmail.com>
Subject: Re: Get "Your branch is ahead of 'origin/master'" message when
 explicitly passing origin url at push command
To:     bentzy.sagiv@firemon.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 4:39 AM Bentzy Sagiv <bentzy.sagiv@firemon.com> wrote:
>
> git version 2.7.4
> ______________________________________________________________________________________________________
>
> First try: NOT passing origin url explicitly
>
> ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push

Since you didn't specify a remote here, Git assumes origin. It uses
your configured "push.default" behavior ("simple" by default) to
determine which refs to push and pushes your master branch to the
origin's master branch. Since it _knows_ it pushed to origin, it
updates your local "refs/remotes/origin/master" ref with the same
commit it just pushed, resulting in an "up-to-date" message.

>
> ubuntu@ci-bentzy:/var/lib/jenkins$ git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
> nothing to commit, working directory clean
> ubuntu@ci-bentzy:/var/lib/jenkins$
>
> ______________________________________________________________________________________________________
>
> Second try: passing origin url explicitily
>
> ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push https://bitbucket.org/OWNER/jenkinsconf-repo.git

This, on the other hand, _is not pushing to a configured remote_. It's
pushing to an explicit URL, which happens to match the URL of a
configured remote. But it's still not a configured remote. It's using
origin's URL, but you didn't push to origin. As a result,
"refs/remotes/origin/master" is not updated, and you get an "ahead"
message.

>
> ubuntu@ci-bentzy:/var/lib/jenkins$ git status
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
> nothing to commit, working directory clean
>
> ______________________________________________________________________________________________________
>
> An additional " sudo git push" (without explicit origin) solves the issue

Everything here is working as intended. If you want to push to a
_remote_, you either need to:
- Name the remote ("git push origin"), or
- Leave it off, so Git will assume origin ("git push")

Pushing to a URL that matches a remote's URL is _not_ pushing to a
remote. It's pushing to an explicit URL.

Hope this helps,
Bryan Turner
>
>
>
