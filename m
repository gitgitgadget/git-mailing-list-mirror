From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 11:19:56 -0300
Message-ID: <46a038f90707230719i106e0576j2868548ef0cb1739@mail.gmail.com>
References: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
	 <46a038f90707230359u5fac77a4i7b6a350d3bb29e3b@mail.gmail.com>
	 <AD8AD244-0B20-44E9-AEE6-9D2A75BC5091@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 16:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICyla-0006gH-DB
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 16:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbXGWOT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 10:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbXGWOT7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 10:19:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:17814 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXGWOT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 10:19:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1503572wxd
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 07:19:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNyoyqRwonzj4sjkzhedvbcbEYq4edrACedpDsuDGF7SvbYi4JDtWcVDd5hbRIkbleUYOos6zIhZ+p/eMOyUN09hcDi+STtLVfjqs/k2TlLx0YkGKJYmUkxDVuAybXbd1AcAZuN1rBRJnplxYpBGQE1ZfvIYiT2pHruFNkoavv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKbsOLQYFjtPTAIxql5dUAk9pF4SIyxuM97JIrA5K6tZNOYamSUwxr1OqfcTja96MICn81mYKFk5D9OlJbOrlNZPIxkUfXzSkmKfRRKPHNzlqMXh6W6gKawr+SJX/YnyFHw20WEwp7G7br7AxXXD0BEcEI5tVGmSQJTU19nAzDs=
Received: by 10.90.78.9 with SMTP id a9mr1858196agb.1185200396196;
        Mon, 23 Jul 2007 07:19:56 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 23 Jul 2007 07:19:56 -0700 (PDT)
In-Reply-To: <AD8AD244-0B20-44E9-AEE6-9D2A75BC5091@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53437>

On 7/23/07, Steffen Prohaska <prohaska@zib.de> wrote:
> If several people commit to the same shared branch exported by
> git-cvsserver they most likely will generate a series of unsorted
> commits, as they did in the past on a single cvs branch. The
> commits will probably deal with various topics, include bug fixes,
> and some are likely more experimental and not really ready for a
> stable branch.

Keep the good commit message practices ;-) in my projects I tend to
mimic the linux and git "style" for commit msgs.

> My question is how to deal with this shared branch on the git
> side. Should a core developer rebuild a sane history from such
> a shared/mixed/unsorted branch by cherry picking the commits
> to one or more topic branches?

I think that's usually frowned upon. As the committer did his/her work
on a particular state of the tree, and tested it. So every commit at
least *should* be of a working state. Once you rewrite history as a
"normal" practice, that flies out of the window. And it's a big loss.

In a sense, it's  a "history that looks tidy but is false". And it's
extra work too. I very strongly prefer good commit messages, and the
real history.

> If one did so, how could one
> bring the git-ish history back to the people connected by cvs?
> Am I allowed to reset branches exported by git-cvsserver?
> Probably not?

Indeed not. Junio rewinds/rebases pu (the proposed updates branch
mentioned earlier) regularly,  but you can only do that in a pure-git
project, and with fairly experienced git users (so if they get caught
with commits on top of a rewound pu branch they'll know what to do).
cvsserver doesn't know what to do with rewinds/rebases and, more
importantly, cvs clients can't cope with it. And that is something we
cannot fix, unfortunately.

cheers,


martin



>         Steffen
>
>
