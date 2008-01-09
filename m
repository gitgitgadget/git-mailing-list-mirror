From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Thu, 10 Jan 2008 00:09:08 +0100
Message-ID: <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCk3H-0000bG-RZ
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 00:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYAIXJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbYAIXJM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 18:09:12 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:17772 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753325AbYAIXJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 18:09:10 -0500
Received: by hs-out-2122.google.com with SMTP id 54so388432hsz.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 15:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0jWTp5b8qWXDlOLO9qRAdn29i0ptAgx/QK6xl0vuMk8=;
        b=LB5fSwG1lTHOZX7g+16+O3sKRt/vg4c0WrPlszPjAO5aUs08UnzjizOZyzKRrv4uvgfdFSKIktuv7f1SAF/s6uv7zCB05tniKiee0SEDANT/OqdfzSXNsK4EIbCERhvZJwQ61BEKT6NZeEDF/d3oYiJcCMlZ/AspYubFeawjD9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qf6QdUShj1doqhrDXIFnvUxML4EMFvD138mw+9eEoX7bOYUhtrqlzveHcYyyuvPn8moLxIrWwku2RhjVVDSceJiMUxBe+tgo8fARIIiD1FYOh+buR6cdvqGtksvupsufcQ04tB10M8yRhrTCqloDkhtngOQf1l4crXpj5dNlJcE=
Received: by 10.142.242.8 with SMTP id p8mr686793wfh.142.1199920148113;
        Wed, 09 Jan 2008 15:09:08 -0800 (PST)
Received: by 10.143.195.1 with HTTP; Wed, 9 Jan 2008 15:09:08 -0800 (PST)
In-Reply-To: <fm1h7t$nnr$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70025>

On Jan 9, 2008 5:06 AM, Douglas Stockwell <doug@11011.net> wrote:
> Paolo Ciarrocchi wrote:
> > " Mailing off a set of patches to a mailing list can be quite neatly
> > done by git-send-email.
> > One of the problems you may encounter there is figuring out which machine
> > is going to send your mail.
> > I tried smtp.gmail.com, but that one requires tls and a password,
> > and git-send-email could not handle that "
> >
> > From http://git.or.cz/gitwiki/GitTips.
> >
> > Is this statemant still correct ?
> > Is msmtp the only solution for using git-send-mail with gmail? (tls +
> > autentication).
>
> No, as of 34cc60ce2b48f6037997543ddbab1ed9903df4a8 you can use SSL and
> SMTP-Auth.
>
> [sendemail]
>          smtpserver = smtp.gmail.com
>          smtpuser = <user>@gmail.com
>          smtppass = <password>
>          smtpssl = true
>
> Can you suggest changes to the documentation if these options are unclear?

Well, it would be nice to add this information to the wiki, it's still
mentioning
that you require an external program for supporting the TLS connection.
I'll do that when I'll get my box working with the configuration you suggested,

What I'm getting at the moment is:
paolo@paolo-desktop:~/git$ git-send-email -compose -to
paolo.ciarrocchi@gmail.com /home/paolo/Desktop/patch/
snip
snip
Can't locate Net/SMTP/SSL.pm in @INC (@INC contains:
/home/paolo/share/perl/5.8.8 /etc/perl /usr/local/lib/perl/5.8.8
/usr/local/share/perl/5.8.8 /usr/lib/perl5 /usr/share/perl5
/usr/lib/perl/5.8 /usr/share/perl/5.8 /usr/local/lib/site_perl .) at
/home/paolo/bin/git-send-email line 627.

Tv on #git helped me in finding an Ubuntu package which includes SSL.pm :
http://packages.ubuntu.com/cgi-bin/search_contents.pl?word=SSL.pm&searchmode=searchfiles&case=insensitive&version=gutsy&arch=i386
which repors:
usr/lib/perl5/Net/SSL.pm				    perl/libcrypt-ssleay-perl [universe]
usr/share/perl5/HTTP/Daemon/SSL.pm			    perl/libhttp-daemon-ssl-perl [universe]
usr/share/perl5/IO/Socket/SSL.pm			    perl/libio-socket-ssl-perl
usr/share/perl5/Net/IMAP/Simple/SSL.pm			
perl/libnet-imap-simple-ssl-perl [universe]
usr/share/perl5/Net/Server/Proto/SSL.pm			    perl/libnet-server-perl [universe]
usr/share/perl5/POE/Component/Client/HTTP/SSL.pm	
perl/libpoe-component-client-http-perl [universe]

I installed libcrypt-ssleay-perl but still no luck.

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
