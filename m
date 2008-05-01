From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with
Date: Thu, 1 May 2008 15:55:22 -0400
Message-ID: <32541b130805011255t4b37a73cx9d670b9250e787c6@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
	 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
	 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
	 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
	 <1209594215.25663.864.camel@work.sfbay.sun.com>
	 <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
	 <20080501183837.GA4772@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Finn Arne Gangstad" <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu May 01 21:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jret5-0001ql-KD
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbYEATz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYEATz1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:55:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:25350 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbYEATz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:55:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so853740fkq.5
        for <git@vger.kernel.org>; Thu, 01 May 2008 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bACrNtbHCmofiBASP/meMEFmXTi+7NZk5nNO9zlNLMI=;
        b=hXDPcTvUDmrnvAD724+hG1ApcX6ThEMkzMJMD+8WL2VIV+SGCSqEaLmAfpS0sd9DVotmCBSM3sPz+ZAixqNMiMMLzQdS6j9j1BTJa+p2N58lb3F+y3D8BjcZroV6eyWIk8IEmWgikjsLOW8hbUb08g08gHBb/ieQYo65vwVUlxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kd3Vbx5IxOgTDDhNteGhz9FnI72u81ln0pV7kZR1ytrh4gaV1X+WDOwp7bD3VmmwzY13FsXGAh97Zn+1F50HU5I/NyoJyi322BjDsTSe7hupwFq61e8G8tIeSMWwJE7rpHdigFriLd4fgKhRxsHwS9OH2/m09UUKa9dyatO08OM=
Received: by 10.82.127.14 with SMTP id z14mr270153buc.7.1209671722805;
        Thu, 01 May 2008 12:55:22 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 1 May 2008 12:55:22 -0700 (PDT)
In-Reply-To: <20080501183837.GA4772@pvv.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80938>

On Thu, May 1, 2008 at 2:38 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:
>  Today, submodules seem to be a "read-only" implementation of the
>  supermodule. By that I mean that it is (only?) suited for creating a
>  supermodule that consists of independently released submodules, where
>  all development happens in the submodules, and you sometimes update
>  the supermodule to refer to a new version of a submodule.
>
>  What I've tried to achieve with submodules is a bit different: I want
>  most development to happen in the supermodule _as if_ the submodules
>  were part of the supermodule. There are two reasons for not doing it
>  with one big module: Total size can be a bit too big, but most
>  importantly, some submodules are shared between different super
>  modules and there is a certain level of synchronizing. Does this match
>  your scenarios in any way?

Your version (the second paragraph) matches my usage exactly.  The
first paragraph does not, but I gather from some discussion on this
list that it does match some people's use cases, so I guess it should
continue to be available.

>  o Branching "crawler" means branching "os-lib"
>  o You can send a patch that contains changes both to "crawler" and "os-lib"
>   and get it applied in a resonable way as ONE modification (and git-am
>   would do the right thing)
>  o Merging branch a and branch b in "crawler" also merges the matching
>   branches a and b in "os-lib".
>  o Pushing the supermodule also pushes the submodules

The above would fit fine into my workflow, although it might be more
fancy than I really need.  Personally, I don't mind thinking of my
submodules as separate projects (ie. I should expect to commit,
branch, merge, and push separately).  But if the above features
existed I would adjust my working style to use them, just for the
added day-to-day convenience factor.

Doing things like a single patch against one repo is a bit messy,
because (presumably) you'd have the same commit message in both repos,
which wouldn't really make sense.

>  - Enable new behaviour with "git subdirectory" instead of "git submodule",
>   and let "git submodule" keep the old behaviour.

If we get to the point where patchsets are gettingd sent around to
play with this, is it better to modify git-submodule or to create an
entirely new file?  I don't know the preferred way of doing this.

Have fun,

Avery
