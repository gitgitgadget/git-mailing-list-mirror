Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524D26738D
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049283; cv=none; b=skZLPqOft9eHDfG2ZewvU1moqmKLtr++OxWShIjsg7ZmUvgiN6GpwEg2pOaiXph0MR+1kJe3BI/G655plOCoW2GZkypDAY/OAj+mGkGd71Ir7ys739hQWQcJ33lSR3EaLgHDYt+m4hPu6nUdyOPsqwphxSFsxbPP1tw01SrRUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049283; c=relaxed/simple;
	bh=uHzqmo43e3tYdLqvNoLGy6HWDC5dsboROwlLHJy8kNI=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=tyiitrSJ5oKZ6+akTaEQhHU9NycpWNJsNFg8k5LNW2gAnDVXuq15dCw5SCWg4AFn5d/28thvYKsvFHX5KGVyzOM69ohV0sMmHbj0+2b3iRze3HvcCPB5ZG10c0nHarnk/DcLYYRlfzWOfqpjUjdBqETPthQ8Ta8zxG+Oq0vYIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b=KGFwYBC/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=lolligerhans@gmx.de header.b="KGFwYBC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770049279; x=1770654079; i=lolligerhans@gmx.de;
	bh=OTVUwbc4zgE2/SMsJKG6gdOSKk+gjl+JVy3oUmfaGdU=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KGFwYBC/wSchzZWalmboOq4RR/RJPDkq++jGbAIoyTh9eLokmc2AxH9fgLKF6jHP
	 maVzrdI/ABD7E7oUNmIsIe5Q3xYK+JKtN9TyxsRbSlrOzK4p6mh7/r28pxrCzB/Ns
	 vz/vhXPTZ+AW2E3Ue7FZpaIO/eV048Qz2cfYzevA0qGj7fF8YOQ+P7UA723Ay17eH
	 AlLIDxHczclUgrfqZX1QInfnvYC4V7gssmu7G4ccgf1gMa//xeQ7l9DiPGMNWlWqr
	 AhzXn50l4jAoPZRvXBpCnNCUNvOB4UmsZqZCi6TxtBNPobzFJ1ZVcK8QP41kToUd8
	 x94WCnknL92bAxsVSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [84.129.137.125] ([84.129.137.125]) by
 trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4 (via HTTP); Mon, 2 Feb 2026
 16:21:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
From: lolligerhans@gmx.de
To: git@vger.kernel.org
Subject: [BUG] git log --graph --pretty=format misplaces graph characters
 when -p given
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Feb 2026 16:21:19 +0000
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:WeKH9P861hSRHMyd3OOyQbdl6JHJfEYLiM5poniUBYA9QItwYsrUa5Bkf/1qNvla/Su5c
 lMxybUmOjly5LGP0GVGS/GLsa2SB10iRah5TEub2pEk76iFSzQJ0llSZRcojtsLaKlFM85MpQzha
 VLedQKrAKSs1LXWyJvkhUcZsddbpB3xHxP5AB2Ze6PpBsZV2t4lT0Pb4vvXlFkJT692/9MCI4sPW
 ixLFq9tf0uhYWLtqnjjly92PbLyCX6Z21BTMY9zcdBQHXsKuhFjHFpIdJVUw556nI8J0yXjzpk/G
 Hq833IZHjoTRdc3mVEAsUn0w4knhusKErRQTFTlqcNw/oRoCR00SacMG1aVJAkj7IyNr5dp/+O5o
 /yqn9tosOf4
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BXOjw1vwjvI=;dVUJT7zxs1vnobiHBBP8fJeo8vG
 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
 M9mJgaMoeDw+oL2rzQQ
Content-Transfer-Encoding: quoted-printable

Hello,

Git can pretty-print a commit graph with git log --graph and a custom --pr=
etty
format. I alias some uses of git log --graph --pretty, to which I then wan=
t to
manually add "-p" upon invocation.

When using the working command
    git log --graph --pretty=3D'format:%h'
and appending "-p/--patch", the output appears erroneous:
    git log --graph --pretty=3D'format:%h' -p                             =
    (1)

Expected output:
      1 !    * d0c34d4
      2      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugrep=
