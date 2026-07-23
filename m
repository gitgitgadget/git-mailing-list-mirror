Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27A36F437
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841573; cv=none; b=Xn+ln1qHH7QaxLc85Sh/5YrIeYPV8F73A2piPvog3JUaPVjx2heLFxSg75VRashji/orb8HgyhLsIpDfdnOduiPyu37INYdvwZbUutghiHwF0Fq4UtmF56CX98SKj5TeOodktMS1CIpFTg4Jzy+b4faefWidKTvg3gG4Hsl6+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841573; c=relaxed/simple;
	bh=R6N4iJGtyVIYTCvTyq03IkA4FnXYM7Krb3vU4EJmpKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=q/l70Rp4ppYfgGJtIQxNxsIIrU6RAQYQ9spyd2iSoZjiwHrjUhStVN1ZjgjPzRGOY1iWRoSPQtWDdUGuMQIDfWw0asoKsHXcDpcHMTA8TEFlkwe+J6P8PZdfK3+tqluvZp1sy/QdpS+yMmfPhWo0xBbNVjSCWlisoLiZxhh3YTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h72IFbWi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h72IFbWi"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a168dc590cso696764eaf.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841570; x=1785446370; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zb0rTan0Wx6J0Ui50HlksickA2CqidS5d533ICn/zWY=;
        b=h72IFbWiKO9xOa/qh5lnKfj1qJrnJ/DGLsPkh82bcvYj7Am5yn8ytjaprL+ab3+IgB
         JLVaJDWVQ3hbPWi+OvfSaBVx8xES1LMa4PIJb4+yL2wZ0OTCub3iyXb1mJrXV8WAqW7a
         Y3YWoYukNPg1O/HCKn+QIJZDOwfL5NUioeaznKg5BEZBb1x533dzWhy7zUlMWWmg9xb1
         mGdevHVSFEX/pT9WhUPAEbErsa/bfhrozvDzR4JGU1t9VAptNVAonhYuiILFHNUyRcUa
         9Lpz2HSCgbWNnOkeY9/IoTICSwf0ExWL1qiE/LBn2FZvqn4pZKxKKmGCbkpylmX3FMnQ
         08xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841570; x=1785446370;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zb0rTan0Wx6J0Ui50HlksickA2CqidS5d533ICn/zWY=;
        b=FELtFZ5DK5b5p4gqAByFoWcCUFwnCIcMStFes4I0l1TakhQGh+3p4RpPvA6wTvT7ad
         3/5NnEAYUTUbgk6xpNX7GjS2i6hwiuj86rKTKUCsFV6Ga/6FYURlmUlc58sTqjYhRn+e
         6XqYGwx7QRObCJUFqvGixZ7JWPM1TkeFpSWd+6ig6KDMZWQElgOUpbrj2yxdY/Bq1hWM
         IqTPPabiv2BE8Qvzez0EdcSgRjY+h4Wfehri28pDt1GFlG/gA3R1PukXLSOJ0O/rRZm5
         Bkzft8pKwLHzb2QKyVyd3viUGuVq/JLrrEd0er6Px/p02wD0vhUhbhYWYxXaz2KPA5R3
         0pVg==
X-Gm-Message-State: AOJu0YyvlI3K8I7MhkpVBXgsWJv/57YiiF7bPhFG4urOiPZAJyHej7MI
	9s/RqiunqalUkGzUGEbGHpqTEaYN+xQzuX55GbnrM7KjFHvyCJMmf1uf6xNxJQ==
X-Gm-Gg: AR+sD13GKFzbQBhhBT+TmFZ3HZE+n0suVtbBBhYH2JElBIh7ADe5tKK7BdVPIOmTHFQ
	LtpXKMj29lFesmrfrUc4CtrnxMvXM1x30boi+wQxfR6fkG9AuFUmluRZxympl/Y8gA0mp1oSDNH
	zg31AYU/+1NBjUHw5d9JOP2jlfc1SoEYRGtnmKPTesK4WgzjhwRTqvNGPs4tskJF8C54tcIc8ND
	f1YSUDYJB0ErScKWUvvabb5tSzUs9pK4+2GZ8jyZk0KFx2nzdyPvCKo6smguMmvWd1VFQtgwsjI
	c8scK7mXGNCbbqF9e+Dtyfzq7mgvX0Y/siPPOn9s0lUy66k67stjMnyUlXCn6eDgg5hEyMW5ry6
	0/Ge8Y68MSL1RhWZuksKU7ly9XEo7lMy1v3wSV2qCXkg8UnvNSQuA1NMZt0h5jtzBI9kRMKso2m
	UZU/ZcX+vdjTmO+C1e
X-Received: by 2002:a05:6820:1c8f:b0:6a3:d683:6660 with SMTP id 006d021491bc7-6aad41b4fc2mr2153527eaf.52.1784841570290;
        Thu, 23 Jul 2026 14:19:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.167])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e7d640sm5263457fac.4.2026.07.23.14.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:19:28 -0700 (PDT)
