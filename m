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
	by dcvr.yhbt.net (Postfix) with ESMTP id C03F31F404
	for <e@80x24.org>; Mon, 26 Feb 2018 23:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeBZX3W (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 18:29:22 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:45505 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeBZX3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 18:29:19 -0500
Received: by mail-lf0-f53.google.com with SMTP id x196so24766615lfd.12
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yZIYfp+N/7I/nZ+mkkQ4zIxPFFioi2FyjI6u2BFmv90=;
        b=H1g4OCxCpGRVmKdlhlFPLcrJiyZL67Pxjw1Gg+w1ELsyIWmoJrstQOgvf4Io94Oqzj
         CgKYz6/RvJt7BiCqJY0D9aqtKzSSHBDtQ8QrBp1EnL95H/vWAu9QYQ0kstV+LvpbZJnm
         9mcavdJ8ZlazSzLQbiE/unq+43rzLJLMvecQ1KOBE93lMbp7IqWUxcW5HQ1E7b/oyl36
         OIsEjVwHr275CFgfkEw8O3vwLmDuYW2vbrT32p4glWArNghH44EBLp80fK3IdWqtWq5T
         4voN80IpQXi+4YDi7pEzp/Ifz6550qar/hWY0o/89RXNtVTjKHR7dl3rrQLBa+RW4LY9
         KXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yZIYfp+N/7I/nZ+mkkQ4zIxPFFioi2FyjI6u2BFmv90=;
        b=D6VGuD9S1OM3IibURRKPnHt7VdkyyzFadOy4482OCI9ahSMb6MT1e93QxDG1GOh/Ut
         2k1tpwPaj0XWQC9wDiT8Gj8dsnMatpVpppCSx/u8DEwhidFcdwoVkzerxVEljI8xDwSj
         SB2R14x63eMg4oWZOhlPY649+u8uJKMDjbbstPZnM7fT3cqYRq1FwlOJe4s/aVbh6Xug
         CRWpgiiACjXNBPUvSj/kBjfas75tzB/WrZPMZPd5YXNWF/S+0d9+EsWZtWSzmj4iCkvg
         8NuJf51hyxUXWG1+E+ztwPBD4wqm6ZT73DIaPx7572bz2Zs29FtIA7Epj7QuUIXCKDsI
         BM3g==
X-Gm-Message-State: APf1xPBe9Vr3GcKUNATR5oMZml0W5iZRvg9TB3JcFhh/ioD3VOTWGzRZ
        4JJlUJmRlvc51Dya5Xx2zcU7kdUC2aQeknLfc2c=
X-Google-Smtp-Source: AG47ELsQK5cISPJ+kwSZ44KqscGGujuLifiMOcpDl25z65+kDs8Z/M1svP6SMGheyyr0UKHHww+NaBuGpFkPml6sl7Y=
X-Received: by 10.46.88.27 with SMTP id m27mr8647919ljb.132.1519687757785;
 Mon, 26 Feb 2018 15:29:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.22.2 with HTTP; Mon, 26 Feb 2018 15:29:16 -0800 (PST)
In-Reply-To: <20180226114822.1617-2-luke@diamand.org>
References: <20180226114822.1617-1-luke@diamand.org> <20180226114822.1617-2-luke@diamand.org>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Tue, 27 Feb 2018 00:29:16 +0100
X-Google-Sender-Auth: Wu-3Njn-9g7Va7t97nqcp7JIPLo
Message-ID: <CAKYtbVYdJVj2Z1XMNURJMaCN8Ur47zZCQrUFvenPoAYePbEi6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add format-patch subcommand
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

very nice subcommand, I tested it with a shelved CL and a submitted CL.
Find my comments inline

On Mon, Feb 26, 2018 at 12:48 PM, Luke Diamand <luke@diamand.org> wrote:
> It takes a list of P4 changelists and generates a patch for
> each one, using "p4 describe".
>
> This is especially useful for applying shelved changelists
> to your git-p4 tree; the existing "git p4" subcommands do
> not handle these.
>
> That's because they "p4 print" the contents of each file at
> a given revision, and then use git-fastimport to generate the
> deltas. But in the case of a shelved changelist, there is no
> easy way to find out what the previous file state was - Perforce
> does not have the concept of a single repo-wide revision.
>
> Unfortunately, using "p4 describe" comes with a price: it cannot
> be used to reliably generate diffs for binary files (it tries to
> linebreak on LF characters) and it is also _much_ slower.
>
> Unicode character correctness is untested - in theory if
> "p4 describe" knows about the character encoding it shouldn't
> break unicode characters if they happen to contain LF, but I
> haven't tested this.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  Documentation/git-p4.txt |  33 +++++
>  git-p4.py                | 304 +++++++++++++++++++++++++++++++++++++++++++++--
>  t/t9832-make-patch.sh    | 135 +++++++++++++++++++++
>  3 files changed, 462 insertions(+), 10 deletions(-)
>  create mode 100755 t/t9832-make-patch.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index d8c8f11c9f..1908b00de2 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -164,6 +164,28 @@ $ git p4 submit --shelve
>  $ git p4 submit --update-shelve 1234 --update-shelve 2345
>  ----
>
> +
> +format-patch
> +~~~~~~~~~~
> +This will attempt to create a unified diff (using the git patch variant) which
> +can be passed to patch. This is generated using the output from "p4 describe".
> +
> +It includes the contents of added files (which "p4 describe" does not).
> +
> +Binary files cannot be handled correctly due to limitations in "p4 describe".
> +
> +It will handle both normal and shelved (pending) changelists.
> +
> +Because of the way this works, it will be much slower than the normal git-p4 clone
> +path.
> +
> +----
> +$ git p4 format-patch 12345
> +$ git p4 format-patch --output patchdir 12345 12346 12347
> +$ git p4 format-patch --strip-depot-prefix 12348 > out.patch
> +$ git am out.patch
> +----
> +
>  OPTIONS
>  -------
>
> @@ -337,6 +359,17 @@ These options can be used to modify 'git p4 rebase' behavior.
>  --import-labels::
>         Import p4 labels.
>
> +Format-patch options
> +~~~~~~~~~~~~~~~~~~~~
> +
> +--output::
> +    Write patches to this directory (which must exist) instead of to
> +    standard output.
> +
> +--strip-depot-prefix::
> +    Strip the depot prefix from filenames in the patch.  This makes
> +    it suitable for passing to tools such as "git am".
> +
>  DEPOT PATH SYNTAX
>  -----------------
>  The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc69..a1e998e6f5 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -26,6 +26,7 @@ import zipfile
>  import zlib
>  import ctypes
>  import errno
> +import time
>
>  try:
>      from subprocess import CalledProcessError
> @@ -316,12 +317,17 @@ def p4_last_change():
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
> @@ -372,7 +378,14 @@ def split_p4_type(p4type):
>      mods = ""
>      if len(s) > 1:
>          mods = s[1]
> -    return (base, mods)
> +
> +    git_mode = "100644"
> +    if "x" in mods:
> +        git_mode = "100755"
> +    if base == "symlink":
> +        git_mode = "120000"
> +
> +    return (base, mods, git_mode)
>
>  #
>  # return the raw p4 type of a file (text, text+ko, etc)
> @@ -413,7 +426,7 @@ def p4_keywords_regexp_for_file(file):
>      if not os.path.exists(file):
>          return None
>      else:
> -        (type_base, type_mods) = split_p4_type(p4_type(file))
> +        (type_base, type_mods, _) = split_p4_type(p4_type(file))
>          return p4_keywords_regexp_for_type(type_base, type_mods)
>
>  def setP4ExecBit(file, mode):
> @@ -1208,6 +1221,9 @@ class P4UserMap:
>          else:
>              return True
>
> +    def getP4UsernameEmail(self, userid):
> +        return self.users[userid]
> +
>      def getUserCacheFilename(self):
>          home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
>          return home + "/.gitp4-usercache.txt"
> @@ -2570,13 +2586,9 @@ class P4Sync(Command, P4UserMap):
>              sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
>              sys.stdout.flush()
>
> -        (type_base, type_mods) = split_p4_type(file["type"])
> +        (type_base, type_mods, git_mode) = split_p4_type(file["type"])
>
> -        git_mode = "100644"
> -        if "x" in type_mods:
> -            git_mode = "100755"
>          if type_base == "symlink":
> -            git_mode = "120000"
>              # p4 print on a symlink sometimes contains "target\n";
>              # if it does, remove the newline
>              data = ''.join(contents)
> @@ -3749,6 +3761,277 @@ class P4Branches(Command):
>              print "%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"])
>          return True
>
> +class P4MakePatch(Command,P4UserMap):
> +    """ Create a git-compatible patch from a P4 changelist using "p4 describe"
> +
> +        "p4 describe" isn't very happy about dealing with binary files: if the file type
> +        is "text" then it outputs any binary deltas as plain text (ASCII?) while if
> +        it the file is binary, "p4 describe" doesn't output anything at all.
> +    """
> +
> +    def __init__(self):
> +        Command.__init__(self)
> +        P4UserMap.__init__(self)
> +        self.options = [
> +            optparse.make_option("--output", dest="output",
> +                help="output directory for patches, if not specified, uses stdout"),
> +            optparse.make_option("--strip-depot-prefix", dest="strip_depot_prefix",
> +                help="strip the depot prefix from paths", action="store_true"),
> +        ]
> +        self.description = ("Generate a git-compatible patch for each changelist (shelved or submitted)")
> +        self.verbose = False
> +        self.output = None
> +        self.client_prefix = None
> +        self.strip_depot_prefix = False
> +
> +    def run(self, args):
> +        if self.output and not os.path.isdir(self.output):
> +            sys.exit("output directory %s does not exist" % self.output)
> +
> +        if self.strip_depot_prefix:
> +            self.clientSpec = getClientSpec()
> +        else:
> +            self.clientSpec = None
> +
> +        self.loadUserMapFromCache()
> +        if len(args) < 1:
> +            return False
> +
> +        for change in args:
> +            self.make_patch(int(change))
> +
> +        return True
> +
> +    def extract_files_from_commit(self, commit):
> +        files = []
> +        fnum = 0
> +        while commit.has_key("depotFile%s" % fnum):
> +            path =  commit["depotFile%s" % fnum]
> +
> +            file = {}
> +            file["path"] = path
> +            file["rev"] = commit["rev%s" % fnum]
> +            file["action"] = commit["action%s" % fnum]
> +            file["type"] = commit["type%s" % fnum]

