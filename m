Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B289CC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIRPhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjIRPhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 11:37:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D11994
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695051105; x=1695655905; i=johannes.schindelin@gmx.de;
 bh=npxJuN/mvyLKH4faSEgYlD7d0voMHIfbThvlWwJRvio=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=dsVTjCUAfvYz7p9O8NdhvL6tqQ+wJVLzecy4cJoCEwSCwK9Y8XI/rVb8LG/HPOCS9ztdcVmGowE
 I0opZIE/WtqUkrsT6Tc4S0hMTrrvWXQPI6ulq5uBybzdrkkSefpMvQLdOIiVyOsiJMc0YaycSKDyK
 f2EeS0vTvHmNE1Wc2perY6AG0U4imrvbJHXgh0xYL3sFQsVdJElaj6wlimuoczrgBjUhrrrx8u5zr
 4OfKaVb4E3WZhhEKe1Pvh8biM9S7LDvzuAZ7kgTrO8w611GFKsNyLr5OekmFHMYP/H4EuVqNoK5Vs
 Iov53g9lIh80af8tRv9B1IPdrPNoTQRFIsTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1rJF7J2oz8-00b15B; Mon, 18
 Sep 2023 17:26:23 +0200
Date:   Mon, 18 Sep 2023 17:26:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Mark Levedahl <mlevedahl@gmail.com>
cc:     gitster@pobox.com, me@yadavpratyush.com, git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui - re-enable use of hook scripts
In-Reply-To: <20230916210131.78593-1-mlevedahl@gmail.com>
Message-ID: <260b62dc-d45b-58fa-85c4-ffbd981a1c84@gmx.de>
References: <xmqqy1h6auy7.fsf@gitster.g> <20230916210131.78593-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FEvP37s793Sqb88bWN8VmIYceJ8MbJ38ekolYlIc2n7f4xvaXpz
 4UDiLaXg3lg2kpbUXbxgaIk4ejRbR256fC9EhTAiC2/ECdjiFemd+rlz1ObWn7VUjCMA6dm
 uAz3RNiX9liP/rB2BCHYLhWCLofNNlgrJno3bSLGx44RK5/2N1rgfZR4HWY9CfU0w2ztMDV
 KbDuNLPT7LGOj8lx5vkVg==
UI-OutboundReport: notjunk:1;M01:P0:i/uoD468ypo=;baeBlKryPjqihfzGF/5sab1vIBM
 1ixsuCR8U9/dOEpO1WeNMdxcUtJDwiwHMfecqLaKmCQl49K9tXgOHdyE/EWK3ztcZ839nM+Wj
 FKSiJ8Q6/dFoRD4gVZBt6GxbeG1dPU1e2UVPCXOz/gXDv+gZqp0n6bPBGAgKARwl2CmlJDsdC
 XizPt1r3m0AvlkaI7hysKTBBkNcQNgP7AMsmb0gfdEy0p8mq3HHN7B6MgV2mSvEPpmasJb9XZ
 5ZPs+V+5imSEvmfY+YWLJWK9QgP6Au5C/bqkInp0lnedBR5wShgh36Q5OIojsVSVFDO5R6OzA
 P6rc7HKdI1r54Zs66vZGClMOnluAk6PTs5M4C2aSTzoWQLlfCsPXPVImrWVuFLVsKLn4vcegN
 Y9G8UZSrLzvmQV0tN6YnsOlN2v7DbUEH1x6KLwY5iSgEN3Tt1SDj2NiNkp21kCDi5piOq0LQO
 HOcCNG2kgm9naR/hYNvaPpgnsxRDgEZzuTEPjkHicrTpjp+jphqUoyyzckGebihGgs6xCrNp0
 cMYCWs9lZHAChtlYJ4G1bHb1xrOFCp41eFBFWnVI+8vAnRUtz3C8UFB6fJf5anPjLCdMi6KiI
 xB0xfRNGdrJaA7CGjPJLm7ASYkZPTN8BrnEjkeclD+Jn9s34rgWIququdydpXl28LdhzKcPyI
 olF3FQhtEvFaeGhXT6TjWBiTMQnYxYJ9UA6v3+pB9O20Y8TNcN6dqNtuXntp82GaaKyIFLBaT
 it3q82U4/tvhqwgoAqWVFzWLaL3YkFkjub8Du41jINbN5ogXqwD+mAWbMNPO0POXKZxa0AaQg
 ok6GbSgqijW1GhDxMgSIbPACSEuCgVAUEt0kOH18GfmNb1wAPbBble1fNg0lTkyHRViCjniJW
 n5Zy+b3yKCxRNwwec2fVbV/b2B2b6XlFSFGF9aBTfeHSpGB/SLHfqKkzRQCBQnNZHuBNxbAU6
 UzQEOA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 16 Sep 2023, Mark Levedahl wrote:

