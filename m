Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E3CEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 11:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjF0Lvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjF0Lvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 07:51:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78001F4
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687866678; x=1688471478; i=johannes.schindelin@gmx.de;
 bh=K3hkMEUN/3X+bS4TbRqPdK8Jk4+74+Yth946ZjxmWf8=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=qexBKakgDu3btD/WMVW1HYOfMCPRjvD4fBXqa8U4lDxFWm1ZrvrfAvxLBOhzYPMgz2LNZOm
 MDlcFPW4y76BZZKCoMPPe3hyRna6hIbHUU+FYn0+FFLrCHizieeAWxQ0wOGqraYRaYZx+MsQg
 GrJfKqa+lTv3deSde1pQbw+AJVNQ8iT0YM4lwNOrZGwZwpMR1Lr5ME61cyWqccdNsWVHf+H97
 dzHuWFMKuXy4z8pHI9kZSUUlih09NZMG8pwSEYYJy7bd+MylKQ96avUHFuUs7+aAlPAbW6mOr
 YZUKP7C5yjtXC5jWifXNfzGQ0i2Ozbth/16/zD2R6CMUJEJbTuCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1qTiAe3LXF-00K5AI; Tue, 27
 Jun 2023 13:51:17 +0200
Date:   Tue, 27 Jun 2023 13:51:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Mark Levedahl <mlevedahl@gmail.com>
cc:     mdl123@verizon.net, git@vger.kernel.org, adam@dinwoodie.org,
        me@yadavpratyush.com, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com>
Message-ID: <5c1dc85f-f3a3-2e60-be85-08eefb633e5c@gmx.de>
References: <20230624212347.179656-1-mlevedahl@gmail.com> <20230626165305.37488-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q2tRd556TC/+yvaMdX/AnClcVe0ilZnIDYF7Zd2P907Ua2h+4lq
 VFlrb2TMowVbBo5jtE0VyV+UBo03SQNi/6sujjB/b73MNcXcoT5laLt1UNAhyl750IP96bv
 UgYJva3u2oBO/ZfE4xujXfNoePb710F6GbaWPu2p9tr4tGn8RmBT24EEM7vGOuyEqfRNCrP
 xpf9Tpsuagx+gIZgMRbSg==
UI-OutboundReport: notjunk:1;M01:P0:q93XnjxmjTw=;FD46LJkCdSVQDsBO3ZRTgrD19Nx
 OxUY4aHcz40NfiEbBDmVVoDQhid0UkGGVPHi40g2PNKxrOLg6CQVtKOSqjZ7lqK5jGtUTK9Oz
 fLAvuHaxMc2Jqr12lGSD2UfSGn6LLrRXyn7+xedJnxOSq2NM8Ob/6wi0f5RjoWtPAeuVrEcTL
 UOEfhDisp5rMiu6uH3Xm6PPIKCKf176f7t03pjwG5KUUvDlYcgB/XyuJ/gqqf7HyiTddT7A1T
 CrBpmj/+WQNYkkubuuhWsw1N919QHHIUHHMSUs2/s6JO/Ibbj1Mi8aqZQgiwzL/ySbr7ZWxmr
 PyXOMEX9iKrrjX7LLD4nM5NJ7OSqgYqMj+g0vZiR8wZstYS5kFauh50NSOnPGJQz51SUjPQmT
 xxoxS1m6p/hFA4ElE5g7/omlV3qLIHvo+UZAVgU9AYFRxYcnw5kAnrw5G4kKO0QH03vP5+wDK
 YZsrGBAloPLcUehhJLRtrQCn8HEZE4grFQoB1rIQtmIGTNdcSpgM/pUnsyUW5G7JH9i35FUmP
 3SirN3lXj+JHf9wPb0HUwMqWQu1Qp4tiVRi5WQdy52U2VAODK8c2caG52mzkgtW2zuKCWnS1x
 0iGsg6tqrm1WAG5cesKjswqa7gV/KqkdlM24GVMkJuK+r/86evtdRfr1xtjyTWgjStCVZBY8y
 l08T/aL4FlZ87fGcAqPSlhmgmV9shCCt4QExsUtohBgQWmqjKVuAMFK5aX0tHYREyENFxTfef
 RL9LieTpEBMMgI5BWSKeqEubpFpIEhr7+Z8aQD3SRSTvNSCSy3zgpRK1rx0yxXfa+yH0ZMu0g
 uahrHwhkC+Cr35ZKk7j9IoXVoVQS5skCTEZKZHqpCh1fBsqXuuOi24wGTeH+fyXblCStFrz4K
 TBVFshfejJ2JGOnvLGtVW8Db7Yx2Lqm5mNG/XYGc92Y3zITBusd3W4jnnUkL9H94inG81oAPw
 8SPWfLZb3A0uNox5ECEa1DBYI1M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Mon, 26 Jun 2023, Mark Levedahl wrote:

