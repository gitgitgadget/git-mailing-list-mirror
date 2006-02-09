From: Bertrand Jacquin <beber.mailing@gmail.com>
Subject: Re: gitweb: View graphes & get tar
Date: Thu, 9 Feb 2006 12:12:42 +0100
Message-ID: <4fb292fa0602090312k1607e42fu88e03b788d339390@mail.gmail.com>
References: <4fb292fa0602081534x7f6e74c1veb8c4ea7ad5a83cc@mail.gmail.com>
	 <200602090003.35354.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 12:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F79jE-0002Fr-33
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 12:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWBILMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 06:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWBILMp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 06:12:45 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:14149 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422884AbWBILMp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 06:12:45 -0500
Received: by uproxy.gmail.com with SMTP id j40so165088ugd
        for <git@vger.kernel.org>; Thu, 09 Feb 2006 03:12:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kk5ARMTI1sbdwXQv0cPvxrS6LtDV1fByyH4Nz31TtzUffhltgYDC/jsxfuJ6ix69yqGV4GyRBVO0JvmXlcnfOFnyNScxuKrYGSGbGZXVX4ORiGTq4MuWQ7Qc+vOY80T4iLRSX77CQUieIc5stFNZLdEiPbimUlBzoHllNCt0RrU=
Received: by 10.48.235.15 with SMTP id i15mr2333480nfh;
        Thu, 09 Feb 2006 03:12:42 -0800 (PST)
Received: by 10.49.5.3 with HTTP; Thu, 9 Feb 2006 03:12:42 -0800 (PST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602090003.35354.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15805>

On 2/9/06, Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> On Wednesday 08 February 2006 23:34, Bertrand Jacquin wrote:
> > Hi,
> >
> > Is gitweb maintainer planned to allow people to get from gitweb ? It
> > could be something good for ungited/remote people to get a tar for a
> > specific tree.
> > gd provide to create graphs and is often use in "web project" to
> > generate graphe. Could it here generated a graph of branches like in
> > gitk ?
> > It also could be cool to allow people to get binary files in an other
> > mimetype that text/plain.
> >
> > Here are my wish :D it's worth what it's worth.
>
> You can do some of that a different way.
>
> I have it set up so that when I push a tag into my public git repositories,
> that a post-update hook creates a tarball of the site and puts it into the
> download directory.
>
> The hook is of the following form
>
> #!/bin/sh
> #
> # This script is used to create a tarball of the project and place it into the
> "files"
> # directory of the web site whenever a release is tagged in the repository
> #
> PROJECT=akcmoney
> # this should look at each positional parameter
> for ref ; do
> #if its a tag then create a tarball
>         if [ "${ref:0:10}" == "refs/tags/" ] ; then
>                 git-tar-tree ${ref:10} $PROJECT | gzip -9
> > /var/www/chandlerfamily/files/$PROJECT/$PROJECT-${ref:10}.tar.gz
>         fi
> done

That's ok, but with that I couldn't get a tar for _not_ the current
tree. If i want to get a tar tree for 2 months old in not master
branch, I can't with that. The idea here is the create the tar on the
fly, on the user demand.
And also, I use http push so hooks can't be used :/

>
> --
> Alan Chandler
> http://www.chandlerfamily.org.uk
> Open Source. It's the difference between trust and antitrust.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Beber
#e.fr@freenode
