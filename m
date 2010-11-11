From: Karl Wiberg <kha@treskal.com>
Subject: Re: making stgit handle being rebased by git rebase
Date: Thu, 11 Nov 2010 11:29:48 +0100
Message-ID: <AANLkTik_dFsaiDkugrpBp8T31zNWVMRNC=hQBj0RmV+o@mail.gmail.com>
References: <AANLkTik3MVNW0svJEo5gWq3+qGo6dKeqAUz9NPcJnYNN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 12:05:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGUyE-0004Ez-C8
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 12:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab0KKLFL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 06:05:11 -0500
Received: from mail1.space2u.com ([62.20.1.135]:43626 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535Ab0KKLFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 06:05:07 -0500
X-Greylist: delayed 2115 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2010 06:05:07 EST
Received: from mail-qy0-f174.google.com (mail-qy0-f174.google.com [209.85.216.174])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.4/8.14.3) with ESMTP id oABATjQO031693
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:29:46 +0100
Received: by qyk12 with SMTP id 12so4173666qyk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 02:29:48 -0800 (PST)
Received: by 10.224.67.82 with SMTP id q18mr907737qai.358.1289471388713; Thu,
 11 Nov 2010 02:29:48 -0800 (PST)
Received: by 10.220.124.193 with HTTP; Thu, 11 Nov 2010 02:29:48 -0800 (PST)
In-Reply-To: <AANLkTik3MVNW0svJEo5gWq3+qGo6dKeqAUz9NPcJnYNN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161225>

On Mon, Nov 8, 2010 at 11:39 PM, Chris Packham <judge.packham@gmail.com=
> wrote:
> Has anyone looked at making stgit interact with git-rebase more grace=
fully?

The problem is that StGit's metadata gets out of date when you do a
git rebase. A solution would either have to change StGit's metadata
representation so that it can't get out of date, or be a fancy version
of repair/uncommit that can actually figure out what git did.

I've thought a bit about this in the past, and the best solution I
could come up with is of the first kind, and would change the
representation of applied patches to use just two refs: the branch
itself, and the stack base ref. I think git rebase wouldn't wreck
things for that representation.

This kind of change is a lot of work, though, more than I have time
for at the moment. And it's not like I have the details worked out or
anything... Making stg repair more intelligent would be a lot less
involved.

--=20
Karl Wiberg, kha@treskal.com
=C2=A0=C2=A0 subrabbit.wordpress.com
=C2=A0=C2=A0 www.treskal.com/kalle
