From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value
 for table cells
Date: Tue, 20 Jun 2006 13:57:50 +0300
Message-ID: <20060620135750.7880c62d.tihirvon@gmail.com>
References: <200606201012.31684.jnareb@gmail.com>
	<7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
	<20060620124606.4e3e226c.tihirvon@gmail.com>
	<e78gun$65s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 12:58:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsdvi-0002TR-GQ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 12:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWFTK5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 06:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWFTK5y
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 06:57:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:29670 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932585AbWFTK5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 06:57:54 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1393301nfb
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 03:57:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=aHmu+4Pmi4YEyvWCfB1pmaOXS/QAFvgOgm2QGwqvh0FYI9fRcbFDGGl/WUcMc7zMxmKjeL3kq+VdHFzzACapnPZFL6/JfVU/lr9rRzv2MvQungFzWRjlTpzKpzQm3O2Ft25YY/ES+MUcj0eHnPGXk4S6cavxVnV3265RId4seio=
Received: by 10.49.72.16 with SMTP id z16mr5513620nfk;
        Tue, 20 Jun 2006 03:57:52 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l38sm7882660nfc.2006.06.20.03.57.51;
        Tue, 20 Jun 2006 03:57:52 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e78gun$65s$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22190>

Jakub Narebski <jnareb@gmail.com> wrote:

> Timo Hirvonen wrote:
> 
> > http://onion.dynserv.net/git/gitweb.cgi
> > 
> > Global symbol "$path" requires explicit package name at
> > /var/www/localhost/htdocs/git/gitweb.cgi line 1521.
> > Execution of /var/www/localhost/htdocs/git/gitweb.cgi aborted due to
> > compilation errors.
> > 
> > The line is:
> > 
> > $file =~ m#^/# or $file = "$projectroot/$path/$file";
> > 
> > $path seems to be undefined.  I don't understand perl very well so I
> > can't fix it.
> 
> Temporary fix is in:
>  
>   "[PATCH] Fix: Support for the standard mime.types map in gitweb"
>   (Message-Id: <11507843541678-git-send-email-jnareb@gmail.com>)
>     http://permalink.gmane.org/gmane.comp.version-control.git/22172

Seems to work now.  I also enabled blame and it works too. But I noticed
that the search is sometimes broken.  If you click a "blob" link and
then try to search something gitweb will complain:

    403 Forbidden - Unknown commit object. 

"h" parameter is blob, not commit. Shouldn't the h parameter be set to
HEAD always when searching?  Searching starts at h so the search results
vary:

http://onion.dynserv.net/git/gitweb.cgi?p=cmus.git&a=search&h=HEAD&s=pickaxe%3Atheme

http://onion.dynserv.net/git/gitweb.cgi?p=cmus.git&a=search&h=fd2d983d51858e25cc71b14b59c787e1683ba7c5&s=pickaxe%3Atheme

-- 
http://onion.dynserv.net/~timo/
