From: Tait <git.git@t41t.com>
Subject: Re: using gvim as editor on Windows
Date: Mon, 8 Mar 2010 10:54:39 -0800
Message-ID: <20100308185439.GO2480@ece.pdx.edu>
References: <20100306070628.GM2480@ece.pdx.edu> <8c9a061003052322v446acddbm5792038af450d0b9@mail.gmail.com> <20100306073729.GN2480@ece.pdx.edu> <201003061317.38422.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 08 19:54:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noi6M-0001aj-TE
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 19:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab0CHSyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 13:54:44 -0500
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:36158 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186Ab0CHSym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 13:54:42 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o28IseKt000478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Mar 2010 10:54:40 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o28IsdLH012908;
	Mon, 8 Mar 2010 10:54:39 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o28Isdk4012892;
	Mon, 8 Mar 2010 10:54:39 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <201003061317.38422.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Mon, 08 Mar 2010 10:54:40 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141776>

> > On Windows, gvim -f is basically a shortcut for the start invocation I
> > pasted above.
>
> Not necessarily. You can avoid using the .bat wrappers from C:\Windows,
> which cause the problem, but use gvim.exe directly by setting your PATH
> appropriately. It will also work for git-difftool.

I was hoping for a little more life in this thread.

Does calling the .exe directly work for you? If I call gvim.exe directly
(with or without -f -- it doesn't matter), it opens a new file called
$@. After quitting, the commit is aborted for lack of a commit message. I
can do an ugly work-around by making core.editor "gvim.exe -f $@" but
then gvim opens two buffers, one for the commit message and another for
the literal $@.

With rebase -i, calling the executable directly (with or without -f)
works to open the commit list. Rebase -i with $@ in the setting fails. It
appears the filename is not quoted correctly and vim is opening multiple
buffers with various components of the path name as filenames.

The problem seems to be unique to me, so I'll find some time to look at
what rebase and/or commit are doing wrong.

Tait
