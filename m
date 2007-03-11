From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 14:33:51 +0100
Message-ID: <20070311133350.GA12553@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 14:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQOBR-0004Qz-IS
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 14:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546AbXCKNdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 09:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbXCKNdy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 09:33:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:52912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752236AbXCKNdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 09:33:54 -0400
Received: (qmail invoked by alias); 11 Mar 2007 13:33:52 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp049) with SMTP; 11 Mar 2007 14:33:52 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+maPofH96m4F1lwNFxAZyNMFpUPVyXjfj5Qyn7ce
	KTq8C6IB/TStS9
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41923>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> My case seems a bit complicated than usual. The working directory
> (/home/pclouds/blog/data) was not a prefix of cwd (/home/pclouds/blog)
> so the code failed silently at this line. If I replace
> "has_working_directory = 0; return NULL;" with "strcpy(cwd,gitwd);c =
> 0;break;", it may work but see below

If you're outside the specifed working directory the
is_bare_repository will return true, just as if you don't have a
working directory.  Do you expect anything else or doesn't this work?
