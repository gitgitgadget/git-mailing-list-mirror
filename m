From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 17:08:23 +0200
Message-ID: <u5tpsr5aye0.fsf@lysator.liu.se>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org>
	<u5tmzm9bbrb.fsf@lysator.liu.se> <432EC7D6.6080105@gmail.com>
	<u5tvf0xb0fp.fsf@lysator.liu.se> <432ECE5A.7040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 19 17:16:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHNKH-0003j1-T4
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 17:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVISPM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 11:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVISPM7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 11:12:59 -0400
Received: from main.gmane.org ([80.91.229.2]:40340 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932457AbVISPM6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 11:12:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHNH6-0002s0-GD
	for git@vger.kernel.org; Mon, 19 Sep 2005 17:09:44 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 17:09:44 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 17:09:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:mwtCBJWc+mwbUaSIYItyglOCfqI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8876>

A Large Angry SCM <gitzilla@gmail.com> writes:

> There are better methods of setting environment variables than an=20
> endless set of command options. Use the env command or you own=20
> (personal) command wrapper instead.

Remember that, to the user, this isn't about setting environment
variables, It's about providing git parameters.

Currently, the only of doing this is by setting environment variables;
what I'm suggesting is an *alternative* to that.

The fact that the implementation of these flags would actually use
environment variables to propagate these parameters to subprocesses
doesn't necessary mean that it is the only sane way to specify it
originally.

Anyway, there are other options, such as

   $ git GIT_DIR=3D/foo/bar status

and today we already have

   $ env GIT_DIR=3D/foo/bar status

The advantage of these forms is of course that they don't limit the
parameters that can be set, so I could keep setting EDITOR if I want
to.  But if setting GIT_DIR is common enough it might make sense to
provide a short flag for that.

The summary of my ramblings are probably that I think the -d flag is a
good idea, but no way of specifying other parameters is needed.

--=20
David K=E5gedal
