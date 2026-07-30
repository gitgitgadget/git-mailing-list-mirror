Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E73AD531
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440742; cv=none; b=TcjQ2q0k7WvhSL0sQg+fR4aaSa0ezYcuaf96iLG0ANKDw6rtKOTUK2LGe8rY+wuQmImsjJKk29NO+1UUTk8dehqeH2CNP2FnbIDe0LDE2ubYemCM17zIUWqI8HlEJyOg6t/nlyf79y6wPOB0wf0+tw85kX6EXGmpmuJXH2WQl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440742; c=relaxed/simple;
	bh=Iru+8ceh+JfENSsbi7WI0Wvv5HW8cr+N4BrLTqYKXbo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KGqhDqxlSHKjNr1csgFYGdWQ5dy0tWgS0ZsU0nqEpqHWXbQOQpzlOJtjdFTKp7w3cB3b9iTJbbDiN1Gj5HS4WpzDOxbtlAI+3+oEjiTRYyWkdgQgf1EvtHLgMhUDyEOJ7LcfNrgoZ460xSkZ4ykGBSebWURLf9Ual9EmQrJ+yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de; spf=pass smtp.mailfrom=fahldieck.de; dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b=LeX9Yedc; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b="LeX9Yedc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fahldieck.de; s=blu9537877; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Jt07rn4RYVi0OpdfKeg4q839dTtAmEHwh+Z1oV4jpaY=; b=LeX9YedcXILM0iexK405ux7Laa
	GZzQ/xszurk4xgjdfkh15SsYXH7R5UB1r9C7chDAJDCmGfVA9s3rMJUQEtyiU96zbDx30DgnjbleW
	ckcydvM5F+O8RjKG9JD7oxhb1DbGzZxT3uX+WOGNrpN0iTCoGHvNdMKyURKB75ywiexhNv5T0loyc
	0UdIlIZh4bzLxpUOAqE5JnVnqJr9QDoYYbA0CabzhKbJv5tGDFK4uY68FA5f4Ybxke1nMM7PdYg8D
	pV5YHYNFcMNU2h+1Ebxp8oPSR+S3IjDviDBWuYCDp5lpUn56mo+XzpO92ooYjuiHcaDFND1vOwGqW
	qwZsK8rw==;
Received: from [209.85.128.175] (helo=mail-yw1-f175.google.com)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nils@fahldieck.de>)
	id 1wpVLk-0026ke-U2
	for git@vger.kernel.org;
	Thu, 30 Jul 2026 20:19:20 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81eaf3709b4so2290317b3.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:19:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxiGzT873bYa+6Fwni19yFDhSPtZEWrn+u7yav4MLStvUW2CKtm
	B6VK/ijZ7Gf1abLHiWqVPqOoQ2ABkJu2myY/XzObXe688pdjgE1Iae0e8KSVHUhJesP3PaRelf/
	LtKVbD+ZDty9AQ65GB942k750fMysc/E=
X-Received: by 2002:a05:690c:48c3:b0:81e:f8ca:1115 with SMTP id
 00721157ae682-81fb8abb899mr28239317b3.41.1785435559464; Thu, 30 Jul 2026
 11:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nils Fahldieck <nils@fahldieck.de>
Date: Thu, 30 Jul 2026 20:18:43 +0200
X-Gmail-Original-Message-ID: <CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com>
X-Gm-Features: AUfX_mxDFfuih7gc9TemjBEaf-ye-UFMLH6xTvZIK_Kd2X-ewD_RUjMJq8VpD04
Message-ID: <CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com>
Subject: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Con-Id: 301193
X-Con-U: 0-nils

Hi,

I ran into a confusing discrepancy between what the git-config(1) man
page promises for --global and what the code actually does when both
~/.gitconfig and ~/.config/git/config exist.


BACKGROUND
----------

Git recognises two "global" config files (described in the FILES
section of git-config(1)):

  $XDG_CONFIG_HOME/git/config
    (falls back to ~/.config/git/config when $XDG_CONFIG_HOME is unset)

  ~/.gitconfig

When --global is NOT passed, git config --get reads both files via
do_git_config_sequence() in config.c.  The XDG file is processed first,
~/.gitconfig second, so ~/.gitconfig takes precedence on any key that
appears in both.  This is correct and consistent with the documentation.

