From: =?utf-8?B?SsSBbmlzIFLFq2Npcw==?= <parasti@gmail.com>
Subject: Re: Git aliases executed from wrong dir
Date: Sat, 16 Aug 2008 06:46:32 +0300
Message-ID: <20080816034632.GA16198@localhost.localdomain>
References: <9777229F-27FD-4CB2-A5C7-6CA15733B8D2@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 05:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUCmR-0008W6-UE
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 05:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYHPDqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 23:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYHPDqo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 23:46:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:37650 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYHPDqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 23:46:43 -0400
Received: by ug-out-1314.google.com with SMTP id c2so6060ugf.37
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mail-followup-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hqavpt8I8Hx/kUrIOHbiE5DodjmJTrFz6TDwrddTX40=;
        b=Aa+fM4nyulgNbPCHA9kdU8lgL9CMLAR8b9/hYEEqNDW/+kNPnKKckFlRK56Dn6nnED
         msmfY6UlwBy5TQzSJc90RszDxxDDcw9YsIQKpHk0OGUiDQVFQJANnJvwhCSILP9owNrm
         0a0XZ8T7yLHGUC/QSLurxU+0gHEzKVozNUmHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=DP08lk5uUjBjsPJqySiteurcxrKnGBBgAwfS3QeVfzVmZg22P3lZMnln0qk99fQF4x
         zQjNdDGY4sFNBVuzmjqWZUt1EizbpBxfHbkNFNqIJI3XeMgLFa3EsEiNuriZJV4ZAiZh
         stS3DjCB9IfjnHJ9kmab31raDEgZ7uryFj+bA=
Received: by 10.67.119.8 with SMTP id w8mr1332200ugm.20.1218858401790;
        Fri, 15 Aug 2008 20:46:41 -0700 (PDT)
Received: from localhost.localdomain ( [62.63.166.34])
        by mx.google.com with ESMTPS id m38sm179252ugd.72.2008.08.15.20.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 20:46:41 -0700 (PDT)
Received: from parasti by localhost.localdomain with local (Exim 4.69)
	(envelope-from <parasti@gmail.com>)
	id 1KUCkK-0004GG-Nx; Sat, 16 Aug 2008 06:46:32 +0300
Mail-Followup-To: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9777229F-27FD-4CB2-A5C7-6CA15733B8D2@sb.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92532>

On Wed, Jun 25, 2008 at 04:44:49PM -0700, Kevin Ballard wrote:
> If I create an alias with `git config alias.foo '!pwd'` and then run it 
> from a subdirectory of my repo, it prints out the root of my repo. This 
> prevents the ability to create aliases that take filenames, as they 
> simply won't work if you try and reference a file from a subdirectory.

Got bitten by the same problem.  I have an alias for the
git-new-workdir script and I'm tracking some config files in my home
directory, but also have a bunch of Git repositories in
subdirectories.  A "cd ..; git new-workdir old new" in one of these
tells me that "old" doesn't exist (because it doesn't exist in my home
dir which the alias ends up being invoked from) while a "git
new-workdir . ../new" works as expected.
