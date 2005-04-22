From: Kyle Hayes <kyle@marchex.com>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 10:43:50 -0700
Organization: Marchex Inc.
Message-ID: <1114191830.31076.426.camel@axer.marchex.com>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
Reply-To: kyle@marchex.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:41:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP28g-0006x9-6w
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVDVRoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVDVRoV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:44:21 -0400
Received: from peer.sef.marchex.com ([66.150.8.204]:55813 "HELO
	nosecone.marchex.com") by vger.kernel.org with SMTP id S262082AbVDVRnz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 13:43:55 -0400
Received: (qmail 1334 invoked from network); 22 Apr 2005 17:43:50 -0000
Received: from unknown (HELO axer.marchex.com) (10.101.11.64)
  by nosecone.marchex.com with SMTP; 22 Apr 2005 17:43:50 -0000
To: azarah@nosferatu.za.org
In-Reply-To: <1114189105.29271.36.camel@nosferatu.lan>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 18:58 +0200, Martin Schlemmer wrote:
> On Fri, 2005-04-22 at 09:16 -0700, Kyle Hayes wrote:
> > Suppose that the GECOS field is:
> > 
> > Hayes, Kyle; Room 42; 424-424-4242; foo bar baz...
> > 
> > You'll search for the first comma, find it, truncate my name to "Hayes",
> > and continue.
> > 
> > I have seen this kind of GECOS in larger environments where the
> > individual users are not the ones that administrate their machines.
> > Using the LastName, FirstName style of name is not rare. 
> > 
> 
> What OS?  With Linux at least, this is what chfn's manpage say:

Can't remember, it's been a while (years).  We had AIX, Solaris, Linux
and BSD machines at the time.  Might have been AIX, I think.  The memory
of which OS is vague, but not the annoyance of finding the problem :-(

> ----
>        The only restriction placed on the contents of the fields is that no control characters may  be  present,
>        nor  any  of  comma, colon, or equal sign. The other field does not have this restriction, and is used to
>        store accounting information used by other applications.
> ----
> 
> Meaning, if they use a ',' in one of the fields (and it is a linux
> system with the chfn most probably from the shadow package), then they
> are looking for trouble.  The only reason I added the ';' was because
> somebody said whatever OS used it instead of a ','.

>From the AIX version of chfn:

----
You can use any printable characters in the gecos information string
except a : (colon), which is an attribute delimiter.
----

The AIX examples show use of semicolon as a separator.

So, at least on AIX, it is appears valid to use the style I showed
above.  I don't have access to Solaris machines right now.  The BSD
(FreeBSD 4.11) version of man 5 passwd:

----
The gecos field normally contains comma (`,') separated subfields as
follows:...
----

Best,
Kyle

-- 
Kyle Hayes <kyle@marchex.com>
Marchex Inc.

