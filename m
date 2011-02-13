From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 13 Feb 2011 13:37:38 -0600
Message-ID: <20110213193738.GA26868@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 20:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PohlW-0000ZO-Uc
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 20:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab1BMThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 14:37:46 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40231 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab1BMThp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 14:37:45 -0500
Received: by gwj20 with SMTP id 20so1774148gwj.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+FZ1xtA9O8oKznZgEH/Np/T9q/tsOjoh77s1132f5Yo=;
        b=aNaYhRunw+7Ck0+7zxN4M0Mloxqb6Lxc1qNiqS2f2atvYV3A3Zo/WgrwjFkwNDKbgd
         PoFFs1DuGn4LnN/P2HABTNLjEc8EvDiY/UJtKUOmysLLE9lItN7LRL9ViSQtyZtIFwUW
         ML8YtIa09Q8CdB6ZZ+DkS44CQBlRoWufNmVOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZwZM+8/gm9Z6Ke5XRKl1oBoBU10pIt8dkSNST1gy8ZZW0Tj+8gw81f2QypDKenxqLS
         BwV2JnfTQaVrZIkAlyPeZm4BCY+WrcK8djC5M8y2vrjii2TR2zgjvGFEO2k/Mes0wSTx
         jvwJDwZiCGGQiBiBIMsjVYPKFr/0euUJ1fuN0=
Received: by 10.150.211.17 with SMTP id j17mr3387354ybg.225.1297625864649;
        Sun, 13 Feb 2011 11:37:44 -0800 (PST)
Received: from elie (adsl-69-209-71-45.dsl.chcgil.sbcglobal.net [69.209.71.45])
        by mx.google.com with ESMTPS id 8sm995831yhl.44.2011.02.13.11.37.43
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Feb 2011 11:37:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166678>

Piotr Krukowiecki wrote:

> is there a plan for using one term instead of three to describe
> operations on index?

No.  But ideas (and especially patches) for improving the
documentation would be appreciated.

> From quick search:
> * "add" mentions index and staging
> * all commands except one take "--cached" only
> * "diff" also takes "--staged"
> * "diff" mentions index and staging
> * "log" mentions index
> * "reset" mentions index

If I understand correctly, the intended semantics are:

--index versus --cached
~~~~~~~~~~~~~~~~~~~~~~~
The place where changes for the next commit get registered is called
the "index file".

Commands that pay attention to the registered content of files rather
than the copies in the work tree use the option name "--cached".  This
is mostly for historical reasons --- early on, it was not obvious that
making the index not match the worktree was going to be useful.

Commands that update the registered content of files in addition to
the worktree use the option name "--index".

--staged
~~~~~~~~
diff takes --staged, but that is only to support some people's habits.

The term "to stage" is generally an abbreviation for "to stage in the
index", meaning "to mark for use in the next commit".  It is used to
paint a certain picture of the process in which one makes sure
everything is just right before committing to the result.

Hope that helps,
Jonathan
