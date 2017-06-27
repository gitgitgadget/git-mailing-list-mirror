Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F78220401
	for <e@80x24.org>; Tue, 27 Jun 2017 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdF0QXN (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 12:23:13 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34739 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF0QXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 12:23:11 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so18996188pfs.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v6EuKD29xYHdSapY69MT9vrOY+5pDS1TbEtXWLteyfU=;
        b=d9VBA67KWCKpD4y13qfr6Y8cTxz4RXTedRsXRLbryUEHP3GBbAAD4P0eAAo6+VwrIZ
         KVi5QTaWt7wBT8Sk6ps5pC9oC99ZDSV/xFrEq+i0Vx7YHGNy/RR2ezOWdWkRkcQCddri
         gQlV4Op7gk9fe0IFMHMNqzYx8+rEKB+uePuT5Q9LBZ1dteyqP/ghqSEbnootOEpKuHOt
         0PyQ0HvERpZ98PE758khF8IQ8nL7EU9RkIqizLAbRpvKFd1+390dRPS7kjzvi5d3dOXS
         JzaI/ABJVMhDlONK99S900uJFHOC6ps+WyX1lGqfw3pxFLJjwuma1+2gTBWI/H6ILA1B
         wT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v6EuKD29xYHdSapY69MT9vrOY+5pDS1TbEtXWLteyfU=;
        b=a6Gr38CtgJW1IdSPv1j9ezyVrM7jcM7E6IYdAqmPVXxBXTlTlhc4xYpe9V7uT2ZPFK
         DWzJn8vquAW624W6sIW0lVMOSAWVBvyOUoiNuKy3YBF4bNmnXuhqhi+viqxtUVxlIuyM
         1iJgW23aKXz258BcrvuZF+NaDzrf8TYPMAnhlpGQz5/WnDr+EjbJ4w+nmtRX1tIaai7+
         6ZozCcKxs6fvEuujDWih+0wcWGhJBtfHWII1cXzNg3oaJt1fZoqU4EaRH4qKsogKzXPU
         v104GNDtXcDUPTOUlC4uTMZKJ5hw33rOR8yUp12DfQOwpIqpX719e0VuTgASKn8YTGRt
         H2FQ==
X-Gm-Message-State: AKS2vOws+bSrCeO62Ei+B31Og5wuM4CFsX1E4+Odc+7cQKXpRPpECJV4
        T4J+7tn3XFxqfDlPC7c=
X-Received: by 10.99.65.7 with SMTP id o7mr6287057pga.90.1498580590656;
        Tue, 27 Jun 2017 09:23:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5069:b7fd:dcb0:fd8c])
        by smtp.gmail.com with ESMTPSA id t11sm7875876pfi.66.2017.06.27.09.23.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 09:23:10 -0700 (PDT)
Date:   Tue, 27 Jun 2017 09:23:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     evandrocoan <evandrocoan@hotmail.com>
Subject: "git push --recurse-submodules=on-demand" regression
Message-ID: <20170627162307.GE161648@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: evandrocoan <evandrocoan@hotmail.com>

Originally posted on:

https://github.com/git-for-windows/git/issues/1212

My git version is:
git --version --build-options

git version 2.13.0.windows.1
built from commit: eba7af3dbb4c846c6303c5f64102acee696c9ab0
sizeof-long: 4
machine: x86

cmd.exe /c ver
Microsoft Windows [Version 10.0.15063]

Before the `git version 2.13`, everything was perfect around here, but now with this version they broke my workflow:

Push: process for submodule 'Packages/Advanced CSV' failed
D:\SublimeText\Data> git.exe push --porcelain --progress --tags --recurse-submodules=on-demand origin refs/heads/develop:refs/heads/develop
src refspec 'refs/heads/develop' must name a ref
process for submodule 'Packages/Advanced CSV' failed


quote:
It looks like the git push recurse-submodules behavior has changed.
Currently with 2.13 you cannot run "git push
--recurse-submodules=on-demand" if the parent repo is on a different
branch than the sub repos, e.g. parent repo is on "develop" and
sub-repo on "master".
...
I was under the impression that Jonathan and may be others considered
the fact that `git push --recurse-submodules=on-demand` doesn't work
as before an unintentional change. He asked me previously if pushing
without a refspec will work for us and I responded with a yes. The
question remains if everyone is on board with change push without
refspec to use `push.default` in the parent repo as well as
submodules.

Cheers,
JS

git push recurse.submodules behavior changed in 2.13 https://public-inbox.org/git/CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com/T/

I did not understand the last part `without refspec to use push.default in the parent repo as well
as submodules`, is it a way to `git push --recurse-submodules=on-demand` when the parent repo is on
the `develop` branch and the submodules are on the `master` branch?

If it is not, how can I do `git push --recurse-submodules=on-demand` when the parent repo is on the
`develop` branch, but the submodules are on the `master` branch with this new git version?



What commands did you run to trigger this issue? If you can provide a
Minimal, Complete, and Verifiable example http://stackoverflow.com/help/mcve
this will help us understand the issue.

1. You need create a main repository
2. Add a git submodule to it and checkout on the master branch
3. Go to your main repository and add the master branch.
4. Go to the submodule and commit some changes on its master branch, but do not push them.
5. Go to the main repository and commit the submodule head pointer change.
6. Go to the main repository and run the command `git.exe push --recurse-submodules=on-demand`

This shell script creates some repositories and remotes which reproduce the problem:


# Create the directory structure
rm -r -f main_repo
rm -r -f main_repo_remote
rm -r -f submodule_remote

mkdir main_repo_remote
mkdir submodule_remote
mkdir main_repo
mkdir main_repo/first_submodule

cd main_repo

# Setup the first_submodule
cd first_submodule
printf "# Submodule Repository\n\n" > README.md
git init
git add README.md
git commit -m "Added the repository first commit."

git init --bare ../../submodule_remote
git remote add origin ../../submodule_remote
git push origin master

# Setup the main_repo
cd ..
printf "# Main Repo\n\nThis is the main repository which contains submodules\n" > README.md
git init
git add README.md
git submodule add -- https://github.com/user/first_submodule "first_submodule"
git commit -m "Added the main repository first commit."

git init --bare ../main_repo_remote
git remote add origin ../main_repo_remote
git push origin master
git checkout -b develop
git push origin develop

# Add an unpushed commit to the submodule
cd first_submodule
printf "Dirty\n\n" >> README.md
git add README.md
git commit -m "Added the repository second commit."

# Go to the main repository and do the push
cd ..
git add first_submodule
git commit -m "Added the main repository second commit."
git push --recurse-submodules=on-demand --set-upstream origin develop


At its last line, I am doing the push on the main repo, but it is failing on the new git version.
Currently the solution is to open the submodules which need to be pushed and push them before to
push the main repository. The problem is that the `--recurse-submodules=on-demand` should work, but
it is not.


What did you expect to occur after running these commands?
I expect to the main repository and the submodule to be pushed to the its remote branch.


What actually happened instead?
After git version `2.13` I see the error `src refspec 'refs/heads/develop' must name a ref`

If the problem was occurring with a specific repository, can you provide the URL to that repository
to help us with testing?

This issue happens mostly with my repository on its develop branch:

https://github.com/evandrocoan/SublimeTextStudio

Which has about 73 git submodules, checkout on the master branch, while the main repository is
checkout on the develop branch.
