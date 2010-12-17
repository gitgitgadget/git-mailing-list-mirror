From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to recover a repository
Date: Thu, 16 Dec 2010 22:45:30 -0600
Message-ID: <20101217044530.GA8590@burratino>
References: <alpine.DEB.2.00.1012162024020.22269@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Dec 17 05:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTSCY-0003WE-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 05:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0LQEpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 23:45:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63356 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab0LQEpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 23:45:49 -0500
Received: by yxt3 with SMTP id 3so140458yxt.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 20:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=POJX/lFe+S9Pwdv4nxboIeE+MIIr/WX0CKafY9WplqI=;
        b=LEXEJn9STLPDK8bvt0Uluokw+NzZ/fIZcjmoLDSzRJMAg0PsSW1Re7JSbYCbeod1mz
         s0O+6K3CRqEz8u9x6kFU7Up9ZMRWxa3Az/orWbUXBdIxneGEq8dL/XM3Vwmtspy90DdX
         uNVIbFCMGBkTjCDXlYUpgJwnaoQupUrN2d9a0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WRIvCGRjmOL5J545KLy2XPHi/LvRYmNudVj9/4ts7tM1JuLqqPr9IXjCQGOMOjSfqa
         GKeKcQMe/PTxnGnKtK6NCAWNS6cPgWp5g3Gmc8ncufSGxp8i0mCPGqA49aBgLhs3D492
         ThW+QfO5pR8Qlga9Cvl5vyQlME1spF+YCDQNA=
Received: by 10.91.7.15 with SMTP id k15mr1682647agi.167.1292561148978;
        Thu, 16 Dec 2010 20:45:48 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id 2sm3749010anw.38.2010.12.16.20.45.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 20:45:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012162024020.22269@asgard.lang.hm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163862>

Hi David,

david@lang.hm wrote:

> I managed to do a 'rm *' in the .git directory (the usual sort of
> fat-fingering when cleaning up after another mistake)
> 
> the subdirectories are still there.

I'd suggest:

 1. Make a backup!
 2. From the worktree (i.e. parent to the .git directory),
    run "git init".
 3. git update-ref HEAD refs/heads/(branch you were on)
 4. git reset;	# (alas, the old index file is gone)
 5. git diff; gitk --all

See gitrepository-layout(7) for details.
