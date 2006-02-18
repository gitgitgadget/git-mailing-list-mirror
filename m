From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stGIT: commit vs export vs mail
Date: Sat, 18 Feb 2006 08:30:06 +0000
Message-ID: <b0943d9e0602180030i1f7b71eco@mail.gmail.com>
References: <Pine.WNT.4.63.0602171139020.3052@jbrandeb-desk.amr.corp.intel.com>
	 <43F64A51.10607@gmail.com>
	 <Pine.WNT.4.63.0602171802030.2172@jbrandeb-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 09:30:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FANTy-0003lP-IV
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 09:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBRIaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 03:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBRIaI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 03:30:08 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:7593 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbWBRIaH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 03:30:07 -0500
Received: by xproxy.gmail.com with SMTP id i31so395117wxd
        for <git@vger.kernel.org>; Sat, 18 Feb 2006 00:30:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O0ivofff5hzdH7JOCFCQmoBCoNfQzJJWZPulrPkoqpDw0LRJplD4LGUPdNPHHb8iZ0VEG0c/t4jugwsz7lhjq8jPXMQutwTQB49KQ1aEYCcMYVCLh4UDqTdiHBr08Bt4W6PVLxCC+Qmq6FGfqFPLxehtJH0jy/JNPIjPX6K3fZM=
Received: by 10.70.97.10 with SMTP id u10mr1945499wxb;
        Sat, 18 Feb 2006 00:30:06 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Sat, 18 Feb 2006 00:30:06 -0800 (PST)
To: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
In-Reply-To: <Pine.WNT.4.63.0602171802030.2172@jbrandeb-desk.amr.corp.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16399>

On 18/02/06, Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
> On Fri, 17 Feb 2006, Catalin Marinas wrote:
> > Jesse Brandeburg wrote:
> >> stg mail <blah blah blah>
> >> or
> >> stg commit
> >
>
> I'm trying to commit changes to a local repository so that the maintainer
> can do a "pull" off of my repository.

All the applied patches in your repository are visible via HEAD. There
is no need to do a commit, unless you want to store them permanently.
The way of using StGIT in contributor mode is to always have the base
of the stack identical to the HEAD of the upstream repository.

I usually just mail the patches but the other way would be to apply
the patches you want to be merged and ask the maintainer to pull from
it. Once the changes were pulled, you could run 'stg pull' on your
repository and StGIT should detect which patches were merged and
whether there are any conflicts (patches modified upstream for
example).

If you want to continue the work on your branch before the maintainer
would pull the changes, you can create a separate "stable" branch for
this. Either use 'stg branch --clone' or simply create it with 'stg
branch --create base' and pick the patches you want merged.

> the stgit command stg commit freezes patches that I've made into my
> repository.  I think I get that, but I've been wrong before.  Its just
> that I can template the Signed-off-by: line for emails, but when I do a
> stg commit I want the thing to have the Signed-off-by: line in the commit
> text (like above where I added it by hand)
>
> I guess I'll just change my templates to not auto add the Signed-off-by
> line and then things will work okay, as I'll just add the line during stg
> new ...

I got it now. You added Signed-off-by to the mail template. As I said
above, commit should not be used to facilitate the maintainer pulling.
It is already available since the patches are valid GIT commits.

--
Catalin
