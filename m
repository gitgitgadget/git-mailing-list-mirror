Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE67A1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 23:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBZXsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 18:48:41 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38779 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBZXsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 18:48:40 -0500
Received: by mail-qk0-f181.google.com with SMTP id s198so21337894qke.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 15:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q018lqkjYGt53cOZNLOZ2VY+8a2bfPC2oWW5BH8DAQY=;
        b=ePeqdB5enV8ZSdQByRTRLbOIdN/b0prEPtuUNXOtASAYhYk10uPcjIe2zjXrncJZrh
         ZSiVSbJZNkkT+GJiLT6ZnMPuauOgVtJZuJosvTEonixaMEeBcFzTcIMC1bJWxmDCsmJq
         KpiNeoDFOx+uEfTKWTBdAJ4hhzHBmoBv6ixSmw3E8bT03uo4nv9TYs+fJq07jg1aDJX5
         6wae19gbJPcimT5r7oDqSA7ICewmV+3tcOTokn/YeWYTL1xbXLDkFfX0/0znuChK7U75
         g3UU3Vz4AcyKpIfxAAfW0StT2AdGyi/YZfQdpkz8eQxw1NRR0OQRcGGETcP0p8jxXVsu
         gPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q018lqkjYGt53cOZNLOZ2VY+8a2bfPC2oWW5BH8DAQY=;
        b=DHR4X8rXOV9mN613ECIdMDze7NweGyca83fvaz6ltfON+MEdiGbhinik/FmQlDfAU2
         IJ/Ef9jac5P5j75aAL8fpoGyex+zr1kMEo66d8FmuPESkuEcK4xsb2abGNz2xQuqhAj9
         4bh6U91biPAGLz/WqHodtwh9rUukqxwbRdbh7OVkx3LrKJZ5i85+qVLEyA8V3MA7miMW
         SiU7FVGXU7lBeucC0VlyhuzhXmUA3IBHC4Y3a3iBg2OPiXCSA3D6ClmLmW1SPdW12Pou
         lEz89PhwuVW8x/pfpTjmwgj3EbjEuMiW3hsdui2tnOmg5/ewOGxYhShUr12eCU6mvV10
         3wFg==
X-Gm-Message-State: APf1xPCUgwCKd0VLf5lIW9TCLoH+IaojOmsv+tEP9u4W5rnepBY0jbrY
        sBwQ8WQgozT21IyG6816H87kIOStAOLUiiaa9w4=
X-Google-Smtp-Source: AG47ELtTw14ShHdfoWAHnWX9E4PrVLB/h8+eJl94+PbSGhl9+mCdu6giASIfRu5LBG/+RHUccGZ8umP/WFTaxcFeyKE=
X-Received: by 10.55.88.7 with SMTP id m7mr20358748qkb.133.1519688919702; Mon,
 26 Feb 2018 15:48:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 26 Feb 2018 15:48:39 -0800 (PST)
In-Reply-To: <20180226114822.1617-2-luke@diamand.org>
References: <20180226114822.1617-1-luke@diamand.org> <20180226114822.1617-2-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Feb 2018 18:48:39 -0500
X-Google-Sender-Auth: wXt5Lzeg1UYvFtdaO8sbURRQ30g
Message-ID: <CAPig+cRt3cdKOCFmbuUMQPuBnP+weD3HcY-5kz9RMkPH=aP63g@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add format-patch subcommand
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 6:48 AM, Luke Diamand <luke@diamand.org> wrote:
> It takes a list of P4 changelists and generates a patch for
> each one, using "p4 describe".
> [...]
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -3749,6 +3761,277 @@ class P4Branches(Command):
> +class P4MakePatch(Command,P4UserMap):
> +    def run(self, args):
> +        if self.output and not os.path.isdir(self.output):
> +            sys.exit("output directory %s does not exist" % self.output)

For consistency with "git format-patch", this could create the output
directory automatically rather than erroring out.

> +        if self.strip_depot_prefix:
> +            self.clientSpec = getClientSpec()
> +        else:
> +            self.clientSpec = None
> +
> +        self.loadUserMapFromCache()
> +        if len(args) < 1:
> +            return False

Would it make sense to handle this no-arguments case earlier before
doing work, such as loading the user map from cache?

> +        for change in args:
> +            self.make_patch(int(change))
> +
> +        return True
> +
> +    def p4_fetch_delta(self, change, files, shelved=False):
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

I'm not familiar with the output of "p4 describe", but does it include
user-supplied text? If so, would it be safer to anchor 'diffmatcher',
for instance, "^Diferences...$"?

> +        delta = ""
> +        skip_next_blank_line = False
> +
> +        for line in result:
> +            if diffmatcher.match(line):

Stepping back, does "Differences..." appear on a line of its own? If
so, why does this need to be a regex at all? Can't it just do a direct
string comparison?

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

Since p4.stdout.readlines() gathered all output from the command
before massaging it into Git format, can't the p4.wait() be done
earlier, just after the output has been read?

> +        return delta
> +
> +    def make_patch(self, change):
> +        [...]
> +        # add new or deleted files
> +        for file in files:
> +            [...]
> +            if add or delete:
> +                if add:
> +                    [...]
> +                else:
> +                    [...]
> +
> +                [...]
> +
> +                if add:
> +                    prefix = "+"
> +                else:
> +                    prefix = "-"
> +
> +                if delete:
> +                    [...]
> +                else:
> +                    # added
> +                    [...]
> +
> +                (lines, delta_content) = self.read_file_contents(prefix, path_rev)
> +
> +                if add:
> +                    if lines > 0:
> +                        delta += "@@ -0,0 +1,%d @@\n" % lines
> +                else:
> +                    delta += "@@ -1,%d +0,0 @@\n" % lines

It's not clear why you sometimes check 'add' but other times 'delete'.
Perhaps always used one or the other? For instance:

    action = file["action"]
    if action == "add" or action == "delete":
        if action == "add":
            before = "/dev/null"
            ...
        else
            ...

        delta += ...

        if action == "add":
            ...

or something.

> +                delta += delta_content
> +
> +        if self.output:
> +            with open("%s/%s.patch" % (self.output, change), "w") as f:
> +                f.write(delta)
> +        else:
> +            print(delta)
> diff --git a/t/t9832-make-patch.sh b/t/t9832-make-patch.sh
> @@ -0,0 +1,135 @@
> +# Converting P4 changes into patches
> +#
> +# - added, deleted, modified files
> +# - regular commits, shelved commits
> +#
> +# directories and symblinks don't yet work
> +# binary files will never work

s/symblinks/symlinks/

> +test_expect_success 'init depot' '
> +       (
> +               cd "$cli" &&
> +               echo file1 >file1 &&
> +               p4 add file1 &&
> +               p4 submit -d "change 1" &&                      # cl 1
> +               cat >file_to_delete <<-EOF &&

Using -\EOF would signal that you don't expect interpolation within the heredoc.

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
> +test_expect_success 'add p4 symlink' '
> +       (
> +               cd "$cli" &&
> +               echo "symlink_source" >symlink_source &&
> +               ln -s symlink_source symlink &&

Should this test be protected with the SYMLINKS prerequisite?

> +               p4 add symlink_source symlink &&
> +               p4 submit -d "add symlink"                      # cl 6
> +       )
> +'
> +
> +test_expect_success 'patch from symlink' '

Ditto SYMLINKS?

> +       test_when_finished cleanup_git &&
> +       cd "$git" &&
> +       (
> +               git p4 format-patch 6 | patch -p1 &&
> +               test_path_is_file depot/symlink_source &&
> +               test -L depot/symlink
> +       )
> +'
