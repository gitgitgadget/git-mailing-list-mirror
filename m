From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 09:46:10 +0100
Message-ID: <e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	 <Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	 <7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	 <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	 <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	 <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	 <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 09:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFns7-000657-Dl
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 09:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbXBJIqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 03:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbXBJIqM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 03:46:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:26018 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbXBJIqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 03:46:11 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1037774nze
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 00:46:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OAo6b2lOIJX4qv7NFyrGWmNohHaNo6O9kgoW0WxAY2NrsYNLXJlcz1ssAI3q3r/XrWcUM3GiM97Dphhz/rNd7hW5rMMno8mXWOhRPBARd/RkOhHxBk53sSjDgq7BoceElqB1FSQizeq4BcWEyPqPxa9yEzbVR6m+PryTAVZO6Qs=
Received: by 10.114.198.1 with SMTP id v1mr5381467waf.1171097170076;
        Sat, 10 Feb 2007 00:46:10 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 00:46:10 -0800 (PST)
In-Reply-To: <e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39211>

On 2/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
> >
> 'git runstatus'  shows all the files also _before_ your patch has been
> applied (I have tested again now resetting HEAD so to remove your two
> patches).
>

This is the complete log under Windows (git with Cygwin distribution,
but run _outside_ cygwin shell, directly in Windows cmd.exe shell).

And _after_ under Linus, current git tree _without_ your last patches applied.

***************  UNDER WINDOWS ***********************

C:\varie\c\qgit4>git status
# Untracked files:
#   (use "git add" to add to commit)
#
#	AAA_convert.xls.lnk
#	Cygwin.lnk
#	Qt 4.2.2 Command Prompt.lnk
#	bld.bat
#	cmd.txt
#	explore2fs.exe.lnk
#	log.txt
#	qgit.lnk
#	src/object_script.qgit.Debug
#	src/object_script.qgit.Release
#	src/object_script.qgit_bin.Debug
#	src/object_script.qgit_bin.Release
#	start_qgit.bat
nothing to commit

C:\varie\c\qgit4>git runstatus
# Untracked files:
#   (use "git add" to add to commit)
#
#	AAA_convert.xls.lnk
#	Cygwin.lnk
#	Qt 4.2.2 Command Prompt.lnk
#	bld.bat
#	cmd.txt
#	explore2fs.exe.lnk
#	log.txt
#	qgit.lnk
#	src/object_script.qgit.Debug
#	src/object_script.qgit.Release
#	src/object_script.qgit_bin.Debug
#	src/object_script.qgit_bin.Release
#	start_qgit.bat
nothing to commit


***************  UNDER LINUX **************************

bash-3.1$ git status
fatal: unable to create '.git/index.lock': Read-only file system
bash-3.1$ git runstatus
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   .gitignore
#       modified:   README
#       modified:   exception_manager.txt
#       modified:   qgit.pro
#       modified:   src/annotate.cpp
#       modified:   src/annotate.h
#       modified:   src/cache.cpp
#       modified:   src/cache.h
#       modified:   src/commit.ui
#       modified:   src/commitimpl.cpp

-------------  cut (all remaining files) -----------------------

#       modified:   src/resources/source_h.png
#       modified:   src/resources/source_java.png
#       modified:   src/resources/source_pl.png
#       modified:   src/resources/source_py.png
#       modified:   src/resources/tab_remove.png
#       modified:   src/resources/tar.png
#       modified:   src/resources/txt.png
#       modified:   src/resources/view_choose.png
#       modified:   src/resources/view_top_bottom.png
#       modified:   src/resources/view_tree.png
#       modified:   src/resources/wizard.png
#       modified:   src/revdesc.cpp
#       modified:   src/revdesc.h
#       modified:   src/revsview.cpp
#       modified:   src/revsview.h
#       modified:   src/revsview.ui
#       modified:   src/settings.ui
#       modified:   src/settingsimpl.cpp
#       modified:   src/settingsimpl.h
#       modified:   src/src.pro
#       modified:   src/todo.txt
#       modified:   src/treeview.cpp
#       modified:   src/treeview.h
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       AAA_convert.xls.lnk
#       Cygwin.lnk
#       Qt 4.2.2 Command Prompt.lnk
#       bld.bat
#       cmd.txt
#       explore2fs.exe.lnk
#       log.txt
#       qgit.lnk
#       src/object_script.qgit.Debug
#       src/object_script.qgit.Release
#       src/object_script.qgit_bin.Debug
#       src/object_script.qgit_bin.Release
no changes added to commit (use "git add" and/or "git commit -a")
bash-3.1$
