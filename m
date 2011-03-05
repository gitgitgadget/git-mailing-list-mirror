From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.9
Date: Sat, 5 Mar 2011 15:18:39 +0100
Message-ID: <AANLkTimk4PKoxtkXo0bO0KLt=29QREOjZJcbFd2tXLyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 15:18:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvsJl-0005HG-Aj
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 15:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab1CEOSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 09:18:42 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43759 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab1CEOSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 09:18:41 -0500
Received: by vxi39 with SMTP id 39so2756249vxi.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=cJRCT0k7gy48VWO3i8Kw+m/fGNo6UBfib9hkIRb4WZk=;
        b=GFDY0fUPstsvR+9P27hXtnFfEyUcmUv2opS3Zz5HCDIebwots+1IsCU8ecNOAk42G7
         A5jmVVP3WiceCk8O5ow1f4kL7Dp4EuG4Yt8T6Jxh1qAt5IWMk6qdN/Xh1nqmYj5FyUfm
         qNMOcjrjcSHCbV7aLT8R6zA407Ijt8f6A1s7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=jJ+Nb9BgsJ5KAZpF6GI55xKPu5KfB59XS+E4baxt+KAEv+Ml0qU72kWHpFOTWa3QtP
         FoK8pgMXcsxHn7IFo1tdlgq94Eb96nM6FM0SGodJIAI9mocjYX351Wc8tgZP/jXpK06u
         V0rsvDqaG2uTnZvfSMuaqlo9FMR9b4ZtPOPr0=
Received: by 10.52.174.226 with SMTP id bv2mr191422vdc.72.1299334719910; Sat,
 05 Mar 2011 06:18:39 -0800 (PST)
Received: by 10.52.160.130 with HTTP; Sat, 5 Mar 2011 06:18:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168496>

A long overdue feature-relase of cgit, a web interface to git
repositories, is now available at http://hjemli.net/git/cgit.