ort-2026-02-02-1427.txt
      3      | index 5a83af1..2740fd4 100644
      4      | --- a/git-bugreport-2026-02-02-1427.txt
      5      | +++ b/git-bugreport-2026-02-02-1427.txt
      6      | @@ -1,22 +1,53 @@
      7      |  Some context-before line
      8      | -Some removed line
    ---      | ...
    101      | +Some added line
    102      |  Some context-after line
    103 !    |=20
    104 !    * 28299b2
    105      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugrep=
ort-2026-02-02-1427.txt
    106      | new file mode 100644
    107      | index 0000000..5a83af1
    ---      | ...

Actual output, shortened, with line numbers:
      1 !    * d0c34d4|=20
      2      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugrep=
ort-2026-02-02-1427.txt
      3      | index 5a83af1..2740fd4 100644
      4      | --- a/git-bugreport-2026-02-02-1427.txt
      5      | +++ b/git-bugreport-2026-02-02-1427.txt
      6      | @@ -1,22 +1,53 @@
      7      |  Some context-before line
      8      | -Some removed line
    ---      | ...
    101      | +Some added line
    102      |  Some context-after line
    103 !   =20
    104 !    * 28299b2|=20
    105      | diff --git a/git-bugreport-2026-02-02-1427.txt b/git-bugrep=
ort-2026-02-02-1427.txt
    106      | new file mode 100644
    107      | index 0000000..5a83af1
    ---      | ...

In the actual output, note the trailing "| " sequences in lines {1, 104} a=
nd the
missing graph character in line 103. I believe the sequence in line 1 belo=
ngs to
line 103.

The actual output looks as if intended to be:
    <asterisk> <format_string>                    <\n> <diff> <\n> <graph_=
characters> <\n>
but is in the wrong order accidentally:
    <asterisk> <format_string> <graph_characters> <\n> <diff> <\n>        =
            <\n>
where the graph_characters "| " are misplaced.

Note: I present the reordering of the offending parts as expected, but it =
may be
more reasonable to expect both not to exist. I.e., no trailing "| " in lin=
e 1
and no line 103 entirely.

There are workarounds that hide this problem, with drawbacks. These workar=
ounds
keep the graph is visually intact, but their output may still differ from =
what
was originally intended:
- Workaround: using "=3Dtformat:" instead of "=3Dformat:".
    But: The diff is visually separated apart from the commit it belongs t=
o and
    next to the subsequent commit. I.e., it appears something is still
    misplaced, and the result is better only coincidentally. Compare to
        git log --graph --oneline -p
    which does not use any separation for a --patch.
- Workaround: using "%h%n" instead of "%h".
    Ending the format string with explicit newline curiously fixes the dis=
play
    with --patch, but introduces many obsolete lines when used without --p=
atch,
    especially for one-line format strings.

What did you do before the bug happened? (Steps to reproduce your issue)

    1. Ensure at least 2 commits exist. Makes --graph meaningful.
    2. Run the offending command (1):
        git log --graph --pretty=3D'format:%h' -p                         =
    (1)

    Alternatively with shorter output:
        git log --graph --pretty=3D'format:%h' -p --color=3Dalways | head =
-3

What did you expect to happen? (Expected behavior)

    The characters forming edges/vertices of the visual graph are printed =
at the
    beginning of lines, horizontally left of the other log contents.

What happened instead? (Actual behavior)

    Some characters semantically belonging to the visual graph are printed=
 at
    the end of the line, after the format string.

What's different between what you expected and what actually happened?

    The actual output does not visually form the expected graph. It appear=
s that
    outputs are printed in unintended order.

Anything else you want to add:

    I did not check if "--format" instead of "--pretty=3Dformat:" behaves
    identically.

    I grepped for "pretty" in the commits v2.51.0..origin/next and the pro=
blem
    appears not to be addressed yet.

    With more branches and colors, the visuals are consistent with what
    I describe above.

    I do not know what is going on here:
        - Using format string "%s%n%b" appears to work fine.
        - Using format string "%s  %b" does not work, but problems start o=
nly at
          the second commit, not first.
        - Using format string "  %n%s" does not work.


[System Info]
git version:
git version 2.51.0
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
not run from a git repository - no hooks to show

