From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: The --no-commit blues
Date: Mon, 18 Jun 2007 18:04:03 +0200
Message-ID: <81b0412b0706180904l52076d7l96797fee0deaf97c@mail.gmail.com>
References: <200706180806.26255.goofyheadedpunk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Brian L. Troutwine" <goofyheadedpunk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 18:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Ji7-0004TW-1z
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 18:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbXFRQEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbXFRQEH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 12:04:07 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:6382 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbXFRQEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 12:04:05 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1310649ika
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 09:04:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gXz6EZ2HX8D7cOCP58UUzh+0Nvw7wpAQ55nZg+CiKr1fBQT4hS26X2o7uOAzA3/3VNgn8KzZyg+nxaRkDQ8lVV1WPEAM0BexRRShvcWcrEDWR8Mzw81f5hVeTmMEQawgD/xrczphLl86tugIToku7S30ID1bjLbYB6WFkayCSO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ip3AuAqq7pzZ2ib72Hj3v5MS+hMSk8qnktqm7uSZn7yb8+5L2kXOuySx9zrMUSN1HlS+bc4IEDVDmD/YL4/minY5ihDMzJBUWu2t8djjA2F6QbVV0HYPL3WJ4dEEXZRp7Xg8JMgyn9mJIWtP0bqCUiqDE39JrQgVE4NT59MBFy8=
Received: by 10.78.201.10 with SMTP id y10mr2385623huf.1182182643704;
        Mon, 18 Jun 2007 09:04:03 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Mon, 18 Jun 2007 09:04:03 -0700 (PDT)
In-Reply-To: <200706180806.26255.goofyheadedpunk@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50400>

On 6/18/07, Brian L. Troutwine <goofyheadedpunk@gmail.com> wrote:
> I've got two branches, one which I commit to quite frequently and another only
> periodically, call them inward and outward. Inward is where I do my work,
> outward tracks an SVN repository. I'd like to merge inward to outward without
> committing the merge so that I may provide a commit message appropriate for
> checking in to the SVN repo.
>
> `git merge --no-commit inward' from branch outward, I thought, should do it.
> Performing a `git status' and a `git log' directly afterward seem to indicate
> that the merge was committed. `git commit' insists the branch is now up to
> date.

Either it was a fast-forward (IOW, the outward had no changes since you
changed inward, and inward is derived from outward), or we have a bug
(which I cannot reproduce).

> Am I going about this the wrong way? What does --no-commit mean, if I am?

exactly what it say: do not commit. Fast-forwards do not commit, just update
your HEAD, index and working directory with the new changed (from inward
in your case).
