Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D461EC012
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890424; cv=none; b=sjwvQeqNbWzNAxniYrkfmO7pExmqjOoE33O6EW+x+pB4SpI4bD8sYi5G1L/aU0qnz+nruJINu+ZbLNUNgyeTorCxMXLooM8Gg3Dn6crertOsEWd1YyEgJp1HgLyZoFGEGiv+M0Utf2ItYmr9eqq3Ql/xqYPPc48UNaZoSOr5Xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890424; c=relaxed/simple;
	bh=+HMGnX41+218mVkw8kheQB9gSzZ/1qS04gm1CX7k1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q0xsD4yzggu3S3/DKP1WafH0Ve1ZQELjDPaOyMzDDJxfyKTjEfxFtwUY3yAN58/2rwWP2ZIonbpdE28ioQsLiv4ZPjdKyrtg6AoIXHfzNxjHaoVBlhYZWc+Y8JCFQg8e+CT14EocDF6I8GmxBoa8/Qgq0sTyshNUD2CoZeXsCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=Hfm+xvNA; arc=none smtp.client-ip=194.105.232.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="Hfm+xvNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1741890420; x=1773426420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eWmy3NWLPc0RPc8ZnNUw3wpaBzcU5wfD9hwPRsRkit0=;
  b=Hfm+xvNAr8qS7ZtAWbBoZyxcEYHCwUCkdivBfmlIPrtAUWSxeqwOC20S
   zvxYu6ijP/cHRbY3NHnSLs+IXDMbkKkV+T6g624ypTcjAvMwpE46E3VsI
   xq7LbJnFj1R93vifdB07HFikEHIyDHiGjXQ6sPm2752eMGge4UjYljk0d
   4VCsJAj3MqetOtTPMcQy0+TZpApWtL9jRu1ZBtXWQ6kfIDOqPGnQOE2an
   OZuDFIe+GYOHuioZnyQi1F3JixcOXCtvpieDiem2EezK7TedThHS5CLbN
   GdJwvlKLGbYNt/vCE/2Gw/DWP/AbZehA0cb08+GFkh034UUrJPjrW7wgE
   Q==;
X-CSE-ConnectionGUID: /09N302lSRiWdEwqE39zlw==
X-CSE-MsgGUID: AWewoIyzR1a7dUCrC2vzng==
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2EtAADqHdNnhVfoacJaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgVOCRH2BZIgWD44igRaQNIxhgVoDFQcBAQEPLg8HB?=
 =?us-ascii?q?AEBAwEDggyCLkaLHSg4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQYBAQEBA?=
 =?us-ascii?q?QEGBwIQAQEBAUAOO4U1Rg2DFnGBJAEBAQEBAQEBAQEBAQEBAQEBAQEBFwEBA?=
 =?us-ascii?q?guBBXgtWyEwgnkBgmQUBq96gTSBAYMcPgIQQdoHgV4QgUgBhWyCYwGFbIR3P?=
 =?us-ascii?q?AaCDYEVMgOBc0oHb4IULxMLAQEBAoE7AQEGRoYYBIIYF4E7ggKBaocdgjKFB?=
 =?us-ascii?q?4NPhBwgEpJqSIEhA1ksAVUTDQoLBwWBbAM1DAsuFTKBFEM3NYIOaUk6Ag0CN?=
 =?us-ascii?q?YIbfIIrglWBeIQ8hEGFToIRizaEYS1USx02CgMLGA1IESw3FBtEbgehVTuDS?=
 =?us-ascii?q?AkBJQlDAQEwGTETASkBARcJAjZAAyoGBg8LEgEiKB6SVCYBMY9aAYFEoCSBP?=
 =?us-ascii?q?oQlhlyDMYILjTmIETMig2GBV4syhjoMOpE1gRaYfo0bapVdGRk3hGiBfoF/L?=
 =?us-ascii?q?AcaCDA7gjMBATIJSRkPjgcjAxYWg0KEWAU2w3V4AjoCBwsBAQMJhkuLHAEB?=
IronPort-PHdr: A9a23:4LXLeBBqClGZytokVOVIUyQVQxdPi9zP1m898Z87k/dJb7jmp8ikJ
 03a4/hxyl7SDs3X6PNB3uzRta2oGWkN+o2Iv31KdptQHwQEhsMbk01oAMOMBUDhav+/aSs8E
 ax/
