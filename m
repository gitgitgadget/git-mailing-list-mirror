Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83441F404
	for <e@80x24.org>; Thu, 22 Feb 2018 21:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeBVVjj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 16:39:39 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:37559 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVVji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 16:39:38 -0500
Received: by mail-lf0-f47.google.com with SMTP id y19so9524148lfd.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BWMCa9ak0iYUWziWyEo4vE4gZ4y5aO59DJW7POqOsVE=;
        b=cphbucZ8upeAHq4A3C+aHGQcjaDQyO2F9JvFRs641J1RYRpmuTatv0diXpc6p45zmx
         9IJqDTjd+4LPUlithZxqd4oxbf3pwTiTHELkne5O5Igovz5o60lQjINT0q1tQDjc0y02
         fgMC4Dacfu8x5bymSjhl8+zCRa+Pzybq3cuCe6Zf09RycIl1k7AMFRhv1fF+bsZP+aVv
         Muz4Uwf4RwmnBKJXqMFDlOIs2V3vn8Ws9jU3oV+e51fIKR/TgYH7Nq6gKct4Fzs4guTj
         Y8n37gdeE1lwzJnGugqeets/Nl5Tg+Hfj/+aKWDvUr7kAbWsjOdrBsald7+AY7gA5ArS
         zTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BWMCa9ak0iYUWziWyEo4vE4gZ4y5aO59DJW7POqOsVE=;
        b=JH7b/ewaE8Nhc8xNmTKbsk4DRnlhbUavvaFqqFwkfizepimejP2R/1XacNDkvbvtrZ
         7NoN1VZx7Q+yMgFHESunnGzWz42QoGVYOhY7ft67mc2oOIDFU4MJM/kiMnpXFxY1DZE0
         kAEo8fr1U+IZr10ryHCRyqyjEUqNaTjH8R0sDr8DqOD0HgOu3Ui3hQD8RzaYtVwEEERF
         B4qwTRZAlVobk6OLDgvY8Zi4bpQa42SRMTmubV4oIaVkGxpYUs9uLloLvyopi4CsU3s2
         gfFbunN34GJNAYNJ9FPV3p6jFjMtWzMw6xFu9ubkAO8T9vq4HkmxW8oMCOlCfQKFxqj5
         eUOg==
X-Gm-Message-State: APf1xPAIW0SrZlKljaENV15TYAb5l2ElwQpIy5tP7EQnEj6IUTElLnUZ
        zMIKIRori44N8kMsnA7m76oKSb6a7MxzA9ZUEpw=
X-Google-Smtp-Source: AH8x227cGoyJri3sbY4/uojKBfdpu+dYdLxbUWq7PVO0kRPE1eqghFYMTB9zJCLQV1lR/ljCE9rnwcnmPDFktv2jn9Y=
X-Received: by 10.25.99.204 with SMTP id v73mr6029577lfi.137.1519335576501;
 Thu, 22 Feb 2018 13:39:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.22.2 with HTTP; Thu, 22 Feb 2018 13:39:35 -0800 (PST)
In-Reply-To: <20180222095022.6227-2-luke@diamand.org>
References: <20180222095022.6227-1-luke@diamand.org> <20180222095022.6227-2-luke@diamand.org>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Thu, 22 Feb 2018 22:39:35 +0100
X-Google-Sender-Auth: jsxY6XvHfPlcLp7DE2-MG1xJIdo
Message-ID: <CAKYtbVYe5hHDXf=nQzt6r9N20CrTgbEMbBS0JBBXQLpz+BVu1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add unshelve command
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

I really like the idea of creating a branch based on a shelved CL (We
particularly use shelves all the time), I tested your change and I
have some comments.

 - I have some concerns about having the same "[git-p4...change =
.....]" as if it were a real submitted CL.
    One use case I foresee of the new implementation could be to
cherry-pick that change on another branch (or current branch) prior to
a git p4 submit.

 - I see that the new p4/unshelve... branch is based on the tip of
p4/master by default. what if we set the default to the current HEAD?

 - Shelved CLs can be updated and you might have to run "git p4
