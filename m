From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 19:54:45 -0700
Message-ID: <AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 04:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3kC-0002Go-03
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 04:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab0GICzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 22:55:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53072 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab0GICzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 22:55:08 -0400
Received: by gye5 with SMTP id 5so914207gye.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=QHHyHCUU755swzzAH2WSyZODMbBRanxqX1QZlH2WRz8=;
        b=xXRSzpgd2N4n5Fnba5vMZfuZPlHy4LcY02he7+tHqLZvCA2e7qsefgJYJOyjn5rq7R
         dX3J9gXK4P6SuyDBCydHUcGZSWP2Pvn797IvPzGdlDpaEdhTZoI42XQcTEIDJDshO9g/
         nKAYnvD4yUCuhjpCppbZgxIHdnh/GXmo9z8s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uqb0auj4YzZnb0Op1grFGusEIj2RV3P7FlEMe5vRrPo9hqsrdbVWsPrU9xrgkbv1KG
         GibCGhbyT9Hm3KR7Yj7JrE3Ey1xsI8zsEX2Azy9MyJJ4MF5LTR/bfQsbJaJU7JOQt8qD
         UJaApYrEVe1W9DV7TmFxy33A7VZFqYp6fMWSo=
Received: by 10.229.188.19 with SMTP id cy19mr5597346qcb.103.1278644105718; 
	Thu, 08 Jul 2010 19:55:05 -0700 (PDT)
Received: by 10.229.25.4 with HTTP; Thu, 8 Jul 2010 19:54:45 -0700 (PDT)
In-Reply-To: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150630>

On Wed, Jul 7, 2010 at 06:36, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> Do I need to convert these remote tags/branches into local Git
> tags/branches before pushing them to my remote Git repo or is there a
> way to push remote branches directly to my remote Git repo?
>

You don't need to "convert" the branches to local ones.  git-push will
accept any ref your local repo knows about when you do a push.  For
example "git push remote2 origin/branch-foo:refs/heads/branch-foo"
works just fine, even if you don't have a "local" branch called
"branch-foo", and it will push the branch-foo branch out to the
remote2 remote repository.

The tags, you'll need to convert to _actual_ tags, instead of just
branches under a tags/ namespace.  Unless you're fine with them
staying as pseudo-tags, then you can just push them out as you would
any other branch.

-Jacob
