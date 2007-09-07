From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 18:08:40 -0700
Message-ID: <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <1189004090.20311.12.camel@hinata.boston.redhat.com>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITSL7-0002yA-GX
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 03:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbXIGBIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 21:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbXIGBIs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 21:08:48 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:60358 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbXIGBIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 21:08:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so290485rvb
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 18:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KPxdlasznxbjRVeJ2pGwrTLbc+S+rfvZDuC3RbttGkY=;
        b=OU65yzLihnPAKCyQc5tgvjH4CvM+fF5NF6XzuokfPBVyhaUZoVNUMd7/KBgM8TfZ2+bEAapIlupu4ikwcstm6Jbjlm+bcbUE0aFO0df6auhJwS6qhFozOrifnKp9FXjRyVjOUWG6x0JlUx6CafMPO5qjhGmpKaZ8x4yszuQJgOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P/+gnVwXmV5X+jCd7PElpqr+Sqyc57OiKx/jsLpl/Y1zDx/PyuhQZ6WXf9UC25J/SMfgFleAVg6XUyLusefJnK7/4kHUlpthRhd63byRwECmgBs5mAN/dw9EUBfj3f/wh8pyUzX/6b1j/fDifo5qKtKPbFVVG8zEZbCs4lLcH4s=
Received: by 10.141.41.12 with SMTP id t12mr505334rvj.1189127320475;
        Thu, 06 Sep 2007 18:08:40 -0700 (PDT)
Received: by 10.141.204.17 with HTTP; Thu, 6 Sep 2007 18:08:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57959>

On 9/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> >
> > As dinosaurs (who code exclusively in C) are becoming extinct, you
> > will soon find yourself alone with attitude like this.
>
> Unlike you, I actually gave reasons for my dislike of C++, and pointed to
> examples of the kinds of failures that it leads to.

As I said, it's a matter of believes. As such, any reasoning and
arguing will be endless and pointless, as for any other religious
issue.

> You, on the other hand, have given no sane reasons *for* using C++.

I'll give you reasons why to use C++ for Git (not why C++ is better
for any project in general, as that again would be pointless):

1. Good String class will make code much more readable (and
significantly shorter)
2. Good Buffer class - same reason
3. Smart pointers and smart handles to manage memory and
file/socket/lock handles.

As it is right now, it's too hard to see the high-level logic thru
this endless-busy-work of micro-managing strings and memory.

> The fact is, git is better than the other SCM's. And good taste (and C) is
> one of the reasons for that.

IMHO Git has a brilliant high-level design (object database, using
hashes, simple and accessible storage for data and metadata). Kudos to
you!
The implementation: a mixture of C and shell scripts, command line
interface that has evolved bottom-up is so-so.

> and comparing C to assembler just shows that you don't have a friggin idea
> about what you're talking about.

I don't see myself comparing assembler to C anywhere.
I was pointing out that I've been programming in different languages
(many more actually) and observed bad developers writing bad code in
all of them. So this quality "bad developer" is actually
language-agnostic :-).
-- 
- Dmitry
