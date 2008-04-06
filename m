From: "seventh guardian" <seventhguardian@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 6 Apr 2008 18:11:12 +0100
Message-ID: <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com>
	 <20080406161120.GB24358@coredump.intra.peff.net>
	 <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
	 <20080406165655.GA26060@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 19:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiYPZ-0002gl-JJ
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 19:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbYDFRLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 13:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYDFRLP
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 13:11:15 -0400
Received: from el-out-1112.google.com ([209.85.162.183]:44714 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYDFRLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 13:11:14 -0400
Received: by el-out-1112.google.com with SMTP id v27so678491ele.17
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JPxwgFfNuI13MfHEGer/GOZLYsh7+M0ConnESapzGcs=;
        b=uIojS0+8QDqihIq1sTpH9X7IfDsu6A8JxJN/Vj+eSSE+d7dfZMx2Lw0Kq6QfG7YWKfLoPcnrr8I6Ut/O7CJ5fOSN9Eju3vgKKmYRF6gqj1NpZ32UOYkIFPlsq517yWJTqhEBQLhbJZIW4j2x2V7Alv6mf/DBR++jjHLrZ6i4iCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c7JI5z7HI0ppD8cOslWxP86eDMrUnqdbbaPIAkwva9JU32mUyAZcG4N1XY3lnSbUZ0PT8nucwYIArH8mFrh/Qn8JPnJ8hkAQZrWdpqp+TA23g/qEyp0VXBKve+PUrg0us0J05Wg/xHtARQ97uwmbnLCHBBst8EWm+EPh9yCYsg0=
Received: by 10.114.24.5 with SMTP id 5mr1806063wax.199.1207501872226;
        Sun, 06 Apr 2008 10:11:12 -0700 (PDT)
Received: by 10.114.126.18 with HTTP; Sun, 6 Apr 2008 10:11:12 -0700 (PDT)
In-Reply-To: <20080406165655.GA26060@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78901>

On Sun, Apr 6, 2008 at 5:56 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 06, 2008 at 05:22:39PM +0100, seventh guardian wrote:
>
>  > I can, but it is a local commit. It seems like local commits aren't
>  > being "cloned over" to the slaves.. As I said, this only happens for
>  > "local masters" where I have local commits. If my master is untouched,
>  > then I can successfuly clone the repo.
>
>  You are going to have to clarify what you mean by "local commit" and
>  "local master". Those aren't terms that are commonly used, so I don't
>  understand what you are talking about. Can you describe which git
>  commands you used to create this situation?

I figured ;) Let me see if I can explain it better:

remote master: the project git server, located remotely over the internet
local master: my laptop repository, made by cloning the project master repo
slave(s): my local machines, which clone the local master, instead of
the remote master (to save bandwidth)

So on the local master (my laptop) I did:
$ git-clone http://remote.master.address/foo/bar.git

Because I had to do some local changes to the code (what I've called a
"local commit"), I did this on the local master:
$ git-commit -a

Now I want a copy of the repository on another machine, "slave". So I do this:
$ git-clone ssh://local.master.address/path/to/repo

Which gives the annoying error.. If I skipped the "local commit"
stuff, then the cloning would work perfectly.

I hope this is clear now.. Thanks!
  Renato
