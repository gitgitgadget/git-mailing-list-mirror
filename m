From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 7 - 9/3] Thinning the git toplevel directory
Date: Thu, 17 Feb 2011 22:51:39 -0600
Message-ID: <20110218045139.GG15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:51:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqIJq-0001ZB-Du
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab1BREvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:51:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56802 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab1BREvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:51:44 -0500
Received: by iyj8 with SMTP id 8so3128335iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TzfGTXiro6ipxU4wK1OhTYNDWxjPMHZcwHXsxXqvd4A=;
        b=SKTzqw/xMAHfvgVK3yUdrdtlZGzHf6rOGc0S5Du3IsJBSkBi/+MKA36x8bGppxa4Gm
         4tIYQ8sGlTY93vRcwcgjNbKYX4enQLvRdsb3VrqbLJPZYK8tZLP7oAU1tP4VfPXBDNOA
         NXWYVI4rrlhCtiQFvZ+S1yR6eiGpUuyf9raRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YDf3PPJUaeJMCKC/ic2B2EZqmS9nr7aWk3vuXi+cXYx68kV2KUNPKNSl5LHFI/yKD7
         AnKZO0vWQUhFguRzdAKzlBoihQwmgz4TizMCE6Ga358DHh5FPaCGJFuCtdLTApdbhfYL
         egRw8/1Odft7ns3hbvob0pgc2coOez6pW5C6U=
Received: by 10.231.40.12 with SMTP id i12mr193896ibe.183.1298004703406;
        Thu, 17 Feb 2011 20:51:43 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id z4sm1348307ibg.19.2011.02.17.20.51.41
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:51:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167171>

Nguyen Thai Ngoc Duy wrote:

> External commands are now more visible. Nice.

Here's a series to make them more visible, by putting them in a
"nonbuiltin/" subdirectory.  The name is a placeholder, of course.

Without a good name for the directory, this just makes things _harder_
to find, but maybe you can fix that.