> =3D=3D=3D This is an update, incorporating responses to Junio's and Eric=
's
> comments:
>   -- clarified what the "upstream" git-gui branch is
>   -- Removed some changes from patch 2 as requested by Junio, reducing
>      changes in patch 3 and patch 4
>        All code is fixed only after applying patch 4
>        Differences in patch 3 and 4 are minimimized
>    -- updated comments to clarify G4w dedicated code.
>    -- updated all comments to (hopefully) clarify points of confusion
> =3D=3D=3D

And here is the range-diff:

    1:  00000000000 ! 1:  00000000000     git gui Makefile - remove Cygwin=
 modifications
        @@ Metadata
         Author: Mark Levedahl <mlevedahl@gmail.com>

          ## Commit message ##
        -    git gui Makefile - remove Cygwin modiifications
        +    git gui Makefile - remove Cygwin modifications

             git-gui's Makefile hardcodes the absolute Windows path of git=
-gui's libraries
             into git-gui, destroying the ability to package git-gui on on=
e machine and
        @@ Commit message
             since 2012. Also, Cygwin does not support a non-Cygwin Tcl/Tk=
.

             The Cygwin git maintainer disables this code, so this code is=
 definitely
        -    not in use in the Cygwin distribution, and targets an unteste=
d /
        -    unsupportable configuration.
        +    not in use in the Cygwin distribution.

        -    The simplest approach is to just delete the Cygwin specific c=
ode as
        -    stock Cygwin needs no special handling. Do so.
        +    The simplest fix is to just delete the Cygwin specific code,
        +    allowing the Makefile to work out of the box on Cygwin. Do so=
.

             Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

    2:  00000000000 ! 2:  00000000000     git-gui - remove obsolete Cygwin=
 specific code
        @@ Commit message
             8.4.1 Windows Tcl/Tk code.  In March, 2012, that 8.4.1 packag=
e was
             replaced with a full port based upon the upstream unix/X11 co=
de,
             since maintained up to date. The two Tcl/Tk packages are comp=
letely
        -    incompatible, and have different sygnatures.
        +    incompatible, and have different signatures.

             When Cygwin's Tcl/Tk signature changed in 2012, git-gui no lo=
nger
             detected Cygwin, so did not enable Cygwin specific code, and =
the POSIX
        @@ Commit message
             unix. Thus, no-one apparently noticed the existence of incomp=
atible
             Cygwin specific code.

        -    However, since commit c5766eae6f2b002396b6cd4f85b62317b707174=
e in
        -    upstream git-gui, the is_Cygwin funcion does detect current C=
ygwin.  The
        -    Cygwin specific code is enabled, causing use of Windows rathe=
r than unix
        -    pathnames, and enabling incorrect warnings about environment =
variables
        -    that are not relevant for the fully functional unix/X11 Tcl/T=
