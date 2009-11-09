From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 19:47:08 +0100
Message-ID: <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org>
	 <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>
	 <loom.20091106T180313-750@post.gmane.org>
	 <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>
	 <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm>
	 <loom.20091109T084539-720@post.gmane.org>
	 <20091109154816.GH27126@dpotapov.dyndns.org>
	 <loom.20091109T170054-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ZGn-0001tJ-IU
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbZKISrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZKISrF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:47:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:56440 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZKISrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 13:47:03 -0500
Received: by ey-out-2122.google.com with SMTP id 4so23029eyf.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 10:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AGUVWHIYI3K/Wz96hah18/sfX76YiQsVjmg5EM5Q1ag=;
        b=MtrDZxH8K5xYPBYnGdqbTMjDl2eB1SnNBVZYKU74qG2YvF5I7x2aJ7hmpCn+gbKzwH
         62wrRYVKAgOlZQLE8fj9nh0Pj4qQZZJ3h4JanjAwoO0FUPgZr0SsKOj5ht9X3rSdJfYb
         Sb/c/IRHJcaoYcSBv2EaDBzkucirjzMO7vlNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lN874UryfVNhsV1U02EcF082mhWfvdLZtur5PXhSSvae1xxzuSFH/QNnxMcuHqj5GX
         vvOtY26udjo+Aal8cw+IFJAte4eTZWsh6XvVIYyydOKIh90/VxF9C4nYwGXq5rael62D
         6J0HuSNGhNlfEcGWQ8cJruMaxY/uNmsJrt7NU=
Received: by 10.213.99.212 with SMTP id v20mr9704811ebn.87.1257792428355; Mon, 
	09 Nov 2009 10:47:08 -0800 (PST)
In-Reply-To: <loom.20091109T170054-451@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132507>

On Mon, Nov 9, 2009 at 17:11, Dmitry Smirnov <divis1969@gmail.com> wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
>
>
>> Actually, in most use cases, there is no reason to have more than one
>> working tree. Git is designed to work well with plenty branches and one
>> working tree. So, switching between two branches and recompiling a few
>> changed files is much faster then going to another directory and try to
>> work there, because when you go to another directory, you may hit cold
>> cache and disk is *slow*... Another thing is that you can do a lot of
>> things without checking out some branch. You can grep any revision in
>> your repository, you can insect any file from it, etc and you do not
>> have to checkout this revision in your working tree.
>
> Shouldn't I even worry about my not yet commited changes before switching the
> branch?

commit them before you switch. you could:

- commit them to the current branch before you switch the branch.
- commit them to a new branch before you switch
- use git stash to move your changes aside.

> I would say that this approach does not work if the build and test could take
> significant time. While in CR fix I don't want to wait for a build to complete
> before I countinue with another bug/fix. That is why I'm curious about
> few working trees...

You don't have to wait to comitting to your own branches, but do make
sure to run your usual builds and tests before pushing or asking
another to pull changes from you.

// Ben
