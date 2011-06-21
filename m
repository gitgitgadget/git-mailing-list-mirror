From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 00:22:34 -0500
Message-ID: <20110621052211.GA16919@elie>
References: <20110621022049.GA1632@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 07:22:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYtQG-0007dg-JB
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 07:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1FUFWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 01:22:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58920 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab1FUFWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 01:22:42 -0400
Received: by iyb12 with SMTP id 12so2569561iyb.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZVQ7LQ9yJCdPLS0VcWNeGWbtF5sWNm40L18tsdaI8RU=;
        b=OvOQITaNO9aE16iEp7UWghBKcovS0gm4+wCVVVXXpS+BXiWCW05IwWG0R6A4QHWUAV
         yrp5EoxdnEvlOWMibptFKIie8ADjWLKpDJK3oCEsJX6iwXXqjsuNCMjaHSBhwWAifNUu
         CiyxKtejqxMkzt+lENy8sDsPFw9HClXChm/+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AR/K3hcghtThIJLataZEWz60kPuHekcMJtKHxuMoWALATOgRwFm0rgu3cHX8czRb7F
         E4o0W01Go+btuA7xsJgxID/9mwyYFNLEjNzytErS0nYiQuIFL9J/meVOH/N4Yvr6vPfC
         PaWDjimL5nNSvNMPcIvsQR0J9kcZsXwz1AkhI=
Received: by 10.43.51.10 with SMTP id vg10mr6138469icb.6.1308633761841;
        Mon, 20 Jun 2011 22:22:41 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.sbcglobal.net [69.209.79.158])
        by mx.google.com with ESMTPS id hp8sm6455347icc.11.2011.06.20.22.22.40
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 22:22:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110621022049.GA1632@gnu.kitenet.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176123>

Hi Joey,

Joey Hess wrote[1]:

> * git-annex stores location tracking information to log files in
>   .git-annex/; gitattributes is configured to use merge=union,
>   and the log files have timestamps or are otherwise structured to be
>   safely merged.
> * git notes merge -s cat_sort_uniq
>   Notes are stored in a tree using the object sha, which can be
>   union merged, when the notes' format is a series of independant lines.
> * probably other tools do things like this too, or will ...
>
> So I've written a prototype of a git-union-merge that could be used
> for all of these. It works like this:
>
> git union-merge foo origin/foo refs/heads/foo 

Hm, this makes a lot of sense.  Often a person needs a worktree anyway
to check the merge result for sanity, but as you say, that needn't
always be the case.

[...]
> Prototype is attached, I doubt it would be suitable for git as-is,

Does the GitRepo module that it uses come from git-annex?

If the prototype were self-contained, I would encourage you to submit
it for inclusion under contrib/ so it can evolve and eventually
graduate out of there.  Cc-ing Johan (who has no doubt thought through
these things in the context of "git notes") in case he has thoughts on
it.

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/176119