Message-Id: <pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:19:22 +0000
Subject: [PATCH v2 0/4] A new batch of synopsis conversion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

The conversion to synopsis continues. Now the commands are less common, so I
may propose larger PRs if it's ok.

Changes since v1:

 * swap formats following comments
 * switch all listing blocks to 4 dash fences

Jean-Noël Avila (4):
  doc: convert git-imap-send synopsis and options to new style
  doc: convert git-format-patch synopsis and options to new style
  doc: convert git-send-email synopsis and options to new style
  doc: convert git-request-pull synopsis and options to new style

 Documentation/config/imap.adoc      |   2 +-
 Documentation/config/sendemail.adoc |  92 ++++-----
 Documentation/diff-options.adoc     |   8 +-
 Documentation/git-format-patch.adoc | 289 ++++++++++++++--------------
 Documentation/git-imap-send.adoc    |  22 ++-
 Documentation/git-request-pull.adoc |  38 ++--
 Documentation/git-send-email.adoc   | 162 ++++++++--------
 7 files changed, 311 insertions(+), 302 deletions(-)


base-commit: 08621c32d5536babd139ab1a9086349b3672edd6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2185%2Fjnavila%2Fconvert_synopsis_202606-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2185/jnavila/convert_synopsis_202606-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2185

Range-diff vs v1:

 1:  798c064390 ! 1:  697b4b55c3 doc: convert git-imap-send synopsis and options to new style
     @@ Documentation/config/imap.adoc
       	plaintext `LOGIN` command.
      
       ## Documentation/git-imap-send.adoc ##
     -@@ Documentation/git-imap-send.adoc: supports only `XOAUTH2` as the mechanism.
     +@@ Documentation/git-imap-send.adoc: that order.
     + 
     + Typical usage is something like:
     + 
     +-------
     ++----
     + $ git format-patch --signoff --stdout --attach origin | git imap-send
     +-------
     ++----
     + 
     + 
     + OPTIONS
     +@@ Documentation/git-imap-send.adoc: have set up) may not be verified correctly.
     + 
     + Using Gmail's IMAP interface:
     + 
     +----------
     ++----
     + [imap]
     +     folder = "[Gmail]/Drafts"
     +     host = imaps://imap.gmail.com
     +     user = user@gmail.com
     +     port = 993
     +----------
     ++----
     + 
     + Gmail does not allow using your regular password for `git imap-send`.
     + If you have multi-factor authentication set up on your Gmail account, you
     +@@ Documentation/git-imap-send.adoc: than using app-specific passwords, and also does not enforce the need of
     + having multi-factor authentication. You will have to use an OAuth2.0
     + access token in place of your password when using this authentication.
     + 
     +----------
     ++----
     + [imap]
     +     folder = "[Gmail]/Drafts"
     +     host = imaps://imap.gmail.com
     +     user = user@gmail.com
     +     port = 993
     +     authmethod = OAUTHBEARER
     +----------
     ++----
     + 
     + Using Outlook's IMAP interface:
     + 
     + Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
     + supports only `XOAUTH2` as the mechanism.
     + 
     +----------
     ++----
     + [imap]
     +     folder = "Drafts"
     +     host = imaps://outlook.office365.com
     +     user = user@outlook.com
     +     port = 993
     +     authmethod = XOAUTH2
     +----------
     ++----
       
       Once the commits are ready to be sent, run the following command:
       
      -  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
     -+
     -+---------
     ++----
      +$ git format-patch --cover-letter -M --stdout origin/master | git imap-send
     -+---------
     ++----
       
       Just make sure to disable line wrapping in the email client (Gmail's web
       interface will wrap lines no matter what, so you need to use a real
 2:  e1ed85e3f2 ! 2:  3850fb33ff doc: convert git-format-patch synopsis and options to new style
     @@ Documentation/git-format-patch.adoc: set.
       	Show progress reports on stderr as patches are generated.
       
       CONFIGURATION
     +@@ Documentation/git-format-patch.adoc: outputting more than one patch, add "To:" or "Cc:" headers, configure
     + attachments, change the patch output directory, and sign off patches
     + with configuration variables.
     + 
     +-------------
     ++----
     + [format]
     + 	headers = "Organization: git-foo\n"
     + 	subjectPrefix = CHANGE
      @@ Documentation/git-format-patch.adoc: with configuration variables.
     + 	coverLetter = auto
     + 	commitListFormat = shortlog
     + 	coverFromDescription = auto
     +-------------
     +-
     ++----
     + 
       DISCUSSION
       ----------
       
     @@ Documentation/git-format-patch.adoc: with configuration variables.
       with a fixed "magic" time stamp to indicate that the file is output
       from format-patch rather than a real mailbox, like so:
       
     +-------------
     ++----
     + From 8f72bad1baf19a53459661343e21d6491c3908d3 Mon Sep 17 00:00:00 2001
     + From: Tony Luck <tony.luck@intel.com>
     + Date: Tue, 13 Jul 2010 11:42:54 -0700
     +@@ Documentation/git-format-patch.adoc: arch/arm config files were slimmed down using a python script
     + 
     + Do the same for ia64 so we can have sleek & trim looking
     + ...
     +-------------
     ++----
     + 
     + Typically it will be placed in a MUA's drafts folder, edited to add
     + timely commentary that should not go in the changelog after the three
      @@ Documentation/git-format-patch.adoc: can save interesting patches in a UNIX mailbox and apply them with
       linkgit:git-am[1].
       
     @@ Documentation/git-format-patch.adoc: can save interesting patches in a UNIX mail
       line that consists solely of "`-- >8 --`" (scissors and perforation),
       followed by the patch with unnecessary header fields removed:
       
     +-------------
     ++----
     + ...
     + > So we should do such-and-such.
     + 
     +@@ Documentation/git-format-patch.adoc: Subject: [IA64] Put ia64 config files on the Uwe Kleine-König diet
     + 
     + arch/arm config files were slimmed down using a python script
     + ...
     +-------------
     ++----
     + 
     + When sending a patch this way, most often you are sending your own
     + patch, so in addition to the "`From $SHA1 $magic_timestamp`" marker you
      @@ Documentation/git-format-patch.adoc: two common types of corruption:
       One way to test if your MUA is set up correctly is:
       
     @@ Documentation/git-format-patch.adoc: External Editor from https://globs.org/arti
          window for the patch, use Tools->about:config to set the
          following to the indicated values:
       +
     +-----------
     ++----
     + 	mailnews.send_plaintext_flowed  => false
     + 	mailnews.wraplength             => 0
     +-----------
     ++----
     + 
     + 4. Open a compose window and click the external editor icon.
     + 
     +@@ Documentation/git-format-patch.adoc: External Editor from https://globs.org/articles.php?lng=en&pg=8
     + Side note: it may be possible to do step 2 with
     + about:config and the following settings but no one's tried yet.
     + 
     +-----------
     ++----
     + 	mail.html_compose                       => false
     + 	mail.identity.default.compose_html      => false
     + 	mail.identity.id?.compose_html          => false
     +-----------
     ++----
     + 
     + There is a script in contrib/thunderbird-patch-inline which can help
     + you include patches with Thunderbird in an easy way. To use it, do the
      @@ Documentation/git-format-patch.adoc: BASE TREE INFORMATION
       
       The base tree information block is used for maintainers or third party
     @@ Documentation/git-format-patch.adoc: BASE TREE INFORMATION
      -The 'base commit' is shown as "base-commit: " followed by the 40-hex of
      -the commit object name.  A 'prerequisite patch' is shown as
      -"prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
     -+The "base commit" is shown as "base-commit: " followed by the 40-hex of
     -+the commit object name.  A `prerequisite patch` is shown as
     -+"prerequisite-patch-id: " followed by the 40-hex `patch id`, which can
     ++The "base commit" is shown as "`base-commit:` " followed by the 40-hex of
     ++the commit object name.  A "prerequisite patch" is shown as
     ++"`prerequisite-patch-id:` " followed by the 40-hex "patch id", which can
       be obtained by passing the patch through the `git patch-id --stable`
       command.
       
     +@@ Documentation/git-format-patch.adoc: range), the base tree information block is shown at the end of the
     + first message the command outputs (either the first patch, or the
     + cover letter), like this:
     + 
     +-------------
     ++----
     + base-commit: P
     + prerequisite-patch-id: X
     + prerequisite-patch-id: Y
     + prerequisite-patch-id: Z
     +-------------
     ++----
     + 
     + For non-linear topology, such as
     + 
      @@ Documentation/git-format-patch.adoc: EXAMPLES
       --------
       
 3:  723450c5a0 = 3:  94751ae58b doc: convert git-send-email synopsis and options to new style
 4:  5b6e9bd3f3 ! 4:  740b24631d doc: convert git-request-pull synopsis and options to new style
     @@ Documentation/git-request-pull.adoc: the `v1.0` release, and want it to be integ
       see:
       
      -	git push https://git.ko.xz/project master
     -+-----
     ++----
      +git push https://git.ko.xz/project master
     -+-----
     ++----
       
       Then, you run this command:
       
      -	git request-pull v1.0 https://git.ko.xz/project master
     -+------
     ++----
      +git request-pull v1.0 https://git.ko.xz/project master
     -+------
     ++----
       
       which will produce a request to the upstream, summarizing the
       changes between the `v1.0` release and your `master`, to pull it
     @@ Documentation/git-request-pull.adoc: from your public repository.
       the one you have locally, e.g.
       
      -	git push https://git.ko.xz/project master:for-linus
     -+-----
     ++----
      +git push https://git.ko.xz/project master:for-linus
     -+-----
     ++----
       
       then you can ask that to be pulled with
       
      -	git request-pull v1.0 https://git.ko.xz/project master:for-linus
     -+-----
     ++----
      +git request-pull v1.0 https://git.ko.xz/project master:for-linus
     -+-----
     ++----
       
       
       GIT

-- 
gitgitgadget
