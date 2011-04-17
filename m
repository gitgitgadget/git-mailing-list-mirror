From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 12:11:13 +0200
Message-ID: <201104171211.14118.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104170019.07997.jnareb@gmail.com> <20110416225729.GB5739@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 12:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBOx4-0003tb-2M
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 12:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab1DQKL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 06:11:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33056 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1DQKL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 06:11:27 -0400
Received: by bwz15 with SMTP id 15so3131267bwz.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OEiq3oLKnZ3TeZrDcHMpBMQbJGgJ7k9bsz10ylauGlw=;
        b=dNAlj2RzkqCuquWEiaEXkke/bSOATyEfKd8Dm0oRnSdiKhxd1pXLOgqH/+okvhArBH
         5k+1V9MIFHPwAqNG2GWvBzmRTUFzpxIzX/UlyKUKS7Fld8bjOO2E4+wNMdMBNSyUEBEC
         l7o0AzSMQO82JPAMMxrwL+8tD7AWXJjbqkK2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ld6YBOmkU1Zu6hjb00RDQDkwIDKCgXdd/GLziV9JGukT62k6hhJIwyF02QPHf1OI2J
         OPnGEGcMfuUq4rh54GMDtI6VDURPqEzQhFeTir3MJYIIqP6LVi4T/AEUX+FVUIrN8cMT
         br/4vgmeiIvpMkkZZpFgUaHBwdmj0APiZj5U4=
Received: by 10.204.46.161 with SMTP id j33mr3061713bkf.212.1303035085696;
        Sun, 17 Apr 2011 03:11:25 -0700 (PDT)
Received: from [192.168.1.13] (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id q18sm2519718bka.3.2011.04.17.03.11.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2011 03:11:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110416225729.GB5739@external.screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171718>

On Sun, 17 Apr 2011, Peter Vereshagin wrote:
> You're face to face with man who sold the world, Jakub!
> 2011/04/17 00:19:07 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

> JN> > There are more disadvantages of such  an approach:
> JN> > - for CGI, the process is being executed on every request. On some systems, e.
> JN> >   g., Windows, launching a process is very expensive, sometimes more than

> JN> git-http-backend is written in C, not Perl.
> 
> Yes, it's about it.

Perl is much better for writing a web app such as gitweb (meant for
web browsers) than bare C.
 
> JN> > - for development, some different parts of the code for the same purpose do
> JN> >   exist, e. g., client and storage i/o. The more it is being developed, the
> JN> >   more features it satisfies, the more such a code.
> JN> 
> JN> Gitweb is written in Perl.  This language is good for prototyping, for
> JN> fast development, and for easy writing of a web app.  Gitweb works on
> JN> porcelain level - it is an user interface (a web one).
> JN> 
> JN> C is good for performance.  git-http-backend is only an example
> JN> implementation.  The "smart" HTTP protocol works on porcelain level.
> 
> It doesn't mean that different parts of code do exist in them
> for the same purpose.  It doesn't mean that such a code can not
> be reused by both.  C code can be used by Perl.

C code can be used by Perl... but if you mean calling C code from Perl
then first, there is no git library; libgit2 is work in progress yet.
Second, there are no Perl bindings for libgit2.  Third, doing Perl
bindings to C in _portable_ way is major pain; XS is hard (this might
change if/when Perl port of ctypes would be finished).

If you mean calling git commands from gitweb and parsing their output...
that is what gitweb does.

But gitweb and git-http-backend doesn't have much common in 
functionality.

> JN> >   For example, I suppose git-http-backend will have 'get a particular
> JN> >   commitdiff quickly without fetching all the repo' feature one day
> JN> >   to be used in web clients' scripts, e.g. will serve the same way
> JN> >   for git cli as a file system. This will make it have the same
> JN> >   feature like 'commitdiff' feature of a gitweb but implemented 
> JN> >   differently.
> JN> 
> JN> Unix philosophy which Git tries to follow is "do one thing and do it
> JN> well".
> 
> This is why the code must not be reused?

What is about code reuse?  Gitweb calls git commands, and generates
output in HTML for web browser.  git-http-backend is responsible for
communicating with git-upload-pack / git-receive-pack on behalf of git
client.

> Does it mean "there is more than one way to do it and we will use
> all of them for the same purpose in the same project"? 

No.

This means that it is gitweb job to tak to web browser, git-http-backend
to talk to "git fetch" or "git push", and web server to route to
correct script (backend).
 
> JN> I don't believe git-http-backend would ever talk to web browsers, and
> JN> it is quite unlikely for git to acquire non-distributed client-server
> JN> mode.

[...]
 
> JN> And if it does acquire such feature, then gitweb will be simply modified
> JN> to use it...
> 
> or git-http-backend? or both?

Gitweb, because it is porcelain.  git-http-backend is plumbing.  It is
porcelain (high level, meant for end user) that uses plumbing (low level,
meant for scripts and other commands).

> isn't it just better for them to reuse the same code?

There is nothing to reuse.

> JN> > - the routing of the request, the deciding what to do with the particular
> JN> >   HTTP request, becomes more obfuscated. First, web server decides what CGI
> JN> >   should approve it. Plus two more decision makers are those 2 CGI, all different.
> JN> > 
> JN> > It's just why I never supposed git to have 2 different native web interfaces,
> JN> > especially in sight of plumbing vs porcelain contrast in cli, sorry for
> JN> > confusion.
> JN> 
> JN> Those are not two _web interfaces_.  Gitweb is one of web interfaces
> JN> to git repositories; more at
> JN>   https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces
> JN> 
> JN> Fetching and pushing via HTTP is not web interface, is HTTP _transport_.
> 
> But HTTP is an application protocol, not a transport protocol.

Fetching via "smart" HTTP protocol is actually git-over-http, with
some extra work due to the fact that HTTP is stateless.

> JN> For one [gitweb] you use web browser, for other [git-http-backend]
> JN> you use git itself. 
> 
> on the client side those are different projects.
> on the server side those are the same.

No, they are not the same.  Besides minuscule part of being a CGI script
they have nothing in common.  Gitweb produces HTML output for consumption
of web browser in response to given URL.  git-http-backend proxies fetch
and push request to git-upload-pack / git-receive-pack.

> 
> Different technologies, right. But not incompatible.

There is nothing to be compatible with.

> JN> But this discussion got very off-topic...
>
> Not about Javascript, right.

Well, except the fact that "git fetch" / "git push" is not a web browser,
and that it would never use JavaScript... so git-http-backend wouldn't
either.

But it is not about JavaScript use by gitweb.
-- 
Jakub Narebski
Poland
