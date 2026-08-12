Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770444B694
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540588; cv=none; b=HIo+Z3bddP1/xCMQ3yRgb5eqjZvQtAOmrpWbvCkKvn7Sw45FLB2KL12qtYFca/PhHondaZFC3s5NsJsEtjon+yalEaVhzfwPBEBueGTO/53pnl6SGsf+1pIT4ErurKSHQ6uMO9C0N0DCX1w4QGwd2C5bAQJqRRQcoIufhFP0IHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540588; c=relaxed/simple;
	bh=nQuagaAsUbwSgBLehRYsEb7MAAoZl4Nd34xZ7rHqHG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BG0/ZkFMfIpdd2QnHd7jzOI77QHQTyOe4tPmUdR43gEwBCcbXtxB/+DDPWmkXPp1e9nxE+t3I0snTU7IH19xvdanCWpIQEVgu+CctjCZt7izF6bCrxf/FZYyz+pA5j81yLM11u/Uo65e4OPa2vFbVNXWa7kXEEy2XuyNJ7B+YmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0afmcUe; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0afmcUe"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f0167e59a3so551349a34.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540585; x=1787145385; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2nD7kiZVHIdGB2Kpt7dcf/CyT86RmlJpoyvD0oPN+4=;
        b=G0afmcUeq9uNFRYIutGIqO5cVv9ZhPk9LLdAUwjtXLbmwjVpiEVglM9Kex6IbsVrV7
         mjKx0dNjx+GaD2u1Izq6LOm9ybXh6lBzbXGEVa/Nb3znXVmmBNq4L6d/1PLyteWc1fOq
         VeM5HKZ1JbsEDPL9/zl7FnKoTc1ZxL704Z9WNsJHFRK5vQ7yXAagjkeYQPv5CDrUZ4b+
         Q+l7FZVmssVwlJEiKc0qeJvALCWpB9fQtqtQVwrPmI5Hy6Jf0WnvMRCHI/CGZku6hs9M
         +9Qdkk2fiaxz/tvFAkYiZunSmjvnuZeeh1QcROAJiWuYBbUu2G+b9rI6Vr/PEhGlMd7M
         523w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540585; x=1787145385;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2nD7kiZVHIdGB2Kpt7dcf/CyT86RmlJpoyvD0oPN+4=;
        b=mqa0rHody8Ohk7eQh1DmEx2nxAGHPObdZ7nHEfd/3jJnIzUarYXP49M/w1PcWvMHYl
         C1+qSJxd71u5TjCdKRMYaqHR19aH03U8O2V5sXIDE2KAduuSNpDKWmmsvtrnBIu57Qvn
         bdZGZDpDuJe5GeXHTDx3+PSy3XkV11iN4+3IkkTvocZoMhM/LjfK2J5l66/5GfO7kTIq
         2lyiQfhdIgat3ZbSISD3GWYq9OePozoXbLg7ayii/7YwbW6y+EMYHnpJqS6tntnYKS5k
         TfD81ncHzjoDk62hXaEeGKx17WvQEM+xINFXkXwRVbiUk2M6ds8h2wBkJ6WsG9Mn6BAs
         5mAg==
X-Gm-Message-State: AOJu0YxjnN+FbbDxeWGPr3btF0/Ps0ssak/SHfuV9Cqfpcho0ROYez3q
	Oo0lAHoFHtIrKYQEMkgl9j9VTgTwiLPdbNWlCR/+VLoPPqNYz3Yd6evoriAryg==
X-Gm-Gg: AR+sD12gzmal78OoNpB/6s3wMGwg1tffY2fa/X31PJA4WXD36zA6XEYGXWRRi1pQZmn
	2vNLzfdNydeA2xY8E87MBBU+kEvG8hFPtnX3UuwSL9GQnMFJgxbfM0jeV7P2JpLbs5XGyGZeG8X
	WW/BKGpI2rwaWn3IbkIqZmM6mMtsj+7Px0zdKccFu687RaQaBZc4uE58odMk2NLNdKgqtiJ+QBk
	xAgzTXCSIuSJwqmAj1SWwlcpL6F0bPodc/9OJ/v9WzxxcdINWEzgpJ7Pp2ZG6IjygKa9/vOoIzC
	dV1OiLVqSl1GHM0slQuCQBzn28auPuQcD0Pr87opvxgZ3HCk2x3Oqe4yVjJl8dGmugguqLrHdoA
	wirXF9CnjVcmbq5V15ooSuxwt76cflhmBaN/LnLl1S31gnBivSECq5Su5oxacmYq0PsIPFDov8i
	4DA15JeJVJZNRx8N5Ti/aYz5/18pDeUnSV0TaKJCj5wDwKu8PmSBa7ihHP1T7iPLU=
