Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D772C20248
	for <e@80x24.org>; Sat, 23 Mar 2019 09:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfCWJJN (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 05:09:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39239 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWJJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 05:09:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so4768026wrn.6
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jN/EiMKOpKH2wi7IyWDl7TgvqzWVOP3KqtkrXBuR/ec=;
        b=dCmouJX3zZ24RVgnCvw4HmHU6B3COfbtklybly6Ygb6c2evBXF63d9WAn3FI/49ZtM
         2ZqFoGuMDwBSkb2DQotXjVhuzbWZjRaTsoaHYrIMVHx5DJRoT1DUBzr8hgJcmmrI80Dd
         m85lEiIQ+MbzQjYsn882RXQupg6w2S1B0IRag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jN/EiMKOpKH2wi7IyWDl7TgvqzWVOP3KqtkrXBuR/ec=;
        b=U0LTDlaZSx+Eb1mEPRvqyOFfh6qW/gM2FBBezixOKQRgLzlq0j/K+SdUr9TmZVZryb
         SQ+eJCOFLRCQtbKjZFzoZ/kEcLGFdMkwgH6lqf2v2c+bFDmX15lJQsBUOZdrYmWj3sW3
         F8j4K97f2kF6kUQfFb/QEfsxwM+4ROowmHLHrafrT7pxvkkB1+iK7qmmxqvXPgND/y3g
         YN4ax29MkER8Gmp2b0d/7734S8fk1byR+9YROM1aw70r7SrCMIiwJo51ryd2Z5ZyPa5S
         dfj2oxSudDR14zXZkBcNodunlv19/8B87fVL7KVpa9CdA/ZZMyWVKL6qYH0Y79Rw0u9V
         GAew==
X-Gm-Message-State: APjAAAX6EmpVIpmIJI+mIdBXMM6wG3Ooi/b6tTgU80TtBQzKRLU1Yno8
        PJvAfINtPw36AZ0HTC29hZab8yeq8WIyYA07HeoBwYaB6+9/QQ==
X-Google-Smtp-Source: APXvYqxMD87oucIwSVTwDP2oiPpye6FPOK74ODmNCyK+dcDPonVcXEnrKX0tsfqoCp/DT+4vAxwwroOQ1u6tps6OvAg=
X-Received: by 2002:adf:b64e:: with SMTP id i14mr9681976wre.10.1553332150416;
 Sat, 23 Mar 2019 02:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553283214.git.amazo@checkvideo.com> <b02df749b9266ac8c73707617a171122156621ab.1553283214.git.amazo@checkvideo.com>
In-Reply-To: <b02df749b9266ac8c73707617a171122156621ab.1553283214.git.amazo@checkvideo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 23 Mar 2019 09:08:59 +0000
Message-ID: <CAE5ih797T4vtuFsDhXuNGX+A89ZQ26GOae9Dt4PVaCwJ8C_GVg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] git-p4: introduce alien branch mappings
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrey <ahippo@yandex.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Mar 2019 at 19:54, Mazo, Andrey <amazo@checkvideo.com> wrote:
>
> Labels in Perforce are not global, but can be placed on a particular view/subdirectory.
> This might pose difficulties when importing only parts of Perforce depot into a git repository.
> For example:
>  1. Depot layout is as follows:
>     //depot/metaproject/branch1/subprojectA/...
>     //depot/metaproject/branch1/subprojectB/...
>     //depot/metaproject/branch2/subprojectA/...
>     //depot/metaproject/branch2/subprojectB/...
>  2. Labels are placed as follows:
>     * label 1A on //depot/metaproject/branch1/subprojectA/...
>     * label 1B on //depot/metaproject/branch1/subprojectB/...
>     * label 2A on //depot/metaproject/branch2/subprojectA/...
>     * label 2B on //depot/metaproject/branch2/subprojectB/...
>  3. The goal is to import
>     subprojectA into subprojectA.git and
>     subprojectB into subprojectB.git
>     preserving all the branches and labels.
>  4. Importing subprojectA.
>     Label 1A is imported fine because it's placed on certain commit on branch1.
>     However, label 1B is not imported because it's placed on a commit in another subproject:
>     git-p4 says: "importing label 1B: could not find git commit for changelist ..."
>     The same is with label 2A, which is imported; and 2B, which is not.
>
> Currently, there is no easy way (that I'm aware of) to tell git-p4 to
> import an empty commit into a desired branch,
> so that a label placed on that changelist could be imported as well,

So there is a file in subprojectA/foo.c@41.
And label 1B is against //depot/metaproject/branch1/subprojectB/bar.c@42.

And I suppose in Perforce you could still checkout subprojectA at
change 42 and you would get change 41.

But with the way git-p4 works, the label just gets discarded.

You want to be able to checkout the subjectA with a tag called 1B and
get the file contents as of 42.

I wonder if it would be easier to teach the code in importP4Labels to
go searching harder for the next lower changelist number?

Where it currently says "could not find git commit"... could it do
something like "p4 changes -m1 //depot/path/...@LABEL" and use that
instead?

I'm not sure if that would work but it would mean you wouldn't need
any extra configuration to maintain.

But perhaps I have misunderstood what you're trying to do here!
Perhaps a failing test case might help explain it better?

Thanks
Luke



> It might be possible to get a similar effect by importing both subprojectA and B in a single git repo,
> and then running `git filter-branch --subdirectory-filter subprojectA`,
> but this might produce way more irrelevant empty commits, than needed for labels.
> (although imported changelists can be limited with git-p4 --changesfile option)
>
> So, introduce a concept of an "alien" branch.
>
> In the above example of importing subprojectA,
>  * branch1/subprojectB is an alien branch for branch1/subprojectA;
>  * branch2/subprojectB is an alien branch for branch2/subprojectA.
> Any changelist for branch1/subprojectB will be imported into subprojectA.git branch1
> as an empty commit for the sole purpose of being labeled with a tag later
> or just to preserve the history of changes across the branches.
>
> This relation between branches is specified in a similar way to branchList:
> `git config --add git-p4.alienLabelBranchMap alien_branch:real_branch`
>
> For the example of importing subprojectA above, config parameters are
> ```
> git config --add git-p4.branchList branch1/subprojectA:branch2/subprojectA
> git config --add git-p4.alienLabelBranchMap branch1/subprojectB:branch1/subprojectA
> git config --add git-p4.alienLabelBranchMap branch2/subprojectB:branch2/subprojectA
> ```
>
> A similar use case, is when a label is placed on a changelist for an excluded path.
>  1. Depot layout is as follows:
>     //depot/branch1/...
>     //depot/branch1/exclude_me/...
>  2. Labels are placed as follows:
>     * label 1  on //depot/branch1/...
>     * label 1E on //depot/branch1/exclude_me/...
>  3. The goal is to import
>     //depot/... into depot.git excluding files under
>     //depot/branch1/exclude_me/...
>     and preserving all the branches and labels.
>  4. Importing subprojectA.
>     Label 1 is imported fine because it's placed on certain commit on branch1.
>     However, label 1E is not imported because it's placed on a commit which is excluded.
>
> For this use case, the config would be
> ```
> git config --add git-p4.alienLabelBranchMap branch1/exclude_me:branch1
> ```
>
> Note that the current implementation doesn't process alien branches
> when a clientspec is used.
>
> Diff best viewed with --ignore-all-space .
>
> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
> ---
>
> Notes:
>     Documentation changes and tests are obviously missing,
>     but I hoped to get some feedback on the idea overall
>     before working on those.
>
>     A better name for "alien" branches is very welcome.
>
>  git-p4.py | 59 ++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 12 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 148ea6f1b0..40bc84573b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2610,10 +2610,12 @@ def __init__(self):
>
>          # map from branch depot path to parent branch
>          self.knownBranches = {}
>          self.initialParents = {}
>
> +        self.knownAlienLabelBranches = {}
> +
>          self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
>          self.labels = {}
>
>      # Force a checkpoint in fast-import and wait for it to finish
>      def checkpoint(self):
> @@ -2705,14 +2707,37 @@ def splitFilesIntoBranches(self, commit):
>          if self.clientSpecDirs:
>              files = self.extractFilesFromCommit(commit)
>              self.clientSpecDirs.update_client_spec_path_cache(files)
>
>          branches = {}
> +        alienBranches = {}
>          fnum = 0
>          while "depotFile%s" % fnum in commit:
>              path =  commit["depotFile%s" % fnum]
>              found = self.isPathWanted(path)
> +
> +            # start with the full relative path where this file would
> +            # go in a p4 client
> +            if self.useClientSpec:
> +                # with a clientspec, we won't know where the file goes if it's excluded
> +                if found:
> +                    relPath = self.clientSpecDirs.map_in_client(path)
> +                else:
> +                    relPath = None
> +            else:
> +                # without a clientspec, we can guess a file path even if it's excluded
> +                relPath = self.stripRepoPath(path, self.depotPaths)
> +
> +            # Process alien branches before excludes (i.e. before respecting `found`) --
> +            # picking (empty) commits from excluded paths is one of the use-cases for alien branches.
> +            # We don't commit any files for alien branches, so don't violate excludes.
> +            for (alienPath, ourPath) in self.knownAlienLabelBranches.items():
> +                if relPath is not None and p4PathStartsWith(relPath, alienPath + '/') and ourPath in self.knownBranches:
> +                    # we don't put any files since they are under the paths, we're not interested in.
> +                    # however, we still want the commit message and etc.
> +                    alienBranches[ourPath] = [{"alienPath": alienPath}]
> +
>              if not found:
>                  fnum = fnum + 1
>                  continue
>
>              file = {}
> @@ -2720,26 +2745,23 @@ def splitFilesIntoBranches(self, commit):
>              file["rev"] = commit["rev%s" % fnum]
>              file["action"] = commit["action%s" % fnum]
>              file["type"] = commit["type%s" % fnum]
>              fnum = fnum + 1
>
> -            # start with the full relative path where this file would
> -            # go in a p4 client
> -            if self.useClientSpec:
> -                relPath = self.clientSpecDirs.map_in_client(path)
> -            else:
> -                relPath = self.stripRepoPath(path, self.depotPaths)
> -
>              for branch in self.knownBranches.keys():
>                  # add a trailing slash so that a commit into qt/4.2foo
>                  # doesn't end up in qt/4.2, e.g.
>                  if p4PathStartsWith(relPath, branch + "/"):
>                      if branch not in branches:
>                          branches[branch] = []
>                      branches[branch].append(file)
>                      break
>
> +        # not on any branch, check out our alien mapping
> +        if not branches:
> +            branches = alienBranches
> +
>          return branches
>
>      def writeToGitStream(self, gitMode, relPath, contents):
>          self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
>          self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
> @@ -3283,10 +3305,17 @@ def getBranchMappingFromGitBranches(self):
>                  branch = "main"
>              else:
>                  branch = branch[len(self.projectName):]
>              self.knownBranches[branch] = branch
>
> +    def getAlienLabelBranchMapping(self):
> +        alienLabelBranches = gitConfigList("git-p4.alienLabelBranchMap")
> +        for mapping in alienLabelBranches:
> +            if mapping:
> +                (alien, ours) = mapping.split(":")
> +                self.knownAlienLabelBranches[alien] = ours
> +
>      def updateOptionDict(self, d):
>          option_keys = {}
>          if self.keepRepoPath:
>              option_keys['keepRepoPath'] = 1
>
> @@ -3396,17 +3425,22 @@ def importChanges(self, changes, origin_revision=0):
>
>              try:
>                  if self.detectBranches:
>                      branches = self.splitFilesIntoBranches(description)
>                      for branch in branches.keys():
> -                        ## HACK  --hwn
> -                        branchPrefix = self.depotPaths[0] + branch + "/"
> -                        self.branchPrefixes = [ branchPrefix ]
> +                        # hack branch prefix and file list for alien branches
> +                        if branches[branch] and "alienPath" in branches[branch][0]:
> +                            branchPrefix = self.depotPaths[0] + branches[branch][0]["alienPath"] + "/"
> +                            filesForCommit = []
> +                        else:
> +                            ## HACK  --hwn
> +                            branchPrefix = self.depotPaths[0] + branch + "/"
> +                            filesForCommit = branches[branch]
>
> -                        parent = ""
> +                        self.branchPrefixes = [branchPrefix]
>
> -                        filesForCommit = branches[branch]
> +                        parent = ""
>
>                          if self.verbose:
>                              print("branch is %s" % branch)
>
>                          self.updatedBranches.add(branch)
> @@ -3715,10 +3749,11 @@ def run(self, args):
>
>              if self.hasOrigin:
>                  self.getBranchMappingFromGitBranches()
>              else:
>                  self.getBranchMapping()
> +                self.getAlienLabelBranchMapping()
>              if self.verbose:
>                  print("p4-git branches: %s" % self.p4BranchesInGit)
>                  print("initial parents: %s" % self.initialParents)
>              for b in self.p4BranchesInGit:
>                  if b != "master":
> --
> 2.19.2
>
