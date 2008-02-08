From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git help -w should not create nohup.out
Date: Fri, 8 Feb 2008 13:33:07 +0300
Message-ID: <20080208103307.GT30368@dpotapov.dyndns.org>
References: <1202434421-8066-1-git-send-email-dpotapov@gmail.com> <alpine.LSU.1.00.0802080153570.11591@racer.site> <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQYK-0005jF-7q
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934430AbYBHKdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934400AbYBHKdP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:33:15 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:53465 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934038AbYBHKdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:33:13 -0500
Received: by an-out-0708.google.com with SMTP id d31so888840and.103
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Wnp8XUrKgKAa+QNcsIG7an+3JBx+ig/ub+yTfoa1tXc=;
        b=latwKXrgAd2mbE8V9h1G22MyMKFUFGFZGiiYbdD4z95tV0P5QTfToEkkuPfU+XBBsxss6UeEt+76CRS4vO+ZX37T3eIHQG4QtImO5FKw0xFE0TOMsBppyeXFasLsiPFO7UEWuuCFa5IN4t5YswmUwBvdOqnqa4ez8RTRPFriXSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cwdNga2SLO4VBfGeykXRLjcpEAXgbtUoLlzrJ/VZoXfTfVdezt4fUOLkSJoILd15qjnvYyy0CzOcF56NUHhXakyFNJL8Prg8PYahHpfNX2eKqhPRds4MgcqjmyfeJwP+TjEEIGzQVlbFAJL91rlDQfPad/D9cr2y6Ui5FGLVSmg=
Received: by 10.100.139.20 with SMTP id m20mr26231644and.102.1202466791065;
        Fri, 08 Feb 2008 02:33:11 -0800 (PST)
Received: from localhost ( [85.141.191.38])
        by mx.google.com with ESMTPS id t10sm13567698muh.13.2008.02.08.02.33.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 02:33:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73068>

On Thu, Feb 07, 2008 at 07:40:21PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Fri, 8 Feb 2008, Dmitry Potapov wrote:
> >
> >> git-help--browse uses 'nohup' to launch some browsers.
> >
> > Why?
> >
> > "nohup" should be used to start a program that should persist even after 
> > you logged out.  I fail to see how this should be sensible for "git help 
> > -w".  So "off with the head", uh, do away with the "nohup", I say!
> 
> True.  Christian, what was the reason you added nohup?
> I would imagine if you did this:
> 
> 	(1) open a new xterm;
> 
>         (2) in that xterm, run the browser, perhaps from
>             git-help--browse, but without nohup, in the
>             background;
> 
> 	(3) exit the terminal
> 
> then the browser might get upset, losing its controlling
> terminal.

I also thought so, therefore, I suggested to redict the output to
/dev/null instead of removing "nohup", but now after some testing,
it seems there is no need for "nohup" here. So, unless Christian
has a good reason for "nohup", I agree with Johannes that "nohup"
should be removed.


Dmitry