The bug is in what happens when --global IS explicitly passed.


WHAT THE DOCS CLAIM
-------------------

From Documentation/git-config.adoc, the --global entry reads:

  For writing options: write to global ~/.gitconfig file rather than
  the repository .git/config, write to $XDG_CONFIG_HOME/git/config
  file if this file exists and the ~/.gitconfig file doesn't.

  For reading options: read only from global ~/.gitconfig and from
  $XDG_CONFIG_HOME/git/config rather than from all available files.


WHAT THE CODE ACTUALLY DOES
----------------------------

Both read and write with --global go through the same function,
git_global_config() in config.c (around line 1505), which returns
exactly ONE path.  That single path is then set as the only source
file in builtin/config.c (around line 960).

The selection logic in git_global_config() is:

  /* access_or_warn returns non-zero on FAILURE, zero on success */
  if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
      !access_or_warn(xdg_config, R_OK, 0)) {
      return xdg_config;   /* ~/.gitconfig unreadable AND XDG readable */
  } else {
      return user_config;  /* otherwise always return ~/.gitconfig */
  }

This means:

1. The writing claim is inaccurate.

   The docs say XDG is used when ~/.gitconfig "doesn't exist".  The
   code tests READABILITY (R_OK), not existence.  A zero-byte file
   created by "touch ~/.gitconfig" is readable, so access_or_warn
   returns 0 (success), the condition is false, and XDG is silently
   ignored even though ~/.gitconfig is empty.

   The condition should be described as "when ~/.gitconfig is not
   readable", not "when it doesn't exist".

2. The reading claim is outright wrong.

   The docs say --global reads from BOTH files.  The code reads from
   ONE.  git_global_config() selects a winner and frees the other
   path.  There is no code path under --global that reads both files.


REPRODUCER
----------

  # Setup: only the XDG file exists and contains user.name = "My Name"
  $ ls ~/.config/git/config     # exists, has user.name
  $ ls ~/.gitconfig             # does not exist

  $ git config --get user.name
  My Name
  $ git config --global user.name
  My Name

  $ touch ~/.gitconfig          # create empty but readable ~/.gitconfig

  $ git config --get user.name
  My Name                       # correct: reads both, XDG value survives

  $ git config --global user.name
                                # BUG: empty output -- git_global_config()
                                # returned ~/.gitconfig (readable but empty)
                                # and silently discarded the XDG file

  $ rm ~/.gitconfig

  $ git config --global user.name
  My Name                       # back to normal: ~/.gitconfig gone, XDG used

Tested on macOS with git version 2.55.0 built and installed via Homebrew.


THE FIX -- TWO OPTIONS
----------------------

Option A -- Fix the code to match the documented intent (preferred):

  Make git config --global for reading behave like do_git_config_sequence():
  read both global files when both are accessible and let later values
  take precedence (i.e. ~/.gitconfig wins over XDG, same as normal reads).
  This is what the documentation describes and what users expect.

Option B -- Fix the docs to match the actual code:

  Document the real rule: "--global selects a single file: ~/.gitconfig
  if it is readable, otherwise the XDG file if it is readable."

  Option B alone closes the documentation bug but leaves the underlying
  asymmetry: "git config --get" and "git config --global" silently
  disagree whenever both global files coexist.  That asymmetry is a
  usability bug in its own right regardless of what the docs say.

I prefer Option A.


RELEVANT CODE LOCATIONS
-----------------------

  config.c ~1505-1523    git_global_config() -- picks one file
  config.c ~1525-1537    git_global_config_paths() -- builds both paths
  config.c ~1580-1586    do_git_config_sequence() -- reads both correctly
  builtin/config.c ~960     --global wires git_global_config() as sole source
  path.c ~1545-1560    xdg_config_home_for() -- XDG fallback to ~/.config/

  Documentation/git-config.adoc ~147-154   the inaccurate --global entry

I am interested in actually contributing a patch once we agreed on a fix. If the
behaviour is intended, though, I am interested in the reasoning. Maybe it is
also a translation issue since English is not my native language.

Kind regards
Nils
