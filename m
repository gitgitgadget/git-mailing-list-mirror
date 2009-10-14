From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Changing branches in supermodule does not affect submodule?
Date: Wed, 14 Oct 2009 07:31:04 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se>
References: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se> <4AD47C65.5080904@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxRR-000452-1e
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbZJNGbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 02:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbZJNGbr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:31:47 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:59431 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755255AbZJNGbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:31:47 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n9E6V4Nt018054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Oct 2009 08:31:04 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n9E6V4Ji018050;
	Wed, 14 Oct 2009 08:31:04 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4AD47C65.5080904@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 14 Oct 2009 08:31:04 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130259>

Jens Lehmann:

> just calling "git submodule update" every time you want the submodule to 
> be updated according to the state committed in the superproject will do 
> the trick (but keep in mind that all referenced commits have to be 
> accessible in the local clone of your submodule, so you might have to do a 
> fetch there once in a while).

Is it possible to automate this from a hook or something else? Basically, I 
would like it to update all the submodules to the state recorded in the 
commit I move to, if they were in a clean state before I moved. I do not 
want it to change states if I do something like

   cd submodule
   # do some changes
   git commit
   cd ..
   git checkout -b newbranch

because there I want the commit I made to the submodule to be recorded on 
the new branch I created. But then it was in a dirty state before I created 
the branch anyway, so that shouldn't be a problem.

-- 
\\// Peter - http://www.softwolves.pp.se/
