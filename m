From: Britton Kerin <britton.kerin@gmail.com>
Subject: Re: strange behavior with nonexistant or partially populated ~/.config/git/gitk
Date: Fri, 5 Feb 2016 18:27:23 -0900
Message-ID: <CAC4O8c-3-x+symzH1GVzFHNj7UtcGF9mBxRgpcVO1zKOeR01Mw@mail.gmail.com>
References: <CAC4O8c8qEjcLASu7JwNhyLX+h3uFSUiHAV2yqJhgE+N5-gC0Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 04:27:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRtXI-0008BG-NF
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 04:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbcBFD1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 22:27:25 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37742 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcBFD1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 22:27:24 -0500
Received: by mail-wm0-f54.google.com with SMTP id g62so51199341wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 19:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=x6NxX34ZrWjBjBnjf6cl2CZzAJUdyWmK1FGoH9gqSuw=;
        b=DbhWq7+teFcZSdiIhlsWSxUP73qRyNtQozN6rXGqh48/6eGvywHE/8h6kHiQ9pC+If
         McXG8kFE9EiTl3NzurNp3NZGeBwck4FsRd+jVnhf/M8fL1Gtmf7ve7vo6oHX8bSjkmpF
         sgD8xcCP8EmL793BO1AYFK57rpHeGTpZesk1lbxz1ZMfojRyoyamy84pVWGP95tBQfEC
         8u5byjzr4ZcQaZcQ9QuvFWny3fGVmTnVDwDm8OioKD+St/PdyTTQmNwLEbQPVF1hfEfm
         AqwzLZXf9tWxKWdpyzqoCSXcJwheSyw71jAEO++VHKuv1T2nDWoJ88dE9LECkiAw04WL
         4YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=x6NxX34ZrWjBjBnjf6cl2CZzAJUdyWmK1FGoH9gqSuw=;
        b=PcJCHUe5SZmbXpTb3UpZ8jon2QosQ+9rTW2zuty15g384sR0j4Me3EDhFLq5l/MKZG
         NmQOww7eCmtoXWEOw44EHuiDShrkJkSze/mVMqJYwep+MTvfL+IVINRZDSrE7DYxbACU
         NRKYtfv7iToIYNnQW3AsPDzyqZHKuaqkNSrdDtx8C4KEG+5jbOpdcT0/U9jX+RztNrnk
         uH0JpdiNdMI3h5c4fmM27Ewl7sE5eKvdW8X0Vv8gRDgiyDsGnUhIGycJHDdlqLd/7lPI
         FhPlTVDxf7HQOSpSUqatyFubmqz1PMIByKWKoDTpe1ecYKPZXWywSHJ7QhujEcotsI3D
         eCLA==
X-Gm-Message-State: AG10YOQBvq8GcuUD2oJgeeKnMYRZQ0rB1LZjSgXeXzVE+Sz0rZg8w0llRIlgcU0FEfyLcp75+cEVoRZaSwUsow==
X-Received: by 10.194.19.164 with SMTP id g4mr16937338wje.120.1454729243175;
 Fri, 05 Feb 2016 19:27:23 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 19:27:23 -0800 (PST)
In-Reply-To: <CAC4O8c8qEjcLASu7JwNhyLX+h3uFSUiHAV2yqJhgE+N5-gC0Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285678>

My bad, problem was I missed existence of .gitk (used only if
~/.config/git/gitk doesn't exist).

On Fri, Feb 5, 2016 at 6:16 PM, Britton Kerin <britton.kerin@gmail.com> wrote:
> If ~/.config/git/gitk doesn't exist, I get small fonts (fine) and ugly
> hard-to-read dark green branch labels.
>
> The fix for the dark green problem is here:
>
>      http://stackoverflow.com/questions/26025810/gtk-apps-show-green-too-dark
>
> But after doing:
>
>       echo 'set headbgcolor lime' >~/.config/git/gitk ; gitk
>
> I end up with a much more extensive ~/.config/git/gitk that changes
> fonts, window geometry, etc. to be different than the defaults that
> you get if you don't have ~/.config/git/gik.  This is weird.
>
> It should work one of these ways:
>
>      1.  Any setting in ~/.config/git/gitk override the defaults, but
> the file is not required, and running gitk doesn't create it or change
> with it's contents.
>
>      2.  ~/.config/git/gitk is always created if it doesn't exist or
> isn't fully populated, and it gets the default values for anything not
> defined.
>
> The full ~/.config/git/gitk that gets created for me is below.  I
> don't know where the setting that get used if it doesn't exist come
> from.
>
> set mainfont {sans 9}
> set textfont {monospace 9}
> set uifont {sans 9 bold}
> set tabstop 8
> set findmergefiles 0
> set maxgraphpct 50
> set maxwidth 16
> set cmitmode patch
> set wrapcomment none
> set autoselect 1
> set autosellen 40
> set showneartags 1
> set maxrefs 20
> set visiblerefs {"master"}
> set hideremotes 0
> set showlocalchanges 1
> set datetimeformat {%Y-%m-%d %H:%M:%S}
> set limitdiffs 1
> set uicolor grey85
> set want_ttk 1
> set bgcolor white
> set fgcolor black
> set uifgcolor black
> set uifgdisabledcolor #999
> set colors {lime red blue magenta darkgrey brown orange}
> set diffcolors {red "#00a000" blue}
> set mergecolors {red blue lime purple brown "#009090" magenta
> "#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0"
> "#f0b070" "#ff70b0"}
> set markbgcolor #e0e0ff
> set diffcontext 3
> set selectbgcolor gray85
> set foundbgcolor yellow
> set currentsearchhitbgcolor orange
> set extdifftool meld
> set perfile_attrs 0
> set headbgcolor lime
> set headfgcolor black
> set headoutlinecolor black
> set remotebgcolor #ffddaa
> set tagbgcolor yellow
> set tagfgcolor black
> set tagoutlinecolor black
> set reflinecolor black
> set filesepbgcolor #aaaaaa
> set filesepfgcolor black
> set linehoverbgcolor #ffff80
> set linehoverfgcolor black
> set linehoveroutlinecolor black
> set mainheadcirclecolor yellow
> set workingfilescirclecolor red
> set indexcirclecolor lime
> set circlecolors {white blue gray blue blue}
> set linkfgcolor blue
> set circleoutlinecolor black
> set geometry(main) 1837x989+5+53
> set geometry(state) normal
> set geometry(topwidth) 1837
> set geometry(topheight) 300
> set geometry(pwsash0) "680 1"
> set geometry(pwsash1) "1020 1"
> set geometry(botwidth) 850
> set geometry(botheight) 684
> set permviews {}
