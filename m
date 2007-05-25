From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 00:33:25 +0200
Message-ID: <8c5c35580705251533r21a3dea5w5d263fad9f8bbfa7@mail.gmail.com>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
	 <11801165433267-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251924280.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 26 00:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HriLk-0006fz-7u
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXEYWd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXEYWd0
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:33:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:56059 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXEYWdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:33:25 -0400
Received: by wa-out-1112.google.com with SMTP id j4so388492wah
        for <git@vger.kernel.org>; Fri, 25 May 2007 15:33:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGLU0OVdbeI6Teii9JO6VJKjGo24JJHmyF61R23178kg/0zqs/f3/hCqSfxf5kSnkd0oVkGJJMIadcNrCFVwmFIzVD8j3cwBzdf5M+QqgkAEz6H2QVbHN2vWavhc2UlyIExTWkDKxRQ/ShX4lSuK7ZgeJckZSXtyKxsRkG/S4NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AbCVduY1qdswm8hC23Ay3x55gB/oIR6byZWaNDT8qPihsMzHixfFnpWn2IGfOtGUsp/V+tmbbuBQZBQAdHFTcVc/bnfMWdJ7oe8QG6MrlJF5POdrq/AiHrE+GlLl1u056ygfZCHqDyg0yXnrwSRbLlA0dRxMWDS7iyRTL6h/XvM=
Received: by 10.114.76.1 with SMTP id y1mr1673309waa.1180132405412;
        Fri, 25 May 2007 15:33:25 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 15:33:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705251924280.4648@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48430>

On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> [* many usefull comments about the docs *]

Thanks, will fix

> > +USAGE='[--init | --update | --cached] [--quiet] [--] [<path>...]'
> > +. git-sh-setup
> > +require_work_tree
>
> Maybe
>
>         test -f "$GIT_DIR"/.gitmodules || die "Not a superproject"
>
> Hmm?

Yeah, maybe. But the command will only touch entries with mode 160000
anyway, so it might not be a big deal.

>
> > +                     rmdir "$path" 2>/dev/null ||
>
> Just out of curiousity: is rmdir portable? I always used "rm -r"...

I have no idea, really. But the reason for using rmdir was this
section of the man page:

NAME
       rmdir - remove empty directories

I do not want to delete an unempty directory. But there is probably
some better way to do this?

--
larsh
