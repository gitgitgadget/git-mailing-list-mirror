From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Fri, 26 May 2006 09:19:19 +1200
Message-ID: <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 23:19:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjNEo-0005Zx-PE
	for gcvg-git@gmane.org; Thu, 25 May 2006 23:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWEYVTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 17:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWEYVTU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 17:19:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:39416 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030427AbWEYVTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 17:19:19 -0400
Received: by wr-out-0506.google.com with SMTP id i7so251961wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 14:19:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SSBNp6WbYSCGG/ROrOT4ElxTbesYnvXUD8kohIcljnCnrNttS/sWRzjPMG5wx0UkiibZ3Q04/cfj0PWINiI3cir2xzvf4co0AWZnhurRY7UhC4bNhJqEmhGAB+u8QBvRjeHbIIAjOr2ognbrlioXl+EyAxCGlkH8fz4BTNLUYNg=
Received: by 10.54.82.14 with SMTP id f14mr1104443wrb;
        Thu, 25 May 2006 14:19:19 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 25 May 2006 14:19:19 -0700 (PDT)
To: "Cameron McBride" <cameron.mcbride@gmail.com>
In-Reply-To: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20766>

On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:
> For reasons I won't go into, the ability to use cvs clients is darn
> near crucial.  Although most development is local (where I install /
> use git), pulling down the latest updates and pushing up minor changes
> via CVS is helpful at remote locations where I don't want to maintain
> clients.  Git with git-cvsserver makes this very nice.   Thanks to
> all!

NP!

There's been some recent changes to cvsserver -- so version info is
crucial. What git version are you using? Can you try with the lastest
#master head from Junio? That's the latest and greatest...

If that doesn't fix it, can you post the logs? I think you have to
declare CVS_LOG=/tmp/cvslog or somesuch.

> code/ntropy> cvs -v
> Concurrent Versions System (CVS) 1.11.1p1 (client/server)

We've developed it testing against 1.12.9 from debian and 1.11.20 from
MacOSX/fink.

> so, it's an old client, a newer client doesn't have this problem.  a
> bare 'cvs up' works fine on:
> Concurrent Versions System (CVS) 1.11.17 (client/server)

Ah! Then capturing the logs of the working and non-working clients,
and comparing them can probably help. Can you capture and post the
relevant parts of the log...?

> p.s.  I'm assuming the following statement is harmless (it's always present):
> closing dbh with active statement handles

Yup. Harmless indeed. They way we are using prepared statements, I
don't know how to avoid it :-/ -- suggestions welcome.

cheers,


martin
