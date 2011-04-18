From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Sun, 17 Apr 2011 19:45:51 -0500
Message-ID: <20110418004550.GA2529@elie>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <BANLkTimTszUC+4d3tMTP-cxG3AoWmr08HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>,
	Harley J Pig <harleypig@gmail.com>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 02:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBcbL-0004vj-1S
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 02:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab1DRAp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 20:45:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47313 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab1DRAp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 20:45:57 -0400
Received: by iwn34 with SMTP id 34so3491673iwn.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s5k08rGgdAt6W1NbuvTWXljUptyq3cX22SjCHVyeDEQ=;
        b=xQpyDE2qFDQ025CPj0z8q74X64Sx/DYUExU6oUsDPi7RtSnSI0mBO7LR2ZhfTKL/xN
         b833B7Z62PbpI3j3O+srqsYurW+TfKE5i2FYlILiVCIJ4ARMPC+gR+/mAIn/7jWwcA5B
         XEzTtA1W7g5BfB+NnmNKgUo1ozdsaVek0WT44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s8Y0ptCzcqN8K2VzBfbc4eJ6pSgO3MttqAMWC3+DlvUYcZBTTC+eDHA4wyc3n4cSvX
         P9s8GFMdZViQHSyn/Bw2sjokT8Qy2ns30TzTkasu8cPqXgXDKm5TrfeV8j1rWT2ZQzml
         g2yWXtuPHQ+qhQvWUNPQcFhvWAE1FqsrJjpZg=
Received: by 10.231.117.36 with SMTP id o36mr3420242ibq.64.1303087557221;
        Sun, 17 Apr 2011 17:45:57 -0700 (PDT)
Received: from elie (adsl-69-209-55-4.dsl.chcgil.sbcglobal.net [69.209.55.4])
        by mx.google.com with ESMTPS id t1sm2629723ibm.55.2011.04.17.17.45.54
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 17:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimTszUC+4d3tMTP-cxG3AoWmr08HA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171733>

Hi again,

Not sure if my thoughts will be useful here since you dropped me from
the cc list.  But anyway:

Richard Hartmann wrote:

> here are the three options:
>
> 1) fix metastore
> 2) default to gitperms
> 3) extend git
>
> I still think 3) would be best, but someone would need to step up to
> do this. Is anyone up for this task? If not, we will have to resort to
> 1) or 2)

The usual practice in git development is

 (1) people make scripts wrapping plumbing commands (see git(1)) that
     work well for themselves
 (2) they tell the git list about it and publish it
 (3) an idea emerges that this is suitable for inclusion, and it
     gets included

In particular, git's design is not so monolithic --- "extend git" can
mean "add a script" or "add a builtin" so it is not so involved as you
seem to think.  See also contrib/README for a place to stop on the
way.

Anyway, if you want something the just works, my suggestion is (4) use
the hook scripts from etckeeper.  Last time I looked into this they
worked better than metastore.

Hope that helps.
Jonathan
