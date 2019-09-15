Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C231F463
	for <e@80x24.org>; Sun, 15 Sep 2019 03:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfIODl0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 23:41:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43286 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfIODlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 23:41:25 -0400
Received: by mail-io1-f66.google.com with SMTP id r8so46266439iol.10
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OVWHpqTgvIijDNghKbYaSE+gIg86kzYu+9KI6UAuGHY=;
        b=Ll6jbw1Jk9+BSxtprwH2b4GLYOj2e22jKrhUntMDckf+vSiC26Os/za6HpjYiUdbIO
         cvUUx3WxXNP4fo0zbaP9oTGmE9DxiLYPuiZ9gbyIOXpvLuwY6P5lJR82JVsfUFdtt3SF
         a95Dnrg2Fr0y339j+cVMGIIf/AQJm0tHQg1tIP+DBtXBi8f0ux8+SER/VlRp8Eyt/O8g
         8StDT9velvTY+89rr/hmM3SbcBMvoHfzErt70OBThJTudaBPQF+nha/noTOfsUVGqPez
         5kFJPQe0li3DKonLgIsifyBNtHwLeFCtxa+T7a/VtfJvw+X3sMtUDckFxTAOxD9utvYC
         r8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OVWHpqTgvIijDNghKbYaSE+gIg86kzYu+9KI6UAuGHY=;
        b=n3MMxGoAS4MYSlY4wQ+dgW+i87HS9Ao9ZjjlNtycPAc+Omm91IWiGryg/mJwszeE2h
         elR5n4PwXHw4wrRePUNi23ZHMUuyEQYzpTghqvEPYBcw6Fxf+TruiabR/JGvxlObcrvx
         UApd2ve8C9Q+BEK4XSOaqV5yXkCizIToYnG5jfBIEHKYifVmxttaesW334wDugeY2ZTj
         OYyz3GyPFkXFWn0GZNbCTw0RYhnMNt1gHOt8cTkVdepUqB9HcYSeqB1t6uF4VxPl0Dfk
         1rM4BoxFUKeDfmeWz1gxP0vvtdwq8FAL9vbC4MSfXgC21PmdZ1aN6+gZFHIso/ZK12+H
         V8vQ==
X-Gm-Message-State: APjAAAV+oxWvbSiuXdL1Nt2zjJCL7NGvGOabimiGjffm75Y7H8KQ8RKH
        62RfhMEHzH6rifoVUYjtA2wgejW9Ib03mj4Lup2DAnLE
X-Google-Smtp-Source: APXvYqy0Ea/D9PQe7+NGrgtKhANyKqP4f/wEpwFIP+WLb+wnVXm3/ghGvEfiaGQgIcEKHo2b71kX5oDri56zTgxWvjw=
X-Received: by 2002:a05:6638:1f5:: with SMTP id t21mr10474056jaq.119.1568518884172;
 Sat, 14 Sep 2019 20:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com> <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
 <CAMPXz=qWmHGpDrGVpg1gwEBQsg5pujY-Ghg8icyaPoiMNCXssg@mail.gmail.com> <20190914190656.r2aogh4dcobay5vn@yadavpratyush.com>
In-Reply-To: <20190914190656.r2aogh4dcobay5vn@yadavpratyush.com>
From:   David <bouncingcats@gmail.com>
Date:   Sun, 15 Sep 2019 13:41:12 +1000
Message-ID: <CAMPXz=oC29Wr16KPp_jJ5gFi7N2AN3tqnHX38FkszR32PH5M+Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_?=
        =?UTF-8?Q?click_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_i?=
        =?UTF-8?Q?tem_to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Sep 2019 at 05:08, Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 15/09/19 02:07AM, David wrote:
> > On Sat, 14 Sep 2019 at 06:51, Bert Wesarg <bert.wesarg@googlemail.com> wrote:

> > > I consider adding a second way as not not acceptable. I also consider
> > > double-click on a file in a GUI an "open" action.
> >
> > Yes!
> >
> > In fact, I've often fantasized how useful it would be that if I double
> > clicked on that file name in the unstaged pane or the staged pane,
> > then that would open the file for editing in my preferred/configured editor.
> >
> > Now for me *that* would be a very frequently used improvement!
> >
> > I wonder what other readers think about this idea?
>
> Sounds reasonable. I've wanted something similar, but for commit
> messages.
>
> But one major reason I didn't come up with a patch for editing commit
> messages in the editor of your choice is terminal based editors.

Hi again Pratyush Yadav, and other readers!

I hope I don't sound like I am arguing or enthusiastically promoting change
in this subthread. I'm not, my attitude is rather just to explore an idea to see
what others think of it. Some days I have good ideas, other days my ideas
have flaws that I missed, so I like to discuss first.

More important, I want to say that I am very happy to see that there are
folks interested to discuss the Tcl/Tk git GUI tools. In fact I have local Tcl
patches myself, bugfixes and enhancements for git-gui and gitk, which I
would be happy to share except that I do not know how to do that effectively.

I don't enjoy Tcl and because of that I have avoided it and don't consider
my skill level to be very high. I find it rather obtuse, especially the way
it does namespacing, and "upvar" in particular. I struggle to read it without
comments. But I learned enough of Tcl specifically to improve aspects
of git-gui and gitk that were bothering me in the past.

As well as bug fixes, I have enhancements to both that greatly assist
my workflow. For example, in git-gui, I have a hotkey that pastes the
currently highlighted pathname into the commit message. In gitk,
I have added "find all files in commit" to the file list pane, and fixed
the flawed regex matching and associated controls.

My workflow involves a lot of large rebases, and merge conflicts can occur
in the middle of them that affect dozens of files, that need editing
to resolve. That's where easily being able to start an editor from git-gui
in that situation would benefit my workflow. But, it's not a big deal.

Now, to specific comments you made:

> I don't
> think there is any way of finding out the default terminal emulator in
> Linux, and I don't think there is a standard way of making terminal
> emulator launch programs you want.

I agree where you say there is no "standard way", because the
various GUI environments are not consistent (Gnome, LXDE, etc) and
neither are the command line arguments of various terminal emulators,
and sometimes those don't work as expected.

> So your suggestion works only for GUI based editors. We would have to
> mention that only GUI based editors can open files.

Here, I disagree. My suggestion was to provide a double-click facility
that would trigger a command that can be *configured by the user*.

And it is wrong to say that only GUI editors can open files.
For example, my OS is Debian, my GUI is LXDE, and my terminal
emulator is lxterminal. (I don't recommend it, but that's another story).
If I have a terminal window open, I can type the command:
  $ lxterminal -e vi foo
and a new independent terminal window opens with the editor 'vi'
editing the file foo. Similar functionality can be achieved from a
.desktop file, or from a shell script.

Here is a demo Tcl script (working here) that confirms one way
of spawning an editor from Tcl in a terminal window under LXDE:

##### begin script #####
#!/usr/bin/tclsh

package require Tk

# name of this script
set scriptname [info script]

# demo user command
set command "lxterminal -e vi -R $scriptname"

# create text widget
pack [text .t]

# add text to show that we are running
.t insert end "$scriptname: Running: $command\n"

# run the demo command
set chan [open "| $command"]

# (at this point, a new terminal window appears
# containing vi displaying this script file)

# add text to show that we did not block on command
.t insert end "$scriptname: Reached end\n"

##### end script #####
