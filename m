From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: pseudo initial empty commit and tag for git-log and git-describe?
Date: Wed, 20 Sep 2006 08:12:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200807120.4388@g5.osdl.org>
References: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1960654969-1158765129=:4388"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ3kc-00029y-44
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWITPM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWITPM1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:12:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751603AbWITPM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:12:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KFCLnW017737
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 08:12:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KFC9Z4000550;
	Wed, 20 Sep 2006 08:12:16 -0700
To: =?ISO-8859-1?Q?Nguy=E1=BBn_Th=C3=A1i_Ng=E1=BBc_Duy?= 
	<pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0609200658p3f04df7oe91ddb971787bd70@mail.gmail.com>
X-Spam-Status: No, hits=-0.509 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27350>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1960654969-1158765129=:4388
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 20 Sep 2006, Nguyá»n ThÃ¡i Ngá»c Duy wrote:
>
> I'm still uncomfortable with git-log -p unable to show the first
> commit (git-whatchanged too).

Both of those work fine with "--root". That option tells git: "I'm 
interested in the root patch too".

It might make sense to have "--root" be the default, but the problem is 
that for projects like the Linux kernel where the first commit is a big 
import, showing it as a patch simply doesn't make sense.

So it would have to be a per-repository decision, depending on whether the 
repo considers the first commit to be an import or not. Maybe a git-config 
option?

> Also git-describe refuses to work without any tag.

Now, that's arguably a real bug. You should be able to describe any 
commit, and if there's no tag that is reachable from it, the "description" 
should probably just be the SHA1 of the commit.

(Side issue: we should probably also accept the output of "git describe" 
as a revision name, since it's a bit silly that you can ask git to 
"describe" a revision, but then git can't actually use the description 
itself ;)

			Linus
--21872808-1960654969-1158765129=:4388--
