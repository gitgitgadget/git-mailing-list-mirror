From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Beginner's question on how to use git for multiple parallel 
	versions
Date: Mon, 4 Jan 2010 17:35:23 +0300
Message-ID: <37fcd2781001040635t12183269rd24f34bf05a5d788@mail.gmail.com>
References: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Christian C. Schouten" <info@zark3.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 15:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRo1q-0003EE-FH
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 15:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0ADOf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 09:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457Ab0ADOfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 09:35:25 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:50523 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0ADOfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 09:35:25 -0500
Received: by fxm25 with SMTP id 25so8741659fxm.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jiZN/melEZK+jYu4GNXzGDFKRG0Key3qtqRrqk/FRxI=;
        b=Tq0PZYe9yYbVAMHc856RZlKavYJ+9Filgp7Gfe6CG/E5YT4EZ+S/eBx+1lv4TRa4fp
         z5i1DTPINxjYkmbabufmtQJIVVrtbiRN9vmUyFnZSg8U6bKNURTHw3Wq3hFhDYj9YEep
         18R3wvTwtTsvhycMaaPu7WD9wuhUwztAPmH5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Neo79OOvnC2tiqgVe1E7uFeq0/gEz03uuDWbd1NIpAdkZNv5x7AWHhYn8FpDfAoO8/
         Zz9g74EzbzBFvnIdvcbi7N4FPi5C9tm9fx+8Qf5MRWkR8ZCCgdjdFcdaO5wnlq1rDqg3
         7HDbikAwr+Sy87zLZXEZVVd5hgto/PHDjXs38=
Received: by 10.239.149.196 with SMTP id k4mr1618768hbb.1.1262615723654; Mon, 
	04 Jan 2010 06:35:23 -0800 (PST)
In-Reply-To: <F8CC469C9CCA415696101414EA997C0.MAI@sohosted19.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136116>

Hi,

On Mon, Jan 4, 2010 at 2:29 PM, Christian C. Schouten <info@zark3.net> wrote:
>
> I&#8217;ve got a project that I want to do version management on with git but being a beginner in
> cvs/svn/dvcs etc. terminology I don&#8217;t know yet how to set it up.
> My project needs to exist as several parallel copies, i.e. there is a &#8220;main version&#8221; in
> which I do my development but it needs to end up being available as a couple of different
> configurations.

One way to achieve that is to use branches. You create a mainline
branch that will contain
what is common for all versions, and then create a few specific
branches from it. Each branch
will contain their own files, as well as modifications to some common
files if it is necessary.

Changes that a common to all branches should be committed to the
mainline, which is merged
to each version specific branch.

Git allows to quickly switch between branches, so you stay in all
worktree all the time.
Moreover, if you made modifications to some file on branchA but then
realized that it should
be commit to another branch, you can switch to another branch as usual
as long as the
modified files are the same on both branches. (If it is not the case,
you can use git stash).

Dmitry