I know the name "file" has been previously used in git-p4.py, but as
file is a built-in type, could we just rename it?

> +
> +            if file["type"] != "text" and \
> +               file["type"] != "symlink":
> +                sys.stderr.write("WARNING: skipping %s file %s\n" % (file["type"], path))
> +                fnum = fnum + 1
> +                continue
> +
> +            files.append(file)
> +            fnum = fnum + 1
> +        return files
> +
> +    def header_lines(self, file):
> +        """ Return the git diff format header lines for a given change
> +        """
> +        ret = ""
> +        type = file["type"]

Same thing for the variable type as in the case of "file" (type is the
'type' object)

> +        (type_base, type_mods, git_mode) = split_p4_type(type)
> +
> +        if file["action"] == "add":
> +            ret += "new file mode %s\n" % git_mode
> +        elif file["action"] == "delete":
> +            ret += "deleted file mode %s\n" % git_mode
> +
> +        return ret
> +
> +    def p4_fetch_delta(self, change, files, shelved=False):
> +        """ Return the diff portion from "p4 describe".
> +
> +            Notes:
> +            1. p4 does not return this when using the "-G" python-mode, so
> +            we have to do this using regular text parsing
> +
> +            2. Binary files are not output at all
> +
> +            3. New files are also not output
> +
> +            4. Diffs of text files that include binary content come out with
> +            any LF characters converted to:
> +              LF
> +                > <more content>
> +
> +            In short, don't use this for binary changes.
> +        """
> +        cmd = ["describe"]
> +        if shelved:
> +            cmd += ["-S"]
> +        cmd += ["-du"]
> +        cmd += ["%s" % change]
> +        cmd = p4_build_cmd(cmd)
> +
> +        p4 = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE)
> +        try:
> +            result = p4.stdout.readlines()
> +        except EOFError:
> +            pass
> +        in_diff = False
> +        matcher = re.compile('====\s+(.*)#(\d+)\s+\(text\)\s+====')
> +        diffmatcher = re.compile("Differences ...")
> +        delta = ""
> +        skip_next_blank_line = False
> +
> +        for line in result:
> +            if diffmatcher.match(line):
> +                in_diff = True
> +                continue
> +
> +            if in_diff:
> +
> +                if skip_next_blank_line and \
> +                    line.rstrip() == "":
> +                    skip_next_blank_line = False
> +                    continue
> +
> +                m = matcher.match(line)
> +                if m:
> +                    file = self.map_path(m.group(1))
> +                    ver = m.group(2)
> +                    delta += "diff --git a%s b%s\n" % (file, file)
> +                    delta += "--- a%s\n" % file
> +                    delta += "+++ b%s\n" % file
> +                    skip_next_blank_line = True
> +                else:
> +                    delta += line
> +
> +        delta += "\n"
> +
> +        exitCode = p4.wait()
> +        if exitCode != 0:
> +            raise IOError("p4 '%s' command failed" % str(cmd))
> +
> +        return delta
> +
> +    def map_path(self, path):
> +        """ Remove leading "//", or if client prefix is being stripped, remove
> +        that as well.
> +        """
> +        if self.strip_depot_prefix:
> +            ret = "/" + self.clientSpec.map_in_client(path)
> +        else:
> +            ret = path[1:]
> +
> +        assert(ret[0] == '/')        # should always have a leading "/"
> +
> +        return ret
> +
> +    def is_pending(self, description):
> +        return description['status'] == 'pending'
> +
> +    def make_patch(self, change):
> +        """ Generate a git-format patch for the given changelist.
> +            For changes to existing files, use "p4 describe". For
> +            deletions and additions, fetch the content.
> +
> +            This is _much_ slower than the normal sync method.
> +        """
> +
> +        description = p4_describe(change)
> +        shelved = False
> +        if self.is_pending(description):
> +            shelved = True
> +            description = p4_describe(change, shelved=shelved)
> +
> +        userid = description["user"]
> +        from_name = self.getP4UsernameEmail(userid)
> +
> +        if not from_name:
> +            from_name = "unknown"
> +
> +        desc = description["desc"]
> +        desc_lines = desc.split('\n')
> +        subject = desc_lines[0].lstrip("\t")
> +
> +        comment = ""
> +        for l in desc_lines[1:]:
> +            comment += "%s\n" % l.lstrip("\t")
> +
> +        commit_date = time.strftime("%c %z", time.gmtime(int(description["time"])))
> +
> +        # try to emulate the stgit patch format
> +        delta = "commit %s\n\n" % change
I had problems with this "commit 1234". In my case, it prevents to be
used with "git am". I had to remove this in order to apply it


