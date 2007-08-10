From: "Govind Salinas" <govindsalinas@gmail.com>
Subject: Re: git-p4 question
Date: Fri, 10 Aug 2007 10:17:04 -0500
Message-ID: <69b0c0350708100817u58f74acbyed5c19830cb92ed7@mail.gmail.com>
References: <69b0c0350708091953wdc9c22vd2b17b1edd1c5cd2@mail.gmail.com>
	 <81b0412b0708100106m3123a504p16309b6e06cd9609@mail.gmail.com>
	 <81b0412b0708100110w6ff90215gd5c367fb65e2ae21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJWFA-00027d-1x
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 17:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185AbXHJPRM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933086AbXHJPRK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 11:17:10 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:18514 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760297AbXHJPRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 11:17:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so162302and
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 08:17:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ubjdT4nDGHU+Zq4axGYauLB++N8CQ1ZLEGhIJwzN2IuPbCAmcrWIaCkGifCVYzbm16mmSMZ2WM3Mt2Y2LzldcQISlXpblcJtQV7vRINKXRiNKUbIOLwJcBXoIAQiFV+gKSMaEWfE7FIMJdBHvnr8f9MvcfTZZmBYuWXNMSDfXms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0koN6U3ptrbJMhB9R3vUCPMxDJu76xt0sLI9zTuBGwV7f/hOBNuSobwUEl3X9Vj+DsJRfyVnEZYxagivKWJwBHAyQiukLybKzFRnKh8V7zHmWiTCr4YK6JhdLMJ2wl12dcNdxQcUwRKH9exX8lJx8FE0HBNqS2zRLhmI4MyOXo=
Received: by 10.100.14.19 with SMTP id 19mr58372ann.1186759024385;
        Fri, 10 Aug 2007 08:17:04 -0700 (PDT)
Received: by 10.100.119.8 with HTTP; Fri, 10 Aug 2007 08:17:04 -0700 (PDT)
In-Reply-To: <81b0412b0708100110w6ff90215gd5c367fb65e2ae21@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55544>

I am having some problems running the script.  It seems that (line
1425) $f->{sha1} is uninitialized and causing the import to fail (the
perforce path is missing the leading "//" I don't know if that is
intentional).  Let me know if you want to continue this off list since
it isn't really a part of git.

On 8/10/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 8/10/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 8/10/07, Govind Salinas <govindsalinas@gmail.com> wrote:
> > > If I can just sync from p4 and then sync my binary share and THEN tell
> > > git-p4 that //depot/my/product/... maps to c:\path\src\realworkhere,
> > > get it to import history etc,  then I would be set.
> >
> > git-p4-import.bat can import a state from the client have-list,
> > but it does not import the history. It can import the history
> > separately, so that you can stitch it into a merge which will be
> > the state imported from the client. Complicated, but I couldn't
> > bring myself to figure out the history automatically.
>
> Err, example:
>
> Import a state from p4 client:
>
>   git-p4-import -y -c client-name -e
>
> Import p4 history of a path mapping:
>
>   git-p4-import --p4-path //perforce/path \
>     --local-path very-local-path \
>     --p4-range '@1234,5678' \
>     --start start-commit \
>     --branch branch-name
>
> The last argument (--branch) is optional, will just store the last imported
> commit there. start-commit will be assumed current HEAD, if omitted.
>
