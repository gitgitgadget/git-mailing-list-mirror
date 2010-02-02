From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is ./git/branches used for anything?
Date: Tue, 02 Feb 2010 07:00:09 -0800 (PST)
Message-ID: <m34olzbs5f.fsf@localhost.localdomain>
References: <ron1-35461E.00013102022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKEs-00080S-7O
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab0BBPAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:00:20 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:53957 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab0BBPAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:00:19 -0500
Received: by fxm7 with SMTP id 7so155539fxm.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bT5PO/GH7giZlwTXItRhE31w1nhIWRiOKw+MqmApAew=;
        b=LM6W5bBSijiDN5cQBbyt2umHmpbP7C09h5UGGYfISAnxBNSCrn857CbGdqeg/rDFJ7
         DFT1Buvg1BPeMSgw2N5jDBcQg3ldtcQy92Kq+nxYa/6rwLvL18Vqng6XRQuwwcCQhQ67
         oonn7OrVsMKZlVZ/6V+byzrZsefyE4vRo4ppM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vQQcJtCf/BqtgT1UxAGAWjFtxmfKB2AbBeTu46Tq6QorTgsjvfeMtySyEWr+RpOZ7Y
         IMbSOxc+KMY01EmyHV6tCvvAsKmyEA7hgxwYYSROoqkdiWfsofgEetHYGstSF3G/704g
         1q25hIkKSdh2C59DMDdz+KYWYnatw/+0m70fw=
Received: by 10.223.2.208 with SMTP id 16mr2477510fak.20.1265122817403;
        Tue, 02 Feb 2010 07:00:17 -0800 (PST)
Received: from localhost.localdomain (abvl217.neoplus.adsl.tpnet.pl [83.8.209.217])
        by mx.google.com with ESMTPS id 16sm2539540fxm.8.2010.02.02.07.00.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 07:00:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o12ExPRJ012758;
	Tue, 2 Feb 2010 15:59:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o12Ex8Oo012751;
	Tue, 2 Feb 2010 15:59:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ron1-35461E.00013102022010@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138720>

Ron Garret <ron1@flownet.com> writes:

> If so, what?  .git/refs/heads seems to contain all the branch info, so 
> what is the branches directory for?

See gitrepository-layout(5):

  branches::
        A slightly deprecated way to store shorthands to be used
        to specify URL to 'git fetch', 'git pull' and 'git push'
        commands is to store a file in `branches/<name>` and
        give 'name' to these commands in place of 'repository'
        argument.

and git-pull(1):

  REMOTES
  -------

  The name of one of the following can be used instead
  of a URL as `<repository>` argument:

  * a remote in the git configuration file: `$GIT_DIR/config`,
  * a file in the `$GIT_DIR/remotes` directory, or
  * a file in the `$GIT_DIR/branches` directory.

  All of these also allow you to omit the refspec from the command line
  because they each contain a refspec which git will use by default.

  [...]

  Named file in `$GIT_DIR/branches`
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  You can choose to provide the name of a
  file in `$GIT_DIR/branches`.
  The URL in this file will be used to access the repository.
  This file should have the following format:


  ------------
          <url>#<head>
  ------------

  `<url>` is required; `#<head>` is optional.

  Depending on the operation, git will use one of the following
  refspecs, if you don't provide one on the command line.
  `<branch>` is the name of this file in `$GIT_DIR/branches` and
  `<head>` defaults to `master`.


Ancient history, if somewhat useful for some workflow[1].  It came from
Cogito, which was alternate UI for git.

[1] Namely one of main Linux kernel developers (Linus lieutienants)
has scripts around this way of specifying remote information.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
