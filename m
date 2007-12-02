From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: problems with importing from cvs archive
Date: Sun, 02 Dec 2007 01:39:02 -0800 (PST)
Message-ID: <m3lk8dwi4x.fsf@roke.D-201>
References: <20071202064613.GB25351@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 10:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IylIQ-00062U-HI
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 10:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXLBJjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 04:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXLBJjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 04:39:09 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:45548 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXLBJjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 04:39:05 -0500
Received: by mu-out-0910.google.com with SMTP id i10so900501mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=2Fr6rK4KbgL5cLJpPtBtaCA/Z8RX+VPSWppaW+EQ2fw=;
        b=xXJAmDS2qtIAkH7XeWzm3Dul4k3POrBeINyvvYHvKMUEor9jbjHnQsAxOy/H7YKGsAEvYYojzFHwETMid5MqBkjQssrjpt3hG9eTgbVL1Ksp7tCNKgBoTZgVmHwrrKzdgbsLBs9i1NqC/pJk0oRxOv9MBwNu3iSQmVPAyvf2bdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Gl1bv44gFL8vIzlJclMSC3L2IxUqJmfXT8gBkpa7JeYtUd4ufj32N+BkNaC+daP3FyFxbZCHWXgbQozRS6PHxCUGnucIHlRWDegoZ//8y8DlFsjNOFOX8dGNT4KmM4K7zr9ogN/6jb9aXbQuRsHM4hrhh39W3FAxgS+s0BTD5T4=
Received: by 10.86.84.5 with SMTP id h5mr9307394fgb.1196588343844;
        Sun, 02 Dec 2007 01:39:03 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id 4sm5291120fge.2007.12.02.01.39.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 01:39:03 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB29cu8b027018;
	Sun, 2 Dec 2007 10:38:57 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB29ctVL027015;
	Sun, 2 Dec 2007 10:38:55 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071202064613.GB25351@venus>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66771>

"Ed S. Peschko" <esp5@pge.com> writes:

> I'm trying to use git-cvsimport to import from a CVS archive, using:
> 
> git-cvsimport -d $CVSROOT
> 
> and am getting the following error:
> 
> 	fatal: refs/heads/origin: not a valid SHA1
> 	fatal: master: not a valid SHA1
> 	warning: You appear to be on a branch yet to be born
> 	warning: Forcing checkout of HEAD
> 	fatal: just how do you expect me to merge 0 trees?
> 	checkout failed: 256

[...]

> Or is this just a plain vanilla bug? 

I guess that you might have been bitten by (just corrected, but not in
any released version yet) the bug in git-cvsimport (which is quite
old, and not very well maintained) when branches are packed.

You can either try last patch to cvsimport (it is in 'master'),
or unpack refs using "git reset --soft HEAD" when on given packed
branch,

-- 
Jakub Narebski
