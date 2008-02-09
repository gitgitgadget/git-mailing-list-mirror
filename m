From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 13:48:35 +0000
Message-ID: <3f4fd2640802090548p3f3b7c95kbbe74662dfcbeba5@mail.gmail.com>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com>
	 <alpine.LSU.1.00.0802091318080.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNq4w-0003EY-0R
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbYBINsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbYBINsj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:48:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:61686 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbYBINsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:48:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2819421rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ooqyJ9+8Oc+y4Wbkf7MHSHLLy7HeCMtVQtg79rUGqlw=;
        b=JPHiNh4vdgAef9PBFgSwaX72Vp0TvqBkB5zQS08PZS0BScKsqz9/QewM3DLL8m0eMK+xG8IRmdYbpql+AwOtgts36LlRGncHapGR2xL9DfqeKxDnS/UwnXhnf1Q6fGtzasB8aOwwJOJ6AIFvzaZvpFfzcUANt3i0BNhUMBjEr0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgdC/dX7HOpk2wwzWxURALOpJmG5JBy9ioEMOKc+LzPxzslqJvjWBmobYVucyPN2+wmys1MVk2BYiwKDYurnsYoUjFgPsZCh3ZahWsci7Hsj4pZadgssfRJyM6J5Nf3nxbGUwNPVs6fbqY197IKkyU5Q5nzCK/5bC/+yv6H9Cxk=
Received: by 10.141.114.21 with SMTP id r21mr563292rvm.154.1202564915863;
        Sat, 09 Feb 2008 05:48:35 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Sat, 9 Feb 2008 05:48:35 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802091318080.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73228>

On 09/02/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 9 Feb 2008, Reece Dunn wrote:
>
> > I have some ideas on improvements I would like to make to git fetch. I
> > am not familiar with the implementation details of builtin-fetch.c and
> > friends, and having a brief look at the implementation I am unsure how
> > to proceed.
> >
> > The ideas for improvements I have are:
> >
> >     1.  When running `git fetch` on a bare repository that does not have
> > a remote called 'origin', fetch fails. I would like this to pick up the
> > first remote entry in the config file.
>
> I am opposed to that.  If you want a default remote, then set the remote
> "origin".  That is well established semantics, and you would only confuse
> yourself if all of a sudden you fetched from a remote that you erroneously
> added at some stage.

Ok. That makes sense. Doing `git remote update` will do what I want in
this case.

> >     2.  When mirroring a repository such as the Linux kernel and its
> > stable repositories in the same git repository, it would be useful to be
> > able to fetch the latest data from all the remotes that you are tracking
> > in the config file. I envision this being done by running `git fetch
> > -all`.
>
> $ git remote update

That does what I want. Thanks for the information.

> >     3.  When fetching, if everything is up-to-date, display a message
> > saying so.
>
> We recently tried to unverbosify the transports.  So I think this would be
> a step back.

Sure. That makes sense.

- Reece