IronPort-Data: A9a23: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
 FXZjFtsGCmTIXMd2+45E5KJMHn1ZA/S8gg=
IronPort-HdrOrdr: A9a23:gdJ7wqOUazRFo8BcTtCjsMiBIKoaSvp037BL7SBMoHluH/Bw+P
 rOoB12726QtN9zYgBCpTnjAse9qBrnnPYY3WB4B9yftWLdyQmVxe9ZgrcKkweLJxHD
X-Talos-CUID: 9a23:6BM6q2AEilrNa+j6E24/pWhPQpohSUfc83v9PFaVUjd7TKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AbQ8dOA0/40LJKOqch+g09DSySzUjypujF0csgIc?=
 =?us-ascii?q?84sDbORFbIRzHkiaxTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="1'?diff'?bugs'?scan'208";a="40704867"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 18:25:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 71A0141CEF48;
	Thu, 13 Mar 2025 18:25:48 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KE01jNQs8aUi; Thu, 13 Mar 2025 18:25:47 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 4199B41CEF49;
	Thu, 13 Mar 2025 18:25:47 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tgOnAQVgq9tv; Thu, 13 Mar 2025 18:25:47 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 0CDA041C4690;
	Thu, 13 Mar 2025 18:25:46 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1tsnFa-000000005o7-24J5;
	Thu, 13 Mar 2025 18:25:46 +0000
Date: Thu, 13 Mar 2025 18:25:46 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: git@vger.kernel.org
Cc: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: git-filter-branch.1: Some remarks and a patch with editorial changes
 for this man page
Message-ID: <174188934245.21716.6680332666412833022.reportbug@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1QreUpu+FrkDDLdd"
Content-Disposition: inline
X-Mailer: reportbug 13.1.0


--1QreUpu+FrkDDLdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: git-man
Version: 1:2.47.2-0.1
Severity: minor
Tags: patch

   * What led up to the situation?

     Checking for defects with a new version

test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=0 -rCHECKSTYLE=10 -ww -z < "man page"

  [Use "groff -e ' $' -e '\\~$' <file>" to find obvious trailing spaces.]

  ["test-groff" is a script in the repository for "groff"; is not shipped]
