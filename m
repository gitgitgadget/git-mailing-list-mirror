X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-*arch* in git-arch rpm
Date: Tue, 24 Oct 2006 22:35:38 -0700
Message-ID: <7viri9dkk5.fsf@assigned-by-dhcp.cox.net>
References: <20061024200211.17221.qmail@9f622d681978b5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 05:35:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30034>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcbQV-0000c6-No for gcvg-git@gmane.org; Wed, 25 Oct
 2006 07:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423028AbWJYFfj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbWJYFfj
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 01:35:39 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26762 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1423028AbWJYFfj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 01:35:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025053538.FXXH18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 01:35:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eVbM1V00P1kojtg0000000 Wed, 25 Oct 2006
 01:35:22 -0400
To: Gerrit Pape <pape@smarden.org>
Sender: git-owner@vger.kernel.org

Gerrit Pape <pape@smarden.org> writes:

> Hi, there're two programs in the git-arch rpm that shouldn't be there:
>
>  $ rpm -qlp git-arch-1.4.3.2-1.i386.rpm 
>  /usr/bin/git-archimport
>  /usr/bin/git-archive
>  /usr/bin/git-upload-archive
>  /usr/share/doc/git-arch-1.4.3.2
>  /usr/share/doc/git-arch-1.4.3.2/git-archimport.html
>  /usr/share/doc/git-arch-1.4.3.2/git-archimport.txt
>  /usr/share/doc/git-arch-1.4.3.2/git-archive.html
>  /usr/share/doc/git-arch-1.4.3.2/git-archive.txt
>  /usr/share/doc/git-arch-1.4.3.2/git-upload-archive.html
>  /usr/share/doc/git-arch-1.4.3.2/git-upload-archive.txt
>  /usr/share/man/man1/git-archimport.1.gz
>  /usr/share/man/man1/git-archive.1.gz
>  /usr/share/man/man1/git-upload-archive.1.gz
>  $ 
>
> Regards, Gerrit.

So we need at least this?

diff --git a/git.spec.in b/git.spec.in
index 9b1217a..b61a338 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -126,10 +126,10 @@ # These are no files in the root package
 
 %files arch
 %defattr(-,root,root)
-%doc Documentation/*arch*.txt
-%{_bindir}/*arch*
-%{!?_without_docs: %{_mandir}/man1/*arch*.1*}
-%{!?_without_docs: %doc Documentation/*arch*.html }
+%doc Documentation/git-archimport.txt
+%{_bindir}/git-archimport
+%{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
+%{!?_without_docs: %doc Documentation/git-archimport.html }
 
 %files email
 %defattr(-,root,root)
