From: Alexandre Erwin Ittner <listas@ittner.com.br>
Subject: Re: rebase parents, or tracking upstream but removing
 non-distributable bits
Date: Thu, 30 Dec 2010 20:58:40 -0200
Message-ID: <20101230205840.bb5d3370.listas@ittner.com.br>
References: <ord3ojb0yy.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 23:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYRSM-0007NI-D4
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 23:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab0L3W6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 17:58:46 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60448 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0L3W6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 17:58:45 -0500
Received: by yib18 with SMTP id 18so2368869yib.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 14:58:44 -0800 (PST)
Received: by 10.90.32.19 with SMTP id f19mr7855723agf.138.1293749924656;
        Thu, 30 Dec 2010 14:58:44 -0800 (PST)
Received: from gandalf (201-25-207-138.jvece701.dsl.brasiltelecom.net.br [201.25.207.138])
        by mx.google.com with ESMTPS id i52sm9391839yhd.41.2010.12.30.14.58.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 14:58:43 -0800 (PST)
In-Reply-To: <ord3ojb0yy.fsf@livre.localdomain>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.3; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164372>

Alexandre Oliva <lxoliva@fsfla.org> wrote

> I need to be able to maintain and publish a modified repository, that
> filters out the unwanted portions, but still be able to pull changes
> from the upstream repository.

Have you tried something with "git filter-branch"? I have never tried
something like this but I think it is possible to automate a process to
(1) pull the changes from the origin into a complete clone, (2) branch
from the HEAD and run "filter-branch" with a customized script to create
a temporary sanitized branch, (3) merge this temporary branch into a
complete sanitized branch, (4) record all the branchpoints, sparing the
next iteration from running through all the history again, and, (5) push
the sanitized branch somewhere.

Of course, this approach creates a complete nightmare with the
integration, testing, and code attribution: it changes the SHA1s,
invalidates signed tags, forces the use of patches instead of pull
requests to the upstream contributions, may taint the validity of the
commit messages and authorship, etc.  Publishing edited commits seems a
delicate subject for me -- your "filter-branch" script should mark their
commit messages as such.


Att.

-- 
Alexandre Erwin Ittner - alexandre@ittner.com.br
OpenPGP pubkey 0x0041A1FB @ http://pgp.mit.edu
