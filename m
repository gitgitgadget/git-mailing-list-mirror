From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: RE: [PATCH 4/5] Add --remote option to send-pack
Date: Mon, 7 May 2007 13:08:19 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C012AA326@az33exm24.fsl.freescale.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org><7vtzuzg26l.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0704290152410.28708@iabervon.org><7vejm3g0dg.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0705022330460.28708@iabervon.org><7virba31wd.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0705030137520.28708@iabervon.org><7vejly305u.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0705050115270.28708@iabervon.org><7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.64.0705050235210.28708@iabervon.org> <7vr6pvln89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>,
	"Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon May 07 22:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl9Vf-0002tV-Iz
	for gcvg-git@gmane.org; Mon, 07 May 2007 22:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966172AbXEGUIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966480AbXEGUIa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 16:08:30 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:44567 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966448AbXEGUI2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 16:08:28 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l47K8Oii012146
	for <git@vger.kernel.org>; Mon, 7 May 2007 13:08:25 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l47K8OOc002245
	for <git@vger.kernel.org>; Mon, 7 May 2007 15:08:24 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7vr6pvln89.fsf@assigned-by-dhcp.cox.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/5] Add --remote option to send-pack
Thread-Index: AceO6pnZa5Q3SBu7Q16kti42Rve95gB+Lcaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46481>


> Another thing is that which branch is merged into the current
> branch should not be a function of the current branch, as the
> current configuration mechanism suggests.  The current way maps
> the current branch to "which repository's which branch".  In
> addition to that, I think it should be a function of ("current
> branch", "remote repository") pair.  IOW, allow you to say "If I
> pull from this remote without saying which one to merge, merge
> that branch.  If I pull from this other remote, merge that other
> branch".  Something like:
> 
>         [branch "master"]
>                 ; Use this when "git pull" did not say which remote
>                 remote = origin
> 
>                 ; Use this when "git pull origin" did not say which
>                 ; branch(es) to merge
>                 merge = refs/heads/master
>                 ; the above should be a synonym for
> 		; merge = refs/heads/master for origin
> 
>                 ; "git pull fast-import" while on my "master"
>                 ; would merge 'for-junio' branch there.
>                 merge = refs/heads/for-junio for fast-import
> 
>                 ; similarly, but use subtree strategy.
>                 merge = refs/heads/for-junio with subtree for git-gui
> 
>         [remote "origin"]
>                 url = git://git.kernel.org/pub/scm/git/git.git/
>                 fetch = refs/heads/*:remotes/origin/*
>         [remote "fast-import"]
>                 url = git://repo.or.cz/git/fastimport.git/
>                 fetch = refs/heads/*:remotes/gfi/*
>         [remote "git-gui"]
>                 url = git://repo.or.cz/git-gui.git/
>                 fetch = refs/heads/*:refs/remotes/git-gui/*
>

Yes, please!

Jdl