k. The end
        -    result is that git-gui is now incommpatible with Cygwin.
        +    However, since commit c5766eae6f in the git-gui source tree
        +    (https://github.com/prati0100/git-gui, master at a5005ded), a=
nd not yet
        +    pulled into the git repository, the is_Cygwin function does d=
etect
        +    Cygwin using the unix/X11 Tcl/Tk.  The Cygwin specific code i=
s enabled,
        +    causing use of Windows rather than unix pathnames, and enabli=
ng
        +    incorrect warnings about environment variables that were rele=
vant only
        +    to the old Tcl/Tk.  The end result is that (upstream) git-gui=
 is now
        +    incompatible with Cygwin.

        -    So, delete all Cygwin specific code (code protected by "if is=
_Cygwin"),
        -    thus restoring the post-2012 behaviour. Note that Cygwin spec=
ific code
        -    is required to enable file browsing and shortcut creation (su=
pported
        -    before 2012), but is not addressed in this patch.
        +    So, delete Cygwin specific code (code protected by "if is_Cyg=
win") that
        +    is not needed in any form to work with the unix/X11 Tcl/Tk.
        +
        +    Cygwin specific code required to enable file browsing and sho=
rtcut
        +    creation is not addressed in this patch, does not currently w=
ork, and
        +    invocation of those items may leave git-gui in a confused sta=
te.

             Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

        @@ git-gui.sh: proc rescan {after {honor_trustmtime 1}} {
          }

          proc rescan_stage2 {fd after} {
        -@@ git-gui.sh: proc do_git_gui {} {
        -
        - # Get the system-specific explorer app/command.
        - proc get_explorer {} {
        --	if {[is_Cygwin] || [is_Windows]} {
        -+	if {[is_Windows]} {
        - 		set explorer "explorer.exe"
        - 	} elseif {[is_MacOSX]} {
        - 		set explorer "open"
        -@@ git-gui.sh: if {[is_enabled multicommit]} {
        -
        - 	.mbar.repository add separator
        -
        --	if {[is_Cygwin]} {
        --		.mbar.repository add command \
        --			-label [mc "Create Desktop Icon"] \
        --			-command do_cygwin_shortcut
        --	} elseif {[is_Windows]} {
        -+	if {[is_Windows]} {
        - 		.mbar.repository add command \
        - 			-label [mc "Create Desktop Icon"] \
        - 			-command do_windows_shortcut
         @@ git-gui.sh: if {[is_MacOSX]} {
          set doc_path [githtmldir]
          if {$doc_path ne {}} {
        @@ lib/choose_repository.tcl: method _do_clone2 {} {
          				}
          				close $f_in
          				close $f_cp
        -
        - ## lib/shortcut.tcl ##
        -@@ lib/shortcut.tcl: proc do_windows_shortcut {} {
        - 	}
        - }
        -
        --proc do_cygwin_shortcut {} {
        --	global argv0 _gitworktree
        --
        --	if {[catch {
        --		set desktop [exec cygpath \
        --			--windows \
        --			--absolute \
        --			--long-name \
        --			--desktop]
        --		}]} {
        --			set desktop .
        --	}
        --	set fn [tk_getSaveFile \
        --		-parent . \
        --		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]=
] \
        --		-initialdir $desktop \
        --		-initialfile "Git [reponame].lnk"]
        --	if {$fn !=3D {}} {
        --		if {[file extension $fn] ne {.lnk}} {
        --			set fn ${fn}.lnk
        --		}
        --		if {[catch {
        --				set sh [exec cygpath \
        --					--windows \
        --					--absolute \
        --					/bin/sh.exe]
        --				set me [exec cygpath \
        --					--unix \
        --					--absolute \
        --					$argv0]
        --				win32_create_lnk $fn [list \
        --					$sh -c \
        --					"CHERE_INVOKING=3D1 source /etc/profile;[sq $me] &" \
        --					] \
        --					[file normalize $_gitworktree]
        --			} err]} {
        --			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
        --		}
        --	}
        --}
        --
        - proc do_macosx_app {} {
        - 	global argv0 env
        -
    3:  00000000000 ! 3:  00000000000     git-gui - use cygstart to browse=
 on Cygwin
        @@ Metadata
          ## Commit message ##
             git-gui - use cygstart to browse on Cygwin

        -    Pre-2012, git-gui enabled the "Repository->Explore Working Co=
py" menu on
        -    Cygwin, offering open a Windows graphical file browser at the=
 root
        -    working directory. The old code relied upon internal use of W=
indows
        -    pathnames, while git-gui must use unix pathnames on Cygwin si=
nce 2012,
        -    so was removed in a previous patch.
        +    git-gui enables the "Repository->Explore Working Copy" menu o=
n Cygwin,
        +    offering to open a Windows graphical file browser at the root=
 of the
        +    working directory. This code, shared with Git For Windows sup=
port,
        +    depends upon use of Windows pathnames. However, git gui on Cy=
gwin uses
        +    unix pathnames, so this shared code will not work on Cygwin.

             A base install of Cygwin provides the /bin/cygstart utility t=
hat runs
        -    arbtitrary Windows applications after translating unix pathna=
mes to
        -    Windows.  Adding the --explore option guarantees that the Win=
dows file
        -    explorer is opened, regardless of the supplied pathname's fil=
e type and
        -    avoiding possibility of some other action being taken.
        +    a registered Windows application based upon the file type, af=
ter
        +    translating unix pathnames to Windows.  Adding the --explore =
option
        +    guarantees that the Windows file explorer is opened, regardle=
ss of the
        +    supplied pathname's file type and avoiding possibility of som=
e other
        +    action being taken.

             So, teach git-gui to use cygstart --explore on Cygwin, restor=
ing the
        -    pre-2012 behavior of opening a Windows file explorer for brow=
sing.
        +    pre-2012 behavior of opening a Windows file explorer for brow=
sing. This
        +    separates the Git For Windows and Cygwin code paths. Note tha=
t
        +    is_Windows is never true on Cygwin, and is_Cygwin is never tr=
ue on Git
        +    for Windows, though this is not obvious by examining the code=
 for those
        +    independent functions.

             Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

          ## git-gui.sh ##
         @@ git-gui.sh: proc do_git_gui {} {
        +
        + # Get the system-specific explorer app/command.
          proc get_explorer {} {
        - 	if {[is_Windows]} {
        - 		set explorer "explorer.exe"
        -+	} elseif {[is_Cygwin]} {
        +-	if {[is_Cygwin] || [is_Windows]} {
        ++	if {[is_Cygwin]} {
         +		set explorer "/bin/cygstart.exe --explore"
        ++	} elseif {[is_Windows]} {
        + 		set explorer "explorer.exe"
          	} elseif {[is_MacOSX]} {
          		set explorer "open"
        - 	} else {
    4:  00000000000 ! 4:  00000000000     git-gui - use mkshortcut on Cygw=
in
        @@ Metadata
          ## Commit message ##
             git-gui - use mkshortcut on Cygwin

        -    Prior to 2012, git-gui enabled the "Repository->Create Deskto=
p Icon"
        -    item on Cygwin, offering to create a shortcut that starts git=
-gui on a
        -    particular repository. The original code for this in lib/win3=
2.tcl,
        -    shared with Git for Windows support, requires Windows pathnam=
es, while
        -    git-gui must use unix pathnames with the unix/X11 Tcl/Tk sinc=
e 2012. The
        -    ability to use this from Cygwin was removed in a previous pat=
ch.
        +    git-gui enables the "Repository->Create Desktop Icon" item on=
 Cygwin,
        +    offering to create a shortcut that starts git-gui on the curr=
ent
        +    repository. The code in do_cygwin_shortcut invokes function
        +    win32_create_lnk to create the shortcut. This latter function=
 is shared
        +    between Cygwin and Git For Windows and expects Windows rather=
 than unix
        +    pathnames, though do_cygwin_shortcut provides unix pathnames.=
 Also, this
        +    function tries to invoke the Windows Script Host to run a jav=
ascript
        +    snippet, but this fails under Cygwin's Tcl. So, win32_create_=
lnk just
        +    does not support Cygwin.

        -    Cygwin's default installation provides /bin/mkshortcut for cr=
eating
        -    desktop shortuts, this is compatible with exec under tcl, and=
 understands
        -    Cygwin's unix pathnames. So, teach git-gui to use mkshortcut =
on Cygwin,
        -    leaving lib/win32.tcl as Git for Windows specific support.
        +    However, Cygwin's default installation provides /bin/mkshortc=
ut for
        +    creating desktop shortcuts. This is compatible with exec unde=
r Cygwin's
        +    Tcl, understands Cygwin's unix pathnames, and avoids the need=
 for shell
        +    escapes to encode troublesome paths. So, teach git-gui to use=
 mkshortcut
        +    on Cygwin, leaving win32_create_lnk unchanged and for exclusi=
ve use by
        +    Git For Windows.

             Notes: "CHERE_INVOKING=3D1" is recognized by Cygwin's /etc/pr=
ofile and
             prevents a "chdir $HOME", leaving the shell in the working di=
rectory
             specified by the shortcut. That directory is written directly=
 by
             mkshortcut eliminating any problems with shell escapes and qu=
oting.

        -    The pre-2012 code includes the full pathname of the git-gui c=
reating the
        -    shortcut (rather than using the system git-gui), but that git=
-gui might
        -    not be compatible with the git found after /etc/profile sets =
the path,
        -    and might have a pathname that defies encoding using shell es=
capes that
        -    can survive the multiple incompatible interpreters involved i=
n this
        -    chain. Instead, use "git gui", thus defaulting to the system =
git and
        +    The code being replaced includes the full pathname of the git=
-gui
        +    creating the shortcut, but that git-gui might not be compatib=
le with the
        +    git found after /etc/profile sets the path, and might have a =
pathname
        +    that defies encoding using shell escapes that can survive the=
 multiple
        +    incompatible interpreters involved in the chain of creating a=
nd using
        +    this shortcut.  The new code uses bare "git gui" as the comma=
nd to
        +    execute, thus using the system git to launch the system git-g=
ui, and
             avoiding both issues.

             Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

        - ## git-gui.sh ##
        -@@ git-gui.sh: if {[is_enabled multicommit]} {
        - 		.mbar.repository add command \
        - 			-label [mc "Create Desktop Icon"] \
        - 			-command do_windows_shortcut
        -+	} elseif {[is_Cygwin]} {
        -+		.mbar.repository add command \
        -+			-label [mc "Create Desktop Icon"] \
        -+			-command do_cygwin_shortcut
        - 	} elseif {[is_MacOSX]} {
        - 		.mbar.repository add command \
        - 			-label [mc "Create Desktop Icon"] \
        -
          ## lib/shortcut.tcl ##
         @@ lib/shortcut.tcl: proc do_windows_shortcut {} {
        - 	}
          }

        -+proc do_cygwin_shortcut {} {
        + proc do_cygwin_shortcut {} {
        +-	global argv0 _gitworktree
         +	global argv0 _gitworktree oguilib
        -+
        -+	if {[catch {
        -+		set desktop [exec cygpath \
        -+			--desktop]
        -+		}]} {
        -+			set desktop .
        -+	}
        -+	set fn [tk_getSaveFile \
        -+		-parent . \
        -+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]=
] \
        -+		-initialdir $desktop \
        -+		-initialfile "Git [reponame].lnk"]
        -+	if {$fn !=3D {}} {
        -+		if {[file extension $fn] ne {.lnk}} {
        -+			set fn ${fn}.lnk
        -+		}
        -+		if {[catch {
        +
        + 	if {[catch {
        + 		set desktop [exec cygpath \
        +-			--windows \
        +-			--absolute \
        +-			--long-name \
        + 			--desktop]
        + 		}]} {
        + 			set desktop .
        +@@ lib/shortcut.tcl: proc do_cygwin_shortcut {} {
        + 			set fn ${fn}.lnk
        + 		}
        + 		if {[catch {
        +-				set sh [exec cygpath \
        +-					--windows \
        +-					--absolute \
        +-					/bin/sh.exe]
        +-				set me [exec cygpath \
        +-					--unix \
        +-					--absolute \
        +-					$argv0]
        +-				win32_create_lnk $fn [list \
        +-					$sh -c \
        +-					"CHERE_INVOKING=3D1 source /etc/profile;[sq $me] &" \
        +-					] \
        +-					[file normalize $_gitworktree]
         +				set repodir [file normalize $_gitworktree]
         +				set shargs {-c \
         +					"CHERE_INVOKING=3D1 \
         +					source /etc/profile; \
         +					git gui"}
         +				exec /bin/mkshortcut.exe \
        -+					-a $shargs \
        -+					-d "git-gui on $repodir" \
        -+					-i $oguilib/git-gui.ico \
        -+					-n $fn \
        -+					-s min \
        -+					-w $repodir \
        ++					--arguments $shargs \
        ++					--desc "git-gui on $repodir" \
        ++					--icon $oguilib/git-gui.ico \
        ++					--name $fn \
        ++					--show min \
        ++					--workingdir $repodir \
         +					/bin/sh.exe
        -+			} err]} {
        -+			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
        -+		}
        -+	}
        -+}
        -+
        - proc do_macosx_app {} {
        - 	global argv0 env
        -
        + 			} err]} {
        + 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
        + 		}

FWIW even v1 looked good to me (I don't care about typos as long as they
don't change meaning).

I tested the changes on top of Git for Windows and everything works as
expected (if you want to cross check my work, look no further than the
`git-gui-cygwin` branch at https://github.com/dscho/git).

If you want, please feel free to add

	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you!
Johannes
