From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Thu, 31 Jan 2008 23:49:24 +0100
Message-ID: <1b46aba20801311449l774a6213kc33c49c0682c0228@mail.gmail.com>
References: <47A20503.2000603@debian.org>
	 <20080131193550.GB10905@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 23:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKiEP-00079o-FU
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 23:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763519AbYAaWt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 17:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763534AbYAaWt1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 17:49:27 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:7557 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762320AbYAaWt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 17:49:26 -0500
Received: by an-out-0708.google.com with SMTP id d31so210380and.103
        for <git@vger.kernel.org>; Thu, 31 Jan 2008 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GgDBkdtpz1UGqjao4eJOwRU5/MOVrcE8+hTNkzEljE8=;
        b=eMb91SJZUZCmB8IomYppdZ7nL1fYmf3+H5VKzJbo70/mhrOLjui0Mk9Xvpa9qJ5SO/PriSvoyTXHsi9rcBU91bPlR1YT6vj5svSz/xNkJrMUVC0Fh22R7JHT7bbIt6jKye0t3iEzU9cWDhx+oruTpcFeSNYkpWgGt5P8GNkyC7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a7+EMSxIHMIoIey43LzHEDtXfHaXfZV0ndXzE/ekCyTy4isJHkqIFa7axixLL+WLs1hFWRzxsRxTyyPpGbALsIy0yqZUmVgrTa3Qi7EupJUd8z911bvc9VhKtYbKtAXq9CGET7MaYvPEwZdYOmGLuXqb8iz5WJTtErHJK3F8ziU=
Received: by 10.142.222.21 with SMTP id u21mr1678108wfg.231.1201819764370;
        Thu, 31 Jan 2008 14:49:24 -0800 (PST)
Received: by 10.142.88.7 with HTTP; Thu, 31 Jan 2008 14:49:24 -0800 (PST)
In-Reply-To: <20080131193550.GB10905@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72140>

On Jan 31, 2008 8:35 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> On Thu, Jan 31, 2008 at 05:27:31PM +0000, Daniel Baumann wrote:
> > Hi,
> >
> > git commit supports --author to overwrite the author information on a
> > particular commit; it would be nice if git tag would offer the same.
>
>   Meanwhile,
>
>   GIT_AUTHOR_NAME="John Doe" GIT_AUTHOR_EMAIL=luser@example.com git tag

That didn't work for me, but perhaps I'm not understanding what this user wants
to do. I think it is about to create a tag object having another
author different from committer.

In such case, and looking at builtin-commit.c, I see that the code needed
could came from the function determine_author_info(), just the part using
force_author variable, to be added in the create_tag() function from
builtin-tag.c.

The only thing I don't know is if this should be different from
git-commit in which
both "author" and "committer" fields are supplied and only "author" can be
changed this way, preserving the committer. In git-tag, only the committer is
included in the tag object, written as the "tagger".

Please, correct me if I'm wrong.

Regards.
Carlos.
