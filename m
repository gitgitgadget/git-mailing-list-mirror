From: Britton Kerin <britton.kerin@gmail.com>
Subject: strange behavior with nonexistant or partially populated ~/.config/git/gitk
Date: Fri, 5 Feb 2016 18:16:59 -0900
Message-ID: <CAC4O8c8qEjcLASu7JwNhyLX+h3uFSUiHAV2yqJhgE+N5-gC0Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 04:17:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRtNV-0003Hv-EV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 04:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbcBFDRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 22:17:02 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36973 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcBFDRA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 22:17:00 -0500
Received: by mail-wm0-f46.google.com with SMTP id g62so51058284wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 19:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gNs0ohO3fL+s3NHktgsL/0kYe4H1yHKkyiLTyVluZJM=;
        b=by369OlPooJFB64qdnhBUMc9MYFeiBo263EftbVTpdcdd88oF8NteuGZR3qBTLyAr8
         KkEdSdbetv4tWCWAlQ3FGMI3UTgXDhZNHyvyoqE4yIeOoVH1yG67cFai6wmvXPsk007n
         bh2MUNj07UOaa23XK0Jd9IDbJ6mSF9am+BySRv3H/HM4fnGv2iqWmhRysZWkqRYtnUPz
         cWxWu+SzR22QPTRZbWNaK6bGu93wvKQsLe2wopTmfdSC4XISxv0U9MOp79peDSLO3RFY
         PGbWz4ZM4FKZqjszpXfvpLU6R0r2NR/Jy8dM//YVlA544PyziFsawsk3jMAfCd/IouE6
         X8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=gNs0ohO3fL+s3NHktgsL/0kYe4H1yHKkyiLTyVluZJM=;
        b=G0NKgQrP/l/Y6PnVDIfbzyplJYpkhnJ+JRfQyjdo7IGAnIfYJACAoEGDprTt9lyrG4
         0j/qDfgCgIdl5n60qgGIsZy1pEP0G9oz0qc/4WwX8xS/umkSdMDUYyKxhxcUcyWQkMDp
         rx7M/mel+7enSlMvL9OWckAM7TheymFwzC88iByQ3ALVL3ViFOuj1+J9UZsMI7iZe5Ob
         h34F8VnKtaRkZc9sUZd6hmKOxOWxbReDvsDeZVyKu9jFQnO0h/WpovWf11FTA4qsIYGz
         j9my41207ro38dVxDGXa170l9gtMW3+TTs+5bRWBwC4VRapZnjkrpo53Qce/zEm7p0i1
         5wGg==
X-Gm-Message-State: AG10YOTU620bp+xLLQJzPCZt8oTFWE6OAWg/523Asn/76evIykGWXWifbJNGuc6XauimcVbvH5Jq/ZUmoXJKrQ==
X-Received: by 10.194.19.164 with SMTP id g4mr16913291wje.120.1454728619154;
 Fri, 05 Feb 2016 19:16:59 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 19:16:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285677>

If ~/.config/git/gitk doesn't exist, I get small fonts (fine) and ugly
hard-to-read dark green branch labels.

The fix for the dark green problem is here:

     http://stackoverflow.com/questions/26025810/gtk-apps-show-green-too-dark

But after doing:

      echo 'set headbgcolor lime' >~/.config/git/gitk ; gitk

I end up with a much more extensive ~/.config/git/gitk that changes
fonts, window geometry, etc. to be different than the defaults that
you get if you don't have ~/.config/git/gik.  This is weird.

It should work one of these ways:

     1.  Any setting in ~/.config/git/gitk override the defaults, but
the file is not required, and running gitk doesn't create it or change
with it's contents.

     2.  ~/.config/git/gitk is always created if it doesn't exist or
isn't fully populated, and it gets the default values for anything not
defined.

The full ~/.config/git/gitk that gets created for me is below.  I
don't know where the setting that get used if it doesn't exist come
from.

set mainfont {sans 9}
set textfont {monospace 9}
set uifont {sans 9 bold}
set tabstop 8
set findmergefiles 0
set maxgraphpct 50
set maxwidth 16
set cmitmode patch
set wrapcomment none
set autoselect 1
set autosellen 40
set showneartags 1
set maxrefs 20
set visiblerefs {"master"}
set hideremotes 0
set showlocalchanges 1
set datetimeformat {%Y-%m-%d %H:%M:%S}
set limitdiffs 1
set uicolor grey85
set want_ttk 1
set bgcolor white
set fgcolor black
set uifgcolor black
set uifgdisabledcolor #999
set colors {lime red blue magenta darkgrey brown orange}
set diffcolors {red "#00a000" blue}
set mergecolors {red blue lime purple brown "#009090" magenta
"#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0"
"#f0b070" "#ff70b0"}
set markbgcolor #e0e0ff
set diffcontext 3
set selectbgcolor gray85
set foundbgcolor yellow
set currentsearchhitbgcolor orange
set extdifftool meld
set perfile_attrs 0
set headbgcolor lime
set headfgcolor black
set headoutlinecolor black
set remotebgcolor #ffddaa
set tagbgcolor yellow
set tagfgcolor black
set tagoutlinecolor black
set reflinecolor black
set filesepbgcolor #aaaaaa
set filesepfgcolor black
set linehoverbgcolor #ffff80
set linehoverfgcolor black
set linehoveroutlinecolor black
set mainheadcirclecolor yellow
set workingfilescirclecolor red
set indexcirclecolor lime
set circlecolors {white blue gray blue blue}
set linkfgcolor blue
set circleoutlinecolor black
set geometry(main) 1837x989+5+53
set geometry(state) normal
set geometry(topwidth) 1837
set geometry(topheight) 300
set geometry(pwsash0) "680 1"
set geometry(pwsash1) "1020 1"
set geometry(botwidth) 850
set geometry(botheight) 684
set permviews {}
