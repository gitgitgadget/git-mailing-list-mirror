From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: git-svn: pulling from local mirror but committing via svn+ssh
Date: Sat, 22 Dec 2007 04:32:36 -0500
Message-ID: <8bd0f97a0712220132w6fdfd7ddud96811d4af8b431f@mail.gmail.com>
References: <8bd0f97a0712200821j778c12a9g9d42bf02482d953c@mail.gmail.com>
	 <20071222043528.GB18812@soma> <476CD5E1.9020204@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 10:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J60j7-00051A-6Z
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 10:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXLVJci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 04:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXLVJci
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 04:32:38 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:37406 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbXLVJcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 04:32:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1087488wah.23
        for <git@vger.kernel.org>; Sat, 22 Dec 2007 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wmo4f/JOyQeuAJ5jnmFdMMyNO985HuQEVWAE287aO0M=;
        b=RLnZAYky7fSNcBfMXPbARdT1XzvqPdTzOg4QMMu6cjCrOTSTSE6Vgvj7vY7GA4GDRwHAUMXEcekU9xznAyMrotSjYlkLACRWVTCzWzv8FI04m52GTYdtGG5TjXn5HzZVHz3xzML18WvMD4a8jaGIXTZgDuIchBpD9HA7gHTgM8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgHzptn4JgoBhK3LaLgt7lMu3z9koxd5R48z6bIhMPETeAz+yNSIEzyXsNIiXP9OmnP1KxuExAVD0F+JIF1xkBoAjGSpBOCZMkHsxZ4RB0O0+BRDb4IIJ4QFODGhMreXdMQo6NR6clZNMTkhl4/HKtplJN2fD+NjDYb4Tl0Ty1M=
Received: by 10.142.239.11 with SMTP id m11mr563850wfh.165.1198315956368;
        Sat, 22 Dec 2007 01:32:36 -0800 (PST)
Received: by 10.142.165.7 with HTTP; Sat, 22 Dec 2007 01:32:36 -0800 (PST)
In-Reply-To: <476CD5E1.9020204@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69132>

On Dec 22, 2007 4:16 AM, Sam Vilain <sam@vilain.net> wrote:
> Eric Wong wrote:
> > > i have local (fast) mirrors of the svn trees i use, so i normally keep
> > > everything pointing at those.  when i need to commit, i use `svn
> > > switch --relocate ...` to flip to the svn+ssh master, and then flop
> > > back to the local mirror.  it actually works out nicely.
> >
> > Can useSvmProps handle this?  I honestly forgot how that stuff
> > was supposed to work with SVK/svn-mirror.
>
> It's precisely this use case.  If you are syncing with SVN::Mirror, part
> of SVK, or via svnsync, these tools leave breadcrumbs as svn properties
> that point to where the repository was copied from.  So, in your commit
> log the message will be the URL of the immediately[*] upstream
> repository.  SVN didn't ever really support clone per se, what did you
> use to copy the repository?

we publish the raw svn tree via rsync so people can create their own svn mirrors

sounds like it's just easier to mirror the original and since this
isnt a terribly large repo (~50 meg w/out any scm stuff), that's ok
-mike