unshelve" a second time to get the latest updates. if we call it a
second time it fails as it's trying to update p4/unshelve... rather
than discarding previous one and creating a new one.


Thanks,


On Thu, Feb 22, 2018 at 10:50 AM, Luke Diamand <luke@diamand.org> wrote:
> This can be used to "unshelve" a shelved P4 commit into
> a git commit.
>
> For example:
>
>   $ git p4 unshelve 12345
>
> The resulting commit ends up in the branch:
>    refs/remotes/p4/unshelved/12345
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  Documentation/git-p4.txt |  22 ++++++++
>  git-p4.py                | 128 +++++++++++++++++++++++++++++++++++------------
>  t/t9832-unshelve.sh      |  67 +++++++++++++++++++++++++
>  3 files changed, 186 insertions(+), 31 deletions(-)
>  create mode 100755 t/t9832-unshelve.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index d8c8f11c9f..910ae63a1c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -164,6 +164,21 @@ $ git p4 submit --shelve
>  $ git p4 submit --update-shelve 1234 --update-shelve 2345
>  ----
>
> +
> +Unshelve
> +~~~~~~~~
> +Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
> +in the branch refs/remotes/p4/unshelved/<changelist>.
> +
> +The git commit is created relative to the current p4/master branch, so if this
> +branch is behind Perforce itself, it may include more changes than you expected.
> +
> +----
> +$ git p4 sync
> +$ git p4 unshelve 12345
> +$ git show refs/remotes/p4/unshelved/12345
> +----
> +
>  OPTIONS
>  -------
>
> @@ -337,6 +352,13 @@ These options can be used to modify 'git p4 rebase' behavior.
>  --import-labels::
>         Import p4 labels.
>
> +Unshelve options
> +~~~~~~~~~~~~~~~~
> +
> +--origin::
> +    Sets the git refspec against which the shelved P4 changelist is compared.
> +    Defaults to p4/master.
> +
>  DEPOT PATH SYNTAX
>  -----------------
>  The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc69..59bd4ff64f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -316,12 +316,17 @@ def p4_last_change():
>      results = p4CmdList(["changes", "-m", "1"], skip_info=True)
>      return int(results[0]['change'])
>
> -def p4_describe(change):
> +def p4_describe(change, shelved=False):
>      """Make sure it returns a valid result by checking for
>         the presence of field "time".  Return a dict of the
>         results."""
>
> -    ds = p4CmdList(["describe", "-s", str(change)], skip_info=True)
> +    cmd = ["describe", "-s"]
> +    if shelved:
> +        cmd += ["-S"]
> +    cmd += [str(change)]
> +
> +    ds = p4CmdList(cmd, skip_info=True)
>      if len(ds) != 1:
>          die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
>
> @@ -2421,6 +2426,18 @@ class P4Sync(Command, P4UserMap):
>          if gitConfig("git-p4.syncFromOrigin") == "false":
>              self.syncWithOrigin = False
>
> +        self.depotPaths = []
> +        self.changeRange = ""
> +        self.previousDepotPaths = []
> +        self.hasOrigin = False
> +
> +        # map from branch depot path to parent branch
> +        self.knownBranches = {}
> +        self.initialParents = {}
> +
> +        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
> +        self.labels = {}
> +
>      # Force a checkpoint in fast-import and wait for it to finish
>      def checkpoint(self):
>          self.gitStream.write("checkpoint\n\n")
> @@ -2429,7 +2446,7 @@ class P4Sync(Command, P4UserMap):
>          if self.verbose:
>              print "checkpoint finished: " + out
>
> -    def extractFilesFromCommit(self, commit):
> +    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
>          self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
>                               for path in self.cloneExclude]
>          files = []
> @@ -2452,6 +2469,9 @@ class P4Sync(Command, P4UserMap):
>              file["rev"] = commit["rev%s" % fnum]
>              file["action"] = commit["action%s" % fnum]
>              file["type"] = commit["type%s" % fnum]
> +            if shelved:
> +                file["shelved_cl"] = int(shelved_cl)
> +
>              files.append(file)
>              fnum = fnum + 1
>          return files
> @@ -2743,7 +2763,16 @@ class P4Sync(Command, P4UserMap):
>              def streamP4FilesCbSelf(entry):
>                  self.streamP4FilesCb(entry)
>
> -            fileArgs = ['%s#%s' % (f['path'], f['rev']) for f in filesToRead]
> +            fileArgs = []
> +            for f in filesToRead:
> +                if 'shelved_cl' in f:
> +                    # Handle shelved CLs using the "p4 print file@=N" syntax to print
> +                    # the contents
> +                    fileArg = '%s@=%d' % (f['path'], f['shelved_cl'])
> +                else:
> +                    fileArg = '%s#%s' % (f['path'], f['rev'])
> +
> +                fileArgs.append(fileArg)
>
>              p4CmdList(["-x", "-", "print"],
>                        stdin=fileArgs,
> @@ -3162,10 +3191,10 @@ class P4Sync(Command, P4UserMap):
>          else:
>              return None
>
> -    def importChanges(self, changes):
> +    def importChanges(self, changes, shelved=False):
>          cnt = 1
>          for change in changes:
> -            description = p4_describe(change)
> +            description = p4_describe(change, shelved)
>              self.updateOptionDict(description)
>
>              if not self.silent:
> @@ -3235,7 +3264,7 @@ class P4Sync(Command, P4UserMap):
>                                  print "Parent of %s not found. Committing into head of %s" % (branch, parent)
>                              self.commit(description, filesForCommit, branch, parent)
>                  else:
> -                    files = self.extractFilesFromCommit(description)
> +                    files = self.extractFilesFromCommit(description, shelved, change)
>                      self.commit(description, files, self.branch,
>                                  self.initialParent)
>                      # only needed once, to connect to the previous commit
> @@ -3300,17 +3329,23 @@ class P4Sync(Command, P4UserMap):
>              print "IO error with git fast-import. Is your git version recent enough?"
>              print self.gitError.read()
>
> +    def openStreams(self):
> +        self.importProcess = subprocess.Popen(["git", "fast-import"],
> +                                              stdin=subprocess.PIPE,
> +                                              stdout=subprocess.PIPE,
> +                                              stderr=subprocess.PIPE);
> +        self.gitOutput = self.importProcess.stdout
> +        self.gitStream = self.importProcess.stdin
> +        self.gitError = self.importProcess.stderr
>
> -    def run(self, args):
> -        self.depotPaths = []
> -        self.changeRange = ""
> -        self.previousDepotPaths = []
> -        self.hasOrigin = False
> -
> -        # map from branch depot path to parent branch
> -        self.knownBranches = {}
> -        self.initialParents = {}
> +    def closeStreams(self):
> +        self.gitStream.close()
> +        if self.importProcess.wait() != 0:
> +            die("fast-import failed: %s" % self.gitError.read())
> +        self.gitOutput.close()
> +        self.gitError.close()
>
> +    def run(self, args):
>          if self.importIntoRemotes:
>              self.refPrefix = "refs/remotes/p4/"
>          else:
> @@ -3497,15 +3532,7 @@ class P4Sync(Command, P4UserMap):
>                      b = b[len(self.projectName):]
>                  self.createdBranches.add(b)
>
> -        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
> -
> -        self.importProcess = subprocess.Popen(["git", "fast-import"],
> -                                              stdin=subprocess.PIPE,
> -                                              stdout=subprocess.PIPE,
> -                                              stderr=subprocess.PIPE);
> -        self.gitOutput = self.importProcess.stdout
> -        self.gitStream = self.importProcess.stdin
> -        self.gitError = self.importProcess.stderr
> +        self.openStreams()
>
>          if revision:
>              self.importHeadRevision(revision)
> @@ -3585,11 +3612,7 @@ class P4Sync(Command, P4UserMap):
>              missingP4Labels = p4Labels - gitTags
>              self.importP4Labels(self.gitStream, missingP4Labels)
>
> -        self.gitStream.close()
> -        if self.importProcess.wait() != 0:
> -            die("fast-import failed: %s" % self.gitError.read())
> -        self.gitOutput.close()
> -        self.gitError.close()
> +        self.closeStreams()
>
>          # Cleanup temporary branches created during import
>          if self.tempBranches != []:
> @@ -3721,6 +3744,48 @@ class P4Clone(P4Sync):
>
>          return True
>
> +class P4Unshelve(Command):
> +    def __init__(self):
> +        Command.__init__(self)
> +        self.options = []
> +        self.description = "Unshelve a P4 changelist into a git commit"
> +        self.usage = "usage: %prog [options] changelist"
> +        self.options += [
> +                optparse.make_option("--no-commit", dest="noCommit",
> +                    action='store_true', default=False,
> +                    help="do not commit, just update the files"),
> +                optparse.make_option("--origin", dest="origin"),
> +        ]
> +        self.verbose = False
> +        self.noCommit = False
> +        self.origin = "p4/master"
As I mention previously, this could be an issue when having several p4 branches,
Does it make sense to set the default value of self.origin to HEAD? e.g.

> +        self.destbranch = "refs/remotes/p4/unshelved/%s"
> +
> +    def run(self, args):
> +        if len(args) != 1:
> +            return False
> +
> +        if not gitBranchExists(self.origin):
> +            sys.exit("origin branch %s does not exist" % self.origin)
> +
> +        sync = P4Sync()
> +        changes = args
> +        sync.initialParent = self.origin
> +        sync.branch = self.destbranch % changes[0]
I know this is kind of minor, but  could we use the format method instead?.
I think is more clear what was the intention. e.g

self.destbranch = "refs/remotes/p4/unshelved/{0}"
...
...
sync.branch = self.destbranch.format(changes[0])

> +        sync.verbose = self.verbose
> +
> +        log = extractLogMessageFromGitCommit(self.origin)
> +        settings = extractSettingsGitLog(log)
> +        sync.depotPaths = settings['depot-paths']
> +        sync.branchPrefixes = sync.depotPaths
> +
> +        sync.openStreams()
> +        sync.loadUserMapFromCache()
> +        sync.importChanges(changes, shelved=True)
> +        sync.closeStreams()
> +
> +        return True
> +
>  class P4Branches(Command):
>      def __init__(self):
>          Command.__init__(self)
> @@ -3775,7 +3840,8 @@ commands = {
>      "rebase" : P4Rebase,
>      "clone" : P4Clone,
>      "rollback" : P4RollBack,
> -    "branches" : P4Branches
> +    "branches" : P4Branches,
> +    "unshelve" : P4Unshelve,
>  }
>
>
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> new file mode 100755
> index 0000000000..868297507a
> --- /dev/null
> +++ b/t/t9832-unshelve.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description='git p4 unshelve'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +       (
> +               cd "$cli" &&
> +               echo file1 >file1 &&
> +               p4 add file1 &&
> +               p4 submit -d "change 1"
> +               : > file_to_delete &&
> +               p4 add file_to_delete &&
> +               p4 submit -d "file to delete"
> +       )
> +'
> +
> +test_expect_success 'initial clone' '
> +       git p4 clone --dest="$git" //depot/@all
> +'
> +
> +test_expect_success 'create shelved changelist' '
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$cli" &&
> +               p4 edit file1 &&
> +               echo "a change" >>file1 &&
> +               echo "new file" > file2 &&
> +               p4 add file2 &&
> +               p4 delete file_to_delete &&
> +               p4 opened &&
> +               p4 shelve -i <<EOF
> +Change: new
> +Description:
> +       Test commit
> +
> +       Further description
> +Files:
> +       //depot/file1
> +       //depot/file2
> +       //depot/file_to_delete
> +EOF
> +
> +       ) &&
> +       (
> +               cd "$git" &&
> +               change=$(p4 changes -s shelved -m1 | cut -d " " -f 2) &&
> +               git p4 unshelve $change &&
> +               git show refs/remotes/p4/unshelved/$change | grep -q "Further description" &&
> +               git cherry-pick refs/remotes/p4/unshelved/$change &&
> +               test_path_is_file file2 &&
> +               test_cmp file1 "$cli"/file1 &&
> +               test_cmp file2 "$cli"/file2 &&
> +               test_path_is_missing file_to_delete
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.15.1.272.gc310869385
>