X-Received: by 2002:a05:6830:3c90:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f3b7a0e4b9mr4786155a34.15.1786540585355;
        Wed, 12 Aug 2026 06:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b31c8857sm2868472a34.2.2026.08.12.06.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:24 -0700 (PDT)
Message-Id: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:15 +0000
Subject: [PATCH v2 0/6] gitk: make color preferences visually more pleasing and better usable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: mark <mlevedahl@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>

I find the user interface to set the color preferences a bit ugly for these
reasons:

 * The color samples are not clickable as one would expect who enters the
   dialog. Instead, the description is the button that must be clicked.

 * Since the descriptive texts are different for the preferences, the width
   of the buttons are different, too.

 * The descriptions themselves are not always natural language (read: they
   are nerdy) and use abbreviations.

This series makes the descriptions static text and turns the color samples
into the clickable buttons. It also makes the descriptions and dialog titles
more natural language.

Changes since v1:

 * Apply a thicker border to the buttons and some vertical distance between
   the lines.
 * Remove "Diff" from the labels, because they are sufficiently unambiguous
   without.
 * Fine-tune the wording of the labels for better English.
 * Move selection and link colors above diff colors.
 * Tweak the commit messages.

This is the dialog before the change: Screenshot_color_buttons_before
[https://github.com/user-attachments/assets/910a647f-4e56-47b0-b4c4-e6e7bc966e9c]
And this is the dialog after the change: Screenshot_color_buttons_after_v2
[https://github.com/user-attachments/assets/9c0fae28-727a-4bdd-9d76-36e276217322]

Johannes Sixt (6):
  gitk: set intitial colors of swatches using the available helper
  gitk: condense repetitive code around color buttons into foreach loops
  gitk: show color preferences on the button instead of the label
  gitk: use more natural language for labels of color preferences
  gitk: avoid constructing dialog titles from text pieces
  gitk: move UI for generic colors above diff colors

 gitk-git/gitk | 123 ++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 64 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2194%2Fj6t%2Fgitk-prefs-color-buttons-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2194/j6t/gitk-prefs-color-buttons-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2194

Range-diff vs v1:

 1:  ab16ec6276 ! 1:  e7e62f428b gitk: set intitial colors of swatches using the available helper
     @@ Commit message
          gitk: set intitial colors of swatches using the available helper
      
          After the user has selected a color in the Preferences dialog, the
     -    helper proc prefspage_set_colorswatches is used update the colors shown
     -    in the Preferences dialog. Use this proc also after the Preferences
     -    dialog is constructed to show the initial colors. This keeps the
     +    helper proc prefspage_set_colorswatches is used to update the colors
     +    shown in the Preferences dialog. Use this proc also to show the initial
     +    colors after the Preferences dialog is constructed. This keeps the
          procedure that gives the UI elements their colors in a single place.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
 2:  edb567608e = 2:  52dacc4924 gitk: condense repetitive code around color buttons into foreach loops
 3:  0428a92efc ! 3:  75202a52d7 gitk: show color preferences on the button instead of the label
     @@ gitk-git/gitk: proc prefspage_colors {notebook} {
      -        label $page.$uielem -padx 40 -relief sunk
      -        ttk::button $page.${uielem}btn -text $label \
      +        ttk::label $page.$uielem -text $label
     -+        button $page.${uielem}btn -padx 40 -pady 0 \
     ++        button $page.${uielem}btn -padx 40 -pady 0 -borderwidth 2 \
                   -command [list choosecolor $colorvar $idx $page $title]
      -        grid x $page.${uielem}btn $page.$uielem -sticky w
     -+        grid x $page.$uielem $page.${uielem}btn -sticky w
     ++        grid x $page.$uielem $page.${uielem}btn -sticky w -pady 1
           }
       
           grid columnconfigure $page 2 -weight 1
 4:  ce417701a8 ! 4:  45d5b05281 gitk: use more natural language for labels of color preferences
     @@ Commit message
          gitk: use more natural language for labels of color preferences
      
          The labels used to be clickable buttons. These would have looked funny
     -    if they carried long texts. For this reason, abbreviations and "nerdy"
     -    texts were used to keep them short. Since these labels are now static
     -    text, bring them closer to natural language.
     +    if they carried long texts. For this reason, jargon and abbreviations
     +    were used to keep them short. Since there is no button frame around the
     +    labels anymore, the texts can become longer without becoming ugly.
     +    Bring them closer to natural language.
     +
     +    Remove the prefix "Diff" from labels, because the remaining texts are
     +    sufficiently unambiguous that they are about diff text.
      
          Signed-off-by: Johannes Sixt <j6t@kdbg.org>
      
     @@ gitk-git/gitk: proc prefspage_colors {notebook} {
      +                    [mc "Main text"] \
                           [mc "foreground"] \
               diffold     diffcolors 0 \
     -                     [mc "Diff: old lines"] \
     +-                    [mc "Diff: old lines"] \
     ++                    [mc "Old line text"] \
                           [mc "diff old lines"] \
               diffoldbg   diffbgcolors 0 \
      -                    [mc "Diff: old lines bg"] \
     -+                    [mc "Diff: old lines background"] \
     ++                    [mc "Old line background"] \
                           [mc "diff old lines bg"] \
               diffnew     diffcolors 1 \
     -                     [mc "Diff: new lines"] \
     +-                    [mc "Diff: new lines"] \
     ++                    [mc "New line text"] \
                           [mc "diff new lines"] \
               diffnewbg   diffbgcolors 1 \
      -                    [mc "Diff: new lines bg"] \
     -+                    [mc "Diff: new lines background"] \
     ++                    [mc "New line background"] \
                           [mc "diff new lines bg"] \
               hunksep     diffcolors 2 \
      -                    [mc "Diff: hunk header"] \
     -+                    [mc "Diff: hunk headers"] \
     ++                    [mc "Hunk header text"] \
                           [mc "diff hunk header"] \
               markbg      markbgcolor {} \
      -                    [mc "Marked line bg"] \
     -+                    [mc "Marked lines background"] \
     ++                    [mc "Marked line background"] \
                           [mc "marked line background"] \
               selbg       selectbgcolor {} \
      -                    [mc "Select bg"] \
 5:  1e1bcfaf5b ! 5:  697159c20e gitk: avoid constructing dialog titles from text pieces
     @@ gitk-git/gitk: proc prefspage_colors {notebook} {
      -                    [mc "foreground"] \
      +                    [mc "choose main text color"] \
               diffold     diffcolors 0 \
     -                     [mc "Diff: old lines"] \
     +                     [mc "Old line text"] \
      -                    [mc "diff old lines"] \
      +                    [mc "choose text color of old lines"] \
               diffoldbg   diffbgcolors 0 \
     -                     [mc "Diff: old lines background"] \
     +                     [mc "Old line background"] \
      -                    [mc "diff old lines bg"] \
      +                    [mc "choose background color of old lines"] \
               diffnew     diffcolors 1 \
     -                     [mc "Diff: new lines"] \
     +                     [mc "New line text"] \
      -                    [mc "diff new lines"] \
      +                    [mc "choose text color of new lines"] \
               diffnewbg   diffbgcolors 1 \
     -                     [mc "Diff: new lines background"] \
     +                     [mc "New line background"] \
      -                    [mc "diff new lines bg"] \
      +                    [mc "choose background color of new lines"] \
               hunksep     diffcolors 2 \
     -                     [mc "Diff: hunk headers"] \
     +                     [mc "Hunk header text"] \
      -                    [mc "diff hunk header"] \
     -+                    [mc "choose hunk header color"] \
     ++                    [mc "choose text color of hunk headers"] \
               markbg      markbgcolor {} \
     -                     [mc "Marked lines background"] \
     +                     [mc "Marked line background"] \
      -                    [mc "marked line background"] \
      +                    [mc "choose background color of marked lines"] \
               selbg       selectbgcolor {} \
 -:  ---------- > 6:  36590e857d gitk: move UI for generic colors above diff colors

-- 
gitgitgadget
