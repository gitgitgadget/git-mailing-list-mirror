From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to find a revision's branch name
Date: Sat, 18 Mar 2006 08:35:19 +0100
Message-ID: <e5bfff550603172335v11ea36a8j9cca2ed2df58b45d@mail.gmail.com>
References: <e5bfff550603172202ia4b69f2he5562b826e491426@mail.gmail.com>
	 <7vfylgz29x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 08:35:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKVyA-0003ny-Nr
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 08:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCRHfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 02:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWCRHfV
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 02:35:21 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:38391 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932248AbWCRHfU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 02:35:20 -0500
Received: by wproxy.gmail.com with SMTP id i6so731375wra
        for <git@vger.kernel.org>; Fri, 17 Mar 2006 23:35:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jwyz26LO0IKyEuqWcUdpvYPzjEjfxph1cZyt+HSUEGkzcrem2ckyqEODzeSQrjuNoLKZHkcDrnXlzr/p3Iz7nu89JicSuwPs5/bmfpk8Z7nmQmYsi2BDKl8U0pRhex/MW5vrWU75YO0fFbXaJfWTtVirjD2SflQJEXg+1WmeVgY=
Received: by 10.65.254.3 with SMTP id g3mr674149qbs;
        Fri, 17 Mar 2006 23:35:19 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Fri, 17 Mar 2006 23:35:19 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfylgz29x.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17689>

On 3/18/06, Junio C Hamano <junkio@cox.net> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
>
> > Is it possible to get branch name from a revision sha?
> > Something like
> >
> > $ git branch b14e2494b8a70737066f4ade4df1b5559e81b44b
> > todo
>
> That is in general impossible.
>

>
> > I need this to correctly annotate files not in HEAD
> > tree. Currently qgit runs git-rev-list --header --topo-order
> > --parents --remove-empty HEAD -- <path>
> >
> > to get a file history. But this fails if <path> is not found
> > in HEAD. The right command to run in our case should be:
> > git-rev-list --header --topo-order --parents --remove-empty
> > todo -- <path>
>
> ... I wonder why you care.  Wouldn't this work just as well?
>
>         $ git rev-list --header --topo-order --parents --remove-empty \
>           --all -- <path>
>

Yessss!!!

Thanks for the fix. I missed that.

Marco