> +        delta += "From: %s\n" % from_name
> +        delta += "Date: %s\n" % commit_date
> +        delta += "Subject: [PATCH] %s\n" % subject
> +        delta += comment
In theory, in the mbox standard, there should a blank line between
"subject: " and the mail body. I can see "git am" tolerates it.
Anyway, git am is adding a blank line between the first line (the
subject) and the rest of the commit log with this patch format.

> +        delta += "---\n"
> +
> +        files = self.extract_files_from_commit(description)
> +        if self.clientSpec:
> +            self.clientSpec.update_client_spec_path_cache(files)
Maybe I'm missing something or did something wrong when I tested it
but I was expecting the common depot-path prefix to be removed from
the diff path in case the option --strip-depot-prefix is set, but in
my case it only removed the "//depot/".


> +
> +        # add modified files, just patching up the diff provided
> +        # by "p4 describe"
> +
> +        delta += self.p4_fetch_delta(change, files, shelved)
> +
> +        # add new or deleted files
> +        for file in files:
> +            name = file["path"]
> +            add = file["action"] == "add"
> +            delete = file["action"] == "delete"
> +            symlink = file["type"] == "symlink"
> +            output_name = self.map_path(name)
> +
> +            if add or delete:
> +                if add:
> +                    before = "/dev/null"
> +                    after = "b%s" % output_name
> +                else:
> +                    before = "a%s" % output_name
> +                    after = "/dev/null"
> +
> +                delta += "diff --git %s %s\n" % (before, after)
> +                delta += self.header_lines(file)
> +                delta += "--- %s\n" % before
> +                delta += "+++ %s\n" % after
> +
> +                if add:
> +                    prefix = "+"
> +                else:
> +                    prefix = "-"
> +
> +                if delete:
> +                    rev = int(file["rev"])
> +                    if shelved:
> +                        path_rev = "%s#%d" % (name, rev)
> +                    else:
> +                        path_rev = "%s#%d" % (name, rev-1)
> +                else:
> +                    # added
> +                    if shelved:
> +                        path_rev = "%s@=%d" % (name, change)
> +                    else:
> +                        path_rev = "%s@%d" % (name, change)
> +
> +                (lines, delta_content) = self.read_file_contents(prefix, path_rev)
> +
> +                if add:
> +                    if lines > 0:
> +                        delta += "@@ -0,0 +1,%d @@\n" % lines
> +                else:
> +                    delta += "@@ -1,%d +0,0 @@\n" % lines
> +
> +                delta += delta_content
> +
> +        if self.output:
> +            with open("%s/%s.patch" % (self.output, change), "w") as f:
> +                f.write(delta)
> +        else:
> +            print(delta)
> +
> +    def read_file_contents(self, prefix, path_rev):
> +        delta_content = ""
> +        lines = 0
> +        for line in p4_read_pipe_lines(["print", "-q", "-k", path_rev]):
> +            delta_content += "%s%s" % (prefix, line)
> +            lines += 1
> +
> +        return (lines, delta_content)
> +
>  class HelpFormatter(optparse.IndentedHelpFormatter):
>      def __init__(self):
>          optparse.IndentedHelpFormatter.__init__(self)
> @@ -3775,7 +4058,8 @@ commands = {
>      "rebase" : P4Rebase,
>      "clone" : P4Clone,
>      "rollback" : P4RollBack,
> -    "branches" : P4Branches
> +    "branches" : P4Branches,
> +    "format-patch" : P4MakePatch,
>  }
>
>
> diff --git a/t/t9832-make-patch.sh b/t/t9832-make-patch.sh
> new file mode 100755
> index 0000000000..5be6e4fcbb
> --- /dev/null
> +++ b/t/t9832-make-patch.sh
> @@ -0,0 +1,135 @@
> +#!/bin/sh
> +
> +#
> +# Converting P4 changes into patches
> +#
> +# - added, deleted, modified files
> +# - regular commits, shelved commits
> +#
> +# directories and symblinks don't yet work
> +# binary files will never work
> +
> +test_description='git p4 format-patch'
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
> +               p4 submit -d "change 1" &&                      # cl 1
> +               cat >file_to_delete <<-EOF &&
> +               LINE1
> +               LINE2
> +               EOF
> +               echo "non-empty" >file_to_delete &&
> +               p4 add file_to_delete &&
> +               p4 submit -d "change 2" &&                      # cl 2
> +               p4 edit file1 &&
> +               cat >>file1 <<-EOF &&
> +               LINE1
> +               LINE2
> +               EOF
> +               p4 submit -d "change 3" &&                      # cl 3
> +               p4 delete file_to_delete &&
> +               echo "file2" >file2 &&
> +               p4 add file2 &&
> +               p4 submit -d "change 4"                         # cl 4
> +       )
> +'
> +
> +test_expect_success 'patches on submitted changes' '
> +       test_when_finished cleanup_git &&
> +       mkdir -p "$git" &&
> +       (
> +               cd "$git" &&
> +               mkdir output &&
> +               git p4 format-patch --output "$PWD/output" 1 2 3 4 &&
> +               patch -p1 <output/1.patch &&
> +               test_path_is_file depot/file1 &&
> +
> +               patch -p1 <output/2.patch &&
> +               test_path_is_file depot/file_to_delete &&
> +
> +               patch -p1 <output/3.patch &&
> +               test_path_is_file depot/file1 &&
> +               test_cmp "$cli"/file1 depot/file1 &&
> +
> +               patch -p1 <output/4.patch &&
> +               test_path_is_missing depot/file_to_delete
> +       )
> +'
> +
> +test_expect_success 'create shelved changelists' '
> +       (
> +               cd "$cli" &&
> +               cat >file10 <<-EOF &&
> +               LINE1
> +               LINE2
> +               EOF
> +               p4 add file10 &&
> +               p4 delete file1 &&
> +               p4 edit file2 &&
> +               cat >>file2 <<-EOF &&
> +               LINE3
> +               LINE4
> +               EOF
> +
> +               p4 shelve -i <<EOF &&
> +Change: new
> +Description:
> +       Test commit
> +
> +       Further description
> +Files:
> +       //depot/file1
> +       //depot/file2
> +       //depot/file10
> +EOF
> +               p4 describe -s -S 5
> +       )
> +'
> +
> +test_expect_success 'git am from shelved changelists' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --destination="$git" //depot &&
> +       (
> +               cd "$git" &&
> +               git p4 format-patch --strip-depot-prefix 5 > out.patch &&
> +               git am out.patch &&
> +               test_cmp file10 "$cli/file10" &&
> +               test_cmp file2 "$cli/file2" &&
> +               test_path_is_missing file1
> +       )
> +'
> +
> +test_expect_success 'add p4 symlink' '
> +       (
> +               cd "$cli" &&
> +               echo "symlink_source" >symlink_source &&
> +               ln -s symlink_source symlink &&
> +               p4 add symlink_source symlink &&
> +               p4 submit -d "add symlink"                      # cl 6
> +       )
> +'
> +
> +test_expect_success 'patch from symlink' '
> +       test_when_finished cleanup_git &&
> +       cd "$git" &&
> +       (
> +               git p4 format-patch 6 | patch -p1 &&
> +               test_path_is_file depot/symlink_source &&
> +               test -L depot/symlink
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