Jonathan Nieder (3):
  Move test-sha1.sh to test-programs/
  Move build helpers to scripts/ subdirectory
  Move non-builtin git commands and script libraries to a subdirectory

 Makefile                                           |  157 ++++++++++----------
 .../add--interactive.perl                          |    0
 git-am.sh => nonbuiltin/am.sh                      |    0
 git-archimport.perl => nonbuiltin/archimport.perl  |    0
 git-bisect.sh => nonbuiltin/bisect.sh              |    0
 check-racy.c => nonbuiltin/check-racy.c            |    0
 .../cvsexportcommit.perl                           |    0
 git-cvsimport.perl => nonbuiltin/cvsimport.perl    |    0
 git-cvsserver.perl => nonbuiltin/cvsserver.perl    |    0
 daemon.c => nonbuiltin/daemon.c                    |    0
 .../difftool--helper.sh                            |    0
 git-difftool.perl => nonbuiltin/difftool.perl      |    0
 fast-import.c => nonbuiltin/fast-import.c          |    0
 .../filter-branch.sh                               |    0
 http-backend.c => nonbuiltin/http-backend.c        |    0
 http-fetch.c => nonbuiltin/http-fetch.c            |    0
 http-push.c => nonbuiltin/http-push.c              |    0
 imap-send.c => nonbuiltin/imap-send.c              |    0
 git-instaweb.sh => nonbuiltin/instaweb.sh          |    0
 git-lost-found.sh => nonbuiltin/lost-found.sh      |    0
 .../merge-octopus.sh                               |    0
 .../merge-one-file.sh                              |    0
 .../merge-resolve.sh                               |    0
 .../mergetool--lib.sh                              |    0
 git-mergetool.sh => nonbuiltin/mergetool.sh        |    0
 git-parse-remote.sh => nonbuiltin/parse-remote.sh  |    0
 git-pull.sh => nonbuiltin/pull.sh                  |    0
 git-quiltimport.sh => nonbuiltin/quiltimport.sh    |    0
 .../rebase--interactive.sh                         |    0
 git-rebase.sh => nonbuiltin/rebase.sh              |    0
 git-relink.perl => nonbuiltin/relink.perl          |    0
 remote-curl.c => nonbuiltin/remote-curl.c          |    0
 .../remote-testgit.py                              |    0
 git-repack.sh => nonbuiltin/repack.sh              |    0
 git-request-pull.sh => nonbuiltin/request-pull.sh  |    0
 git-send-email.perl => nonbuiltin/send-email.perl  |    0
 git-sh-setup.sh => nonbuiltin/sh-setup.sh          |    0
 shell.c => nonbuiltin/shell.c                      |    0
 show-index.c => nonbuiltin/show-index.c            |    0
 git-stash.sh => nonbuiltin/stash.sh                |    0
 git-submodule.sh => nonbuiltin/submodule.sh        |    0
 git-svn.perl => nonbuiltin/svn.perl                |    0
 upload-pack.c => nonbuiltin/upload-pack.c          |    0
 git-web--browse.sh => nonbuiltin/web--browse.sh    |    0
 GIT-VERSION-GEN => scripts/GIT-VERSION-GEN         |    0
 check_bindir => scripts/check-bindir.sh            |    0
 check-builtins.sh => scripts/check-builtins.sh     |    0
 fixup-builtins => scripts/fixup-builtins.sh        |    0
 generate-cmdlist.sh => scripts/generate-cmdlist.sh |    0
 unimplemented.sh => scripts/unimplemented.sh       |    0
 wrap-for-bin.sh => scripts/wrap-for-bin.sh         |    0
 test-sha1.sh => test-programs/test-sha1.sh         |    0
 52 files changed, 80 insertions(+), 77 deletions(-)
 rename git-add--interactive.perl => nonbuiltin/add--interactive.perl (100%)
 rename git-am.sh => nonbuiltin/am.sh (100%)
 rename git-archimport.perl => nonbuiltin/archimport.perl (100%)
 rename git-bisect.sh => nonbuiltin/bisect.sh (100%)
 rename check-racy.c => nonbuiltin/check-racy.c (100%)
 rename git-cvsexportcommit.perl => nonbuiltin/cvsexportcommit.perl (100%)
 rename git-cvsimport.perl => nonbuiltin/cvsimport.perl (100%)
 rename git-cvsserver.perl => nonbuiltin/cvsserver.perl (100%)
 rename daemon.c => nonbuiltin/daemon.c (100%)
 rename git-difftool--helper.sh => nonbuiltin/difftool--helper.sh (100%)
 rename git-difftool.perl => nonbuiltin/difftool.perl (100%)
 rename fast-import.c => nonbuiltin/fast-import.c (100%)
 rename git-filter-branch.sh => nonbuiltin/filter-branch.sh (100%)
 rename http-backend.c => nonbuiltin/http-backend.c (100%)
 rename http-fetch.c => nonbuiltin/http-fetch.c (100%)
 rename http-push.c => nonbuiltin/http-push.c (100%)
 rename imap-send.c => nonbuiltin/imap-send.c (100%)
 rename git-instaweb.sh => nonbuiltin/instaweb.sh (100%)
 rename git-lost-found.sh => nonbuiltin/lost-found.sh (100%)
 rename git-merge-octopus.sh => nonbuiltin/merge-octopus.sh (100%)
 rename git-merge-one-file.sh => nonbuiltin/merge-one-file.sh (100%)
 rename git-merge-resolve.sh => nonbuiltin/merge-resolve.sh (100%)
 rename git-mergetool--lib.sh => nonbuiltin/mergetool--lib.sh (100%)
 rename git-mergetool.sh => nonbuiltin/mergetool.sh (100%)
 rename git-parse-remote.sh => nonbuiltin/parse-remote.sh (100%)
 rename git-pull.sh => nonbuiltin/pull.sh (100%)
 rename git-quiltimport.sh => nonbuiltin/quiltimport.sh (100%)
 rename git-rebase--interactive.sh => nonbuiltin/rebase--interactive.sh (100%)
 rename git-rebase.sh => nonbuiltin/rebase.sh (100%)
 rename git-relink.perl => nonbuiltin/relink.perl (100%)
 rename remote-curl.c => nonbuiltin/remote-curl.c (100%)
 rename git-remote-testgit.py => nonbuiltin/remote-testgit.py (100%)
 rename git-repack.sh => nonbuiltin/repack.sh (100%)
 rename git-request-pull.sh => nonbuiltin/request-pull.sh (100%)
 rename git-send-email.perl => nonbuiltin/send-email.perl (100%)
 rename git-sh-setup.sh => nonbuiltin/sh-setup.sh (100%)
 rename shell.c => nonbuiltin/shell.c (100%)
 rename show-index.c => nonbuiltin/show-index.c (100%)
 rename git-stash.sh => nonbuiltin/stash.sh (100%)
 rename git-submodule.sh => nonbuiltin/submodule.sh (100%)
 rename git-svn.perl => nonbuiltin/svn.perl (100%)
 rename upload-pack.c => nonbuiltin/upload-pack.c (100%)
 rename git-web--browse.sh => nonbuiltin/web--browse.sh (100%)
 rename GIT-VERSION-GEN => scripts/GIT-VERSION-GEN (100%)
 rename check_bindir => scripts/check-bindir.sh (100%)
 rename check-builtins.sh => scripts/check-builtins.sh (100%)
 rename fixup-builtins => scripts/fixup-builtins.sh (100%)
 rename generate-cmdlist.sh => scripts/generate-cmdlist.sh (100%)
 rename unimplemented.sh => scripts/unimplemented.sh (100%)
 rename wrap-for-bin.sh => scripts/wrap-for-bin.sh (100%)
 rename test-sha1.sh => test-programs/test-sha1.sh (100%)
