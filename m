From: Frank Li <lznuaa@gmail.com>
Subject: Re: [msysGit] Using VC build git
Date: Tue, 11 Aug 2009 09:26:21 +0800
Message-ID: <1976ea660908101826q26faa37ao7920d5cf9d4f53fd@mail.gmail.com>
References: <1976ea660908100656u57407131h83761329468607a8@mail.gmail.com>
	 <alpine.DEB.1.00.0908101606220.8324@intel-tinevez-2-302>
	 <alpine.DEB.1.00.0908101609170.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:26:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mag8F-0007xn-8p
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZHKB0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 21:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbZHKB0V
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:26:21 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:48311 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZHKB0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 21:26:20 -0400
Received: by qyk34 with SMTP id 34so2996956qyk.33
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bg8Xk/duwiq2fPJFW3O1c5e0iQXtkBsQ/RoKi251/no=;
        b=GGtVSTi5D38wtPl3fJLFZGmHTe+FInWeuHXkKICis1x19kxctK7WCHGhNeMB8Amy8G
         tcrivOxfNFXA9iCzKVovnxvI0aldmOVe4jK+0uhCFVbjeaqwVORbPoJr6FZl0QwSSfXv
         AqY3jehuaB7SG47CpGg+0jfZRqwKLrx2VYOUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I9IkZitMY/g865WN/2VA4dH4VIiKbW4XyrOeCQsnQhGhGqFmd4rB/8XqGqdu//5gri
         bfvxqu2W2iWEuPyirQH6Q8h2sTq4IlgwJqyeg6FI+w2QZZipksESg0hfCFAxU0USH36J
         o4xl1VMhdbYFlHlk/u0i4PWjQVgZ2qpxSQshw=
Received: by 10.224.37.76 with SMTP id w12mr3833995qad.66.1249953981181; Mon, 
	10 Aug 2009 18:26:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101609170.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125507>

Thank you take care my patch.
I can fix all problems.

This patch is base on v1.6.4 release.  My working branch is vc_build
at git://repo.or.cz/tgit.git.

That is actually prototype to approve VC can build git.
The code style is not big problem. I will fix it.

VC build will reuse many msysgit works because msysgit really do many
work at windows porting.

I think the below is most important problem.

1.  Where are vcbuild directory put, is it okay under contrib ?
2.  How to handle external library, such as zlib? Can use submodule?


2009/8/10, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 10 Aug 2009, Johannes Schindelin wrote:
>
>> Please, we have _high_ standards in git.git, and I really do not want to
>> have to take anything to Junio that does not fulfill that standard.
>
> To elaborate:  if I see something like this in the --stat:
>
>  contrib/vcbuild/include/zlib.h        | 1357
> +++++++++++++++++++++++++++++++++
>  contrib/vcbuild/lib/zlib.lib          |  Bin 0 -> 104148 bytes
>
> ... I know already that there is no way this can make it into git.git.
> There just is not.
>
> Also, if the first commit says nothing else than "Rebase to v1.6.4", it
> is pretty obvious to me that I will not sign off on that (and I just guess
> that is the very reason you did not sign off on that, either).
>
> Further, putting anything into contrib/ that really belongs into contrib/
> is not cutting it, either.
>
> And I am pretty astonished that mingw.[ch] is touched, as VC is definitely
> not MinGW32.
>
> Changing 1000+ lines of libgit.vcproj in almost every commit is also
> something I really do not look upon favorably.
>
> Finally, if _no single_ commit message says _anything_ about the reasons
> why you had to change code outside of vcbuild/, I am only puzzled.
>
> Now, I want to give you a pretty clear idea what has to be done if this is
> going into 4msysgit.git, ever, because you obviously spent a lot of time
> on it, and other people want it, too:
>
> - changing "open" to "_open" in mingw.c is a no-no-no.  If you need to use
>   "_open" in VC, then define "open" in the compile flags for mingw.c, but
>   leave code that is not written for VC alone.
>
> - introducing trailing whitespace is usually a sign of not caring enough
>   about clean and neat code.  So just don't do it.
>
> - making link() fail on MinGW32 just to be able to compile it with VC is
>   outright rude against all people who use a free and open compiler
>   instead of a closed one.
>
> - changing an "_snprintf" to "_vsnprintf" in vcbuild/porting.c without
>   anything else is a clear and loud sign that the code before was broken,
>   and that you fix a faulty patch in a later patch.  This is not how we do
>   things in git.git.  We fix the proper patch before the patch series is
>   accepted into mainline.
>
> - violating the coding style -- even if it is in your VC-specific part --
>   is not an option.  You need to fix the coding style.
>
> - violating the coding style in files that are not VC-specific is not an
>   option at all.  You really need to fix it.
>
> - changing the default editor from "vi" to "notepad2" will break almost
>   every existing Git user's setup.  That is just inexcusable.
>
> Note: these comments are _just for the last_ of your 5 patches.
>
> Just a brief comment on the 4th patch, because I really do not want to
> spend more time on this round of patches: spelling the opendir() function
> as "open dir" function in the commit message is misleading, to say the
> least, and moving code that was added in a previous patch in the same
> patch series just shows that it was a mistake to begin with.  Besides,
> don't move anything into mingw.c if MinGW32 does not need it.
>
> Hth,
> Dscho
>
>
>