> Earlier, commit aae9560a introduced search in $PATH to find executables
> before running them, avoiding an issue where on Windows a same named
> file in the current directory can be executed in preference to anything
> in a directory in $PATH. This search is intended to find an absolute
> path for a bare executable ( e.g, a function "foo") by finding the first
> instance of "foo" in a directory given in $PATH, and this search works
> correctly.  The search is explicitly avoided for an executable named
> with an absolute path (e.g., /bin/sh), and that works as well.
>
> Unfortunately, the search is also applied to commands named with a
> relative path. A hook script (or executable) $HOOK is usually located
> relative to the project directory as .git/hooks/$HOOK. The search for
> this will generally fail as that relative path will (probably) not exist
> on any directory in $PATH. This means that git hooks in general now fail
> to run. Considerable mayhem could occur should a directory on $PATH be
> git controlled. If such a directory includes .git/hooks/$HOOK, that
> repository's $HOOK will be substituted for the one in the current
> project, with unknown consequences.
>
> This lookup failure also occurs in worktrees linked to a remote .git
> directory using git-new-workdir. However, a worktree using a .git file
> pointing to a separate git directory apparently avoids this: in that
> case the hook command is resolved to an absolute path before being
> passed down to the code introduced in aae9560a.
>
> Fix this by replacing the test for an "absolute" pathname to a check for
> a command name having more than one pathname component. This limits the
> search and absolute pathname resolution to bare commands. The new test
> uses tcl's "file split" command. Experiments on Linux and Windows, using
> tclsh, show that command names with relative and absolute paths always
> give at least two components, while a bare command gives only one.
>
> 	  Linux:   puts [file split {foo}]       =3D=3D>  foo
> 	  Linux:   puts [file split {/foo}]      =3D=3D>  / foo
> 	  Linux:   puts [file split {.git/foo}]  =3D=3D> .git foo
> 	  Windows: puts [file split {foo}]       =3D=3D>  foo
> 	  Windows: puts [file split {c:\foo}]    =3D=3D>  c:/ foo
> 	  Windows: puts [file split {.git\foo}]  =3D=3D> .git foo
>
> The above results show the new test limits search and replacement
> to bare commands on both Linux and Windows.

Sounds good. FWIW I ran a couple experiments here, too:

	% file pathtype "C:/foo"
	absolute
	% file pathtype ".git/hooks"
	relative
	% file pathtype ".git\\hooks"
	relative
	% file pathtype "/foo"
	volumerelative
	% file pathtype "foo"
	relative

The problem, therefore, is that `file pathtype` does not discern between a
bare file name and a relative path. The proposed patch looks correct to
me.

Thank you,
Johannes

>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bc8892..8603437 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -118,7 +118,7 @@ proc sanitize_command_line {command_line from_index}=
 {
>  	set i $from_index
>  	while {$i < [llength $command_line]} {
>  		set cmd [lindex $command_line $i]
> -		if {[file pathtype $cmd] ne "absolute"} {
> +		if {[llength [file split $cmd]] < 2} {
>  			set fullpath [_which $cmd]
>  			if {$fullpath eq ""} {
>  				throw {NOT-FOUND} "$cmd not found in PATH"
> --
> 2.41.0.99.19
>
>
