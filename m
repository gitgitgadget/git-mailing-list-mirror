Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF0A20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLLTrF (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:47:05 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35592 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLTrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:47:05 -0500
Received: by mail-lj1-f175.google.com with SMTP id x85-v6so17393494ljb.2
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QsEthcdF0sG0yDOQQmuusfxjhV4m6DScj0noGIO2Q88=;
        b=DZjdX6DPSqSrUdo7MLndzV5h03vwDXHUGp6IrhDm+VKm3lPR3s7NjrenxdLyysmrjr
         RkCxyNkvf+ebLiWdEi/oqLdFHGrg8dfj7NBHimRUPT5uPfHKiwYsCXKE3Hl5cmIZpmD1
         dgPpnHYurH54M3EHKyMR2z47SukOXMT+YFQB1tW2gLLUIxVmUqvataONrvJbeTRj1pOL
         6RKH0xXNcps0lokAMJ1tkyNtDWqCyuoGSa24GhUnOCDFGtfgKMWFUtx7f/91e7tsUxbw
         6stEl9H+YTGIxa2qzj7w0+aOdgfUHocp8yhyorDa7rkmbjoHtFR33cRqgbasNR2td9ct
         hVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QsEthcdF0sG0yDOQQmuusfxjhV4m6DScj0noGIO2Q88=;
        b=s2pIVYTJRU8KoewPoiQxfQ1V0MTybY3QnmEcLBIyC3reUALxqxaM+8cmh0uIXNq26D
         L91VJfYZCjec/4gGy0MvKroFCsXP7Xi90THxI3Hvu6fHS2u3rcVpVJevKU3IEB38N6XY
         QnzkG08ZHkZtLs6Yd1cV1VlJ652epvx+dIVJenmFr2ZRYlKCJdJNk0bboU8Ypr82nl3K
         65aMqY3cFP7elx7JCOBkE2JqIV5qPEWzx/+r9gQ4+WUtLBiG/dNAb15MStjJ2ZP100mx
         yyF8+GOlc0AVn8WFGDaBcVAAe0dwTP7W0/6jrQlVkmkN+QkM+osZ2FL8a7VvBs69KAKL
         9IvA==
X-Gm-Message-State: AA+aEWb8g8qvDanm2GmFZ3aq9TjOPTT1q3un75x2I4t0TpySLzqCpBSs
        o9Vs4qBHRLendPqdxPzT8fY2vjMN
X-Google-Smtp-Source: AFSGD/VQoWixisRIvJWmHgEXx8XaPDjaVInNXUOu/INbu++uwUTNmsqvyu2lToTTuV8a6CjzDUch4g==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr2601164ljc.84.1544644022088;
        Wed, 12 Dec 2018 11:47:02 -0800 (PST)
Received: from duynguyen.home (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id x29-v6sm3433256ljb.97.2018.12.12.11.47.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 11:47:00 -0800 (PST)
Date:   Wed, 12 Dec 2018 20:46:58 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     git@vger.kernel.org
Subject: review "git range-diff -h" output
Message-ID: <20181212194658.GA25117@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not going to bother you with patches (yet) but I could use a few
eyeballs to check the help usage (and perhaps the option grouping) for
commands that take diff options.

Forget about hiding irrelevant options for this particular command for
now. This is something we can do later.

usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>
   or: git range-diff [<options>] <old-tip>...<new-tip>
   or: git range-diff [<options>] <base> <old-tip> <new-tip>

    --creation-factor <n>
                          Percentage by which creation is weighted
    --no-dual-color       use simple diff colors

Diff output format options
    -p, --patch           generate patch
    -s, --no-patch        suppress diff output
    -u                    generate patch
    -U, --unified <n>     generate diffs with <n> lines context
    -W, --function-context
                          generate diffs with <n> lines context
    --raw                 generate the diff in raw format
    --patch-with-raw      synonym for '-p --raw'
    --patch-with-stat     synonym for '-p --stat'
    --numstat             machine friendly --stat
    --shortstat           output only the last line of --stat
    -X, --dirstat[=<param1,param2>...]
                          output the distribution of relative amount of changes for each sub-directory
    --cumulative          synonym for --dirstat=cumulative
    --dirstat-by-file[=<param1,param2>...]
                          synonym for --dirstat=files,param1,param2...
    --check               warn if changes introduce conflict markers or whitespace errors
    --summary             condensed summary such as creations, renames and mode changes
    --name-only           show only names of changed files
    --name-status         show only names and status of changed files
    --stat[=<width>[,<name-width>[,<count>]]]
                          generate diffstat
    --stat-width <width>  generate diffstat with a given width
    --stat-name-width <width>
                          generate diffstat with a given name width
    --stat-graph-width <width>
                          generate diffstat with a given graph width
    --stat-count <count>  generate diffstat with limited lines
    --compact-summary     generate compact summary in diffstat
    --binary              output a binary diff that can be applied
    --full-index          show full pre- and post-image object names on the "index" lines
    --color[=<when>]      show colored diff
    --ws-error-highlight <kind>
                          highlight whitespaces errors in the context, old or new lines in the diff
    -z                    do not munge pathnames and use NULs as output field terminators in --raw or --numstat
    --abbrev[=<n>]        use <n> digits to display SHA-1s
    --src-prefix <prefix>
                          show the given source prefix instead of "a/"
    --dst-prefix <prefix>
                          show the given source prefix instead of "b/"
    --line-prefix <prefix>
                          prepend an additional prefix to every line of output
    --no-prefix           no not show any source or destination prefix
    --inter-hunk-context <n>
                          show context between diff hunks up to the specified number of lines
    --output-indicator-new <char>
                          specify the character to indicate a new line instead of '+'
    --output-indicator-old <char>
                          specify the character to indicate an old line instead of '-'
    --output-indicator-context <char>
                          specify the character to indicate a context instead of ' '

Diff rename options
    -B, --break-rewrites[=<n>[/<m>]]
                          break complete rewrite changes into pairs of delete and create
    -M, --find-renames[=<n>]
                          detect renames
    -D, --irreversible-delete
                          omit the preimage for deletes
    -C, --find-copies[=<n>]
                          detect copies
    --find-copies-harder  use unmodified files as source to find copies
    --no-renames          disable rename detection
    --rename-empty        use empty blobs as rename source
    --follow              continue listing the history of a file beyond renames
    -l <n>                prevent rename/copy detection if the number of rename/copy targets exceeds given limit

Diff algorithm options
    --minimal             produce the smallest possible diff
    -w, --ignore-all-space
                          ignore whitespace when comparing lines
    -b, --ignore-space-change
                          ignore changes in amount of whitespace
    --ignore-space-at-eol
                          ignore changes in whitespace at EOL
    --ignore-cr-at-eol    ignore carrier-return at the end of line
    --ignore-blank-lines  ignore changes whose lines are all blank
    --indent-heuristic    heuristic to shift diff hunk boundaries for easy reading
    --patience            generate diff using the "patience diff" algorithm
    --histogram           generate diff using the "histogram diff" algorithm
    --diff-algorithm <algorithm>
                          choose a diff algorithm
    --anchored <text>     generate diff using the "anchored diff" algorithm
    --word-diff[=<mode>]  show word diff, using <mode> to delimit changed words
    --word-diff-regex <regex>
                          use <regex> to decide what a word is
    --color-words[=<regex>]
                          equivalent to --word-diff=color --word-diff-regex=<regex>
    --color-moved[=<mode>]
                          move lines of code are colored differently
    --color-moved-ws <mode>
                          how white spaces are ignored in --color-moved

Diff other options
    --relative[=<prefix>]
                          when run from subdir, exclude changes outside and show relative paths
    -a, --text            treat all files as text
    -R                    swap two inputs, reverse the diff
    --exit-code           exit with 1 if there were differences, 0 otherwise
    --quiet               disable all output of the program
    --ext-diff            allow an external diff helper to be executed
    --textconv            run external text conversion filters when comparing binary files
    --ignore-submodules[=<when>]
                          ignore changes to submodules in the diff generation
    --submodule[=<format>]
                          specify how differences in submodules are shown
    --ita-invisible-in-index
                          hide 'git add -N' entries from the index
    --ita-visible-in-index
                          treat 'git add -N' entries as real in the index
    -S <string>           look for differences that change the number of occurrences of the specified string
    -G <regex>            look for differences that change the number of occurrences of the specified regex
    --pickaxe-all         show all changes in the changeset with -S or -G
    --pickaxe-regex       treat <string> in -S as extended POSIX regular expression
    -O <file>             override diff.orderFile configuration variable
    --find-object <object-id>
                          look for differences that change the number of occurrences of the specified object
    --diff-filter [(A|C|D|M|R|T|U|X|B)...[*]]
                          select files by diff type
    --output <file>       Output to a specific file

