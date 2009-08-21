From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Issue with gitweb + tag + branch of the same name from master branch commit
Date: Fri, 21 Aug 2009 15:49:23 -0700 (PDT)
Message-ID: <m3fxbkn5ot.fsf@localhost.localdomain>
References: <1250811031.26147.42.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MecvN-0006XS-My
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbZHUWtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbZHUWtY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:49:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:17545 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbZHUWtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:49:23 -0400
Received: by fg-out-1718.google.com with SMTP id e21so262491fga.17
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eMjOcvR7/Haqsv+FMQBkdD7bVLxPKFqfc6S5s1EfsjE=;
        b=X1pGQCCmJ+4PtkyBi8YEOfqt5zJNSF8Hz0gG0CJO0vr4zOy+mkUKTFzuADc77L0NSg
         jrLvtTfBzYJn8sYJirwX1Kaoo1sr/5jy/Q/FczBzmSFP4LDKxmdIbcrteBlfT4MYsDR/
         CUG0QEy8uqLxQcagPMXt8mz70r0yXacGqeBck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AYpM1bLS6xjGyjnyPkNVwW6B/QCmEXkkPcmIJTEHiYGSc6aWeSdUMAw+rtDIOfgKfW
         96VbarQrHR8Wt4X4a+HqiLMN6FoqYtjRdlTOozyji984iMGiaurASVr/h2fJJGRQz/yQ
         nVSOLSJxmuBozEOhSZjnHjSlBjZ5d7ZkCjaDc=
Received: by 10.86.17.27 with SMTP id 27mr1238317fgq.31.1250894964457;
        Fri, 21 Aug 2009 15:49:24 -0700 (PDT)
Received: from localhost.localdomain (abwo198.neoplus.adsl.tpnet.pl [83.8.238.198])
        by mx.google.com with ESMTPS id 4sm5952346fgg.14.2009.08.21.15.49.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 15:49:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7LMnP4D022416;
	Sat, 22 Aug 2009 00:49:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7LMnNFY022413;
	Sat, 22 Aug 2009 00:49:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1250811031.26147.42.camel@haakon2.linux-iscsi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126769>

"Nicholas A. Bellinger" <nab@linux-iscsi.org> writes:

> I have recently been trying to make a tag and branch of the same name

But why?  Why do you want to confuse git and yourself?

> from a previous <COMMIT> on a master branch on a kernel.org tree using
> the following commands:
> 
> 	# Create the tag:
> 	git tag -a lio-x.y <COMMIT>
> 	# Push the tags:
> 	git push --tags origin
> 	# Fetch to be sure
> 	git fetch origin
> 	# Make tagged branch:
> 	git checkout -b lio-x.y <COMMIT>
> 	# Make <NEW_COMMIT> to lio-x.y and commit
>         git commit frob
> 	# Switch back to master branch
> 	git checkout master
> 	# Push local branch to origin
> 	git push origin refs/heads/lio-x.y
> 
> At this point after pushing to origin, I can do a fresh clone of the
> tree, and do a 'git checkout origin/lio-x.y and I see '<NEW_COMMIT>',
> and the logs and blobs look as expected..
> 
> However, after checking gitweb log for branch lio-x.y on kernel.org, I
> only see <COMMIT>, and not <NEW_COMMIT>, and all of the blobs in branch
> lio-x.y still reference the original <COMMIT>, et al.

I guess that you meant here gitweb's 'log' / 'shortlog' view linked
from 'heads' view, don't you?
 
> John Hawley has been helping to resolve the issue (I am just going to
> use different tag/branch names instead), and hpa asked me to report this
> as it is easy to reproduce with the gitweb version on kernel.org..

> 22:42 < warthog9> I would got show this to the git people, it *could*
>                   just be an old bug in gitweb (ours is not particularly
>                   up to date) but if I can replicate it here easily enough
>                   I'm guessing there's still a bug elsewhere

This is an old and long fixed (or rather worked around) issue in
gitweb, fixed in bf901f8 (gitweb: disambiguate heads and tags withs
the same name, 2007-12-15)... well if by fixed you can consider
passing around "fully qualified" refnames, i.e. the 'shortlog' link in
'heads' view now uses 'refs/heads/frob', and not only 'frob'.

J.H., you might want to consider cherry-picking this... unless you
have done that, or independently fixed this issue.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