(local copy and "troff" slightly changed by me).

  [The fate of "test-nroff" was decided in groff bug #55941.]

   * What was the outcome of this action?


troff:<stdin>:902: warning [page 10, line 29]: cannot break line


   * What outcome did you expect instead?

     No output (no warnings).

-.-

  General remarks and further material, if a diff-file exist, are in the
attachments.


-- System Information:
Debian Release: trixie/sid
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 6.12.17-amd64 (SMP w/2 CPU threads; PREEMPT)
Locale: LANG=is_IS.iso88591, LC_CTYPE=is_IS.iso88591 (charmap=ISO-8859-1), LANGUAGE not set
Shell: /bin/sh linked to /usr/bin/dash
Init: sysvinit (via /sbin/init)

-- no debconf information

--1QreUpu+FrkDDLdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chk_man.err.git-filter-branch.1"
Content-Transfer-Encoding: quoted-printable

Input file is git-filter-branch.1

Output from "mandoc -T lint  git-filter-branch.1": (shortened list)

      1 input text line longer than 80 bytes: (if the parent strin...
      1 input text line longer than 80 bytes: A \fImap\fR function...
      1 input text line longer than 80 bytes: A minor issue, but u...
      1 input text line longer than 80 bytes: Always verify that t...
      1 input text line longer than 80 bytes: Annotated tags can b...
      1 input text line longer than 80 bytes: Any commit messages ...
      1 input text line longer than 80 bytes: As a special extensi...
      1 input text line longer than 80 bytes: By using \fBgit-rev-...
      1 input text line longer than 80 bytes: Coming up with the c...
      1 input text line longer than 80 bytes: Commit messages (eve...
      1 input text line longer than 80 bytes: Even if you don\(cqt...
      1 input text line longer than 80 bytes: Filenames with space...
      1 input text line longer than 80 bytes: Further, several add...
      1 input text line longer than 80 bytes: However, if the file...
      3 input text line longer than 80 bytes: If \-\-prune\-empty ...
      1 input text line longer than 80 bytes: If any evaluation of...
      1 input text line longer than 80 bytes: If the user provides...
      1 input text line longer than 80 bytes: If you need to add \...
      1 input text line longer than 80 bytes: If you really don\(c...
      1 input text line longer than 80 bytes: If you try and cheat...
      1 input text line longer than 80 bytes: In editing files, gi...
      1 input text line longer than 80 bytes: It\(cqs far too easy...
      1 input text line longer than 80 bytes: Lets you rewrite Git...
      1 input text line longer than 80 bytes: Nearly proper rewrit...
      1 input text line longer than 80 bytes: Non\-ascii filenames...
      1 input text line longer than 80 bytes: Note that since this...
      1 input text line longer than 80 bytes: On success, the exit...
      1 input text line longer than 80 bytes: Only look at the his...
      1 input text line longer than 80 bytes: Running git\-filter\...
      1 input text line longer than 80 bytes: Side note: Unfortuna...
      1 input text line longer than 80 bytes: Similarly, when movi...
      1 input text line longer than 80 bytes: Some filters will ge...
      1 input text line longer than 80 bytes: Someone can do a his...
      1 input text line longer than 80 bytes: Someone can have a s...
      1 input text line longer than 80 bytes: Suppose you want to ...
      1 input text line longer than 80 bytes: The \fB\-\-env\-filt...
      1 input text line longer than 80 bytes: The \m[blue]\fBgit f...
      1 input text line longer than 80 bytes: The command will onl...
      1 input text line longer than 80 bytes: The filters are appl...
      1 input text line longer than 80 bytes: The original tags ar...
      1 input text line longer than 80 bytes: The performance of g...
      1 input text line longer than 80 bytes: The shift magic firs...
      1 input text line longer than 80 bytes: The user\-provided s...
      1 input text line longer than 80 bytes: Then there are two w...
      1 input text line longer than 80 bytes: There are no facilit...
      1 input text line longer than 80 bytes: This filter may be u...
      1 input text line longer than 80 bytes: This is not a real f...
      6 input text line longer than 80 bytes: This is the filter f...
      1 input text line longer than 80 bytes: This option will cau...
      1 input text line longer than 80 bytes: Thus you can, e\&.g\...
      1 input text line longer than 80 bytes: To restrict rewritin...
      1 input text line longer than 80 bytes: To rewrite the repos...
      1 input text line longer than 80 bytes: To set a commit (whi...
      1 input text line longer than 80 bytes: To top it all off, e...
      2 input text line longer than 80 bytes: Use this option to s...
      1 input text line longer than 80 bytes: Using \fB\-\-index\-...
      1 input text line longer than 80 bytes: You can rewrite the ...
      1 input text line longer than 80 bytes: You really removed a...
      1 input text line longer than 80 bytes: argument could no lo...
      1 input text line longer than 80 bytes: command, with argume...
      1 input text line longer than 80 bytes: commits, but each co...
      1 input text line longer than 80 bytes: convenience function...
      1 input text line longer than 80 bytes: even if you succeed ...
      3 input text line longer than 80 bytes: git\-filter\-branch ...
      1 input text line longer than 80 bytes: if you don\(cqt wish...
      1 input text line longer than 80 bytes: refuses to start wit...
      1 input text line longer than 80 bytes: the fact that \-\-ta...
      1 input text line longer than 80 bytes: the fact that little...
      1 input text line longer than 80 bytes: you run into problem...
      1 skipping paragraph macro: PP after SH
      9 skipping paragraph macro: sp after SH
      2 skipping paragraph macro: sp after SS


-.-.

Output from "test-nroff -mandoc -t -ww -z git-filter-branch.1": (shortened =
list)

      1 cannot break line

-.-.

Lines containing '\c':

447:\h'-04'\(bu\h'+03'\c
460:\h'-04'\(bu\h'+03'\c
475:\h'-04'\(bu\h'+03'\c
490:\h'-04'\(bu\h'+03'\c
502:\h'-04'\(bu\h'+03'\c
514:\h'-04'\(bu\h'+03'\c
533:\h'-04'\(bu\h'+03'\c
552:\h'-04'\(bu\h'+03'\c
562:\h'-04'\(bu\h'+03'\c
573:\h'-04'\(bu\h'+03'\c
585:\h'-04'\(bu\h'+03'\c
596:\h'-04'\(bu\h'+03'\c
607:\h'-04'\(bu\h'+03'\c
618:\h'-04'\(bu\h'+03'\c
628:\h'-04'\(bu\h'+03'\c
647:\h'-04'\(bu\h'+03'\c
658:\h'-04'\(bu\h'+03'\c
669:\h'-04'\(bu\h'+03'\c
681:\h'-04'\(bu\h'+03'\c
692:\h'-04'\(bu\h'+03'\c
702:\h'-04'\(bu\h'+03'\c
714:\h'-04'\(bu\h'+03'\c
725:\h'-04'\(bu\h'+03'\c
736:\h'-04'\(bu\h'+03'\c
748:\h'-04'\(bu\h'+03'\c
758:\h'-04'\(bu\h'+03'\c
769:\h'-04'\(bu\h'+03'\c
781:\h'-04'\(bu\h'+03'\c
792:\h'-04'\(bu\h'+03'\c
803:\h'-04'\(bu\h'+03'\c
814:\h'-04'\(bu\h'+03'\c
825:\h'-04'\(bu\h'+03'\c
836:\h'-04'\(bu\h'+03'\c
847:\h'-04'\(bu\h'+03'\c
858:\h'-04'\(bu\h'+03'\c
871:\h'-04'\(bu\h'+03'\c
882:\h'-04'\(bu\h'+03'\c

  Use a macro for repeated use of the same code.

-.-

Show if docman-to-man created this.

Who is actually creating this man page?  Debian or upstream?

Is the generating software out of date?

3:.\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/a=
uthor]
4:.\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>

-.-.

Strings longer than 3/4 of a standard line length (80)
Use "\:" to split the string at the end of an output line, for example a
long URL (web address)

902 \%https://github.com/newren/git-filter-repo/blob/master/contrib/filter-=
repo-demos/filter-lamely

-.-.

Wrong distance (not two spaces) between sentences in the input file.

  Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) ("Conventions for source file layout") and
"info groff" ("Input Conventions").

  The best procedure is to always start a new sentence on a new line,
at least, if you are typing on a computer.

Remember coding: Only one command ("sentence") on each (logical) line.

E-mail: Easier to quote exactly the relevant lines.

Generally: Easier to edit the sentence.

Patches: Less unaffected text.

Search for two adjacent words is easier, when they belong to the same line,
and the same phrase.

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

Mark a final abbreviation point as such by suffixing it with "\&".

Some sentences (etc.) do not begin on a new line.

Split (sometimes) lines after a punctuation mark; before a conjunction.

  Lines with only one (or two) space(s) between sentences could be split,
so latter sentences begin on a new line.

Use

#!/usr/bin/sh

sed -e '/^\./n' \
-e 's/\([[:alpha:]]\)\.  */\1.\n/g' $1

to split lines after a sentence period.
Check result with the difference between the formatted outputs.
See also the attachment "general.bugs"

[List of affected lines removed.]

-.-

Split lines longer than 80 characters into two or more lines.
Appropriate break points are the end of a sentence and a subordinate
clause; after punctuation marks.
Add "\:" to split the string for the output, "\<newline>" in the source. =
=20

[List of affected lines removed.]

-.-

Put a parenthetical sentence, phrase on a separate line,
if not part of a code.
See man-pages(7), item "semantic newline".

[List of affected lines removed.]

Change a HYPHEN-MINUS (code 0x55, 2D) to a dash
(\-, minus) if it matches "[[:alph:]]-[[:alpha:]]" in the name of an
option).
Facilitates the copy and paste of
a) an option in UTF-8 text
b) web addresses (URL).

Is not needed in ordinary words like "mother-in-law", that are not
copied and pasted to a command line (which needs ASCII code)

897:\%https://github.com/newren/git-filter-repo/
902:\%https://github.com/newren/git-filter-repo/blob/master/contrib/filter-=
repo-demos/filter-lamely

-.-.

No need for '\&' to be in front of a period (.),
if there is a character in front of it.

Remove with "sed -e 's/\\&\././g'".

[List with affected lines removed.]

Lines longer than about(?) 1023 forces a mail program to use quoted-printab=
le
encoding which is bad.  Translater program is unusable.

Line 877, length 1036

Coming up with the correct shell snippet to do the filtering you want is so=
metimes difficult unless you\(cqre just doing a trivial modification such a=
s deleting a couple files\&. Unfortunately, people often learn if the snipp=
et is right or wrong by trying it out, but the rightness or wrongness can v=
ary depending on special circumstances (spaces in filenames, non\-ascii fil=
enames, funny author names or emails, invalid timezones, presence of grafts=
 or replace objects, etc\&.), meaning they may have to wait a long time, hi=
t an error, then restart\&. The performance of git\-filter\-branch is so ba=
d that this cycle is painful, reducing the time available to carefully re\-=
check (to say nothing about what it does to the patience of the person doin=
g the rewrite even if they do technically have more time available)\&. This=
 problem is extra compounded because errors from broken filters may not be =
shown for a long time and/or get lost in a sea of output\&. Even worse, bro=
ken filters often just result in silent incorrect rewrites\&.

-.-.

One space only after a possible end of sentence
(after a punctuation, that
can end a sentence).

[List of affected lines removed.]

-.-

Put a subordinate sentence (after a comma) on a new line.

[List of affected lines removed.]

-.-.

Remove quotes when there is a printable
but no space character between them
and the quotes are not for emphasis (markup),
for example as an argument to a macro.

git-filter-branch.1:10:.TH "GIT\-FILTER\-BRANCH" "1" "01/19/2025" "Git 2\&.=
47\&.2" "Git Manual"
git-filter-branch.1:30:.SH "NAME"
git-filter-branch.1:32:.SH "SYNOPSIS"
git-filter-branch.1:44:.SH "WARNING"
git-filter-branch.1:47:.SH "DESCRIPTION"
git-filter-branch.1:60:.SS "Filters"
git-filter-branch.1:67:.SH "OPTIONS"
git-filter-branch.1:195:.SH "EXAMPLES"
git-filter-branch.1:527:.SH "PERFORMANCE"
git-filter-branch.1:641:.SH "SAFETY"
git-filter-branch.1:890:.SH "GIT"
git-filter-branch.1:893:.SH "NOTES"

-.-.

Use ".na" (no adjustment) instead of ".ad l" (and ".ad" to begin the
same adjustment again as before).

26:.ad l

-.-.

Section headings (.SH and .SS) do not need quoting their arguments.

30:.SH "NAME"
32:.SH "SYNOPSIS"
44:.SH "WARNING"
47:.SH "DESCRIPTION"
60:.SS "Filters"
67:.SH "OPTIONS"
189:.SS "Remap to ancestor"
192:.SH "EXIT STATUS"
195:.SH "EXAMPLES"
441:.SH "CHECKLIST FOR SHRINKING A REPOSITORY"
527:.SH "PERFORMANCE"
641:.SH "SAFETY"
890:.SH "GIT"
893:.SH "NOTES"

-.-.

Remove excessive "\&" when it has no functional purpose.

46:\fIgit filter\-branch\fR has a plethora of pitfalls that can produce non=
\-obvious manglings of the intended history rewrite (and can leave you with=
 little time to investigate such problems since it has such abysmal perform=
ance)\&. These safety and performance issues cannot be backward compatibly =
fixed and as such, its use is not recommended\&. Please use an alternative =
history filtering tool such as \m[blue]\fBgit filter\-repo\fR\m[]\&\s-2\u[1=
]\d\s+2\&. If you still need to use \fIgit filter\-branch\fR, please carefu=
lly read the section called \(lqSAFETY\(rq (and the section called \(lqPERF=
ORMANCE\(rq) to learn about the land mines of filter\-branch, and then vigi=
lantly avoid as many of the hazards listed there as reasonably possible\&.
640:The \m[blue]\fBgit filter\-repo\fR\m[]\&\s-2\u[1]\d\s+2 tool is an alte=
rnative to git\-filter\-branch which does not suffer from these performance=
 problems or the safety problems (mentioned below)\&. For those with existi=
ng tooling which relies upon git\-filter\-branch, \fIgit filter\-repo\fR al=
so provides \m[blue]\fBfilter\-lamely\fR\m[]\&\s-2\u[2]\d\s+2, a drop\-in g=
it\-filter\-branch replacement (with a few caveats)\&. While filter\-lamely=
 suffers from all the same safety issues as git\-filter\-branch, it at leas=
t ameliorates the performance issues a little\&.

-.-.

Use "\-" instead of "-" in web addresses.

16:.\" http://lists.gnu.org/archive/html/groff/2009-02/msg00013.html
897:\%https://github.com/newren/git-filter-repo/
902:\%https://github.com/newren/git-filter-repo/blob/master/contrib/filter-=
repo-demos/filter-lamely

-.-.

Put a (long) web address on a new line to reduce the posibility of
splitting the address between two output lines.
Or inhibit hyphenation with "\%" in front of the name.

897:\%https://github.com/newren/git-filter-repo/
902:\%https://github.com/newren/git-filter-repo/blob/master/contrib/filter-=
repo-demos/filter-lamely

-.-.

Output from "test-nroff  -mandoc -t -K utf8 -rF0 -rHY=3D0 -rCHECKSTYLE=3D10=
 -ww -z ":

troff:<stdin>:902: warning [page 10, line 29]: cannot break line

-.-.

Generally:

Split (sometimes) lines after a punctuation mark; before a conjunction.

--1QreUpu+FrkDDLdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-filter-branch.1.diff"

--- git-filter-branch.1	2025-03-13 02:10:27.604859557 +0000
+++ git-filter-branch.1.new	2025-03-13 18:02:25.935434652 +0000
@@ -894,10 +894,10 @@ Part of the \fBgit\fR(1) suite
 .IP " 1." 4
 git filter-repo
 .RS 4
-\%https://github.com/newren/git-filter-repo/
+\%https://github.com/newren/git\-filter\-repo/
 .RE
 .IP " 2." 4
 filter-lamely
 .RS 4
-\%https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely
+https://github.com/newren/git\-filter\-repo/\:blob/\:master/\:contrib/\:filter\-repo\-demos/\:filter\-lamely
 .RE

--1QreUpu+FrkDDLdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="general.bugs"

  Any program (person), that produces man pages, should check the output
for defects by using (both groff and nroff)

[gn]roff -mandoc -t -ww -b -z -K utf8 <man page>

  The same goes for man pages that are used as an input.

  For a style guide use

  mandoc -T lint

-.-

  Any "autogenerator" should check its products with the above mentioned
'groff', 'mandoc', and additionally with 'nroff ...'.

  It should also check its input files for too long (> 80) lines.

  This is just a simple quality control measure.

  The "autogenerator" may have to be corrected to get a better man page,
the source file may, and any additional file may.

  Common defects:

  Not removing trailing spaces (in in- and output).
  The reason for these trailing spaces should be found and eliminated.

  "git" has a "tool" to point out whitespace,
see for example "git-apply(1)" and git-config(1)")

  Not beginning each input sentence on a new line.
Line length and patch size should thus be reduced.

  The script "reportbug" uses 'quoted-printable' encoding when a line is
longer than 1024 characters in an 'ascii' file.

  See man-pages(7), item "semantic newline".

-.-

The difference between the formatted output of the original and patched file
can be seen with:

  nroff -mandoc <file1> > <out1>
  nroff -mandoc <file2> > <out2>
  diff -d -u <out1> <out2>

and for groff, using

\"printf '%s\n%s\n' '.kern 0' '.ss 12 0' | groff -mandoc -Z - \"

instead of 'nroff -mandoc'

  Add the option '-t', if the file contains a table.

  Read the output from 'diff -d -u ...' with 'less -R' or similar.

-.-.

  If 'man' (man-db) is used to check the manual for warnings,
the following must be set:

  The option \"-warnings=w\"

  The environmental variable:

export MAN_KEEP_STDERR=yes (or any non-empty value)

  or

  (produce only warnings):

export MANROFFOPT=\"-ww -b -z\"

export MAN_KEEP_STDERR=yes (or any non-empty value)

-.-

--1QreUpu+FrkDDLdd--