Executive summary:
* support for side-by-side diffs
* support for repo content in "about" view
* improved integration with gitolite/gitweb
* support for git notes in commit/log view
* support for graph in log view (similar to 'git log --graph')
* improved handling/display of path filters
* clients can modify diff view parameters
* support for directory listings in plain view
* support for remote branches
* support for range searches in log view (like 'git log master ^stable)
* support for expansion of environment vars in certain cgitrc options,
which can simplify virtual hosting

Thanks to everyone who contributed.

Shortlog since v0.8.3.5:

Aaron Griffin (2):
      Add all=3D1 query param for atom feeds
      Add 'max-atom-items' config variable

Alexey Nezhdanov (1):
      ui-tag: add snapshot links

Andreas Wiese (1):
      Add .tar.xz-snapshot support

Bernhard Reutner-Fischer (3):
      implement repo.logo and repo.logo-link
      ssdiff: anchors for ssdiff
      Use transparent background for the cgit logo

Chris Mayo (1):
      Use committer date for atom feed entry updated element

=46elix Hanley (1):
      Add `strict-export` option

Georg Lukas (3):
      syntax highlighting for all formats supported by "highlight"
      cgit.css: highlight directories in tree
      "max-blob-size" config var to limit generated HTML size

Jason A. Donenfeld (4):
      Add support for 'project-list' option
      Add support for 'remove-suffix' option
      Add support for 'enable-gitweb-owner' option
      Support refspecs in about-filter.

Jeff Smith (3):
      commit-links.sh: Seperate the expressions for filtering commit me=
ssages.
      ui-commit: Display git notes when present
      ui-log: Display git notes when present

Johan Herland (31):
      Fix small typo in cgitrc example
      Remove unused variable in shared.c
      ui-shared: Improve const-ness in API
      ui-shared: Remove needless cgit_get_cmd() call, and refactor
hc() accordingly
      struct cgit_cmd: Differentiate between various usages of ctx.qry.=
path
      ui-shared: Replace ctx.qry.path with ctx.qry.vpath
      ui-shared: Display path limit directly beneath tab bar in relevan=
t pages
      ui-shared: Teach "breadcrumb" navigation to path limit display
beneath tab bar
      ui-tree: Remove unnecessary path breadcrumb navigation
      ui-diff: Teach diffstat to obey path limit
      ui-commit: Limit diff based on path limit in qry.path
      ui-patch: Apply path limit to generated patch
      ui-commit: Preserve path limit in links to tree and diff pages
      ui-commit: Preserve path limit in links to commit page
      ui-shared: Preserve path limit in "tab bar" links
      ui-log: Preserve path limit in outgoing links
      Fix style of commit-filter links in commit-subject.
      Add URL parameter 'context' for changing the number of context
lines in diffs
      ui-diff: Add links to increase/decrease number of context lines i=
n diffs
      Add URL parameter 'ignorews' for optionally ignoring whitespace i=
n diffs
      ui-diff: Add link to ignore/show whitespace changes in diffs
      ui-log: Fix filecount/linecount when path limit is in effect
      ui-log: Prevent crash when given empty range search
      ui-stats: Remove unnecessary #include
      ui-log: Change display of full commit messages (and notes)
      ui-log: Implement support for commit graphs
      ui-log: Colorize commit graph
      ui-log: Line-wrap long commit subjects when showmsg is enabled
      ui-log: Move 'Age' column when commit graph is present
      scan_path(): Improve handling of inaccessible directories
      scan_path(): Do not recurse into hidden directories by default

Kamil Kaminski (1):
      Fix a typo in README, s/ExecCGI/+ExecCGI

Lars Hjemli (23):
      ui-tag: make output more similar to commit view
      ui-shared.c: prettify download links when generated from tag page
      Add support for remote branches
      Optionally generate verbose parent links
      Use GIT-1.7.0
      scan-tree: add test for noweb-file in repo dir
      ui-tree: add link to plain view for blobs in tree listing
      Add support for environment variable expansion
      ui-shared.c: path-limit style nitpick
      ui-log.c: allow commit range as search expression
      Use GIT-1.7.2.2
      Add support for "readme" option
      Add support for 'section-from-path' option
      Use GIT-1.7.3
      Makefile: add -MP option
      Append path and branch to atom feed title
      Makefile: avoid spurious rebuilds of git sources due to `sudo mak=
e`
      Add vector utility functions
      ui-log.c: improve handling of range-search argument
      html.c: use '+' to escape spaces in urls
      Use GIT-1.7.4
      Update README
      CGIT 0.9

Lukasz Janyst (1):
      ui-diff.c: avoid html injection

Lynn Lin (1):
      Makefile: do not include dependency-file on `make clean`

Mark Lodato (9):
      ui-plain: remove unused curr_rev variable
      ui-plain: more efficient walk_tree()
      ui-plain: print directory listings
      html: make all strings 'const char *'
      html: properly percent-escape URLs
      use __attribute__ to catch printf format mistakes
      fix errors in printf-style format strings
      ui-repolist: fix redefinition of _XOPEN_SOURCE
      prefer html_raw() to write()

Mikhail Gusarov (1):
      Add NO_OPENSSL option

Ragnar Ouchterlony (5):
      First version of side-by-side diff.
      Add possibility to switch between unidiff and side-by-side-diff.
      Polishing of how the side-by-side diff looks.
      Fixed side-by-side diff bugs related to binary diff and more.
      In side-by-side diff, add support for marking individual characte=
rs.

Stefan B=C3=BChler (1):
      Skip leading "/" in url querystring value

Stefan Naewe (1):
      display subject instead of sha1 as link title of parents

Todd Zullinger (5):
      Generalize doc generation
      Add Makefile targets to install/uninstall docs
      Install filter scripts
      cgit.css: Add syntax highlighting entries
      Use example.com in documentation, per RFC 2606
