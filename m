From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [git question] how to handle few projects with common parts?
Date: Fri, 23 Oct 2009 12:07:38 -0400
Message-ID: <32541b130910230907x38d8c1f8vb504865eaf5b524@mail.gmail.com>
References: <368bc75e0910230201y8e4310dme6276d436c6a6ab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ivan Dimitrov <ivand58@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 18:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1MgX-0005WF-M9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 18:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZJWQHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbZJWQHy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 12:07:54 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:56388 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZJWQHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 12:07:53 -0400
Received: by ywh40 with SMTP id 40so6525061ywh.33
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+oaR6OQNRx48+e/mKfbfl4/jiKpSoFRn3or2JPDxdHw=;
        b=nR/rJXvGuctKQ9NDlvdZf64syezNrEhVkKK4/ghHxQU2FpmCQgI9UQqRTSveZo3DO/
         xIt5Wo1W1ewnzmxUaYZoEtQxImwPfuO15Dh70Rp3Djjbhvvx8jBgYa/F5vTlVqTOsZS7
         asvzNpYO+fWc7xhKDR9iVSEejxEMQyOc04ZoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F4nkgkyJAB9x2Al45ABOfnvwJvm/n02Bo20BkAVSs+2hR2e6d9sr6uPGUdlJHuW3OX
         EaagMwLcA+Lit5pjwF1/s3a1u1FS4B2hMKHHgpXadabvzc79Bv6U4qTG5NrWemzbVMa+
         RqtU7Bt+RceFSLBlOBWo/Hx/hSAeG7GP3Unko=
Received: by 10.150.37.5 with SMTP id k5mr7243037ybk.245.1256314078411; Fri, 
	23 Oct 2009 09:07:58 -0700 (PDT)
In-Reply-To: <368bc75e0910230201y8e4310dme6276d436c6a6ab6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131110>

On Fri, Oct 23, 2009 at 5:01 AM, Ivan Dimitrov <ivand58@gmail.com> wrote:
> Maybe my question relates rather to configuration management, but it
> is over GIT.
> In short - I have to manage two projects with 95% same files
> (components) and all the rest are platform depended. I am trying to
> keep different platforms in different branches, but I can't figure out
> how keep the common part of the project synchronized?

Are the other files (1) *completely* different across branches, or (2)
the same in each branch, but customized?

If (1), I don't think branches are the answer.  You probably just want
a subdir per platform and a simple config file that points at which
branch to use.  Or maybe use some #ifdefs, or whatever the equivalent
is in your system.

If (2), perhaps what you want is three branches: a main development
branch, and two customized branches that you merge (or rebase) master
into.  I do this sometimes when I want a "development" branch and then
some specific customizations for a particular production deployment.
(eg. a default config file and the "live" config file, and I want both
to be version controlled separately)

Have fun,

Avery
