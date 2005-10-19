From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Pushing a single tag (ref + object)?
Date: Wed, 19 Oct 2005 19:05:32 +1300
Message-ID: <46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com>
References: <46a038f90510131929m3dac4cc5y6071550e9e9c71ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 19 08:06:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES75Q-0000DK-Ll
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 08:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbVJSGFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 02:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbVJSGFf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 02:05:35 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:65346 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751541AbVJSGFe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 02:05:34 -0400
Received: by qproxy.gmail.com with SMTP id v40so15079qbe
        for <git@vger.kernel.org>; Tue, 18 Oct 2005 23:05:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQN0jiyFe+uAkOLVRMVZ7i0LJ5SRXLfKtp9r61rY+RBnsaIlSiZh6TyO2VwqUWk74WOTovvD40ybdiRyj4jduwQB2gdvvaJBnZN+CguhGdHLfD7d3ohg1jeyV82PfnBesSWa1+iibd/aW9lJOEs3T9chRGwVUL+ywU7JxrS4KO4=
Received: by 10.65.38.14 with SMTP id q14mr197410qbj;
        Tue, 18 Oct 2005 23:05:32 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 18 Oct 2005 23:05:32 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f90510131929m3dac4cc5y6071550e9e9c71ad@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10266>

While we are using a repo which holds all our branches
(dev/test/prod), locally we have a group of developers that checkout
one repo-per-branch, working on it with a
cg-clone/cg-update/cg-commit/cg-push workcycle. So far it's working
great.

Now, I am at a loss on how to push a _tag_ object+ref to the repo,
without doing a git-push --all, which I naturally don't want to do. I
managed to push the object itself, doing

    git-push repository tagrefname

But that ddn't create the ref on the repo. So I had to do

    scp .git/refs/tags/refname repostory/refs/tags/

I'm feeling a tad lost here. Surely there's a way? Or should I be
crafting a patch against git-push-script? Problem is, git-push script
doesn't do any parsing of the params. Grmbl.


martin
